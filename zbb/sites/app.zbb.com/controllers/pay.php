<?php

/*
 * 支付控制器
 */

class Pay extends App_Controller
{
    const HL_PAYID = 1;//互联支付paymentID
    const ALI_PAYID = 2;//支付宝paymentID
    const WEI_PAYID = 3;//微信支付paymentID
    const EBANK_PAYID = 4;//网银支付paymentID

    public function __construct()
    {
        parent::__construct();
        $this->load->model('pay_model');
    }

    /**
     * 支付接口
     * @author 王立
     */
    public function lightpay()
    {
        $addr_id = $this->get_uint('addr_id');
        $goods_json = $this->get_string('goods_json');
        $payment_id = $this->get_uint('payment_id');
        $from_cart = $this->get_int('from_cart');
        $this->check_user();
        $user = $this->user;
        $uid = $this->uid;

        $goods_arr = json_decode($goods_json, true);
        if (!is_array($goods_arr) || !$goods_arr) {
            $this->failure(0, 'json解析错误，json=' . $goods_json);
        }
        $addr_info = $this->pay_model->check_buyer_addr(array('addr_id' => $addr_id, 'user_id' => $user['id'], 'type' => 0));
        if (!$addr_info) {
            $this->failure(0, '收货地址不存在');
        }
        $this->check_payment($payment_id);
        //验证商品参数
        foreach ($goods_arr as $v) {
            foreach ($v['goods'] as $goods) {
                $params[] = array(
                    'store_id' => $v['store_id'],
                    'goods_id' => $goods['goods_id'],
                    'sku_id' => $goods['sku_id'],
                    'quantity' => $goods['quantity']
                );
            }
        }
        $goods_info = $this->pay_model->_get_goods_info($params);
        if (count($goods_info) != count($params)) {
            $this->failure(0, '商品失效');
        }
        $orderIds = $this->pay_model->create_orders($user, $payment_id, $goods_arr, $goods_info, $addr_info, $from_cart);
        if (!$orderIds) {
            $this->failure(0, '生成订单事务回滚');
        }
        $orders = $this->pay_model->get_orders(array('buyer_id' => $uid, 'order_status' => ORDER_UNPAY), $orderIds);
        $this->choose_payway($payment_id, $uid, $orders);
    }

    /**
     * 订单列表支付，单个订单/多个订单支付
     * @author 王立
     */
    public function continue_pay()
    {
        $orderIds_json = $this->get_string('orderIds_json');
        $payment_id = $this->get_uint('payment_id');
        $this->check_user();
        $uid = $this->uid;

        $orderIds = json_decode($orderIds_json, true);
        if (!is_array($orderIds) || !$orderIds) {
            $this->failure(0, 'json解析错误，json=' . $orderIds_json);
        }
        $this->check_payment($payment_id);
        //更新订单支付渠道
        $this->pay_model->update_order_payment($orderIds, $payment_id);
        $orders = $this->pay_model->get_orders(array('buyer_id' => $uid, 'order_status' => ORDER_UNPAY), $orderIds);
        if (count($orderIds) != count($orders)) {
            $this->failure(0, '订单状态错误');
        }
        $this->choose_payway($payment_id, $uid, $orders);
    }

    /**
     * 确认收货
     * @author 王立
     */
    public function confirm()
    {
        $orderIds_json = $this->get_string('orderIds_json');
        $this->check_user();
        $uid = $this->uid;

        $orderIds = json_decode($orderIds_json, true);
        if (!is_array($orderIds) || !$orderIds) {
            $this->failure(0, 'json解析错误，json=' . $orderIds_json);
        }
        $orders = $this->pay_model->get_orders(array('buyer_id' => $uid, 'order_status' => ORDER_SHIPPED), $orderIds);
        if (count($orderIds) != count($orders)) {
            $this->failure(0, '订单状态错误');
        }
        $created = $this->create_confirm_array($orders);
        $this->load->library('hulianpayment');
        $url = $this->hulianpayment->confirm_payform($created['jsonData'], $created['arrayData']);
        if ($this->hulianpayment->hlpay_error) {
            $this->failure(0, $this->hulianpayment->hlpay_error);
        }
        $this->success(1, '请求互联支付成功', $url);
    }

    /**
     * 选择支付方式
     * @param $payment_id 支付方式ID
     * @param $uid 用户ID
     * @param $orders 订单数组
     * @author 王立
     */
    private function choose_payway($payment_id, $uid, $orders)
    {
        switch ($payment_id) {
            case self::HL_PAYID:
                $this->hl_pay($uid, $orders);
                break;
            case self::ALI_PAYID:
                $this->ali_pay($uid, $orders);
                break;
            case self::WEI_PAYID:
                $this->wei_pay($uid, $orders);
                break;
            case self::EBANK_PAYID:
                $this->ebank_pay($uid, $orders);
                break;
            default:
                break;
        }
    }

    /**
     * 互联支余额支付
     * @param $user_id 用户ID
     * @param $orders 订单二维数组
     * @author 王立
     */
    private function hl_pay($user_id, $orders)
    {
        $created = $this->create_pay_array($user_id, $orders);
        //TODO互联支付
        $this->load->library('hulianpayment');
        $url = $this->hulianpayment->balance_payform($created['jsonData'], $created['arrayData']);
        if ($this->hulianpayment->hlpay_error) {
            $this->failure(0, $this->hulianpayment->hlpay_error);
        }
        $this->success(1, '请求互联支付成功', $url);
    }

    /**
     * 支付宝支付
     * @param $user_id 用户ID
     * @param $orders 订单二维数组
     * @author 王立
     */
    private function ali_pay($user_id, $orders)
    {
        //TODO支付宝支付
        $this->load->library('hulianpayment');
    }

    /**
     * 微信支付
     * @param $user_id 用户ID
     * @param $orders 订单二维数组
     * @author 王立
     */
    private function wei_pay($user_id, $orders)
    {
        $created = $this->create_pay_array($user_id, $orders);
        //TODO微信支付
        $this->load->library('hulianpayment');
        $wx_sdk = $this->hulianpayment->wei_payform($created['jsonData'], $created['arrayData']);
        if ($this->hulianpayment->hlpay_error) {
            $this->failure(0, $this->hulianpayment->hlpay_error);
        }
        $this->success(0, '请求微信SDK数据成功', $wx_sdk);
    }

    /**
     * 网银支付
     * @param $user_id 用户ID
     * @param $orders 订单二维数组
     * @author 王立
     */
    private function ebank_pay($user_id, $orders)
    {
        //TODO网银支付
        $this->load->library('hulianpayment');
    }

    /**
     * 构建支付表单数据
     * @param $user_id 用户ID
     * @param $orders 订单详情二维数组
     * @return array
     * @author 王立
     */
    private function create_pay_array($user_id, $orders)
    {
        $arrayData = [];
        foreach ($orders as $v) {
            $arrayData[] = array(
                'orderNumber' => $v['order_sn'],
                'money' => $v['discount'],
                'title' => $v['order_sn'],
                'toUserCode' => $v['seller_id'],
                'fromUserCode' => $user_id,
                'isHidden' => false
            );
        }
        $jsonData['payMoney'] = array_sum(array_column($orders, 'discount'));;
        $jsonData['fromUserCode'] = $user_id;
        $jsonData['isCombo'] = false;
        return array(
            'jsonData' => $jsonData,
            'arrayData' => $arrayData
        );
    }

    /**
     * 构建确认收货表单数据
     * @param $orders 订单数组
     * @return array
     * @author 王立
     */
    private function create_confirm_array($orders)
    {
        $arrayData = [];
        foreach ($orders as $v) {
            $arrayData[] = array(
                'fromOrder' => $v['order_sn'],
                'orderNumber' => $v['order_confirm_sn'],
                'money' => $v['service_charges'] > 0 ? bcsub($v['order_balance'], $v['service_charges'], 2) : $v['order_balance'],
                'title' => $v['order_sn'],
                'toUserCode' => $v['seller_id'],
                'isHidden' => false
            );
            if ($v['service_charges'] > 0) {
                $arrayData[] = array(
                    'fromOrder' => $v['order_sn'],
                    'orderNumber' => $v['service_charges_sn'],
                    'money' => $v['service_charges'],
                    'title' => $v['order_sn'],
                    'toUserCode' => SERVICE_CHARGES_CHARGEDID,
                    'isHidden' => true
                );
            }
        }
        $jsonData['tradeStatus'] = 1;// 1:交易完成 2:交易关闭 3：金额变更 暂时写死
        return array(
            'jsonData' => $jsonData,
            'arrayData' => $arrayData
        );
    }

    /**
     * 检测支付方式
     * @param $payment_id 支付渠道ID
     * @return mixed
     * @author 王立
     */
    private function check_payment($payment_id)
    {
        $payment = $this->pay_model->payment(array('payment_id' => $payment_id));
        $payment || $this->failure(0, '支付渠道不存在');
        $payment['enabled'] || $this->failure(0, '支付渠道已关闭');
        return $payment;
    }

}