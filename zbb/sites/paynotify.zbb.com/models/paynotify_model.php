<?php

/**
 * Class Paynotify_model 通知模型
 */
class Paynotify_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 检测未支付订单
     * @param $order_status 交易状态
     * @param $orderSn_arr 订单ID数组
     * @return mixed
     */
    public function check_paynotify_orders($order_status, $orderSn_arr)
    {
        switch ($order_status) {
            case ORDER_UNPAY:
                $field = 'order_sn';
                break;
            case ORDER_SHIPPED:
                $field = 'order_confirm_sn';
                break;
            default:
                return false;
                break;
        }
        return $this->db->where('order_status', $order_status)->where_in($field, $orderSn_arr)->get('order')->result_array();
    }

    /**
     * 改变订单统一入口
     * @param $tradeStatus 交易状态
     * @param $data 订单/订单商品数组
     * @return bool
     */
    public function change_order_status($tradeStatus, $data)
    {
        switch ($tradeStatus) {
            case 0:
                $result = $this->paid_order_status($data);
                break;
            case 1:
                $result = $this->finished_order_status($data);
                break;
            case 2:
            case 3:
                $result = $this->refund_order_status($data);
                break;
            default:
                $result = false;
                break;
        }
        return $result;
    }

    /**
     * 支付后改变状态
     * @param $orders 订单数组
     * @return bool
     */
    private function paid_order_status($orders)
    {
        //开启事务
        $this->db->trans_begin();
        $orderIds = array_column($orders, 'order_id');
        $this->db->where_in('order_id', $orderIds)->update('order', array('order_status' => ORDER_PAID, 'pay_time' => time()));
        $this->db->where_in('order_id', $orderIds)->update('order_goods', array('order_goods_status' => ORDER_GOODS_PAID));
        $this->db->where('type', CANCEL_TIMER)->where_in('target_id', $orderIds)->delete('tasktimer');
        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    /**
     * 确认收货改变状态业务
     * @param $orders 订单数组
     * @return bool
     */
    private function finished_order_status($orders)
    {
        //开启事务
        $this->db->trans_begin();

        $orderIds = array_column($orders, 'order_id');


        //获取订单中正在售后的商品
        $order_goods = $this->db->select('order_id,rec_id,order_goods_status')->where_in('order_id', $orderIds)->get('order_goods')->result_array();
        $aftermarket_target = [];
        foreach ($order_goods as $goods) {
            if (in_array($goods['order_goods_status'], array(ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING))) {
                $aftermarket_target[] = $goods['rec_id'];
            }
        }

        //存在售后商品，强项关闭，写入mongo日志
        if (!empty($aftermarket_target)) {
            $refunds_info = $this->db->select('id,target_id')->where_in('target_id', $aftermarket_target)->get('refund')->result_array();
            $this->db->where_in('target_id', $aftermarket_target)->update('refund', array('status' => AFTERMARKET_CLOSE));

            //写入mongoDB的refund_log
            $this->load->model('aftermarket_model');
            $this->load->library('MongoOperate');
            $node = 0;
            foreach ($refunds_info as $refund) {
                $node_details = $this->aftermarket_model->refund_log_node_details($refund['id'], REFUND_CLOSE, array('target_id' => $refund['target_id'], 'close_reason' => '买家确认收货'));
                if (!$this->mongooperate->insert('refund_log', $node_details)) {
                    $this->db->trans_rollback();
                    $node = 0;
                    break;
                }
                $node = 1;
            }
            if (!$node) {
                return false;
            }
        }
        //改变订单状态
        $this->db->where_in('order_id', $orderIds)->update('order', array('finished_time' => time(), 'refund_group' => '', 'order_balance' => 0, 'order_status' => ORDER_FINISHED));

        //改变订单商品状态
        $this->db->where_not_in('order_goods_status', array(ORDER_GOODS_DRAWBACKED, ORDER_GOODS_RETURNED, ORDER_GOODS_FINISHED))->where_in('order_id', $orderIds)->update('order_goods', array('order_goods_status' => ORDER_GOODS_FINISHED));

        //技术服务费
        $service = [];
        foreach ($orders as $v) {
            if ($v['service_charges'] > 0) {
                $service[] = array(
                    'order_id' => $v['order_id'],
                    'service_charges_sn' => $v['service_charges_sn'],
                    'money' => $v['service_charges'],
                    'add_time' => time()
                );
            }
        }
        if (!empty($service)) {
            $this->db->insert_batch('service_charges', $service);
        }

        //定时器删除
        $this->db->where('type', COMFIRM_TIMER)->where_in('target_id', $orderIds)->delete('tasktimer');
        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    /**
     * 退款成功业务改变
     * @param $order_goods 订单商品信息
     * @return bool
     */
    private function refund_order_status($order_goods)
    {
        //开启事务
        $this->db->trans_begin();

        //改变订单商品状态
        $refund = $this->db->select('id,type,money')->where('target_id', $order_goods['rec_id'])->get('refund')->row_array();
        $this->db->where('target_id', $order_goods['rec_id'])->update('refund', array('status' => AFTERMARKET_SUCCESS));
        $post_goods_status = array(
            1 => ORDER_GOODS_DRAWBACKED,
            2 => ORDER_GOODS_RETURNED
        );

        //改变订单商品
        $this->db->where('rec_id', $order_goods['rec_id'])->set(array('order_goods_status' => $post_goods_status[$refund['type']], 'order_goods_balance' => 'order_goods_balance - ' . $refund['money']), null, false)->update('order_goods');

        //改变订单诚信金和确认收货剩余金额
        //减去order表refund_group
        $order = $this->db->select('refund_group,surplus_comfirm_time,order_status')->where('order_id', $refund['order_id'])->get('order')->row_array();
        $refund_group = array_flip(explode(',', $order['refund_group']));
        unset($refund_group[$refund['target_id']]);
        $this->db->set('order_balance', 'order_balance - ' . $refund['money'], false);
        if ($order_goods['service_fee'] > 0) {
            $this->db->set('service_charges', 'service_charges - ' . $order_goods['service_fee'], false);
        }
        $this->db->where('order_id', $order_goods['order_id'])->update('order', array('refund_group' => implode(',', array_flip($refund_group))));

        //判断订单状态是否修改
        $goods_status = $this->db->select('order_goods_status')->where('order_id', $order_goods['order_id'])->get('order_goods')->result_array();
        $current_status = array_column($goods_status, 'order_goods_status');

        //订单商品如存在退款/退货中，订单状态无需改变，如没有并且商品中有完成商品，订单状态则为完成，相反则为取消
        if (!array_intersect(array(ORDER_GOODS_PAID, ORDER_GOODS_SHIPPED, ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING), $current_status)) {
            $order_status['finished_time'] = time();
            if (in_array(ORDER_GOODS_FINISHED, $current_status)) {
                $order_status['order_status'] = ORDER_FINISHED;
            } else {
                $order_status['order_status'] = ORDER_CANCELED;
            }
            $this->db->where('order_id', $order_goods['order_id'])->update('order', $order_status);
        } else {
            //判断是否重新插入确认收货定时器
            if ($order['order_status'] == ORDER_SHIPPED && !array_intersect(array(ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING), $current_status)) {
                $this->db->where('order_id', $order_goods['order_id'])->update('order', array('auto_comfirm_time' => time() + $order['surplus_comfirm_time']));
                $this->db->insert('tasktimer', array('dateline' => time(), 'type' => COMFIRM_TIMER, 'target_id' => $order_goods['order_id'], 'plan_time' => time() + $order['surplus_comfirm_time']));
            }
        }

        //删除定时器
        $this->db->where_in('type', array(UNSHIP_DRAWBACK_TIMER, SHIPPED_DRAWBACK_TIMER, SHIPPED_BUYER_RETURNED_TIMER))->where('target_id', $order_goods['rec_id'])->delete('tasktimer');

        //写入mongoDB的refund_log
        $this->load->model('aftermarket_model');
        $this->load->library('MongoOperate');
        $node_details = $this->aftermarket_model->refund_log_node_details($refund['id'], REFUND_SUCCESS, array('target_id' => $order_goods['rec_id'], 'refund_money' => $refund['money']));
        if (!$this->mongooperate->insert('refund_log', $node_details)) {
            $this->db->trans_rollback();
            return false;
        }

        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    /**
     * 插入通知记录
     * @param $data 参数
     */
    public function addPaynotifyLog($data)
    {
        $this->db->insert('paynotify_log', $data);
        return $this->db->insert_id();
    }

    /**
     * 通知成功，删除通知记录
     * @param $paynotifyLogId
     */
    public function delPaynotifyLog($paynotifyLogId)
    {
        $this->db->where('id', $paynotifyLogId)->delete('paynotify_log');
    }

    /**
     * 获取退款记录
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_refund($condition)
    {
        return $this->db->where($condition)->get('refund')->row_array();
    }

    /**
     * 获取订单商品
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_order_goods($condition)
    {
        return $this->db->where($condition)->get('order_goods')->row_array();
    }
}