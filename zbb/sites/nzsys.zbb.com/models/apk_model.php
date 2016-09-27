<?php

/**
 * apk模型
 */
class Apk_model extends CI_Model {
    /*
     * 继承父级构造方法
     * 实例化两个数据库方法
     */

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }


    /**
     * 查询数据
     */
    public function get_info() {
        $ret = $this->db->where('key', 2)->get('common_content')->row_array();
        return $ret;
    }

     /**
     * 更新apk数据
     */
    public function update_info($arr) {
        $ret = $this->db->where('key', 2)->update('common_content',$arr);
        return $ret;
    }
	 
	 /**
     * 查询数据
     */
    public function get_client_info() {
        $ret = $this->db->where('key', 3)->get('common_content')->row_array();
        return $ret;
    }

     /**
     * 更新apk数据
     */
    public function update_client_info($arr) {
        $ret = $this->db->where('key', 3)->update('common_content',$arr);
        return $ret;
    }

}
