<?php
/**
 *app用户中心模型
 */
require "app_model.php";

class App_user_model extends App_model
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 查询用户订单列表
     * @param $condition 查询条件
     * @param $per_page 单页显示数
     * @param $offset 偏移量
     * @return mixed
     */
    public function get_orders($condition, $per_page, $offset)
    {
        $this->db->where('del_status', 0);
        $this->db->where($condition);
        $clone = clone($this->db);
        $result['list'] = $this->db->select('store_name,order_id,discount as total,order_status,extend_confirm,auto_comfirm_time')->order_by('add_time', 'DESC')->limit($per_page, $offset)->get('order')->result_array();
        $this->db = $clone;
        $result['total'] = $this->db->count_all_results('order');
        return $result;
    }

    /**
     * 通过订单ID数组查询订单商品表
     * @param $orderIds 订单ID数组
     * @return mixed
     */
    public function get_order_goods($orderIds)
    {
        return $this->db->where_in('order_id', $orderIds)->get('order_goods')->result_array();
    }

    /**
     * 查询单条订单记录
     * @param $condition 查询条件
     */
    public function get_order($condition)
    {
        return $this->db->where($condition)->get('order')->row_array();
    }

    /**
     * 更新订单信息，删除状态等等
     * @param $condition 查询条件
     * @param $data 更新数据
     * @return mixed
     */
    public function update_order($condition, $data)
    {
        $this->db->where($condition)->update('order', $data);
        return $this->db->affected_rows();
    }

    /*
    *用户头像
     */
    public function get_user_info($user_id)
    {
        $this->db->select('portrait,qq as service_qq,user_name');
        $this->db->where('user_id', $user_id);
        $ret = $this->db->get('member')->row_array();
        $this->uc_db = $this->load->database('uc', TRUE);
        $temp=$this->uc_db->select('mobile')->where('uid',$user_id)->get('members')->row_array();
        if($temp){
            $ret['mobile']=$temp['mobile'];
        }
        return $ret;
    }

    //待付款
    public function shipments_status($user_id,$status)
    {
        $this->db->where('buyer_id', $user_id);
        $this->db->where('order_status', $status);
        $ret = $this->db->count_all_results('order');
        return $ret;
    }
    //待处理退货
    public function un_refund($user_id)
    {
        $this->db->where('buyer_id', $user_id);
        $this->db->where('refund_group IS NOT ', 'NULL', false);
        $ret = $this->db->count_all_results('order');
        return $ret;
    }

    //获取订单收货信息
    public function order_extm($order_id)
    {
        $ret = $this->db->get_where('order_extm', array('order_id' => $order_id))->row_array();
        return $ret;
    }

    //获取订单收货信息
    public function get_store($store_id)
    {
        $ret = $this->db->get_where('store', array('store_id' => $store_id))->row_array();
        return $ret;
    }
}