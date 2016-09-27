<?php

/**
 * 首页模型
 * @author feimo
 * @version 2013-10
 */
class Send_model extends CI_Model {

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }
      
	/*
	 *会员详细
	 */  
	public function user_info($username){
		$row=$this->db->where_in('user_name',$username)->get('member')->result_array();
		return $row;
		
		}  
    /*
     * 写入群发表
     */
    public function send_mass($from_id, $to_type, $title, $content,$end_time) {
		$ret=array('from_uid' => $from_id,'to_type'=>$to_type,'title' => $title, 'content' => $content, 'dateline' => time(), 'end_time' => $end_time);
        $this->db->insert('message_mass', $ret);
        $data = $this->db->insert_id();
        return $data;
    }
	
	
	
	
}
