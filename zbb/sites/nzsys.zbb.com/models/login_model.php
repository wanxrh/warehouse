<?php

/**
 * 登录模型
 * @author feimo
 * @version 2013-10
 */
class Login_model extends CI_Model {

    /**
     * 继承父级构造方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 获取用户
     */
    public function get_user($user_name) {
        $this->db->select('password,salt,user_name,user_id');
        $ret = array('user_name' => $user_name);
        $data = $this->db->get_where('member', $ret)->row_array();
        return $data;
    }

}
