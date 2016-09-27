<?php

/*
 * 店铺商品分类模型
 */

class express_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 收货人信息
     */
    public function get_order_extm($order_id)
    {
        return $this->db->where('order_id', $order_id)->get('order_extm')->row_array();
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
    public function get_region($parent_id = 0)
    {
        $this->db->select('region_id,region_name');
        return $this->db->where('parent_id', $parent_id)->get('region')->result_array();
    }

    public function update_address($order_id, $arr)
    {
        return $this->db->where('order_id', $order_id)->update('order_extm', $arr);
    }


    /**
     * 发货
     * @param $order_id 订单ID
     * @param $express_name 物流名称
     * @param $invoice_no 物流编号
     * @param $comment 卖家发货备注
     * @return bool
     */
    public function save_shipments($order_id, $express_name, $invoice_no, $comment)
    {
        $this->load->library('MongoOperate');

        $this->db->trans_begin();//开启事务
        //修改发货地址表的备注
        $this->db->where('order_id', $order_id)->update('order_extm', array('comment' => $comment));
        //获取订单所有商品
        $order_goods = $this->db->get_where('order_goods', array('order_id'=>$order_id))->result_array();
        
        $arr=array();
        foreach ($order_goods as $m) {
            if (!in_array($m['order_goods_status'], array(ORDER_GOODS_DRAWBACKED))) {
                //不是取消的订单商品都可以发货
                $this->db->where('rec_id', $m['rec_id']);
                $this->db->update('order_goods', array('order_goods_status' => ORDER_GOODS_SHIPPED));
                //删除退款申请定时
                $this->db->where('type', UNSHIP_DRAWBACK_TIMER)->where('target_id', $m['rec_id'])->delete('tasktimer');
                $temp = $this->db->select('id,target_id')->where('target_id', $m['rec_id'])->get('refund')->row_array();
                if($temp){
                    //关闭对应售后记录
                    $this->db->where('id', $temp['id'])->update('refund',array('status'=>AFTERMARKET_CLOSE));
                    $mongo_arr = array(
                        'apply_refund_id' => intval($temp['id']),//售后申请记录ID
                        'target_id' => intval($temp['target_id']),//申请退款/退货ID
                        'node_id' => REFUND_CLOSE,//节点
                        'node' => '退款关闭',//节点
                        'node_time' => time(),//节点时间
                        'supplement' => '卖家发货,关闭了退款'
                    );
                    $this->mongooperate->insert('refund_log', $mongo_arr);
                }
            } else {
                $arr[] = $m['rec_id'];
            }
        }
        $arr = implode(',', $arr);
        //更新order表
        $this->db->where('order_id', $order_id)->update('order', array(
            'express_name' => $express_name,
            'invoice_no' => $invoice_no,
            'ship_time' => time(),
            'refund_group' => $arr,
            'order_status' => ORDER_SHIPPED,
            'auto_comfirm_time' => time() + AUTO_COMFIRM
        ));

        //写定时器表
        $this->db->insert('tasktimer', array(
            'dateline' => time(),
            'type' => COMFIRM_TIMER,
            'target_id' => $order_id,
            'plan_time' => time() + AUTO_COMFIRM
        ));

        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    public function check_order_address($user_id)
    {
        return $this->db->where('user_id', $user_id)->get('address')->row_array();
    }

    /*
     * 获取订单商品
     */
    public function order_goods($order_id)
    {
        $this->db->select('goods_name,specification,quantity,discounted_price,goods_id,goods_image,order_goods_status');
        $this->db->where('order_id', $order_id);
        $ret = $this->db->get('order_goods')->result_array();
        return $ret;
    }
}
