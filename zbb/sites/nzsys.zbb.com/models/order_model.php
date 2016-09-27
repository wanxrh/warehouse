<?php

/**
 * @name 后台订单模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Order_model extends CI_Model
{
    /*
     * 继承父级构造方法
     * 实例化两个数据库方法
     */

    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_model');
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 根据用户输入的条件进行订单查询，结合分页类使用
     * @param $field 输入的关键字类型
     * @param $search_name 关键字
     * @param $status 订单状态
     * @param $add_time_from 起始时间
     * @param $add_time_to 结束时间
     * @param $order_amount_from 起始价钱
     * @param $order_amount_to 结束价钱
     * @return $data 返回满足条件的订单列表data['list']和订单分页data['page']（二维数组）
     */
    public function get_search($field, $search_name, $status, $add_time_from, $add_time_to, $pay_time_from, $pay_time_to, $order_amount_from, $order_amount_to, $payment_id, $type = FALSE)
    {
        //查询条件
        $this->db = $this->search_where($status, $field, $search_name, $add_time_from, $add_time_to, $pay_time_from, $pay_time_to, $order_amount_from, $order_amount_to, $payment_id);
        $temp = clone($this->db);
        $a = clone($this->db);
        //总条数
        $data['count'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->from('order')->count_all_results();
        //查询符合条件的总金额
        $this->db = $temp;
        $data['total'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->select_sum('order_amount')->get('order')->row_array();
        $this->db = $a;
        if ($type == FALSE) {
            $data['list'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->join('payment', 'payment.payment_id=order.payment_id', 'left')->select('order.*,store.store_name,payment.payment_name')->order_by('add_time', 'desc')->get('order', $this->per_page, $this->offset)->result_array();
        } else {
            $data['list'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->join('payment', 'payment.payment_id=order.payment_id', 'left')->select('order.*,store.store_name')->order_by('add_time', 'desc')->get('order')->result_array();
        }
        return $data;
    }

    /**
     * 根据用户输入的条件进行订单查询，结合分页类使用
     * @param $field 输入的关键字类型
     * @param $search_name 关键字
     * @param $status 订单状态
     * @param $add_time_from 起始时间
     * @param $add_time_to 结束时间
     * @param $order_amount_from 起始价钱
     * @param $order_amount_to 结束价钱
     * @return $data 返回满足条件的订单列表data['list']和订单分页data['page']（二维数组）
     */
    public function get_xls_search($field, $search_name, $status, $add_time_from, $add_time_to, $pay_time_from, $pay_time_to, $order_amount_from, $order_amount_to, $payment_id, $type = FALSE)
    {
        //查询条件
        $this->db = $this->search_where($status, $field, $search_name, $add_time_from, $add_time_to, $pay_time_from, $pay_time_to, $order_amount_from, $order_amount_to, $payment_id);
        $temp = clone($this->db);
        $a = clone($this->db);
        //总条数
        $data['count'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->from('order')->count_all_results();
        //查询符合条件的总金额
        $this->db = $temp;
        $data['total'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->select_sum('order_amount')->get('order')->row_array();
        $this->db = $a;
        if ($type == FALSE) {
            $data['list'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->join('payment', 'payment.payment_id=order.payment_id', 'left')->select('order.*,store.store_name,payment.payment_name')->order_by('add_time', 'desc')->get('order')->result_array();
        } else {
            $data['list'] = $this->db->join('store', 'store.store_id=order.seller_id', 'left')->join('payment', 'payment.payment_id=order.payment_id', 'left')->select('order.*,store.store_name')->order_by('add_time', 'desc')->get('order')->result_array();
        }
        return $data;
    }

    /**
     * 订单商品搜索
     */
    public function get_goods_xls($field, $search_name, $status, $add_time_from, $add_time_to, $pay_time_from, $pay_time_to, $finished_time_from, $finished_time_to)
    {
        switch ($field) {
            case 'order_sn':
                $this->db->like('order.order_sn', $search_name);
                break;
            case 'seller_name':
                $this->db->like('store.store_name', $search_name);
                break;
            case 'buyer_name':
                $this->db->like('order.buyer_name', $search_name);
                break;
        }
        if (!empty($status)) {
            $status_arr = array();
            foreach ($status as $v) {
                switch (intval($v)) {
                    case 0:
                        array_push($status_arr, 0);
                        break;
                    case 11:
                        array_push($status_arr, 11);
                        break;
                    case 21:
                        array_push($status_arr, 21);
                        break;
                    case 31:
                        array_push($status_arr, 31);
                        break;
                    case 41:
                        array_push($status_arr, 41);
                        break;
                    case 50:
                        array_push($status_arr, 50);
                        break;
                    case 51:
                        array_push($status_arr, 51);
                        break;
                    case 60:
                        array_push($status_arr, 60);
                        break;
                    case 61:
                        array_push($status_arr, 61);
                        break;
                }
            }
            $this->db->where_in('order_goods.order_goods_status', $status_arr);
        }
        if (!empty($add_time_from)) {
            $this->db->where('order.add_time >=', $add_time_from);
        }
        if (!empty($add_time_to)) {
            $this->db->where('order.add_time <=', $add_time_to);
        }
        if (!empty($pay_time_from)) {
            $this->db->where('order.pay_time >=', $pay_time_from);
        }
        if (!empty($pay_time_to)) {
            $this->db->where('order.pay_time <=', $pay_time_to);
        }
        if (!empty($finished_time_from)) {
            $this->db->where('order.finished_time >=', $finished_time_from);
        }
        if (!empty($finished_time_to)) {
            $this->db->where('order.finished_time <=', $finished_time_to);
        }
        $a = clone($this->db);
        $b = clone($this->db);
        $data['count'] = $this->db->join('store', 'store.store_id=order.seller_id', 'inner')->join('order_goods', 'order.order_id = order_goods.order_id', 'inner')->from('order')->count_all_results();
        $this->db = $a;
        $this->db->join('store', 'store.store_id=order.seller_id', 'inner');
        $data['list'] = $this->db->join('order_goods', 'order.order_id = order_goods.order_id', 'inner')->select('order.add_time,order.order_sn,order.buyer_name,order_goods.*,store.store_name')->order_by('add_time', 'desc')->get('order')->result_array();
        $this->db = $b;
        $data['total'] = $this->db->join('store', 'store.store_id=order.seller_id', 'inner')->join('order_goods', 'order.order_id = order_goods.order_id', 'inner')->select('price,quantity')->get('order')->result_array();
        return $data;
    }


    /**
     * 根据用户输入的条件进行查询
     * @param $status 订单类型
     * @param $field 查询类型
     * @param $search_name 查询关键字
     * @param $add_time_from 起始时间
     * @param $add_time_to 终止时间
     * @param $order_amount_from 起始价格
     * @param $order_amount_to 终止价格
     */
    protected function search_where($status, $field, $search_name, $add_time_from, $add_time_to, $pay_time_from, $pay_time_to, $order_amount_from, $order_amount_to, $payment_id)
    {

        if ($status) {
            if ($status == 1) {
                $this->db->where('order.pay_time >', 0);
            } elseif ($status == 2) {
                $this->db->where('order.pay_time', 0);
            }
        }
        if ($field) {
            switch ($field) {
                case 'order_sn':
                    $this->db->like('order.order_sn', $search_name);
                    break;
                case 'seller_name':
                    $this->db->like('store.store_name', $search_name);
                    break;
                case 'buyer_name':
                    $this->db_special = $this->load->database('zbb', TRUE);
                    $ret = $this->db_special->where('user_name', $search_name)->get('member')->row_array();
                    if (!$ret) {
                        $this->user_model->sync($search_name);
                    }
                    $this->db->like('order.buyer_name', $search_name);
                    break;
                case 'payment_name':
                    $this->db->like('order.payment_name', $search_name);
                    break;
                case 'consignee':
                    $this->db_special = $this->load->database('zbb', TRUE);
                    $order_arr = $this->db_special->select('order_id')->like('consignee', $search_name)->get('order_extm')->result_array();
                    if ($order_arr) {
                        $this->db->where_in('order.order_id', array_column($order_arr, 'order_id'));
                    } else {
                        $this->db->where('order.order_id < 0');
                    }
                    break;
                case 'phone':
                    $this->db_special = $this->load->database('zbb', TRUE);
                    $order_arr = $this->db_special->select('order_id')->where('phone_mob', $search_name)->get('order_extm')->result_array();
                    if ($order_arr) {
                        $this->db->where_in('order.order_id', array_column($order_arr, 'order_id'));
                    } else {
                        $this->db->where('order.order_id < 0');
                    }
                    break;
                case 'box':
                    $this->db_special = $this->load->database('zbb', TRUE);
                    $order_arr = $this->db_special->select('order_id')->where('box', '1')->get('order')->result_array();
                    if ($order_arr) {
                        $this->db->where_in('order.order_id', array_column($order_arr, 'order_id'));
                    } else {
                        $this->db->where('order.order_id < 0');
                    }
                    break;
            }
        }
        if ($payment_id) {

            $this->db->where('order.payment_id', $payment_id);

        }
        if ($add_time_from) {
            $this->db->where('order.add_time >=', $add_time_from);
        }
        if ($add_time_to) {
            $this->db->where('order.add_time <=', $add_time_to);
        }
        if ($pay_time_from) {
            $this->db->where('order.pay_time >=', $pay_time_from);
        }
        if ($pay_time_to) {
            $this->db->where('order.pay_time <=', $pay_time_to);
        }
        if ($order_amount_from) {
            $this->db->where('order.order_amount >=', $order_amount_from);
        }
        if ($order_amount_to) {
            $this->db->where('order.order_amount <=', $order_amount_to);
        }
        return $this->db;
    }


    /**
     * 订单商品搜索
     */
    public function get_goods_search($field, $search_name, $status, $add_time_from, $add_time_to, $pay_time_from, $pay_time_to, $finished_time_from, $finished_time_to)
    {
        switch ($field) {
            case 'order_sn':
                $this->db->like('order.order_sn', $search_name);
                break;
            case 'seller_name':
                $this->db->like('store.store_name', $search_name);
                break;
            case 'buyer_name':
                $this->db->like('order.buyer_name', $search_name);
                break;
        }
        if (!empty($status)) {
            $status_arr = array();
            foreach ($status as $v) {
                switch (intval($v)) {
                    case 0:
                        array_push($status_arr, 0);
                        break;
                    case 11:
                        array_push($status_arr, 11);
                        break;
                    case 21:
                        array_push($status_arr, 21);
                        break;
                    case 31:
                        array_push($status_arr, 31);
                        break;
                    case 41:
                        array_push($status_arr, 41);
                        break;
                    case 50:
                        array_push($status_arr, 50);
                        break;
                    case 51:
                        array_push($status_arr, 51);
                        break;
                    case 60:
                        array_push($status_arr, 60);
                        break;
                    case 61:
                        array_push($status_arr, 61);
                        break;
                }
            }
            $this->db->where_in('order_goods.order_goods_status', $status_arr);
        }
        if (!empty($add_time_from)) {
            $this->db->where('order.add_time >=', $add_time_from);
        }
        if (!empty($add_time_to)) {
            $this->db->where('order.add_time <=', $add_time_to);
        }
        if (!empty($pay_time_from)) {
            $this->db->where('order.pay_time >=', $pay_time_from);
        }
        if (!empty($pay_time_to)) {
            $this->db->where('order.pay_time <=', $pay_time_to);
        }
        if (!empty($finished_time_from)) {
            $this->db->where('order.finished_time >=', $finished_time_from);
        }
        if (!empty($finished_time_to)) {
            $this->db->where('order.finished_time <=', $finished_time_to);
        }
        $a = clone($this->db);
        $b = clone($this->db);
        $data['count'] = $this->db->join('store', 'store.store_id=order.seller_id', 'inner')->join('order_goods', 'order.order_id = order_goods.order_id', 'inner')->from('order')->count_all_results();
        $this->db = $a;
        $this->db->join('store', 'store.store_id=order.seller_id', 'inner');
        $data['list'] = $this->db->join('order_goods', 'order.order_id = order_goods.order_id', 'inner')->select('order.add_time,order.order_sn,order.buyer_name,order_goods.*,store.store_name')->order_by('rec_id', 'desc')->get('order', $this->per_page, $this->offset)->result_array();
        $this->db = $b;
        $data['total'] = $this->db->join('store', 'store.store_id=order.seller_id', 'inner')->join('order_goods', 'order.order_id = order_goods.order_id', 'inner')->select('price,quantity')->get('order')->result_array();
        return $data;
    }

    /**
     * 订单详情
     */
    public function order_info($order_id)
    {
        $this->db->from('order');
        $this->db->where('order.order_id', $order_id);
        $this->db->join('order_extm', 'order_extm.order_id = order.order_id');
        $ret = $this->db->get_where()->row_array();
        return $ret;
    }

    /**
     * 买家订单查看订单详情
     */
    public function get_goods($order_id)
    {
        $this->db->select('goods_id,goods_name');
        $ret=$this->db->where('order_id',$order_id)->get('order_goods')->result_array();
        return $ret;
    }

    /**
     * 获取订单商品详情的信息
     */
    public function get_order_goods($rec_id)
    {
        $this->db->select('order.add_time,auto_comfirm_time,order.pay_time,order.ship_time,order.finished_time,order_goods.goods_name,order_goods.goods_id,order_goods.specification');
        return $this->db->where('order_goods.rec_id', $rec_id)->join('order', 'order.order_id = order_goods.order_id', 'inner')->get('order_goods')->row_array();
    }

    /**
     * 获取售后信息
     */
    public function get_refund($rec_id){
        return $this->db->select('id')->where('target_id',$rec_id)->get('refund')->row_array();
    }

    /**
     * drawback关联appeal_type
     */
    public function drawback_appeal($condition)
    {
        $this->db->select('drawback.*,appeal_type.utype,appeal_type.name')->from('drawback');
        $this->db->join('appeal_type', 'drawback.appeal = appeal_type.id', 'inner');
        return $this->db->where($condition)->get()->row_array();
    }

    /**
     * goods_return关联appeal_type
     */
    public function goods_return_appeal($condition)
    {
        $this->db->select('goods_return.*,appeal_type.utype,appeal_type.name')->from('goods_return');
        $this->db->join('appeal_type', 'goods_return.appeal = appeal_type.id', 'inner');
        return $this->db->where($condition)->get()->row_array();
    }

}
