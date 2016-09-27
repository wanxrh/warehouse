<?php

class Service_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 退款退货列表
     */
    public function refund_list($order_sn='',$refund_sn='',$buyer_name='',$order_status='',$user_id,$per_page='',$offset='')
    {
        if($order_sn){
            $this->db->where('order_sn',$order_sn);
        }
        if($refund_sn){
            $this->db->where('refund_sn',$refund_sn);
        }
        if($buyer_name){
            $this->db->where('buyer_name',$buyer_name);
        }
        if($order_status){
                $this->db->where('refund.status', $order_status-1);
        }
        $this->db->select('refund.type,refund_sn,order_status,order_sn,goods_name,buyer_name,discounted_price,money,apply_time,refund.status,rec_id');
        $this->db->from('refund');
        $this->db->join('order','order.order_id=refund.order_id');
        $this->db->join('order_goods','order_goods.rec_id=refund.target_id');
        $this->db->where('seller_id',$user_id);
        $db=clone($this->db);
        $ret['list']=$this->db->limit($per_page,$offset)->order_by('refund.id','desc')->get()->result_array();
        $this->db=$db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /**导出退货信息
     * @param string $order_sn 订单编号
     * @param string $refund_sn 退货编号
     * @param string $buyer_name 买家名称
     * @param string $order_status 退货状态
     * @param $user_id 商家id
     * @return mixed
     */
    public function refund_list_xls($order_sn='',$refund_sn='',$buyer_name='',$order_status='',$user_id){
        if($order_sn){
            $this->db->where('order_sn',$order_sn);
        }
        if($refund_sn){
            $this->db->where('refund_sn',$refund_sn);
        }
        if($buyer_name){
            $this->db->where('buyer_name',$buyer_name);
        }
        if($order_status){
            $this->db->where('refund.status', $order_status-1);
        }
        $this->db->select('refund.type,refund_sn,order_sn,goods_name,buyer_name,discounted_price,money,apply_time,refund.status,rec_id');
        $this->db->from('refund');
        $this->db->join('order','order.order_id=refund.order_id');
        $this->db->join('order_goods','order_goods.rec_id=refund.target_id');
        $this->db->where('seller_id',$user_id);
        $ret=$this->db->order_by('refund.id','desc')->get()->result_array();
        return $ret;
    }
}
