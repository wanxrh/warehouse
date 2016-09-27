<?php

/**
 * 订单表的数据库操作类
 * @author Sunny
 *
 */
class Order_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 查询全部订单
     */
    public function get_orders($goods_name = '', $order_sn = '', $add_time_from = '', $add_time_to = '', $order_status = '', $buyer_name = '', $per_page, $offset)
    {

        if (!empty($goods_name)) {
            $this->db->select('order_id');
            $this->db->like('goods_name', $goods_name);
            $ret=$this->db->distinct()->get('order_goods')->result_array();
            if(!empty($ret)){
                $res = array_column($ret,'order_id');
                $this->db->where_in('order.order_id',$res);
            }else{
                $ret['list']='';
                $ret['total']=0;
                return $ret;
            }
        }

        if ($buyer_name!='') {
            $this->db->where('buyer_name',$buyer_name);
        }

        if ($order_sn!= '') {
            $this->db->where('order_sn', $order_sn);
        }
        if ($order_status!='') {
            $this->db->where('order_status', $order_status);
        }
        if ($add_time_from!='') {
            $this->db->where('order.add_time >=', $add_time_from);
        }
        if ($add_time_to!='') {
            $this->db->where('order.add_time <=', $add_time_to+86400);
        }

        $this->db->select('order.order_id,order_sn,order_status,buyer_name,buyer_id,order_amount,add_time');
        $this->db->from('order');
        $this->db->where('seller_id', get_user()['id']);
        $db = clone($this->db);
        $ret['list'] = $this->db->order_by('add_time', 'desc')->limit($per_page, $offset)->get()->result_array();
        $this->db = $db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /*
     * 查询订单里面的商品
     */
    public function get_order_goods($ids)
    {

        $this->db->select('rec_id,order_id,goods_id,goods_name,price,quantity,specification,goods_image,order_goods_status');
        $this->db->from('order_goods');
        $this->db->where_in('order_id', $ids);
        $ret = $this->db->order_by('rec_id', 'desc')->get()->result_array();
        return $ret;
    }

    public function get_goods($goods_name)
    {
        return $this->db->like('goods_name', $goods_name)->order_by('rec_id', 'desc')->group_by('order_id')->get('order_goods')->result_array();
    }

    /*
    * 订单校验
    */
    public function check_order($order_id, $seller_id, $status = '')
    {
        $this->db->where(array('seller_id' => $seller_id, 'order_id' => $order_id));
        if ($status != '') {
            $this->db->where('order_status', $status);
        }
        return $this->db->get('order')->row_array();
    }

    /*
     * 收货人信息
     */
    public function get_order_extm($order_id)
    {
        return $this->db->where('order_id', $order_id)->get('order_extm')->row_array();
    }

    /*
     * 订单信息
     */
    public function get_order_info($order_id)
    {
        return $this->db->get_where('order', array('order_id' => $order_id))->row_array();
    }

    /*
    * 查询全部订单
    */
    public function get_orders_xls($goods_name='', $add_time_from='', $add_time_to='', $order_sn='', $order_status='', $buyer_name='')
    {
        if (!empty($goods_name)) {
            $this->db->select('order_id');
            $this->db->like('goods_name', $goods_name);
            $ret=$this->db->distinct()->get('order_goods')->result_array();
            if(!empty($ret)){
                $this->db->where_in('order.order_id',array_column($ret,'order_id'));
            }else{
                $ret='';
                return $ret;
            }
        }

        if ($buyer_name!='') {
            $this->db->where('buyer_name',$buyer_name);
        }
        if ($order_status!='') {
            $this->db->where('order_status', $order_status);
        }
        if (!empty($add_time_from)) {
            $this->db->where('order.add_time >=', $add_time_from);
        }
        if (!empty($add_time_to)) {
            $this->db->where('order.add_time <=', $add_time_to);
        }
        if ($order_sn!='') {
            $this->db->where('order_sn', $order_sn);
        }

        $this->db->select('order.order_id,consignee,mobile,region_name,address,order_sn,order_status,buyer_name,postscript,pay_time,invoice_no,express_name,order_amount,add_time,comment');
        $this->db->from('order');
        $this->db->where('seller_id', get_user()['id']);
        $this->db->join('order_extm', 'order.order_id=order_extm.order_id', 'left');
        $ret = $this->db->order_by('add_time', 'desc')->get()->result_array();
        return $ret;
    }

    /*
      * 取消订单
     */
    public function cancel($order_id)
    {
        //读取订单商品信息
        $order_goods_info = $this->get_goods_info($order_id);
        //开启事务
        $this->db->trans_begin();
        //修改order表订单状态
        $this->db->where('order_id', $order_id)->update('order', array('order_status' => ORDER_CANCELED,'finished_time'=>time()));
        //修改订单商品状态
        $this->db->where('order_id', $order_id)->update('order_goods', array('order_goods_status' => ORDER_GOODS_CANCELED));
        //修改库存
        foreach ($order_goods_info as $v) {
            $sql = 'update shop_goods_sku set stock=stock+' . $v['quantity'] . ' where sku_id=' . $v['sku_id'];
            $this->db->query($sql);
        }
        //删除定时任务
        $this->db->where(array('target_id'=>$order_id,'type'=>CANCEL_TIMER))->delete('tasktimer');

        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }

    }

    public function get_goods_info($order_id)
    {
        $ret = $this->db->where('order_id', $order_id)->get('order_goods')->result_array();
        return $ret;
    }

    public function get_order_goods_quantity($order_ids)
    {
        $this->db->select('order_id,sum(quantity) as quantity');
        $this->db->where_in('order_id', $order_ids);
        $ret = $this->db->order_by('order_id', 'desc')->group_by('order_id')->get('order_goods')->result_array();
        return $ret;
    }

    public function get_order_goods_xls($ids)
    {
        $this->db->select('order_id,goods_name');
        $this->db->from('order_goods');
        $this->db->where_in('order_id', $ids);
        $ret = $this->db->order_by('rec_id', 'desc')->group_by('order_id')->get()->result_array();
        return $ret;
    }
    /*
     * 修改快递
     */
    public function express($order_id,$arr){
       return $this->db->where('order_id',$order_id)->update('order',$arr);
    }

}
