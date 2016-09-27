<?php

/*
 * 用户基础控制器
 */

class Aftermarket extends App_Controller
{
    const REFUND_TYPE = 1;//申请退款
    const RETURN_TYPE = 2;//申请退货
    const REFUSE_REFUND_TYPE = 3;//拒绝退款
    const REFUSE_RETURN_TYPE = 4;//拒绝退货

    //售后详情按钮
    const CANCEL_BTN = 1;//1撤销 aftermarket/cancel
    const MODIFY_BTN = 2;//2修改申请 aftermarket/modify
    const RETURN_BTN = 3;//3退货 aftermarket/return_action
    const EXTEND_BTN = 4;//4延长时间 aftermarket/extend
    const MODIFY_RETURN_BTN = 5;//5修改申请（修改退货信息）aftermarket/modify_return
    const INTERVENE_BTN = 6;//6申请客服介入 aftermarket/intervene

    const PROOF_IMG_MAX_SIZE = 5242880;//5*1024*1024 凭证上传最大szie
    const PROOF_IMG_MAX_MUNS = 3;//凭证最大上传数量
    const EXTEND_GOODS_RETURN_TIME = 259200;//买家退货，延长卖家响应时间 3*86400
    const AFTERMARKET_INTERVENE_COUNTDOWN = 172800;//申请客服介入倒计时 2*86400

    const PER_PAGE = 20;//订单列表单页条数

    public function __construct()
    {
        parent::__construct();
        $this->load->model('aftermarket_model');
    }

    /**
     * 售后申请
     * @author 王立
     */
    public function apply()
    {
        $order_id = $this->get_uint('order_id');
        $rec_id = $this->get_uint('order_goods_id');
        $this->check_user();
        $uid = $this->uid;

        /*$order_id = 10;
        $rec_id = 10;
        $uid = 2091722708;*/

        $order = $this->check_order($order_id, $uid, array(ORDER_PAID, ORDER_SHIPPED));
        $order_goods = $this->check_order_goods($order_id, $rec_id, array(ORDER_GOODS_PAID, ORDER_GOODS_SHIPPED, ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING));
        $store = $this->aftermarket_model->get_store(array('store_id' => $order['seller_id']));
        $data['goods'] = array(
            'store_tel' => $store['tel'],
            'store_im_qq' => $store['im_qq'],
            'order_id' => $order_id,
            'order_goods_id' => $rec_id,
            'goods_img' => img_url($order_goods['goods_image']),
            'goods_name' => $order_goods['goods_name'],
            'spec_info' => $order_goods['specification'],
            'price' => $order_goods['price'],
            'quantity' => $order_goods['quantity'],
            'total' => $order_goods['discounted_price'],
            'default_money' => $order_goods['discounted_price'],
            'immutable' => 1,
            'apply_btn' => 0
        );
        if ($order['order_status'] == ORDER_SHIPPED) {
            $data['goods']['apply_btn'] = 1;
            $data['goods']['immutable'] = 0;
        }
        $refund = $this->aftermarket_model->get_refund(array('target_id' => $rec_id, 'status <>' => AFTERMARKET_CLOSE));
        if ($refund) {
            $data['modify'] = array(
                'btn_type' => $refund['type'],
                'refund_reason' => $refund['apply_reason'],
                'refund_money' => $refund['money'],
                'supplement' => $refund['supplement'],
                'proof' => explode(',', $refund['proof_img']),
                'img_url' => config_item('domain_img')
            );
        }
        //获取原因
        $data['refund_reason'] = $this->aftermarket_model->get_apply_reason(array('type' => self::REFUND_TYPE));
        if ($data['goods']['apply_btn']) {
            $data['return_reason'] = $this->aftermarket_model->get_apply_reason(array('type' => self::RETURN_TYPE));
        }

        $this->success(1, '状态可申请', $data);
    }

    /**
     * 申请售后操作
     * @author 王立
     */
    public function apply_action()
    {
        $order_id = $this->get_uint('order_id');
        $rec_id = $this->get_uint('order_goods_id');
        $apply_reason_id = $this->get_uint('apply_reason_id');
        $money = $this->get_ufloat('money');
        $supplement = $this->get_string('supplement');
        $proof_img = $this->get_string('proof');
        $apply_type = intval($this->input->get_post('apply_type'));
        if ($apply_type) {
            $apply_type = $this->get_uint('apply_type');
        }
        $this->check_user();
        $uid = $this->uid;

        $apply_type = $apply_type ? $apply_type : self::REFUND_TYPE;
        $goods_status_rule = array(
            self::REFUND_TYPE => ORDER_GOODS_DRAWBACK,
            self::RETURN_TYPE => ORDER_GOODS_RETURNING
        );
        if (!isset($goods_status_rule[$apply_type])) {
            $this->failure(0, '申请售后类型不存在');
        }
        $proof_img = $this->check_proof_img($proof_img);
        $order = $this->check_order($order_id, $uid, array(ORDER_PAID, ORDER_SHIPPED));
        $order_goods = $this->check_order_goods($order_id, $rec_id, array(ORDER_GOODS_PAID, ORDER_GOODS_SHIPPED));

        //判断申请类型，得出不同的定时器任务
        if ($order_goods['order_goods_status'] == ORDER_GOODS_PAID) {
            if ($money != $order_goods['discounted_price']) $this->failure(0, '申请退款金额错误');
            $timer = UNSHIP_DRAWBACK_TIMER;
            $auto_time = AUTO_UNSHIP_DRAWBACK;
        } else {
            if ($money <= 0 || $money > $order_goods['discounted_price']) $this->failure(0, '申请退款金额错误');
            $timer = $apply_type == 1 ? SHIPPED_DRAWBACK_TIMER : SHIPPED_UNRESPOND_RETURN_TIMER;
            $auto_time = $apply_type == 1 ? AUTO_SHIPPED_DRAWBACK : AUTO_SHIPPED_UNRESPOND_RETURN;
        }
        //检测申请原因ID是否合法
        $apply_reason = $this->aftermarket_model->apply_reason(array('id' => $apply_reason_id));
        if (!$apply_reason) {
            $this->failure(0, '申请售后原因不明');
        }
        $result = $this->aftermarket_model->add_refund_apply($uid, $order['seller_id'], $order_id, $rec_id, $apply_type, $goods_status_rule[$apply_type], $money, $apply_reason, $supplement, $proof_img, $timer, $auto_time);
        if (!$result) {
            $this->failure(1, '申请退款失败，请稍后重试');
        }
        $this->success(1, '申请成功');
    }

    /**
     * 撤销售后申请
     * @author 王立
     */
    public function cancel()
    {
        $refund_id = $this->get_uint('refund_id');
        $this->check_user();
        $uid = $this->uid;

        $refund = $this->check_refund($refund_id);
        $this->check_order($refund['order_id'], $uid);
        $this->check_order_goods($refund['order_id'], $refund['target_id'], array(ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING));

        $cancel = $this->aftermarket_model->cancelAftermarket($refund);
        if (!$cancel) {
            $this->failure(1, '撤销失败');
        }
        $this->success(1, '撤销成功');
    }

    /**
     * 修改售后申请
     * @author 王立
     */
    public function modify()
    {
        $refund_id = $this->get_uint('refund_id');
        $rec_id = $this->get_uint('order_goods_id');
        $apply_reason_id = $this->get_uint('apply_reason_id');
        $money = $this->get_ufloat('money');
        $supplement = $this->get_string('supplement');
        $proof_img = $this->get_string('proof');
        $apply_type = intval($this->input->get_post('apply_type'));
        if ($apply_type) {
            $apply_type = $this->get_uint('apply_type');
        }
        $this->check_user();
        $uid = $this->uid;

        $refund = $this->check_refund($refund_id, array(AFTERMARKET_REFUSE, AFTERMARKET_INTERVENE));
        if ($refund['target_id'] != $rec_id) {
            $this->failure(0, '退款目标不一致');
        }
        $proof_img = $this->check_proof_img($proof_img);
        //只有发货状态下的售后才能修改售后
        $this->check_order($refund['order_id'], $uid, ORDER_SHIPPED);
        $order_goods = $this->check_order_goods($refund['order_id'], $refund['target_id'], array(ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING));
        //售后类型
        $apply_type = $apply_type ? $apply_type : self::REFUND_TYPE;
        $goods_status_rule = array(
            self::REFUND_TYPE => ORDER_GOODS_DRAWBACK,
            self::RETURN_TYPE => ORDER_GOODS_RETURNING
        );
        if (!isset($goods_status_rule[$apply_type])) {
            $this->failure(0, '申请售后类型不存在');
        }

        //检测申请原因ID是否合法
        $apply_reason = $this->aftermarket_model->apply_reason(array('id' => $apply_reason_id));
        if (!$apply_reason) {
            $this->failure(0, '申请售后原因不明');
        }

        if ($money <= 0 || $money > $order_goods['discounted_price']) $this->failure(0, '申请退款金额错误');
        //TODO 判断是发货状态下的仅退款修改，还是发货下退款退货，或者客服介入的修改，操作删除不同定时器，插入新定时器
        $timer = null;
        $auto_time = null;
        $old_timer = null;
        if ($refund['status'] == AFTERMARKET_REFUSE) {
            $timer = $apply_type == 1 ? SHIPPED_DRAWBACK_TIMER : SHIPPED_UNRESPOND_RETURN_TIMER;
            $auto_time = $apply_type == 1 ? AUTO_SHIPPED_DRAWBACK : AUTO_SHIPPED_UNRESPOND_RETURN;
            $old_timer = $refund['type'] == 1 ? SHIPPED_DRAWBACK_TIMER : SHIPPED_UNRESPOND_RETURN_TIMER;
        } elseif ($refund['status'] == AFTERMARKET_INTERVENE) {
            $auto_time = self::AFTERMARKET_INTERVENE_COUNTDOWN;
        }
        $result = $this->aftermarket_model->modify_refund($refund, $apply_type, $goods_status_rule[$apply_type], $money, $apply_reason, $supplement, $proof_img, $old_timer, $timer, $auto_time);
        if (!$result) {
            $this->failure(1, '修改申请，请稍后重试');
        }
        $this->success(1, '修改申请成功');
    }

    /**
     * 买家退货信息填写页面
     * @author 王立
     */
    public function handle_return()
    {
        $refund_id = $this->get_uint('refund_id');
        $this->check_user();
        $uid = $this->uid;

        $refund = $this->check_refund($refund_id, array(AFTERMARKET_AGREE, AFTERMARKET_REFUSE_RETURN));
        //只有发货状态下的售后才能修改售后
        $order = $this->check_order($refund['order_id'], $uid, ORDER_SHIPPED);
        $order_goods = $this->check_order_goods($refund['order_id'], $refund['target_id'], ORDER_GOODS_RETURNING);

        $store = $this->aftermarket_model->get_store(array('store_id' => $order['seller_id']));
        $data['goods'] = array(
            'store_tel' => $store['tel'],
            'store_im_qq' => $store['im_qq'],
            'refund_id' => $refund_id,
            'order_id' => $refund['order_id'],
            'rec_id' => $refund['target_id'],
            'goods_img' => img_url($order_goods['goods_image']),
            'goods_name' => $order_goods['goods_name'],
            'price' => $order_goods['price'],
            'quantity' => $order_goods['quantity'],
            'total' => $order_goods['discounted_price']
        );
        $goods_return = $this->aftermarket_model->get_goods_return(array('refund_id' => $refund_id, 'return_status' => 1));
        if ($goods_return) {
            $data['modify'] = array(
                'express' => $goods_return['return_express'],
                'express_sn' => $goods_return['return_express_sn'],
                'supplement' => $refund['supplement'],
                'proof' => explode(',', $refund['proof_img']),
                'img_url' => config_item('domain_img')
            );
        }
        //获取快递公司数组
        $data['express'] = array_values(array_flip(get_ship()));
        $this->success(1, '填写退货信息', $data);
    }

    /**
     * 买家填写退货信息请求
     * @author 王立
     */
    public function return_action()
    {
        $refund_id = $this->get_uint('refund_id');
        $express = $this->get_string('express');
        $express_sn = $this->get_string('express_sn');
        $supplement = trim($this->input->get_post('supplement'));
        if ($supplement) {
            $supplement = $this->get_string('supplement');
        }
        $proof_img = $this->get_string('proof');
        $this->check_user();
        $uid = $this->uid;

        //检测快递是否合法
        if (!isset(get_ship()[$express])) {
            $this->failure(0, '不支持此快递公司');
        }
        $proof_img = $this->check_proof_img($proof_img);
        $refund = $this->check_refund($refund_id, AFTERMARKET_AGREE);

        $this->check_order($refund['order_id'], $uid, ORDER_SHIPPED);
        $this->check_order_goods($refund['order_id'], $refund['target_id'], ORDER_GOODS_RETURNING);

        //检测是否有卖家提供的退货地址
        $goods_return = $this->aftermarket_model->get_goods_return(array('refund_id' => $refund_id));
        if (!$goods_return) {
            $this->failure(0, '卖家退货地址未获取');
        }
        if ($goods_return['return_status']) {
            $this->failure(0, '买家已经退货');
        }
        $result = $this->aftermarket_model->reutrnGoods($refund, $express, $express_sn, $supplement, $proof_img);
        if (!$result) {
            $this->failure(1, '填写退货信息失败');
        }
        $this->success(1, '填写退货信息成功');
    }

    /**
     * 买家修改退货物流信息
     * @author 王立
     */
    public function modify_return()
    {
        $refund_id = $this->get_uint('refund_id');
        $express = $this->get_string('express');
        $express_sn = $this->get_string('express_sn');
        $supplement = trim($this->input->get_post('supplement'));
        if ($supplement) {
            $supplement = $this->get_string('supplement');
        }
        $proof_img = $this->get_string('proof');
        $this->check_user();
        $uid = $this->uid;

        //检测快递是否合法
        if (!isset(get_ship()[$express])) {
            $this->failure(0, '不支持此快递公司');
        }
        $proof_img = $this->check_proof_img($proof_img);
        $refund = $this->check_refund($refund_id, AFTERMARKET_REFUSE_RETURN);

        $this->check_order($refund['order_id'], $uid, ORDER_SHIPPED);
        $this->check_order_goods($refund['order_id'], $refund['target_id'], ORDER_GOODS_RETURNING);

        //检测是否有卖家提供的退货地址
        $goods_return = $this->aftermarket_model->get_goods_return(array('refund_id' => $refund_id));
        if (!$goods_return) {
            $this->failure(0, '卖家退货地址未获取');
        }
        if ($goods_return['return_status'] != 1) {
            $this->failure(0, '该状态下不能修改');
        }
        $result = $this->aftermarket_model->modifyReturn($refund, $express, $express_sn, $supplement, $proof_img);
        if (!$result) {
            $this->failure(1, '修改退货信息失败');
        }
        $this->success(1, '修改退货信息成功');
    }

    /**
     * 买家退货，延后卖家响应时间
     * @author 王立
     */
    public function extend()
    {
        $refund_id = $this->get_uint('refund_id');
        $this->check_user();
        $uid = $this->uid;

        $refund = $this->check_refund($refund_id, AFTERMARKET_AGREE);
        $this->check_order($refund['order_id'], $uid, ORDER_SHIPPED);
        $this->check_order_goods($refund['order_id'], $refund['target_id'], ORDER_GOODS_RETURNING);

        $goods_return = $this->aftermarket_model->goods_return_info(array('refund_id' => $refund_id));
        if (!$goods_return) {
            $this->failure(0, '卖家未同意退货');
        }
        if (!$goods_return['return_status']) {
            $this->failure(0, '买家未退货');
        }
        if ($goods_return['extend_time']) {
            $this->failure(0, '不能多次延长时间');
        }
        $result = $this->aftermarket_model->extendGoodsReturn($refund, self::EXTEND_GOODS_RETURN_TIME);
        if (!$result) {
            $this->failure(1, '延长时间失败');
        }
        $this->success(1, '延长时间成功');
    }

    /**
     * 申请客服介入
     * @author 王立
     */
    public function intervene()
    {
        $refund_id = $this->get_uint('refund_id');
        $this->check_user();
        $uid = $this->uid;

        $refund = $this->check_refund($refund_id, array(AFTERMARKET_REFUSE, AFTERMARKET_REFUSE_RETURN));

        $this->check_order($refund['order_id'], $uid, ORDER_SHIPPED);
        $this->check_order_goods($refund['order_id'], $refund['target_id'], array(ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING));

        $result = $this->aftermarket_model->applyIntervene($refund, self::AFTERMARKET_INTERVENE_COUNTDOWN);
        if (!$result) {
            $this->failure(1, '申请客服介入失败');
        }
        $this->success(1, '申请客服介入成功');
    }

    /**
     * 售后详情
     * @author 王立
     */
    public function details()
    {
        $refund_id = $this->get_uint('refund_id');
        $this->check_user();
        $uid = $this->uid;

        $refund = $this->check_refund($refund_id);

        $this->check_order($refund['order_id'], $uid, array(ORDER_PAID, ORDER_SHIPPED, ORDER_CANCELED, ORDER_FINISHED));
        $this->check_order_goods($refund['order_id'], $refund['target_id'], array(ORDER_GOODS_PAID, ORDER_GOODS_SHIPPED, ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING, ORDER_GOODS_DRAWBACKED, ORDER_GOODS_RETURNED));

        //按钮类型
        $btn = array(
            AFTERMARKET_HANDLE => [self::CANCEL_BTN],//等待卖家处理
            AFTERMARKET_AGREE => [self::CANCEL_BTN, self::RETURN_BTN],//卖家同意
            AFTERMARKET_REFUSE => [self::INTERVENE_BTN, self::MODIFY_BTN],//卖家拒绝申请
            AFTERMARKET_GOODS_RETURNING => [self::EXTEND_BTN],//买家退回商品
            AFTERMARKET_REFUSE_RETURN => [self::INTERVENE_BTN, self::MODIFY_RETURN_BTN],//卖家拒绝签收退货商品
            AFTERMARKET_INTERVENE => [self::MODIFY_BTN],//申请客服介入
            AFTERMARKET_SUCCESS => [],//退款成功
            AFTERMARKET_CLOSE => []//退款关闭
        );
        if ($refund['status'] == AFTERMARKET_GOODS_RETURNING) {
            $goods_return = $this->aftermarket_model->get_goods_return(array('refund_id' => $refund_id, 'extend_time' => 1));
            $goods_return && $btn[AFTERMARKET_GOODS_RETURNING] = [];
        }
        $data['info'] = array(
            'order_id' => $refund['order_id'],
            'order_goods_id' => $refund['target_id'],
            'refund_sn' => $refund['refund_sn'],
            'btn_type' => $btn[$refund['status']],
            'countdown' => $refund['countdown'],
            'now_time' => time(),
            'type' => trim($refund['status'])
        );
        if ($refund['status'] == AFTERMARKET_SUCCESS) {
            $data['info']['refund_monry'] = $refund['money'];
        }
        if ($refund['status'] == AFTERMARKET_HANDLE) {
            $data['info']['type_desc'] = $refund['type'];
        }

        //获取售后日志，模板输出
        $data['log'] = $this->aftermarket_model->refund_log($refund_id);
        $this->success(1, '售后详情', $data);
    }

    /**
     * 售后商品列表
     * @author 王立
     */
    public function refund_list()
    {
        $page = intval($this->input->get_post('page'));
        if ($page < 1) {
            $page = 1;
        }
        $offset = ($page - 1) * self::PER_PAGE;
        $this->check_user();
        $uid = $this->uid;

        $data = $this->aftermarket_model->refundList($uid, self::PER_PAGE, $offset);
        $btn = array(
            AFTERMARKET_HANDLE => [self::CANCEL_BTN],
            AFTERMARKET_AGREE => [self::CANCEL_BTN, self::RETURN_BTN],
            AFTERMARKET_REFUSE => [self::INTERVENE_BTN, self::MODIFY_BTN],
            AFTERMARKET_GOODS_RETURNING => [self::EXTEND_BTN],
            AFTERMARKET_REFUSE_RETURN => [self::INTERVENE_BTN, self::MODIFY_RETURN_BTN],
            AFTERMARKET_INTERVENE => [self::MODIFY_BTN],
            AFTERMARKET_SUCCESS => [],
            AFTERMARKET_CLOSE => []
        );
        $status_arr = array(
            AFTERMARKET_HANDLE => '退款中',//等待卖家处理
            AFTERMARKET_AGREE => '卖家同意退货',//卖家同意
            AFTERMARKET_REFUSE => '商家已拒绝',//卖家拒绝申请
            AFTERMARKET_GOODS_RETURNING => '等待卖家退款',//买家退货，等待卖家退款
            AFTERMARKET_REFUSE_RETURN => '商家拒绝退款',//卖家拒绝退货
            AFTERMARKET_INTERVENE => '等待客服处理',//申请客服介入
            AFTERMARKET_SUCCESS => '退款成功',//退款成功
            AFTERMARKET_CLOSE => '退款关闭'//退款关闭
        );
        foreach ($data['list'] as &$v) {
            $v['goods_img'] = img_url($v['goods_image']);
            $v['refund_status'] = isset($status_arr[$v['status']]) ? $status_arr[$v['status']] : '';
            $v['btn_type'] = ($v['status'] == AFTERMARKET_GOODS_RETURNING && $v['extend_time']) ? [] : $btn[$v['status']];
            if ($v['status'] == AFTERMARKET_SUCCESS) {
                $v['refund_monry'] = $v['money'];
            }
        }
        $data['page_size'] = self::PER_PAGE;
        $this->success(1, '售后列表', $data);
    }

    /**
     * 凭证上传
     * @author 王立
     */
    public function proof_upload()
    {
        $this->check_user();

        $img = $this->appUpload('proof', self::PROOF_IMG_MAX_SIZE);
        $this->success(1, '上传成功', $img);
    }

    /**
     * 检测订单
     * @param $order_id 订单ID
     * @param $uid 用户ID
     * @param $order_status 订单状态条件
     * @return mixed
     * @author 王立
     */
    protected function check_order($order_id, $uid, $order_status = null)
    {
        $order = $this->aftermarket_model->get_order(array('order_id' => $order_id, 'buyer_id' => $uid));
        if (!$order) {
            $this->failure(0, '订单不存在');
        }
        if ($order['del_status'] != 0) {
            $this->failure(1, '订单已删除');
        }
        if ($order_status) {
            if (is_array($order_status)) {
                in_array($order['order_status'], $order_status) || $this->failure(2, '订单状态错误');
            } else {
                if ($order['order_status'] != $order_status) $this->failure(2, '订单状态错误');
            }
        }
        return $order;
    }

    /**
     * 检测订单商品
     * @param $order_id 订单ID
     * @param $rec_id 订单商品ID
     * @param $order_goods_status 订单商品状态
     * @return mixed
     * @author 王立
     */
    protected function check_order_goods($order_id, $rec_id, $order_goods_status)
    {
        $order_goods = $this->aftermarket_model->get_order_goods(array('order_id' => $order_id, 'rec_id' => $rec_id));
        if (!$order_goods) {
            $this->failure(0, '订单商品不存在');
        }
        if ($order_goods_status) {
            if (is_array($order_goods_status)) {
                in_array($order_goods['order_goods_status'], $order_goods_status) || $this->failure(1, '订单商品状态错误');
            } else {
                if ($order_goods['order_goods_status'] != $order_goods_status) $this->failure(1, '订单商品状态错误');
            }
        }
        return $order_goods;
    }

    /**
     * 检测售后申请
     * @param $refund_id 申请售后ID
     * @param bool $status 状态
     * @return mixed
     * @author 王立
     */
    protected function check_refund($refund_id, $status = false)
    {
        $refund = $this->aftermarket_model->get_refund(array('id' => $refund_id));
        if (!$refund) {
            $this->failure(0, '售后申请不存在');
        }
        if ($status !== false) {
            if (is_array($status)) {
                in_array($refund['status'], $status) || $this->failure(1, '售后申请状态错误');
            } else {
                if ($refund['status'] != $status) $this->failure(1, '售后申请状态错误');
            }
        }
        return $refund;
    }

    /**
     * 检测凭证图片
     * @param $img 图片
     * @return string
     * @author 王立
     */
    private function check_proof_img($img)
    {
        $proof_img = json_decode($img, true);
        if (!$proof_img) {
            $this->failure(0, '凭证图片json解析错误：' . $img);
        }
        if (count($proof_img) <= 0 || count($proof_img) > self::PROOF_IMG_MAX_MUNS) {
            $this->failure(0, '凭证图片上传数量错误');
        }
        return implode(',', $proof_img);
    }
}