<?php


/**
 * Class Paynotify支付通知控制器
 */
class Paynotify extends CI_Controller
{

    const PAY_TRADESTATUS = 0;
    const FINISH_TRADESTATUS = 1;
    const REFUND_TRADESTATUS = 2;
    const BILATERAL_REFUND_TRADESTATUS = 3;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('paynotify_model');
    }

    /**
     * 支付成功通知
     * @author 王立
     */
    public function paid()
    {
        $notify = $this->verifyNotify(self::PAY_TRADESTATUS);
        $paynotifyLogId = $this->paynotifyLog($notify);
        //验证商品状态-未支付
        $notify['jsonData'] = json_decode($notify['jsonData'], true);
        $orderSn_arr = array_column($notify['jsonData']['arrayData'], 'orderNumber');
        $orders = $this->check_paynotify_orders(ORDER_UNPAY, $orderSn_arr);
        $result = $this->_change_order_status($notify['jsonData']['tradeStatus'], $orders);
        if (!$result) {
            exit('事务回滚');
        }
        ob_clean();
        $this->hulianpayment->verify_result(true);
        $this->paynotifyPostAction($paynotifyLogId);
    }

    /**
     * 确认收货成功通知
     * @author 王立
     */
    public function finished()
    {
        $notify = $this->verifyNotify(self::FINISH_TRADESTATUS);
        $paynotifyLogId = $this->paynotifyLog($notify);
        $jsonData = json_decode($notify['jsonData'], true);
        $confirmSn_arr = [];
        foreach ($jsonData['arrayData'] as $Data) {
            if ($Data['toUserCode'] != SERVICE_CHARGES_CHARGEDID) {
                $confirmSn_arr[] = $Data['orderNumber'];
            }
        }
        if (empty($confirmSn_arr)) {
            exit('确认收货订单为空');
        }
        $orders = $this->check_paynotify_orders(ORDER_SHIPPED, $confirmSn_arr);
        $result = $this->_change_order_status($jsonData['tradeStatus'], $orders);
        if (!$result) {
            exit('事务回滚');
        }
        ob_clean();
        $this->hulianpayment->verify_result(true);
        $this->paynotifyPostAction($paynotifyLogId);
    }

    /**
     * 退款成功通知
     * @author 王立
     */
    public function refunded()
    {
        $notify = $this->verifyNotify(array(self::REFUND_TRADESTATUS, self::BILATERAL_REFUND_TRADESTATUS));
        $paynotifyLogId = $this->paynotifyLog($notify);
        $notify['jsonData'] = json_decode($notify['jsonData'], true);
        $order_goods = $this->check_refund_order($notify['jsonData']['arrayData'][0]['orderNumber']);
        $result = $this->_change_order_status($notify['jsonData']['tradeStatus'], $order_goods);
        if (!$result) {
            exit('事务回滚');
        }
        ob_clean();
        $this->hulianpayment->verify_result(true);
        $this->paynotifyPostAction($paynotifyLogId);

    }

    /**
     * 检测订单
     * @param $order_status 订单正确状态
     * @param $sn 编号
     * @param bool $oSn_field order_sn或者out_order_sn
     * @return mixed
     * @author 王立
     */
    protected function check_paynotify_orders($order_status, $sn, $oSn_field = true)
    {
        $orders = $this->paynotify_model->check_paynotify_orders($order_status, $sn, $oSn_field);
        if (count($sn) != count(array_column($orders, 'order_sn'))) {
            exit('订单状态错误');
        }
        return $orders;
    }

    /**
     * 检测退款合法性
     * @param $refund_sn 退款交易编号
     * @return mixed
     */
    protected function check_refund_order($refund_sn)
    {
        $refund = $this->paynotify_model->get_refund(array('refund_sn' => $refund_sn));
        if (!$refund) {
            exit('退款申请不存在');
        }
        //此段后期可以配置
        $type = array(
            1 => ORDER_GOODS_DRAWBACK,
            2 => ORDER_GOODS_RETURNING
        );
        if (!isset($type[$refund['type']])) {
            exit('退款类型不存在');
        }
        $order_goods = $this->paynotify_model->get_order_goods(array('rec_id' => $refund['target_id'], 'order_goods_status' => $type[$refund['type']]));
        if (!$order_goods) {
            exit('退款商品不存在');
        }
        return $order_goods;
    }

    /**
     * 检测通知参数和交易状态
     * @param $tradeStatus 交易状态
     * @return mixed|void
     * @author 王立
     */
    protected function verifyNotify($tradeStatus)
    {
        $this->load->library('hulianpayment');
        $notify = $this->hulianpayment->verify_notify();
        if ($notify === false) {
            /* 支付参数验证失败 */
            $this->hulianpayment->verify_result(false);
            exit();
        }
        //验证tradeStatus状态
        if (is_array($tradeStatus)) {
            if (!in_array(json_decode($notify['jsonData'])->tradeStatus, $tradeStatus)) {
                exit('交易状态错误');
            }
        } else {
            if (json_decode($notify['jsonData'])->tradeStatus != $tradeStatus) {
                exit('交易状态错误');
            }
        }
        return $notify;
    }

    /**
     * 改变订单状态统一入口
     * @param $tradeStatus
     * @param $data
     * @return mixed
     * @author 王立
     */
    private function _change_order_status($tradeStatus, $data)
    {
        return $this->paynotify_model->change_order_status($tradeStatus, $data);
    }

    /**
     * 记录通知地址和参数
     * @param $notify 通知参数
     * @return mixed
     * @author 王立
     */
    private function paynotifyLog($notify)
    {
        //获取当前地址
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
        $url = "$protocol$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        return $this->paynotify_model->addPaynotifyLog(array('url' => $url, 'params' => http_build_query($notify), 'time' => time()));
    }

    /**
     * 通知成功，删除通知记录
     * @param $paynotifyLogId 通知记录ID
     * @author 王立
     */
    private function paynotifyPostAction($paynotifyLogId)
    {
        $this->paynotify_model->delPaynotifyLog($paynotifyLogId);
    }
}