<?php

/**
 * Class Login登陆控制器
 */
class Login extends CI_Controller
{

    const USER_CACHE_NAME_PREFIX = 'zbb_user_info_';
    const UTYPEID = 2;//UC库登录账号类型 1买家，2商家

    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_model');
        $this->load->model('log_model');
    }

    /**
     * 显示验证码
     */
    public function vcode()
    {
        $this->load->library('vcode');
        $this->vcode->show();
    }

    /**
     * AJAX 跨域登陆
     */
    public function index()
    {
        // 获取账号、密码
        $username = trim($this->input->get_post('username', TRUE));
        $password = trim($this->input->get_post('password', TRUE));
        if (!$username || !$password) {
            exit(json_encode(array('code' => 300, 'data' => '账号密码不能为空')));
        }
        // 验证是否需要输入验证码
        //$this->vcode->check ( $username, TRUE );
        // 验证通过，检验账号密码
        $user = $this->user_model->login($username, $password, self::UTYPEID);
        //$this->vcode->clean ();
        if ($user) {
            $this->user_model->login_post_action($user, self::USER_CACHE_NAME_PREFIX . $user['uid'], 10800, true);
            $this->log_model->insert_log('进行了登录操作', $user['uid']);
            //后期开发，自动跳转回原页面	，暂定
            $data = array('code' => 200, 'to' => $this->config->item('domain_user'));
            exit(json_encode($data));
        }
        // 验证不通过，更新错误次数
        //$this->vcode->error ( $username );
        // 返回错误
        $data = $this->user_model->error;
        exit(json_encode($data));
    }

    /**
     * 外部站点通过sign值进行同步登录
     */
    public function sign_on()
    {
        $uid = intval($this->input->get('uid')) or die ('need uid');
        $sign = $this->input->get('sign') or die ('need sign');

        // 登录联盟
        $this->user_model->login_by_token($uid, $sign) or die ($this->user_model->error['code']);

        // 判断是否继续跳转页面
        isset ($_GET ['to']) && die ('<script type="text/javascript">location.href="' . str_replace('"', '', $_GET ['to']) . '";</script>');
        die ('success');
    }


    /**
     * 退出
     */
    public function out()
    {
        $user_info = get_user();
        // 更新在线用户表
        $db_uc = $this->load->database('uc', TRUE);
        $db_uc->where('uid', $user_info['id'])->delete('onlineusers');

        $admin_id = get_admin();
        setcookie(COOKIE_NAME, '', time() - 3600, '/', $this->config->item('cookie_domain'), NULL, FALSE);
        setcookie('nzsys_c', '', time() - 3600, '/', $this->config->item('cookie_domain'), NULL, FALSE);
        cache('nzw_' . $user_info['id'], FALSE);
        $referer = explode('/', $this->config->item('domain_nzsys'));
        $wait = explode('/', $_SERVER['HTTP_REFERER']);
        if ($wait['2'] == $referer['2']) {
            header('Location:' . $this->config->item('domain_nzsys'));
            exit;
        } else {
            $ret = urldecode($_GET['to']);
            $ret ? header('Location:' . $ret) : header('Location:' . $this->config->item('domain_www'));
            exit;
        }
    }


}
