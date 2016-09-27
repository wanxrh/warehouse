<?php

/**
 * @name 后台店铺模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Appeal_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
        $this->uc_db = $this->load->database('uc', TRUE);
    }

    /*
     * 未处理的申诉列表
     */
    public function un_treated($order_sn = '', $refund_sn = '', $goods_name = '', $buyer_name = '', $seller_name = '', $per_page, $offset, $status, $order_status = '')
    {
        if ($order_sn) {
            $this->db->where('order_sn', $order_sn);
        }
        if ($refund_sn) {
            $this->db->where('refund_sn', $refund_sn);
        }
        if ($goods_name) {
            $this->db->where('goods_name', $goods_name);
        }
        if ($buyer_name) {
            $this->db->where('buyer_name', $buyer_name);
        }
        if ($seller_name) {
            $this->db->select('user_id');
            $this->db->where('user_name', $seller_name);
            $seller_id = $this->db->get('member')->row_array();
            if ($seller_id) {
                $this->db->where('seller_id', $seller_id);
            }
        }
        if ($order_status) {
            $this->db->where('refund.status', $order_status - 1);
        }
        if ($status) {
            $this->db->where('appeal.status >=', $status);
        } else {
            $this->db->where('appeal.status', 0);
        }
        $this->db->select('refund_sn,goods_name,order_sn,buyer_name,seller_id,discounted_price,appeal.add_time,money,refund.status,refund.type,rec_id');
        $this->db->from('appeal');
        $this->db->join('refund', 'refund.id=appeal.refund_id');
        $this->db->join('order_goods', 'order_goods.rec_id=refund.target_id');
        $this->db->join('order', 'order.order_id=refund.order_id');
        $db = clone($this->db);
        $ret['list'] = $this->db->limit($per_page, $offset)->get()->result_array();
        $this->db = $db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /*
     *关闭退款
    */
    public function close_appeal($appeal_id)
    {
        //开启事务
        $this->db->trans_begin();
        $temp = $this->get_appeal($appeal_id);
        $this->db->where('appeal_id', $appeal_id)->update('appeal', array('status' => 1, 'handle_time' => time()));
        $this->db->where('id', $temp['refund_id'])->update('refund', array('status' => AFTERMARKET_CLOSE));
        //更新order
        $this->db->from('refund');
        $this->db->select('refund_group,order.order_id,target_id,order.order_status,surplus_comfirm_time');
        $this->db->join('order', 'order.order_id=refund.order_id');
        $this->db->where('refund.id', $temp['refund_id']);
        $ret = $this->db->get()->row_array();

        $refund_group = explode(',', $ret['refund_group']);
        foreach ($refund_group as $key => $v) {
            if ($v == $ret['target_id']) ;
            unset($refund_group[$key]);
        }
        $refund_group = implode(',', $refund_group);
        $order_id = $ret['order_id'];
        $auto_comfirm_time = time() + $ret['surplus_comfirm_time'];
        $this->db->where('order_id', $order_id)->update('order', array('auto_comfirm_time' => $auto_comfirm_time, 'refund_group' => $refund_group));

        //插入定时器
        $this->db->inert('tasktimer', array('type' => COMFIRM_TIMER, 'dateline' => time(), 'target_id' => $ret['order_id'], 'plan_time' => $auto_comfirm_time));

        //更新order_goods表状态
        $order_goods_status = array(
            ORDER_PAID => ORDER_GOODS_PAID,
            ORDER_SHIPPED => ORDER_GOODS_SHIPPED
        );
        $this->db->where('rec_id', $temp['target_id'])->update('order_goods', array('order_goods_status' => $order_goods_status[$ret['order_status']]));
        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    /*
     * 退款信息
     */

    public function refund_info($rec_id)
    {
        $this->db->from('refund');
        $this->db->select('refund.id,order_goods.price,target_id,refund_sn,buyer_id,order_confirm_sn,order_balance,seller_id,rec_id,apply_reason,order_goods.order_id,goods_id,goods_name,specification,goods_image,buyer_name,order_sn,discounted_price,quantity,money,refund.type,order_status,supplement,countdown,refund.status');
        $this->db->where('refund.target_id', $rec_id);
        $this->db->join('order_goods', 'refund.target_id=order_goods.rec_id');
        $this->db->join('order', 'order.order_id=refund.order_id');
        $ret = $this->db->get()->row_array();
        return $ret;
    }

    /*
     * 退款退货类型
     */
    public function reason_info($type)
    {
        return $this->db->get_where('apply_reason', array('type' => $type))->result_array();
    }

    /*
    * 更新退换货表
    */
    public function update_refund($rec_id, $arr)
    {
        return $this->db->where('target_id', $rec_id)->update('refund', $arr);
    }

    /*
     * 更新退货表
     */
    public function insert_goods_return($arr)
    {
        $this->db->insert('goods_return', $arr);
        return $this->db->insert_id();
    }

    /*
     * 退款退货类型描述
     */
    public function reason_name($id)
    {
        $this->db->where('id', $id);
        return $this->db->get('apply_reason')->row_array();
    }

    /*
    * 申诉信息
    */
    public function appeal_info($rec_id)
    {
        return $this->db->get_where('appeal', array('target_id' => $rec_id))->row_array();
    }

    /*
    * 申诉信息
    */
    public function get_appeal($appeal_id)
    {
        return $this->db->get_where('appeal', array('appeal_id' => $appeal_id))->row_array();
    }

    /*
    * 申诉信息
    */
    public function user_info($user_id)
    {
        $this->db->select('user_id,user_name');
        $this->db->where_in('user_id', $user_id);
        return $this->db->get('member')->result_array();
    }

    /*
   * 售后信息
   */
    public function get_refund($refund_id)
    {
        return $this->db->get_where('refund', array('refund_id' => $refund_id))->row_array();
    }

    /*
   * 删除定时器
   */
    public function del_timer($type, $target_id)
    {
        $ret = $this->db->where(array('type' => $type, 'target_id' => $target_id))->delete('tasktimer');
        return $ret;
    }

    /*
    * 增加定时
    */
    public function insert_timer($arr)
    {
        $this->db->insert('tasktimer', $arr);
        return $this->db->insert_id();
    }

    /*
   * 默认退货地址
   */
    public function get_address($user_id)
    {
        $this->db->where('type', 1);
        $this->db->where('user_id', $user_id);
        $this->db->where('is_default', 1);
        return $this->db->get('address')->row_array();
    }

    /*
  * 默认退货地址
  */
    public function goods_return($refund_id)
    {
        $this->db->where('refund_id', $refund_id);
        $this->db->where('return_status', 1);
        return $this->db->get('goods_return')->row_array();
    }

    /*
    *退款给买家
   */
    public function refund($appeal_id)
    {
        //开启事务
        $this->db->trans_begin();

        $temp = $this->get_appeal($appeal_id);
        //关闭申诉
        $this->db->where('appeal_id', $appeal_id)->update('appeal', array('status' => 1, 'handle_time' => time()));
        $this->db->where('id', $temp['refund_id'])->update('refund', array('status' => AFTERMARKET_SUCCESS));
        //更新order
        $this->db->from('refund');
        $this->db->select('refund_group,order.order_id,target_id,order.order_status');
        $this->db->join('order', 'order.order_id=refund.order_id');
        $this->db->where('refund.id', $temp['refund_id']);
        $ret = $this->db->get()->row_array();

        $refund_group = explode(',', $ret['refund_group']);
        foreach ($refund_group as $key => $v) {
            if ($v == $ret['target_id']) ;
            unset($refund_group[$key]);
        }
        $refund_group = implode(',', $refund_group);
        $order_id = $ret['order_id'];
        if ($refund_group != '') {
            $this->db->where('order_id', $order_id)->update('order', array('refund_group' => $refund_group));
        } else {
            //没有过退货就关闭订单
            $temp_arr = array(
                'refund_group' =>'',
                'finished_time' => time(),
                'order_status' => ORDER_CANCELED
            );
            $this->db->where('order_id', $order_id)->update('order', $temp_arr);
        }

        //更新order_goods表状态
        $order_goods_status = array(
            ORDER_PAID => ORDER_GOODS_PAID,
            ORDER_SHIPPED => ORDER_GOODS_SHIPPED
        );
        $this->db->where('rec_id', $temp['target_id'])->update('order_goods', array('order_goods_status' => $order_goods_status[$ret['order_status']]));

        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }

    }

}

