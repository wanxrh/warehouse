<?php

class Refund_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 退款信息
     */
    public function refund_info($rec_id, $user_id)
    {
        $this->db->from('refund');
        $this->db->select('refund.id,order_goods.price,target_id,refund_sn,buyer_id,order_confirm_sn,order_balance,seller_id,rec_id,apply_reason,order_goods.order_id,goods_id,goods_name,specification,goods_image,buyer_name,order_sn,discounted_price,quantity,money,refund.type,order_status,supplement,countdown,refund.status');
        $this->db->where('refund.target_id', $rec_id);
        $this->db->where('order.seller_id', $user_id);
        $this->db->join('order_goods', 'refund.target_id=order_goods.rec_id');
        $this->db->join('order', 'order.order_id=refund.order_id');
        $ret = $this->db->get()->row_array();
        return $ret;
    }

    /*
     * 退款退货类型
     */
    public function reason_info($type){
        return $this->db->get_where('apply_reason',array('type'=>$type))->result_array();
    }

    /*
     * 退款退货类型描述
     */
    public function reason_name($id){
        $this->db->where('id',$id);
        return $this->db->get('apply_reason')->row_array();
    }

    /*
     * 更新退换货表
     */
    public function update_refund($rec_id,$arr){
        return $this->db->where('target_id',$rec_id)->update('refund',$arr);
    }

    /*
     * 商家退货地址
     */
    public function return_address($user_id){
        $this->db->where(array('user_id'=>$user_id,'type'=>1));
        return $this->db->get('address')->result_array();
    }

    /*
     * 检测rec_id有效
     */
    public function check_refund($rec_id,$seller_id){
        
        $this->db->from('refund');
        $this->db->where('target_id',$rec_id);
        $this->db->join('order','order.order_id=refund.order_id');
        $ret=$this->db->where('seller_id',$seller_id)->get()->row_array();
        return $ret;
    }

    /*
     * 更新退货表
     */
    public function insert_goods_return($arr){
        $this->db->insert('goods_return',$arr);
        return $this->db->insert_id();
    }

    /*
     * 地址信息
     */
    public function get_address($addr_id){
        return $this->db->get_where('address',array('addr_id'=>$addr_id))->row_array();
    }

    /*
     * 退货信息表
     */
    public function get_goods_return($refund_id){
        $ret=$this->db->get_where('goods_return',array('refund_id'=>$refund_id))->row_array();
        return $ret;
    }

    /*
     * 删除定时器
     */
    public function del_timer($type,$target_id){
        $ret=$this->db->where(array('type'=>$type,'target_id'=>$target_id))->delete('tasktimer');
        return $ret;
    }
    /*
    * 增加定时
    */
    public function insert_timer($arr){
        $this->db->insert('tasktimer',$arr);
        return $this->db->insert_id();
    }

    public function get_refund($conditon)
    {
        return $this->db->where($conditon)->get('refund')->row_array();
    }
}
