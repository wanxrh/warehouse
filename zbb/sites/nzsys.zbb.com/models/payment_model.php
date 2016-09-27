<?php
/**
 * 后台支付管理模型
 */
class Payment_model extends CI_Model {
	public function __construct() {
		parent::__construct ();
		$this->db = $this->load->database ( 'zbb', TRUE );
	}
	/**
	 * 获取所有的支付方式
	 */
	public function get_payments(){
		return $this->db->order_by('sort_order')->get('payment')->result_array();
	}
	
	/**
	 * 根据Id获取一条支付方式
	 */
	public function get_one_payment($payment_id) {
		return $this->db->where('payment_id', $payment_id)->get('payment')->row_array();
	}
	
	/**
	 * 新增支付方式 
	 */
	public function add_payment($data) {
		$this->db->insert('payment', $data);
		$id = $this->db->insert_id();
		return $id;
	}
	
	/**
	 * 删除支付方式
	 */
	public function del_payment($payment_id) {
		return $this->db->where('payment_id', $payment_id)->delete('payment');
	}
	
	/**
	 * 修改支付方式
	 */
	public function edit_payment($payment_id, $data) {
		return $this->db->where('payment_id', $payment_id)->update('payment', $data);
	}
}