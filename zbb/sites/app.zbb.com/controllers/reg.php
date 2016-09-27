<?php

/*
 * APP注册控制器
 */

class Reg extends App_Controller
{
    const MOBILE_CHECK_MAX_NUMS = 6; //验证码次数
    const MOBILE_CHECK_TIME_LEN = 600; //验证码有效时长秒
    const MOBILE_SEND_FREQUENCY = 60;//发送验证码的频率秒
    const REG_USER_TYPE = 11; //注册类型
    const REG_USER_MOBILE_PREFIX = "reg_mobile_"; //注册手机号cache前缀
    const APP_CACHE_NAME_PREFIX = 'app_user_info_';//app用户信息缓存前缀
    const REG_TYPE = 2;//注册来源：众宝贝PC 1，uc库同步 0,app注册2

    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_model');
    }

    /**
     *APP检查用户名是否存在
     *
     * @author 王立
     */
    public function check_uname()
    {
        $uname = $this->get_string('uname');
        if (!$this->user_model->is_registrable($uname)) {
            $this->failure($this->user_model->error['code'], $this->user_model->error['data']);
        }
        $this->success(0, '用户名可用');
    }

    /**
     * APP发送手机验证码接口
     *
     * @author 王立
     */
    public function get_mobile_code()
    {
        $mobile = $this->get_string('mobile');

        //验证手机号码
        $this->check_mobile($mobile);
        $reg_cahche = cache(self::REG_USER_MOBILE_PREFIX . $mobile);
        if (!$reg_cahche) {
            cache(self::REG_USER_MOBILE_PREFIX . $mobile, array('send_num' => 0, 'last_send_time' => time()), strtotime(date('Y-m-d', time())) + 86400 - time());
        }
        if ($reg_cahche['send_num'] >= self::MOBILE_CHECK_MAX_NUMS) {
            $this->failure(MOBILE_SEND_MAX, '注册不成功？联系我们吧。');
        }
        if (($reg_cahche['last_send_time'] + self::MOBILE_SEND_FREQUENCY) > time()) {
            $this->failure(MOBILE_FREQUENCY_MAX, '您操作获取验证码的次数过于频繁，请在1分钟后重试。');
        }
        //保存验证码，发送短信，更新缓存
        $code = rand_code();
        $send = json_decode($this->_send_msg($mobile, $code));
        if ($send->status == 'n') {
            $this->failure($send->info);
        }
        cache(self::REG_USER_MOBILE_PREFIX . $mobile, array('send_num' => $reg_cahche['send_num'] + 1, 'last_send_time' => time()), strtotime(date('Y-m-d', time())) + 86400 - time());
        $this->success(0, $code . '发送验证码成功');
    }

    /**
     * 注册并登陆
     * @author 王立
     */
    public function save()
    {
        $uname = $this->get_string('uname');
        $password = $this->get_string('password');
        $a_password = $this->get_string('a_password');
        $mobile = $this->get_string('mobile');
        $code = $this->get_string('code');

        if (!$this->user_model->is_registrable($uname)) {
            $this->failure($this->user_model->error['code'], $this->user_model->error['data']);
        }
        if ($password != $a_password) {
            $this->failure(PASSWORD_UNSAME, '密码不一致');
        }
        if (!$this->user_model->check_password($password)) {
            $this->failure($this->user_model->error['code'], $this->user_model->error['data']);
        }
        $this->check_mobile($mobile);
        $reg_cahche = cache(self::REG_USER_MOBILE_PREFIX . $mobile);
        if (($reg_cahche['last_send_time'] + self::MOBILE_CHECK_TIME_LEN) < time()) {
            $this->failure(CODE_TIME_OUT, '您的验证码已经失效，请重新发送');
        }
        $this->load->model('reg_model');
        $check_code = $this->reg_model->check_code($mobile, $code);
        if (!$check_code) {
            $this->failure(CODE_ERROR, '验证码错误');
        }
        $user = $this->user_model->add_user(self::REG_USER_TYPE, $uname, $password, $mobile, self::REG_TYPE);
        if (!$user) {
            $this->failure($this->user_model->error['code'], $this->user_model->error['data']);
        }
        //登陆
        $this->user_model->login_post_action($user, self::APP_CACHE_NAME_PREFIX . $user['uid']);
        $this->success(1, '注册成功', $user);
    }

    /**
     * 发送手机验证码
     * @param $mobile
     * @param $code
     * @return mixed
     * @author 王立
     */
    private function _send_msg($mobile, $code)
    {
        $this->load->model('reg_model');
        $this->reg_model->save_code($mobile, $code);
        $this->load->library('sms');
        $content = '您的验证码是' . $code . '，' . (self::MOBILE_CHECK_TIME_LEN) / 60 . '分钟内有效，请妥善保管。';
        $result = $this->sms->send($mobile, $content);
        return $result;
    }

    /**
     * 验证手机是否可用
     * @param $mobile 手机号码
     * @author 王立
     */
    private function check_mobile($mobile)
    {
        if (!$this->user_model->check_mobile_exists($mobile)) {
            $this->failure($this->user_model->error['code'], $this->user_model->error['data']);
        }
        $this->load->library('hulianpay');
        $hl_user = $this->hulianpay->is_exist_hluser($mobile);
        if ($this->hulianpay->hlpay_error) {
            $this->failure(1, $this->hulianpay->hlpay_error);
        }
        if ($hl_user) {
            $this->failure(MOBILE_EXISTS, '该手机号码已被使用');
        }
    }
}