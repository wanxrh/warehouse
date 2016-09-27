<?php

/**
 *    互联支付接口
 *
 */
include('Hulianpay.php');

class Hulianpayment extends Hulianpay
{

    private static $_type_pay = 1; //支付
    private static $_type_refund = 2; //退款
    private static $_type_finish = 3; //确认收货

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 余额支付接口
     * @param $out_jsonData
     * @param $out_arrayData
     * @return string
     * @author 王立
     */
    public function balance_payform($out_jsonData, $out_arrayData)
    {
        $jsonData = $this->create_pay_jsonData($out_jsonData, $out_arrayData);
        $params = array(
            'jsonData' => $jsonData,
            'sign' => $this->_get_guarantee_sign($jsonData)
        );
        return $this->_complete_url(GUARANTEE_TRADING_FREEZE, $params);
    }

    /**
     * 微信接口
     * @param $out_jsonData
     * @param $out_arrayData
     * @return mixed|void
     * @author 王立
     */
    public function wei_payform($out_jsonData, $out_arrayData)
    {
        $params = $this->create_recharge_jsonData($out_jsonData, $out_arrayData);
        return $this->soapCall(HL_WEIXIN_PAY, http_build_query($params));
    }

    /**
     * 确认收货
     * @param $out_jsonData
     * @param $out_arrayData
     * @return bool|string
     * @author 王立
     */
    public function confirm_payform($out_jsonData, $out_arrayData)
    {
        $jsonData = $this->create_confirm_jsonData($out_jsonData, $out_arrayData, self::$_type_finish, $this->_create_finish_notify_url());
        $params = array(
            'jsonData' => $jsonData,
            'sign' => $this->_get_guarantee_sign($jsonData)
        );
        return $this->_complete_url(GUARANTEE_TRADING_PAY, $params);
    }

    /**
     * 退款
     * @param $out_jsonData
     * @param $out_arrayData
     * @param $returnUrl
     * @return string
     * @author 王立
     */
    public function refund_payform($out_jsonData, $out_arrayData,$returnUrl = null)
    {
        $jsonData = $this->create_confirm_jsonData($out_jsonData, $out_arrayData, self::$_type_refund, $this->_create_refund_notify_url(),$returnUrl);
        $params = array(
            'jsonData' => $jsonData,
            'sign' => $this->_get_guarantee_sign($jsonData)
        );
        return $this->_complete_url(GUARANTEE_TRADING_PAY_WEB, $params);
    }

    /**
     * 创建支付表单数据结构
     * @param $out_jsonData
     * @param $out_arrayData
     * @return string
     * @author 王立
     */
    private function create_pay_jsonData($out_jsonData, $out_arrayData)
    {
        foreach ($out_arrayData as $v) {
            if ($v['money'] <= 0) {
                $this->hlpay_error = '非法金额';
                return false;
            }
            $arrayData[] = array(
                'orderNumber' => $v['orderNumber'],
                'money' => $v['money'],
                'title' => $this->_goods_guarantee_title($v['title']),
                'toUserCode' => $v['toUserCode'],
                'fromUserCode' => $v['fromUserCode'],
                'isHidden' => $v['isHidden']
            );
        }
        if ($out_jsonData['payMoney'] <= 0) {
            $this->hlpay_error = '非法金额';
            return false;
        }
        $jsondata['site'] = HLPAY_SITE;
        $jsondata['notifyUrl'] = $this->_create_paid_notify_url();
        //$jsondata['returnUrl'] = '';
        $jsondata['payMoney'] = $out_jsonData['payMoney'];
        $jsondata['fromUserCode'] = $out_jsonData['fromUserCode'];
        $jsondata['createTime'] = $this->createTime();
        $jsondata['isCombo'] = $out_jsonData['isCombo'];
        $jsondata['arrayData'] = $arrayData;

        return json_encode($jsondata, true);
    }

    /**
     * 创建充值支付表单数据结构
     * @param $out_jsonData
     * @param $out_arrayData
     * @return array
     * @author 王立
     */
    private function create_recharge_jsonData($out_jsonData, $out_arrayData)
    {
        $payJsonData = $this->create_pay_jsonData($out_jsonData, $out_arrayData);
        //充值数据构建
        $jsonData['site'] = HLPAY_SITE;
        $jsonData['money'] = $out_jsonData['payMoney'];
        $jsonData['userCode'] = $out_jsonData['fromUserCode'];
        $jsonData['title'] = $this->_recharge_title();
        $jsonData['dateTime'] = $this->dateTime();
        //$jsonData['notifyUrl'] = '';
        //$jsonData['returnUrl'] = '';
        $jsonData = json_encode($jsonData, true);

        return array(
            'payJsonData' => $payJsonData,
            'jsonData' => $jsonData,
            'payType' => 2,//1:为支付担保交易接口 2:担保交易接口 3:站内转账接口 4:通用冻结接口 (不会改变，暂时写死，别的地方如共用，可以配置)
            'paySign' => $this->_get_guarantee_sign($payJsonData),
            'sign' => $this->_get_recharge_sign($jsonData)
        );
    }

    /**
     * 确认/返款支付表单数据结构
     * @param $out_jsonData
     * @param $out_arrayData
     * @param $pay_type
     * @param $notifyUrl
     * @param $returnUrl
     * @return bool|string
     * @author 王立
     */
    private function create_confirm_jsonData($out_jsonData, $out_arrayData, $pay_type, $notifyUrl,$returnUrl = null)
    {
        foreach ($out_arrayData as $v) {
            if ($v['money'] <= 0) {
                $this->hlpay_error = '非法金额';
                return false;
            }
            $arrayData[] = array(
                'fromOrder' => $v['fromOrder'],
                'orderNumber' => $v['orderNumber'],
                'money' => $v['money'],
                'title' => $this->_confirm_title($pay_type, $v['fromOrder'], $v['toUserCode'], $v['orderNumber'], isset($v['order_confirm_sn']) ? $v['order_confirm_sn'] : ''),
                'toUserCode' => $v['toUserCode'],
                'isHidden' => $v['isHidden']
            );
        }
        $jsondata['site'] = HLPAY_SITE;
        $jsondata['notifyUrl'] = $notifyUrl;
        if($returnUrl){
            $jsondata['returnUrl'] = $returnUrl;
        }
        $jsondata['tradeStatus'] = $out_jsonData['tradeStatus'];
        $jsondata['createTime'] = $this->createTime();
        $jsondata['arrayData'] = $arrayData;

        return json_encode($jsondata, true);
    }

    /**
     * 创建互联支付充值支付表单时间格式
     * @return bool|string
     * @author 王立
     */
    private function dateTime()
    {
        return date('YmdHis', time());
    }

    /**
     * 创建互联支付表单时间格式
     * @return bool|string
     * @author 王立
     */
    private function createTime()
    {
        return date('Y-m-d H:i:s', time());
    }

    /**
     * 担保交易sign加密
     * @param $jsonData
     * @return string
     * @author 王立
     */
    private function _get_guarantee_sign($jsonData)
    {
        return md5($jsonData . GUARANTEE_TRADING_KEY);
    }

    /**
     * 充值支付sign加密
     * @param $jsonData
     * @return string
     * @author 王立
     */
    private function _get_recharge_sign($jsonData)
    {
        return md5($jsonData . CHARGE_TO_PAY_KEY);
    }

    /**
     * 互联支付充值标题
     * @author 王立
     */
    private function _recharge_title()
    {
        return DOMAIN_NAME . '充值支付';
    }

    /**
     * 支付商品标题
     * @param $order_sn 订单号
     * @return string
     * @author 王立
     */
    private function _goods_guarantee_title($order_sn)
    {
        return DOMAIN_NAME . '购物支出-' . $order_sn;
    }

    /**
     * 确认收货互联支付流水标题
     * @param $toUserCode 技术服务费收款账号ID
     * @param $fromOrder 订单编号
     * @return string
     * @author 王立
     */
    private function _goods_confirm_title($fromOrder, $toUserCode)
    {
        if ($toUserCode == SERVICE_CHARGES_CHARGEDID) {
            return DOMAIN_NAME . '技术服务费-' . $fromOrder;
        }
        return DOMAIN_NAME . '确认收货-' . $fromOrder;
    }

    /**
     * 退款标题
     * @param $fromOrder
     * @param $orderNumber
     * @param $order_confirm_sn
     * @return string
     * @author 王立
     */
    private function _goods_refund_title($fromOrder, $orderNumber, $order_confirm_sn)
    {
        if ($order_confirm_sn == $orderNumber) {
            return DOMAIN_NAME . '订单余额返还-' . $fromOrder;
        }
        return DOMAIN_NAME . '退款-' . $fromOrder;
    }

    /**
     * 确认/退款标题方法入口
     * @param $pay_type
     * @param $fromOrder
     * @param $toUserCode
     * @param $orderNumber
     * @param $order_confirm_sn
     * @return string
     * @author 王立
     */
    private function _confirm_title($pay_type, $fromOrder, $toUserCode, $orderNumber, $order_confirm_sn)
    {
        switch ($pay_type) {
            case self::$_type_refund:
                $title = $this->_goods_refund_title($fromOrder, $toUserCode, $order_confirm_sn);
                break;
            case self::$_type_finish:
                $title = $this->_goods_confirm_title($fromOrder, $orderNumber);
                break;
            default:
                $title = '';
                break;
        }
        return $title;
    }

    /**
     * 拼接互联支付地址
     * @param $url 网址
     * @param $param array 参数
     * @return string
     * @author 王立
     */
    private function _complete_url($url, $param)
    {
        return $url . '?' . http_build_query($param);
    }
}
