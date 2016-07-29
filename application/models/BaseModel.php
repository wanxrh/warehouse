<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class BaseModel extends CI_Model {
    
    public function __construct()
	{
	   parent::__construct();
	}
	public function getRow($table,$conditon = NULL,$colnums = '*')
	{
	    if($conditon){
	        $this->db->where($conditon);
	    }
	    return $this->db->select($colnums)->get($table)->row_array();
	}
	public function getRows($table,$conditon = NULL,$colnums = '*')
	{
	    if($conditon){
	        $this->db->where($conditon);
	    }
	    return $this->db->select($colnums)->get($table)->result_array();
	}
	public function update($table,$conditon,$colnums)
	{
	    return $this->db->where($conditon)->update($table,$colnums);
	}
	public function insert($table,$colnums)
	{
		return $this->db->insert($table,$colnums);
	}
	public function insertBatch($table,$colnums)
	{
	    return $this->db->insert_batch($table,$colnums);
	}
	public function delete($table,$conditon)
	{
		return $this->db->where($conditon)->delete($table);		
	}
	function setStatusCode($id, $code) {
		$save ['status_code'] = $code;
		$this->update('shop_order', array('id'=>$id), $save);
	
		$data ['order_id'] = $id;
		$data ['status_code'] = $code;
		$data ['cTime'] = time();
	
		switch ($code) {
			case '1' :
				$data ['remark'] = '您提交了订单，请等待商家确认';
				break;
			case '2' :
				$data ['remark'] = '商家已经确认订单，开始拣货';
				break;
			case '3' :
				$info = $this->getRow('shop_order',array('id'=>$id),'send_code_name,send_number');
				$data ['remark'] = '您的订单已经发货，发货快递： ' . $info ['send_code_name'] . ', 快递单号： ' . $info ['send_number'];
				$data ['extend'] = '0';
				break;
			case '4' :
				$data ['remark'] = '确认已收货';
				break;
			case '5' :
				$data ['remark'] = '确认已收款';
				break;
			case '6' :
				$data ['remark'] = '订单已完成，请评价这次服务';
				break;
			case '7' :
				$data ['remark'] = '评论完成，欢迎下次再来';
				break;
		}
		$this->insert('shop_order_log', $data);
		return true;
	}
}
