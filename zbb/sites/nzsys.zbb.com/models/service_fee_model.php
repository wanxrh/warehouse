<?php

class Service_fee_model extends CI_Model {

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 服务费列表查询
     * @param unknown $per_page  每页显示的记录数
     * @param unknown $offset 偏移量
     * @param unknown $time_from 开始时间 
     * @param unknown $time_from 结束时间
     */

    public function get_search($per_page, $offset, $time_from, $time_to) {
        if (!empty($time_from)) {
            $this->db->where('add_time >', $time_from);
        }
        if (!empty($time_to)) {
            $this->db->where('add_time <', $time_to);
        }
        $this->db->from('service_charges');

        $temp = clone($this->db);
        $temp2 = clone($this->db);
        $res['list'] = $this->db->limit($per_page, $offset)->order_by('add_time', 'desc')->get()->result_array();
        $this->db = $temp;
        $res['total'] = $this->db->count_all_results();
        $this->db = $temp2;
        $this->db->select_sum('money');
        $sum = $this->db->get()->row_array();
        $res['amount'] = $sum['money'];
        return $res;
    }
    //更新订单的状态
    public function pay($log_id,$trading_time) {
        $arr = array('status' => 2,'trading_time'=>$trading_time);
        $this->db->where('log_id', $log_id);
        $this->db->update('service_log', $arr);
        $ret = $this->db->affected_rows();
        return $ret;
    }

     //删除
    public function del_log($log_id) {
        if($log_id){
            $this->db->where('log_id', $log_id);
            $this->db->delete('service_log');
            $ret = $this->db->affected_rows();
            return $ret;
        }else{
            return 0;
        }
        
    }


 

    public function get_search_xls($pay_type, $store, $order_id, $time_from, $time_to, $order_by,$payment_id) {

        $this->db->select('service_log.payment_id as pay_id,log_id,service_log.order_id,order_sn,store_name,owner_name,order_amount,service_fee,trading_time,service_log.status as fee_status');
        $this->db->where('service_log.service_fee <> 0');
        $this->db->from('service_log');
        $this->db->join('store', 'service_log.store_id = store.store_id', 'left');
        $this->db->join('order', 'service_log.order_id = order.order_id', 'left');

        $temp = clone($this->db);

        if (!empty($order_id)) {
            $this->db->where('order_sn', $order_id);
        }
        if (!empty($store)) {
            $this->db->where('store_name', $store);
        }
        if (!empty($time_from)) {
            $this->db->where('service_log.trading_time >', $time_from);
        }
        if (!empty($payment_id)) {
            $this->db->where('service_log.payment_id', $payment_id);
        }
        if (!empty($time_to)) {
            $this->db->where('service_log.trading_time <', $time_to);
        }
        if (!empty($pay_type)) {
            $this->db->where('service_log.status', $pay_type);
        }
        switch ($order_by) {
            case 1:
                $this->db->order_by('service_fee', 'asc');
                break;
            case 2:
                $this->db->order_by('service_fee', 'desc');
                break;
        }


        $temp = clone($this->db);
        $a = clone($this->db);
        $data['list'] = $this->db->order_by('log_id', 'desc')->get()->result_array();
        $this->db = $a;
        $data['total_money'] = $this->db->where('service_log.status', 2)->select_sum('service_fee')->get()->row_array();
        $this->db = $temp;
        $data['total'] = $this->db->count_all_results();
        return $data;
    }
}