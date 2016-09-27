<?php

class Myinfo_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }
    public function get_member($user_id){
       $ret = $this->db->where('user_id',$user_id)->get('member')->row_array();
        return $ret;
    }

    public function edit_portrait($id,$arr){
        $this->db->where('user_id',$id)->update('member',$arr);
    }

    public function get_mobile($uid){
        $this->uc_db = $this->load->database('uc', TRUE);
        return $this->uc_db->select('mobile')->where('uid',$uid)->get('members')->row_array();
    }
    //待发货
    public function un_ship($user_id){
        $this->db->where('seller_id',$user_id);
        $this->db->where('order_status',ORDER_PAID);
        $ret=$this->db->count_all_results('order');
        return $ret;
    }

    //待处理退货
    public function un_refund($user_id){
        $this->db->where('store_id',$user_id);
        $this->db->where('status <',AFTERMARKET_SUCCESS);
        $ret=$this->db->count_all_results('refund');
        return $ret;
    }

    //未读消息
    public function un_read($user_id){
        $this->db->select('msg_unread');
        $this->db->where('uid',$user_id);
        $ret=$this->db->get('user_stat')->row_array();
        return $ret;
    }

    //已完成的订单数
    public function finished($user_id){
        $this->db->where('seller_id',$user_id);
        $this->db->where('order_status',ORDER_FINISHED);
        $ret=$this->db->count_all_results('order');
        return $ret;
    }
}
