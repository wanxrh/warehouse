<?php

class Log_model extends CI_Model {

    /**
     * 继承父级构造方法
     * 实例化数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 写入日志表
     */
    public function insert_log($action_name, $op_uid) {
        $arr=array('action_name'=>$action_name,'op_uid'=>$op_uid,'dateline'=>time(),'ip'=>ip());
        $this->db->insert('action_log', $arr);
    }
}