<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Coupon extends BaseController
{
    public $_openid = '';

    public function __construct()
    {
        parent::__construct();
        $this->load->model('CouponModel');
        $_SESSION['lao337']['AGENT']['uid'] = 'o1teys8ZQeB8kfP7UQe3NHTI-d6w';
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
                $param['scope'] = 'snsapi_base';//'snsapi_userinfo';
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
                $_SESSION['lao337']['COUPON'] = array(
                    'uid' => $outuser['openid']
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
        $data['form'] = get_defined_vars();
        if (!$coupon_id || !$time || !$sign) {
            exit('无效请求！');
        }
        $coupon = $this->CouponModel->getRow('shop_coupon', array('coupon_id' => $coupon_id));
        if (!$coupon) {
            exit('无效请求！');
        }
        if ($sign != md5($coupon_id . $coupon['sign'] . $time)) {
            exit('无效请求！');
        }
        $order_id = $coupon['order_id'];
        $data['order_info'] = $this->CouponModel->getRow('shop_order', array('id' => $order_id));
        if (!$data['order_info']) return FALSE;

        $data['goods_datas'] = json_decode($data['order_info']['goods_datas'], TRUE);
        $data['coupon'] = $coupon;
        $data['user_id'] = $user_id;
        if(IS_POST){
            $coupon_id = intval($this->input->post('id', true));
            $time = trim($this->input->post('time', true));
            $sign = trim($this->input->post('sign', true));

            if (!$coupon_id || !$time || !$sign) {
                return false;
            }
            $coupon = $this->CouponModel->getRow('shop_coupon', array('coupon_id' => $coupon_id));
            if (!$coupon) {
                return false;
            }
            $order = $this->CouponModel->getRow('shop_order', array('id' => $order_id));
            if (!$order){
                return false;
            }
            if($coupon['owner_id'] == $user_id){
                return false;
            }
            if($coupon['status'] != 0){
                return false;
            }

            $this->CouponModel->update('shop_coupon',array('coupon_id'=>$coupon_id),array('status'=>2));
            $insert = array(
                'owner_id'=>$user_id,
                'sign'=>md5($order['id'].$order['order_number'].$order['cTime'].$order['uid'].$user_id),
                'from'=>$coupon['coupon_id'],
                'order_id'=>$coupon['order_id'],
                'get_time'=>time()
            );
            $this->CouponModel->insert('shop_coupon',$insert);
            $this->successJump('领取成功','/mall/coupon');
        }
        $this->load->view('coupon/index', $data);
    }

    //兑换
    public function exchange(){
        $user_id = $this->_openid;
        $id = $this->input->get('id', true);
        $time = $this->input->get('time', true);
        $sign = $this->input->get('sign', true);
        $data['form'] = get_defined_vars();
        $coupon = $this->CouponModel->getRow('shop_coupon', array('coupon_id' => $id));
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

        $data['super'] = $this->CouponModel->getRow('shop_qrcode', array('openid'=>$user_id,'super' => 1));
        $data['coupon'] = $coupon;
        if(IS_POST){
            $coupon_id = intval($this->input->post('id', true));
            $time = trim($this->input->post('time', true));
            $sign = trim($this->input->post('sign', true));
            if (!$coupon_id || !$time || !$sign) {
                return false;
            }
            $coupon = $this->CouponModel->getRow('shop_coupon', array('coupon_id' => $coupon_id));
            if (!$coupon) {
                return false;
            }
            if ($sign != md5($coupon['sign'] . $time)) {
                return false;
            }
            if($coupon['status'] != 0){
                return false;
            }
            $super = $this->CouponModel->getRow('shop_qrcode', array('openid'=>$user_id,'super' => 1));
            if(!$super){
                return false;
            }
            $daili = $this->CouponModel->getRow('shop_daili_store',array('open_id'=>$user_id));
            if(!$daili){
                return false;
            }
            $this->CouponModel->update('shop_coupon',array('coupon_id'=>$coupon_id),array('use_time'=>time(),'status'=>1));
            foreach ($data['goods_datas'] as $v){
                $this->CouponModel->daili_store_goods(array('daili_id'=>$daili['id'],'goods_id'=>$v['id']),$v['num']);
            }

            $this->successJump('确认成功');
            return;
        }
        $this->load->view('coupon/exchange', $data);
    }

    //赠送
    public function present(){
        $user_id = $this->_openid;
        $id = $this->input->get('id', true);
        $time = $this->input->get('time', true);
        $sign = $this->input->get('sign', true);
        $data['form'] = get_defined_vars();

        $coupon = $this->CouponModel->getRow('shop_voucherinfo', array('id' => $id));
        if (!$coupon) {
            exit('无效请求！');
        }
        if ($sign != md5($coupon['sign'] . $time)) {
            exit('无效请求！');
        }
        $goods_datas = $this->CouponModel->getRow('shop_goods', array('id' => $coupon['goods_id']),'cover,title,price');
        if(!$goods_datas){
            exit('无效请求！');
        }
        $data['super'] = $this->CouponModel->getRow('shop_qrcode', array('openid'=>$user_id,'super' => 1));
        $data['goods_datas'] = $goods_datas;
        $data['coupon'] = $coupon;
        if(IS_POST){
            $id = intval($this->input->post('id', true));
            $time = trim($this->input->post('time', true));
            $sign = trim($this->input->post('sign', true));
            if (!$id || !$time || !$sign) {
                return false;
            }
            $coupon = $this->CouponModel->getRow('shop_voucherinfo', array('id' => $id));
            if (!$coupon) {
                return false;
            }
            if ($sign != md5($coupon['sign'] . $time)) {
                return false;
            }
            $super = $this->CouponModel->getRow('shop_qrcode', array('openid'=>$user_id,'super' => 1));
            if(!$super){
                return false;
            }
            $daili = $this->CouponModel->getRow('shop_daili_store',array('open_id'=>$user_id));
            if(!$daili){
                return false;
            }
            $this->CouponModel->update('shop_voucherinfo',array('id'=>$id),array('use_time'=>time(),'status'=>2));

            $this->CouponModel->daili_store_goods(array('daili_id'=>$daili['id'],'goods_id'=>$coupon['goods_id']),$coupon['number']);
            $this->successJump('确认成功');
            return;
        }
        $this->load->view('coupon/present', $data);
    }

    public function online(){
        if(!IS_POST){
            return false;
        }
        $user_id = $this->_openid;
        $id = $this->input->post('id', true);
        $time = $this->input->post('time', true);
        $sign = $this->input->post('sign', true);
        if (!$id || !$time || !$sign) {
            return false;
        }
        $coupon = $this->CouponModel->getRow('shop_voucherinfo', array('id' => $id));
        if (!$coupon) {
            return false;
        }
        if ($sign != md5($coupon['sign'] . $time)) {
            return false;
        }
        if($coupon['status'] != 0){
            return false;
        }
        $this->CouponModel->update('shop_voucherinfo',array('id'=>$id),array('get_time'=>time(),'owner_id'=>$user_id,'status'=>1));
        $this->successJump('生成电子券成功');
    }

    public function share()
    {
        $id = $this->input->get('id', true);
        $time = $this->input->get('time', true);
        $sign = $this->input->get('sign', true);

        if (!$id || !$time || !$sign) {
            return false;
        }
        $coupon = $this->CouponModel->getRow('shop_coupon', array('coupon_id' => $id));
        if (!$coupon) {
            exit('无效请求！');
        }
        if ($sign != md5($coupon['sign'] . $coupon['coupon_id'] . $time)) {
            exit('无效请求！');
        }
        $this->load->library('package');
        $SignPackage = $this->package->getSignPackage();
        $data['signPackage'] = $SignPackage;

        $order_info = $this->CouponModel->getRow('shop_order', array('id' => $coupon['order_id']));
        if (!$order_info) return FALSE;

        $goods_data = json_decode($order_info['goods_datas'], TRUE);
        $PicUrl = array_column($goods_data,'cover');
        $now = time();
        $news = array(
            "Title" => "老山圈兑换券领取",
            "Description" => implode(',',array_column($goods_data,'title')),
            "PicUrl" => imgUrl($PicUrl[0]),
            "Url" => $this->config->base_url().'coupon?id='.$id.'&time='.$now.'&sign='.md5($id.$coupon['sign'].$now)
        );
        $data['news'] = $news;

        $data['goods_datas'] = $goods_data;
        $this->load->view('coupon/share', $data);
    }
}
