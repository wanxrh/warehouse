<?php

/*
 * 用户基础控制器
 */

class User extends App_Controller
{
    const APP_CACHE_NAME_PREFIX = 'app_user_info_';//app用户信息缓存前缀
    const PER_PAGE = 20;//订单列表单页条数
    const EXTEND_CONFIRM_TIME = 259200;//延长确认收货时间,3天*86400 = 259200
    const UTYPEID = 1;//UC库登录账号类型 1买家，2商家

    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_model');
        $this->load->model('app_user_model');
    }

    /**
     * APP登陆接口
     * @author 王立
     */
    public function login()
    {
        $uname = $this->get_string('uname');
        $password = $this->get_string('password');

        $user = $this->user_model->login($uname, $password, self::UTYPEID);
        if (!$user) {
            $this->failure($this->user_model->error['code'], $this->user_model->error['data']);
        }
        $this->user_model->login_post_action($user, self::APP_CACHE_NAME_PREFIX . $user['uid']);
        $this->success(1, '登陆成功', array('uid' => $user['uid'], 'uname' => $user['uname'], 'sign' => $user['login_sign']));
    }

    /**
     * @author 小莫
     */
    public function center()
    {
        //TODO 用户中心
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;
        //获取头像和电话
        $my_info['list_userinfo'] = $this->app_user_model->get_user_info($user_id);
        $my_info['list_userinfo']['portrait'] = img_url($my_info['list_userinfo']['portrait']);
        $my_info['list_order']['un_pay'] = $this->app_user_model->shipments_status($user_id, ORDER_UNPAY);//待付款
        $my_info['list_order']['un_ship'] = $this->app_user_model->shipments_status($user_id, ORDER_PAID);//待发货
        $my_info['list_order']['un_receive'] = $this->app_user_model->shipments_status($user_id, ORDER_SHIPPED);//待收货
        $my_info['list_order']['finished'] = $this->app_user_model->shipments_status($user_id, ORDER_FINISHED);//已完成
        $my_info['list_order']['un_refund'] = $this->app_user_model->un_refund($user_id);//待退货

        //调取互联支付接口
        $this->load->library('Hulianpay');
        $my_info['list_userinfo']['balance'] = $this->hulianpay->get_user_amount($user_id);
        if ($this->hulianpay->hlpay_error) {
            $this->failure(1, $this->hulianpay->hlpay_error);
        }
        $this->success(1, '数据返回成功', $my_info);

    }

    /**
     * 全部订单
     * @author 王立
     */
    public function my_orders()
    {
        $type = $this->get_uint('type');
        $this->check_user();
        $uid = $this->uid;
        /*$type = 3;
        $uid = 2091722322;*/
        $conditon['buyer_id'] = $uid;
        if ($this->_order_type($type)) {
            $conditon['order_status'] = $this->_order_type($type);
        }
        $result = $this->_get_orders($conditon);
        $this->success(1, '全部订单', $result);
    }

    /**
     * 获取订单及商品方法
     * @param $condition 查询条件
     * @param int $per_page 单页显示数
     * @return mixed
     * @author 王立
     */
    private function _get_orders($condition, $per_page = self::PER_PAGE)
    {
        $page = intval($this->input->get_post('page'));
        if ($page < 1) {
            $page = 1;
        }
        $offset = ($page - 1) * self::PER_PAGE;
        $orders = $this->app_user_model->get_orders($condition, $per_page, $offset);
        if ($orders['list']) {
            $goods = $this->app_user_model->get_order_goods(array_column($orders['list'], 'order_id'));
            $goods || $this->failure(0, '订单商品为空');
            $order_goods = [];
            foreach ($goods as $v) {
                $order_goods[$v['order_id']][] = array(
                    'goods_name' => $v['goods_name'],
                    'goods_img' => img_url($v['goods_image']),
                    'spec_info' => $v['specification'],
                    'price' => $v['price'],
                    'quantity' => $v['quantity']
                );
            }
            foreach ($orders['list'] as &$order) {
                $order['goods'] = $order_goods[$order['order_id']];
            }
            foreach ($orders['list'] as &$v) {
                $v['extend_confirm'] = (!$v['extend_confirm'] && ((($order['auto_comfirm_time'] - time())) < self::EXTEND_CONFIRM_TIME)) ? 0 : 1;
                $v['btn_type'] = $this->_btn_type($v['order_status'], $v['extend_confirm']);
                unset($v['extend_confirm'], $v['auto_comfirm_time']);
            }
        }
        $orders['page_size'] = self::PER_PAGE;
        return $orders;
    }

    /**
     * 过滤订单类型
     * @param int $type 类型
     * @return bool|mixed
     * @author 王立
     */
    private function _order_type($type = 1)
    {
        $order_type = array(
            1 => '',
            2 => ORDER_UNPAY,
            3 => ORDER_PAID,
            4 => ORDER_SHIPPED,
            5 => ORDER_FINISHED
        );
        if (!isset($order_type[$type])) {
            return false;
        }
        return $order_type[$type];
    }

    /**
     * 订单状态下可操作按钮
     * @param $order_status 订单状态
     * @param int $extend_confirm 是否已经延长确认收货 默认未延长
     * @return array
     * @author 王立
     */
    private function _btn_type($order_status, $extend_confirm = 0)
    {
        //增加评价功能之后转为常量
        //1:付款 2:取消订单 3确认收货，4查看物流，5，延长后货，6删除订单，7评价
        $rule[ORDER_CANCELED] = array(6);
        $rule[ORDER_UNPAY] = array(1, 2);
        $rule[ORDER_PAID] = array();
        $rule[ORDER_SHIPPED] = $extend_confirm ? array(3) : array(3, 5);
        $rule[ORDER_FINISHED] = array(6);
        if (!isset($rule[$order_status])) {
            return array();
        }
        return $rule[$order_status];
    }

    public function order_view()
    {
        $this->check_user();
        $uid = $this->uid;
        $order_id = intval($this->input->post('order_id'));

        $ret = $this->app_user_model->get_order(array('buyer_id' => $uid, 'order_id' => $order_id));
        if ($ret) {
            $data['order_info']['discount'] = $ret['discount'];
            $data['order_info']['order_sn'] = $ret['order_sn'];
            $data['order_info']['order_status'] = $ret['order_status'];
            $order_extm = $this->app_user_model->order_extm($ret['order_id']);
            $data['order_info']['consignee'] = $order_extm['consignee'];
            $data['order_info']['mobile'] = $order_extm['mobile'];
            $data['order_info']['tel'] = $order_extm['tel'];
            $data['order_info']['store_name'] = $ret['store_name'];
            $data['order_info']['store_id'] = $store_id = $ret['seller_id'];
            $data['order_info']['address'] = $order_extm['region_name'] . $order_extm['address'];
            //店铺联系方式
            $store_info = $this->app_user_model->get_store($store_id);
            $data['order_info']['store_tel'] = $store_info['tel'];
            $data['order_info']['store_im_qq'] = $store_info['im_qq'];
            $data['order_info']['is_express'] = $ret['invoice_no'] > 0 ? 1 : 0;
            //物流信息
            if ($data['order_info']['is_express']) {
                $this->load->library('express');
                $express_info = $this->express->get_order($ret['invoice_no'], $ret['express_name']);
                $data['express_list'] = $express_info['data'];
            }
            //订单商品
            $temp = $this->app_user_model->get_order_goods(array($ret['order_id']));
            foreach ($temp as $key => $v) {
                $arr[$key]['goods_id'] = $v['goods_id'];
                $arr[$key]['order_goods_id'] = $v['rec_id'];
                $arr[$key]['goods_name'] = $v['goods_name'];
                $arr[$key]['goods_img'] = img_url($v['goods_image']);
                $arr[$key]['quantity'] = $v['quantity'];
                $arr[$key]['order_goods_status'] = $v['order_goods_status'];
                $arr[$key]['price'] = $v['discounted_price'];
                $arr[$key]['spec_info'] = $v['specification'];
            }
            $data['goods_list'] = $arr;
            $this->success(1, '数据返回成功', $data);
        } else {
            $this->failure(0, '订单错误');
        }
    }
}