<?php

class Home extends CI_Controller {

    public function __construct() {
        parent::__construct();
        header("Content-type: text/html; charset=utf-8");
        $this->load->model('login_model');
    }

    /*
     * 默认管理员首页
     */
    public function index() {
        $this->load->view('home');
    }

    /*
     * 管理员登录
     */
    public function login() {
        $user_name = filter_sql($this->input->post('user_name', TRUE));
        $password = $this->input->post('password', TRUE);
        $user_info=$this->login_model->get_user($user_name);
        if($user_info){
            $temp_pass=strtolower(md5(strtolower(md5($password).$user_info['salt'])));
            if($temp_pass==$user_info['password']){
            // 保存cookie
            $this->load->library('crypt', array('key' => KEY_COOKIE_CRYPT,'iv' => KEY_COOKIE_CRYPT_IV));
            $value = array();
            $value ['auth'] = $this->crypt->encode($user_info['user_name'] . '|' . $user_info['user_id'] . '|' . $this->_random(8));
            $cookie = implode('|', $value);
            setcookie('nzsys_c', $cookie, time() + 3600, '/',$this->config->item('cookie_domain'), NULL, FALSE);
            header('Location: ' . $this->config->item('domain_nzsys') . 'main');
            }else{
                get_redirect("用户名或密码错误", '/home/index');
            }
        }else{
            get_redirect("用户名或密码错误", '/home/index');
        }
        
    }

    /*
     * 生成随机字符函数
     */

    protected function _random($length, $numeric = 0) {
        $seed = base_convert(md5(microtime() . $_SERVER ['DOCUMENT_ROOT']), 16, $numeric ? 10 : 35 );
        $seed = $numeric ? (str_replace('0', '', $seed) . '012340567890') : ($seed . 'zZ' . strtoupper($seed));
        if ($numeric) {
            $hash = '';
        } else {
            $hash = chr(rand(1, 26) + rand(0, 1) * 32 + 64);
            $length --;
        }
        $max = strlen($seed) - 1;
        for ($i = 0; $i < $length; $i ++) {
            $hash .= $seed {mt_rand(0, $max)};
        }
        return $hash;
    }
   
}
