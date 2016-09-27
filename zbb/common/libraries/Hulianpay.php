<?php

/**
 * 互联支付
 */
class Hulianpay
{

    /**
     * curl请求接口错误返回
     * @var
     */
    public $hlpay_error = null;

    public function __construct()
    {
        //TODO
    }

    /**
     * 查询用户互联支付余额
     * @param int $user_id 用户ID
     * @return bool
     */
    public function get_user_amount($user_id = 0)
    {
        if (intval($user_id)) {
            $user_id = intval($user_id);
        } else {
            $user_id = get_user();
        }
        $post_arr = array();
        $post_arr['jsonData'] = json_encode(array('site' => HLPAY_SITE, 'userCode' => $user_id), TRUE);
        $post_arr['sign'] = MD5($post_arr['jsonData'] . HL_COMMON_KEY);

        $result = $this->soapCall(HL_USER_BLANCE_URL, http_build_query($post_arr));
        if ($result === false) {
            return '0.00';
        }
        if (isset($result['error'])) {
            $this->hlpay_error = $result['error'];
            return false;
        } else {
            $amount = $result['success'];
        }
        return $amount;
    }

    /**
     * APP微信充值订单查询结果
     *
     * @param $rechargeNo 互联支付充值订单号
     * @return bool
     * @author 王立
     */
    public function weixin_order_query($rechargeNo)
    {
        $param['jsonData'] = json_encode(array('site' => HLPAY_SITE, 'orderNo' => $rechargeNo), true);
        $param['sign'] = md5($param['jsonData'] . NEW_CHARGE_TO_PAY_KEY);
        $result = $this->soapCall(EXIST_HLUSER_URL, http_build_query($param));
        if ($result === false) {
            return false;
        }
        if ($result['result'] != 'SUCCESS') {
            $this->hlpay_error = $result['msg'];
            return false;
        }
        return true;
    }

    /**
     * 查询互联支付账号是否存在
     * @param $acount 账号
     * @return bool
     */
    public function is_exist_hluser($acount)
    {
        if (preg_match('/^[^_][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/', $acount)) {
            $type = 3;
        } else if (preg_match('/^([1][3|4|5|8][0-9]{9}){1}$/', $acount)) {
            $type = 2;
        } else {
            $type = 1;
        }
        $post_arr = array();
        $post_arr['jsonData'] = json_encode(array("site" => HLPAY_SITE, "userdata" => $acount, 'type' => $type), TRUE);
        $post_arr['sign'] = MD5($post_arr['jsonData'] . HL_COMMON_KEY);

        $output = $this->soapCall(EXIST_HLUSER_URL, http_build_query($post_arr));
        if($output === false){
            return false;
        }
        if (isset($output['error'])) {
            return false;
        }
        return $output['success'];
    }

    /**
     * 通用接口请求方法
     *
     * @param $url 接口地址
     * @param null $data 请求参数
     * @param bool $esolve 是否解析，默认解析
     * @return mixed|void
     * @author 王立
     */
    protected function soapCall($url, $data = null, $esolve = true)
    {
        try {
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
            curl_setopt($ch, CURLOPT_HEADER, false);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); //将curl_exec()获取的信息以文件流的形式返回，而不是直接输出。
            curl_setopt($ch, CURLOPT_TIMEOUT, 5);
            if ($data) {
                curl_setopt($ch, CURLOPT_POST, true);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
            }
            $output = curl_exec($ch);
            if ($esolve) {
                $output = json_decode($output, true);
            }
        } catch (Exception $e) {
            $this->hlpay_error = $e->getMessage();
            return false;
        }
        return $output;
    }

    /**
     * 获取通知信息
     * @return    array
     * @author 王立
     */
    protected function _get_notify()
    {
        /* 如果有POST的数据，则认为POST的数据是通知内容 */
        if (!empty($_POST)) {
            return $_POST;
        }
        /* 否则就认为是GET的 */
        return $_GET;
    }

    /**
     * 将验证结果反馈给网关
     * @param bool $result
     * @return void
     * @author 王立
     */
    public function verify_result($result)
    {
        if ($result) {
            echo 'true';
        } else {
            echo 'false';
        }
    }

    /**
     * 返回通知结果
     * @author 王立
     */
    public function verify_notify()
    {
        /* 初始化所需数据 */
        $notify = $this->_get_notify();
        /* 严格验证 */
        $verify_result = $this->_query_notify($notify);
        if (!$verify_result) {
            /* 来路不可信 */
            return false;
        }
        return $notify;
    }

    /**
     * 验证通知是否有效
     * @param     string $notify
     * @return    string
     * @author 王立
     */
    private function _query_notify($notify)
    {
        //互联支付通知校验
        if (!isset($notify['jsonData']) || !isset($notify['sign']) || !isset($notify['notifySign'])) {
            return FALSE;
        }
        if (!$notify['jsonData'] || !$notify['sign'] || !$notify['notifySign']) {
            return FALSE;
        }
        $query_sign = MD5($notify['jsonData'] . GUARANTEE_TRADING_KEY);
        $query_notifysign = MD5($query_sign . GUARANTEE_TRADING_KEY);
        return (($notify['sign'] == $query_sign) && ($notify['notifySign'] == $query_notifysign) && !isset($notify['jsonData']['notifyUrl']));
    }

    /**
     * 支付通知地址
     * @author 王立
     */
    protected function _create_paid_notify_url()
    {
        $CI =& get_instance();
        return $CI->config->item('domain_paynotify') . 'paynotify/paid';
    }

    /**
     * 确认收货通知地址
     * @author 王立
     */
    protected function _create_finish_notify_url()
    {
        $CI =& get_instance();
        return $CI->config->item('domain_paynotify') . 'paynotify/finished';
    }

    /**
     * 退款通知地址
     * @author 王立
     */
    protected function _create_refund_notify_url()
    {
        $CI =& get_instance();
        return $CI->config->item('domain_paynotify') . 'paynotify/refunded';
    }
}
