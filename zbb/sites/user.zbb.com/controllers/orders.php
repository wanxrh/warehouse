<?php

/**
 * 用户中心控制器
 */
class Orders extends User_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('order_model');
        // 初始化分页属性
        $this->per_page = 5;
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;
    }

    public function view()
    {
        $user_id = get_user()['id'];
        $order_id = intval($this->input->get('order_id'));
        //判断订单是否输入自己的
        $ret = $this->order_model->check_order($order_id, $user_id);
        if (!$ret) {
            show_error('订单号或状态错误');
        }
        //收货信息
        $data['order_extm'] = $this->order_model->get_order_extm($ret['order_id']);
        //订单信息
        $data['order_info'] = $this->order_model->get_order_info($ret['order_id']);
        //订单商品
        $data['order_goods'] = $this->order_model->get_goods_info($ret['order_id']);
        $this->load->view('order/view', $data);
    }

    public function cancel()
    {
        $user_id = get_user()['id'];
        $order_id = intval($this->input->get('order_id'));
        //判断订单是否输入自己的
        $ret = $this->order_model->check_order($order_id, $user_id, ORDER_UNPAY);
        if (!$ret) {
            show_error('订单号或状态错误');
        }
        //订单取消
        $temp = $this->order_model->cancel($ret['order_id']);
        if ($temp) {
            ajax_success('取消成功');
        } else {
            ajax_error('取消失败');
        }
    }

    public function lists()
    {
        //表单参数
        $data['goods_name'] = $goods_name = filter_sql($this->input->get('goods_name'));
        $data['add_time_from'] = $add_time_from = strtotime($this->input->get('add_time_from'));
        $data['add_time_to'] = $add_time_to = strtotime($this->input->get('add_time_to'));
        $data['buyer_name'] = $buyer_name = $this->input->get('buyer_name');
        $data['order_sn'] = $order_sn = filter_sql($this->input->get('order_sn'));
        $data['status'] = $order_status = filter_sql($this->input->get('status'));

        //查询所有订单
        $result = $this->order_model->get_orders($goods_name,$order_sn,$add_time_from,$add_time_to,$order_status,$buyer_name,$this->per_page,$this->offset);
        if ($result['list']) {
            $ids=array_column($result['list'],'order_id');
            $res = $this->order_model->get_order_goods($ids);
            $data['order_goods'] = $res;
        }
        // 分页
        $total = $result['total'];
        $url_format = "/orders/lists/%d?" . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($total / $this->per_page), $url_format);
        $data['list'] = $result['list'];
//        print_r($data);die;
        $this->load->view('order/lists', $data);
    }
    /*
     修改快递
     */
    public function express(){
        $order_id = intval($this->input->post('order_id'));
        $express_name = filter_sql($this->input->post('express_name'));//快递公司
        $invoice_no = filter_sql($this->input->post('invoice_no'));//快递单号

        $data = array(
            'express_name'=>$express_name,
            'invoice_no'=>$invoice_no,
        );
        $ret = $this->order_model->express($order_id,$data);
        if($ret){
            ajax_success('修改成功');
        }else{
            ajax_error('修改失败');
        }
    }
    /**
     * 导出xls
     */
    function exportxls()
    {
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment; filename=' . date("Ymd", time()) . '.xls');
        header('Pragma: no-cache');
        header('Expires: 0');
        $data = $this->_get_try_data();
        $title = array(
            '订单号',
            '买家名称',
            '订单下单时间',
            '订单付款时间',
            '订单总价',
            '订单状态',
            '物流公司',
            '物流公司单号',
            '买家留言',
            '收件姓名',
            '收件街道',
            '收件手机',
            '发货备注',
            '宝贝标题',
            '商品数量',
        );
        $arr = array();
        // 数据字段处理
        $res = order_status_name();
        if($data['list']) {
            foreach ($data['list'] as $key => $value) {

                $arr [$key] ['order_sn'] = '#' . $value ['order_sn'];
                $arr [$key] ['buyer_name'] = $value ['buyer_name'];
                $arr [$key] ['add_time'] = '#' . date("Y-m-d H:i:s", $value['add_time']);
                $arr [$key] ['pay_time'] = '#' . date("Y-m-d H:i:s", $value['pay_time']);
                $arr [$key] ['order_amount'] = $value ['order_amount'];
                $arr [$key] ['order_status'] = $res[$value ['order_status']];
                $arr [$key] ['postscript'] = $value ['postscript'];
                $arr [$key] ['express_name'] = $value ['express_name'];
                $arr [$key] ['invoice_no'] = $value ['invoice_no'];
                $arr [$key] ['user_name'] = $value ['consignee'];
                $arr [$key] ['address'] = $value ['region_name'] . ' ' . $value ['address'];
                $arr [$key] ['mobile'] = $value ['mobile'];
                $arr [$key] ['comment'] = $value ['comment'];
            }
            foreach ($data['order_goods'] as $key => $value) {

                $arr [$key] ['goods_name'] = $value ['goods_name'];
            }
            foreach ($data['quantity'] as $key => $value) {
                $arr [$key] ['quantity'] = $value ['quantity'];
            }
        }
        echo iconv('utf-8', 'gbk', implode("\t", $title)) . "\n";
        foreach ($arr as $v) {
            echo iconv('utf-8', 'gbk', implode("\t", $v)) . "\n";
        }
    }

    private function _get_try_data()
    {
        //获取宝贝名称
        $goods_name = filter_sql($this->input->get('goods_name', TRUE));
        //获取下单时间（订单生成时间）。
        $add_time_from = $this->input->get('add_time_from', TRUE);
        $add_time_to = $this->input->get('add_time_to', TRUE);
        if ($add_time_to != '') {
            $time_to = strtotime($add_time_to) + 3600 * 24;
        } else {
            $time_to = strtotime($add_time_to);
        }
        $buyer_name = $this->input->get('buyer_name', TRUE);
        $order_sn = filter_sql($this->input->get('order_sn'));
        $order_status = $this->input->get('status');
        //查询所有订单
        $result = $this->order_model->get_orders_xls($goods_name, strtotime($add_time_from), $time_to, $order_sn, $order_status, $buyer_name);

        if ($result) {
            $ids=array_column($result,'order_id');
            $results = $this->order_model->get_order_goods_xls($ids);
            $data['order_goods'] = $results;
            $quantity = $this->order_model->get_order_goods_quantity($ids);
            if($quantity){
                $data['quantity'] = $quantity;
            }
        }
        $data['list'] = $result;
        return $data;
    }

    /*
  * 物流接口
  */
    public function get_express()
    {
        $order_id = intval($this->input->post('order_id'));
        $order_info = $this->order_model->check_order($order_id, get_user()['id']);
        $this->load->library('express');
        $ret = $this->express->get_order($order_info['invoice_no'], $order_info['express_name']);
        ajax_success($ret['data']);
    }
}