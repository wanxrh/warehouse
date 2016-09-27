<?php

/**
 * Class Login登陆控制器
 */
class Reg extends CI_Controller
{
    const MOBILE_CHECK_MAX_NUMS = 6; //验证码次数
    const MOBILE_CHECK_TIME_LEN = 600; //验证码有效时长秒
    const MOBILE_SEND_FREQUENCY = 60;//发送验证码的频率秒
    const REG_USER_TYPE = 11; //注册类型
    const REG_USER_MOBILE_PREFIX = "reg_mobile_"; //注册手机号cache前缀
    const USER_CACHE_NAME_PREFIX = 'zbb_user_info_';
    const APP_CACHE_NAME_PREFIX = 'app_user_info_';//app用户信息缓存前缀
    const REG_TYPE = 1;//注册来源：众宝贝PC 1，uc库同步 0,app注册2
    const UTYPEID = 2;//UC库登录账号类型 1买家，2商家

    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_model');
        $this->load->model('reg_model');
    }

    /**
     * 显示验证码
     */
    public function vcode()
    {
        $this->load->library('vcode');
        $this->vcode->show();
    }

    public function check_vcode()
    {
        $vcode = trim($this->input->post('vcode', TRUE));
        if (!$vcode) {
            exit(json_encode(array('code' => 300, 'data' => '验证码不能为空')));
        }
        $this->_check_vcode($vcode);
        exit(json_encode(array('code' => 200, 'data' => '验证码正确')));
    }

    protected function _check_vcode($vcode)
    {
        $this->load->library('vcode');
        if (!$this->vcode->check($vcode)) {
            exit(json_encode(array('code' => 301, 'data' => '验证码错误')));
        }

    }

    public function check_mobile()
    {
        $mobile = trim($this->input->post('mobile', TRUE));
        if (!$mobile) {
            exit(json_encode(array('code' => 300, 'data' => '手机号码不能为空')));
        }
        $this->_check_mobile($mobile);
        exit(json_encode(array('code' => 200, 'data' => '手机号码可使用')));
    }

    protected function _check_mobile($mobile)
    {

        $this->load->library('hulianpay');
        $hl_user = $this->hulianpay->is_exist_hluser($mobile);
        if ($this->hulianpay->hlpay_error) {
            exit(json_encode(array('code' => 300, 'data' => $this->hulianpay->hlpay_error)));
        }
        if ($hl_user) {
            exit(json_encode(array('code' => MOBILE_EXISTS, 'data' => '该手机号码已被使用')));
        }
        if (!$this->user_model->check_mobile_exists($mobile)) {
            exit(json_encode(array('code' => MOBILE_EXISTS, 'data' => '该手机号码已被使用')));
        }

    }

    public function get_mobile_code()
    {
        $mobile = trim($this->input->post('mobile'));
        if (!$mobile) {
            exit(json_encode(array('code' => 300, 'data' => '手机号码不能为空')));
        }
        //验证手机号码
        $this->_check_mobile($mobile);
        $reg_cahche = cache(self::REG_USER_MOBILE_PREFIX . $mobile);
        if (!$reg_cahche) {
            cache(self::REG_USER_MOBILE_PREFIX . $mobile, array('send_num' => 0, 'last_send_time' => time()), strtotime(date('Y-m-d', time())) + 86400 - time());
        }
        if ($reg_cahche['send_num'] >= self::MOBILE_CHECK_MAX_NUMS) {
            exit(json_encode(array('code' => MOBILE_SEND_MAX, 'data' => '注册不成功？联系我们吧。')));
        }
        if (($reg_cahche['last_send_time'] + self::MOBILE_SEND_FREQUENCY) > time()) {
            exit(json_encode(array('code' => MOBILE_FREQUENCY_MAX, 'data' => '您操作获取验证码的次数过于频繁，请在1分钟后重试。')));
        }
        //保存验证码，发送短信，更新缓存
        $code = $this->mobile_code();
        $send = json_decode($this->_send_msg($mobile, $code));
        if ($send->status == 'n') {
            exit(json_encode(array('code' => 300, 'data' => $send->info)));
        }
        cache(self::REG_USER_MOBILE_PREFIX . $mobile, array('send_num' => $reg_cahche['send_num'] + 1, 'last_send_time' => time()), strtotime(date('Y-m-d', time())) + 86400 - time());
        exit(json_encode(array('code' => 200, 'data' => '验证码发送成功')));
    }

    public function check_mobile_code()
    {
        $mobile = trim($this->input->post('mobile', true));
        $code = trim($this->input->post('code', true));

        if (!$mobile || !$code) {
            exit(json_encode(array('code' => 300, 'data' => '手机或验证码不能为空')));
        }
        $this->_check_mobile_code($mobile, $code);
        exit(json_encode(array('code' => 200, 'data' => '验证码正确')));
    }

    protected function _check_mobile_code($mobile, $code)
    {
        $this->_check_mobile($mobile);
        $check_code = $this->reg_model->check_code($mobile, $code);
        if (!$check_code) {
            exit(json_encode(array('code' => CODE_ERROR, 'data' => '短信验证码错误')));
        }
    }

    private function _send_msg($mobile, $code)
    {
        $this->load->model('reg_model');
        $this->reg_model->save_code($mobile, $code);
        $this->load->library('sms');
        $content = '您的验证码是' . $code . '，' . (self::MOBILE_CHECK_TIME_LEN) / 10 . '分钟内有效，请妥善保管。';
        $result = $this->sms->send($mobile, $content);
        return $result;
    }

    public function check_username()
    {
        $uname = trim($this->input->post('uname', TRUE));
        if (!$uname) {
            exit(json_encode(array('code' => 300, 'data' => '用户名不能为空')));
        }
        $this->_check_username($uname);
        exit(json_encode(array('code' => 200, 'data' => '用户名可以使用')));
    }

    /**
     * AJAX验证用户名
     */
    public function _check_username($username)
    {
        $result = $this->user_model->is_registrable($username);
        if (!$result) {
            $data = $this->user_model->error;
            exit(json_encode($data));
        }
    }

    public function save()
    {
        $uname = trim($this->input->post('uname'));
        $password = trim($this->input->post('password'));
        $a_password = trim($this->input->post('a_password'));
        $vcode = trim($this->input->post('vcode'));
        $mobile = trim($this->input->post('mobile'));
        $code = trim($this->input->post('code'));

        $this->_check_username($uname);
        if ($password != $a_password) {
            exit(json_encode(array('code' => PASSWORD_UNSAME, 'data' => '密码不一致')));
        }
        if (!$this->user_model->check_password($password)) {
            exit(json_encode($this->user_model->error));
        }
        $this->_check_vcode($vcode);

        $reg_cahche = cache(self::REG_USER_MOBILE_PREFIX . $mobile);
        if (($reg_cahche['last_send_time'] + self::MOBILE_CHECK_TIME_LEN) < time()) {
            exit(json_encode(array('code' => CODE_TIME_OUT, 'data' => '您的验证码已经失效，请重新发送')));
        }
        $this->_check_mobile_code($mobile, $code);

        $user = $this->user_model->add_user(self::REG_USER_TYPE, $uname, $password, $mobile, self::REG_TYPE, self::UTYPEID);
        if (!$user) {
            exit(json_encode(array('code' => $this->user_model->error['code'], 'data' => $this->user_model->error['data'])));
        }
        //登陆
        $this->user_model->login_post_action($user, self::APP_CACHE_NAME_PREFIX . $user['uid'], 60 * 60 * 3, true);
        exit(json_encode(array('code' => 200, 'to' => $this->config->item('domain_user'))));
    }

    protected function mobile_code($length = 6)
    {
        $chars = '1234567890';
        $len = strlen($chars);
        $code = '';
        for ($i = 0; $i < $length; $i++) {
            $code .= $chars [mt_rand(0, $len - 1)];
        }
        return $code;
    }
}
