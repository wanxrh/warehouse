<?php

/*
 * APP注册模型
 */

class Reg_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 保存手机发送验证码
     *
     * @param $mobile
     * @param $code
     * @author 王立
     */
    public function save_code($mobile, $code)
    {
        $info = $this->db->where(array('input' => $mobile, 'type' => 2))->get('code')->row_array();
        if ($info) {
            $this->db->where(array('input' => $mobile, 'type' => 2))->update('code', array('vcode' => $code));
        } else {
            $this->db->insert('code', array('dateline' => time(), 'type' => 2, 'input' => $mobile, 'vcode' => $code));
        }
    }

    public function check_code($mobile, $code)
    {
        return $this->db->where(array('input' => $mobile, 'vcode' => $code))->get('code')->row_array();
    }
}