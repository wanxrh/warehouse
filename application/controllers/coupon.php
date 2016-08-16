<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Coupon extends BaseController
{
    public $_openid = '';

    public function __construct()
    {
        parent::__construct();
        $this->load->model('CouponModel');
        $_SESSION['lao337']['AGENT']['uid'] = 'o1teys--QgpSDXlTwHqBcEWKJTfY';
        $_SESSION['lao337']['AGENT']['nickname'] = '（●—●）';
        $_SESSION['lao337']['AGENT']['headimgurl'] = 'http://wx.qlogo.cn/mmopen/2ibiauvDg7obiaUSCH7X1EzGJpllf4jpksWloKUFm1AGnA5D8hGrTLGaNXKspQuwHFHZaQ1UYppaWdl5bY1Bzj5xYXVN59bSHn2/0';
        if (isset($_SESSION['lao337']['AGENT']['uid'])) {
            $this->_openid = $_SESSION['lao337']['AGENT']['uid'];
        } else {
            $callback = $this->getCurUrl();
            $callback = urldecode($callback);

            if (strpos($callback, '?') === false) {
                $callback .= '?';
            } else {
                $callback .= '&';
            }
            $param['appid'] = APPID;

            if (!isset($_GET['getOpenId'])) {
                $param['redirect_uri'] = $callback . 'getOpenId=1';
                $param['response_type'] = 'code';
                $param['scope'] = 'snsapi_userinfo';
                $param['state'] = 1;

                $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?' . http_build_query($param) . '#wechat_redirect';
                //echo $url;exit;
                redirect($url);
            } else if ($_GET['state']) {
                $param['secret'] = APPSECRET;
                $param['code'] = $this->input->get('code', TRUE);
                $param['grant_type'] = 'authorization_code';

                $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?' . http_build_query($param);
                $output = $this->soapCall($url);
                if (!isset($output['openid'])) {
                    exit('/(ㄒoㄒ)/~~授权失败！');
                }
                $data['access_token'] = $output['access_token'];
                $data['openid'] = $output['openid'];
                $data['lang'] = 'zh_CN';

                $url = 'https://api.weixin.qq.com/sns/userinfo?' . http_build_query($data);
                $outuser = $this->soapCall($url);
                if (!isset($outuser['openid'])) {
                    exit('o(╯□╰)o授权失败！');
                }
                $this->_openid = $outuser['openid'];
                $_SESSION['lao337']['AGENT'] = array(
                    'uid' => $outuser['openid'],
                    'nickname' => $outuser['nickname'],
                    'headimgurl' => $outuser['headimgurl']
                );
            }
        }
    }

    public function index()
    {
        $user_id = $this->_openid;
        $coupon_id = intval($this->input->get('id', true));
        $time = trim($this->input->get('time', true));
        $sign = trim($this->input->get('sign', true));

        if (!$coupon_id || !$time || !$sign) {
            exit('无效请求！');
        }
        $coupon = $this->CouponModel->getRow('shop_coupon', array('coupon_id' => $coupon_id));
        if (!$coupon) {
            exit('无效请求！');
        }
        if ($sign != md5($coupon['sign'] . $time)) {
            exit('无效请求！');
        }
        $order_id = $coupon['order_id'];
        $data['order_info'] = $this->CouponModel->getRow('shop_order', array('id' => $order_id));
        if (!$data['order_info']) return FALSE;

        $data['goods_datas'] = json_decode($data['order_info']['goods_datas'], TRUE);
        $data['coupon'] = $coupon;
        $data['user_id'] = $user_id;
        $this->load->view('coupon/index', $data);
    }
}
