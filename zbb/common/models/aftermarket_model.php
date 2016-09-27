<?php

/*
 * 售后模型
 */

class Aftermarket_model extends CI_Model
{
    private static $_claim = array(1 => '仅退款', 2 => '退款退货');

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 获取店铺信息
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_store($conditon)
    {
        return $this->db->where($conditon)->get('store')->row_array();
    }

    /**
     * 获取订单信息
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_order($conditon)
    {
        return $this->db->where($conditon)->get('order')->row_array();
    }

    /**
     * 获取订单商品信息
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_order_goods($conditon)
    {
        return $this->db->where($conditon)->get('order_goods')->row_array();
    }

    /**
     * 获取售后信息
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_refund($condition)
    {
        return $this->db->where($condition)->get('refund')->row_array();
    }

    /**
     * 查询买家退货信息
     * @param $condition 查询条件
     * @return mixed
     */
    public function goods_return_info($condition)
    {
        return $this->db->where($condition)->get('goods_return')->row_array();
    }

    /**
     * 获取申请退款退货条件
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_apply_reason($conditon)
    {
        return $this->db->select('id,reason')->where($conditon)->get('apply_reason')->result_array();
    }

    /**
     * 获取售后退货地址信息
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_goods_return($conditon)
    {
        return $this->db->where($conditon)->get('goods_return')->row_array();
    }

    /**
     * 售后列表
     * @param $uid 用户ID
     * @param $per_page 一页显示数
     * @param $offset 偏移量
     * @return mixed
     */
    public function refundList($uid, $per_page, $offset)
    {
        $this->db->select('refund.id as refund_id,refund.status,refund.money,order.seller_id as store_id,order.store_name,order_goods.goods_name,order_goods.goods_image,order_goods.specification as spec_info,order_goods.price,order_goods.quantity,order_goods.discounted_price as total,goods_return.extend_time');
        $this->db->join('order_goods', 'order_goods.rec_id = refund.target_id', 'inner');
        $this->db->join('order', 'order_goods.order_id = order.order_id', 'inner');
        $this->db->join('goods_return', 'refund.id = goods_return.refund_id', 'left');
        $clone = clone($this->db);
        $result['list'] = $this->db->where('uid', $uid)->limit($per_page, $offset)->order_by('refund.id', 'DESC')->get('refund')->result_array();
        $this->db = $clone;
        $result['total'] = $this->db->count_all_results('refund');
        return $result;
    }

    /**
     * 获取单条售后原因记录
     * @param $conditon
     * @return mixed
     */
    public function apply_reason($conditon)
    {
        return $this->db->select('id,reason')->where($conditon)->get('apply_reason')->row_array();
    }

    /**
     * 申请售后操作
     * @param $uid 用户ID
     * @param $store_id 店铺ID
     * @param $order_id 订单ID
     * @param $target_id 目标ID，order_id或rec_id
     * @param $type 申请类型，1退款，2退货
     * @param $order_goods_status 订单商品状态
     * @param $money 申请退款金额
     * @param $apply_reason 申请售后原因ID和名称
     * @param $supplement 补充文字说明
     * @param $proof_img 凭证图片
     * @param $timer_type 定时器类型
     * @param $auto_time 自动操作时间
     * @return bool
     */
    public function add_refund_apply($uid, $store_id, $order_id, $target_id, $type, $order_goods_status, $money, $apply_reason, $supplement, $proof_img, $timer_type, $auto_time)
    {
        $this->db->trans_begin();
        $this->db->where(array('target_id' => $target_id, 'status' => AFTERMARKET_CLOSE))->delete('refund');
        //写入售后申请表
        $apply = array(
            'order_id' => $order_id,
            'target_id' => $target_id,
            'uid' => $uid,
            'store_id' => $store_id,
            'type' => $type,
            'apply_time' => time(),
            'apply_reason' => $apply_reason['id'],
            'supplement' => $supplement,
            'proof_img' => $proof_img,
            'money' => $money,
            'refund_sn' => $this->_gen_refund_sn(),
            'countdown' => time() + $auto_time
        );
        $this->db->insert('refund', $apply);
        $refund_id = $this->db->insert_id();

        //改变订单商品状态
        $this->db->where('rec_id', $target_id)->update('order_goods', array('order_goods_status' => $order_goods_status));

        //order表增加refund_group,并且判断是否发货是否为第一个申请售后，则需要删除确认收货定时器，记录剩余确认收货时间
        $order = $this->db->select('order_sn,refund_group,auto_comfirm_time,order_status')->where('order_id', $order_id)->get('order')->row_array();
        $order_surplus['refund_group'] = trim($order['refund_group'] . ',' . $target_id, ',');
        if ($order['order_status'] == ORDER_SHIPPED && !$order['refund_group']) {
            $order_surplus['surplus_comfirm_time'] = $order['auto_comfirm_time'] - time();
            $this->db->where(array('type' => COMFIRM_TIMER, 'target_id' => $order_id))->delete('tasktimer');
        }
        $this->db->where('order_id', $order_id)->update('order', $order_surplus);

        //写入定时器
        $timer = array(
            'dateline' => time(),
            'type' => $timer_type,
            'target_id' => $target_id,
            'plan_time' => $apply['countdown']
        );
        $this->db->insert('tasktimer', $timer);

        //写入售后日志表
        $init = array(
            'apply_refund_id' => $refund_id,//售后申请记录ID
            'target_id' => $target_id,//申请售后目标ID
            'order_sn' => $order['order_sn'],//互联支付交易编号
            'refund_money' => $apply['money'],//退款金额
            'refund_reason' => $apply_reason['reason'],//退款原因
            'claim' => isset(self::$_claim[$type]) ? self::$_claim[$type] : '',//要求
            'supplement' => $apply['supplement'],//补充说明
            'proof' => $apply['proof_img']//凭证
        );
        $node_details = $this->refund_log_node_details($refund_id, $type == 1 ? APPLY_REFUND : APPLY_RETURN, $init);
        $this->load->library('MongoOperate');
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
     * 修改售后申请
     * @param $refund 原售后数据
     * @param $apply_type 申请类型
     * @param $order_goods_status 订单商品状态
     * @param $money 退款金额
     * @param $apply_reason 退款原因ID
     * @param $supplement 补充说明
     * @param $proof_img 凭证图片
     * @param $old_timer 原定时器类型
     * @param $timer 新定时器类型
     * @param $auto_time 自动时间
     * @return bool
     */
    public function modify_refund($refund, $apply_type, $order_goods_status, $money, $apply_reason, $supplement, $proof_img, $old_timer, $timer, $auto_time)
    {
        $this->db->trans_begin();

        //修改售后申请表
        $apply = array(
            'type' => $apply_type,
            'apply_time' => time(),
            'apply_reason' => $apply_reason['id'],
            'supplement' => $supplement,
            'proof_img' => $proof_img,
            'money' => $money,
            'countdown' => time() + $auto_time
        );
        if ($refund['status'] != AFTERMARKET_INTERVENE) {
            $apply['status'] = AFTERMARKET_HANDLE;
        }
        $this->db->where('id', $refund['id'])->update('refund', $apply);

        //修改订单商品状态
        $this->db->where('rec_id', $refund['target_id'])->update('order_goods', array('order_goods_status' => $order_goods_status));

        //写入mongo的售后日志表
        $order = $this->db->select('order_sn')->where('order_id', $refund['order_id'])->get('order')->row_array();
        $init = array(
            'target_id' => intval($refund['target_id']),//申请售后目标ID
            'order_sn' => $order['order_sn'],//订单编号
            'refund_money' => $apply['money'],//退款金额
            'refund_reason' => $apply_reason['reason'],//退款原因
            'claim' => isset(self::$_claim[$apply_type]) ? self::$_claim[$apply_type] : '',//要求
            'supplement' => $apply['supplement'],//补充说明
            'proof' => $apply['proof_img']//凭证
        );
        $node_details = $this->refund_log_node_details($refund['id'], $refund['type'] == 1 ? MODIFY_REFUND : MODIFY_RETURN, $init);
        $this->load->library('MongoOperate');
        if (!$this->mongooperate->insert('refund_log', $node_details)) {
            $this->db->trans_rollback();
            return false;
        }
        //修改定时器表
        if ($timer !== null) {
            $this->db->where(array('type' => $old_timer, 'target_id' => $refund['target_id']))->delete('tasktimer');
            $this->db->insert('tasktimer', array('dateline' => time(), 'type' => $timer, 'target_id' => $refund['target_id'], 'plan_time' => $apply['countdown']));
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
     * 撤销售后申请
     * @param $refund
     * @return mixed
     */
    public function cancelAftermarket($refund)
    {
        $this->db->trans_begin();

        //删除refund
        $this->db->where('id', $refund['id'])->update('refund', array('status' => AFTERMARKET_CLOSE));

        //减去order表refund_group
        $order = $this->db->select('refund_group,surplus_comfirm_time,order_status')->where('order_id', $refund['order_id'])->get('order')->row_array();
        $refund_group = array_flip(explode(',', $order['refund_group']));
        unset($refund_group[$refund['target_id']]);
        $this->db->where('order_id', $refund['order_id'])->update('order', array('refund_group' => implode(',', $refund_group)));

        //更新order_goods表状态
        $order_goods_status = array(
            ORDER_PAID => ORDER_GOODS_PAID,
            ORDER_SHIPPED => ORDER_GOODS_SHIPPED
        );
        $this->db->where('rec_id', $refund['target_id'])->update('order_goods', array('order_goods_status' => $order_goods_status[$order['order_status']]));

        //删除定时器
        $this->db->where('target_id', $refund['target_id'])->where_in('type', array(UNSHIP_DRAWBACK_TIMER, SHIPPED_DRAWBACK_TIMER, SHIPPED_UNRESPOND_RETURN_TIMER))->delete('tasktimer');

        //判断是否需要重新插入确认收货定时器
        if (empty($refund_group) && $order['order_status'] == ORDER_SHIPPED) {
            $this->db->insert('tasktimer', array('dateline' => time(), 'type' => COMFIRM_TIMER, 'target_id' => $refund['order_id'], 'plan_time' => time() + $order['surplus_comfirm_time']));
        }

        $this->load->library('MongoOperate');
        $node_details = $this->refund_log_node_details($refund['id'], REFUND_CLOSE, array('target_id' => $refund['target_id'], 'close_reason' => '买家撤销申请'));
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
     * 买家退货给卖家
     * @param $refund 售后申请数组
     * @param $express 快递名称
     * @param $express_sn 快递编号
     * @param $supplement 补充说明
     * @param $proof_img 凭证图片
     * @return bool
     */
    public function reutrnGoods($refund, $express, $express_sn, $supplement, $proof_img)
    {
        $this->db->trans_begin();

        //更新refund表的倒计时
        $auto_time = time() + AUTO_SHIPPED_BUYER_RETURNED;
        $this->db->where('id', $refund['id'])->update('refund', array('supplement' => $supplement, 'proof_img' => $proof_img, 'countdown' => $auto_time, 'status' => AFTERMARKET_GOODS_RETURNING));

        //物流信息写入goods_return表，并且return_status = 1
        $this->db->where('refund_id', $refund['id'])->update('goods_return', array('return_express' => $express, 'return_express_sn' => $express_sn, 'return_status' => 1));

        //删除SHIPPED_AGREE_RETURN_TIMER定时器，写入SHIPPED_BUYER_RETURNED_TIMER定时器
        $this->db->where(array('type' => SHIPPED_AGREE_RETURN_TIMER, 'target_id' => $refund['target_id']))->delete('tasktimer');
        $this->db->insert('tasktimer', array('dateline' => time(), 'type' => SHIPPED_BUYER_RETURNED_TIMER, 'target_id' => $refund['target_id'], 'plan_time' => $auto_time));

        //售后操作写入mongo的refund_log
        $this->load->library('MongoOperate');
        $node_details = $this->refund_log_node_details($refund['id'], RETURN_MESSAGE, array('target_id' => $refund['target_id'], 'express' => $express, 'express_number' => $express_sn, 'supplement' => $supplement, 'proof' => $proof_img));
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
     * 退货，延长卖家收货时间
     * @param $refund 原售后信息
     * @param $extend_time 延长时间
     * @return bool
     */
    public function extendGoodsReturn($refund, $extend_time)
    {
        $this->db->trans_begin();

        //延长refund的倒计时
        $this->db->where('id', $refund['id'])->set('countdown', 'countdown + ' . $extend_time, false)->update('refund');

        //更新goods_return表extend_time = 1
        $this->db->where('refund_id', $refund['id'])->update('goods_return', array('extend_time' => 1));

        //延长定时器SHIPPED_BUYER_RETURNED_TIMER时间
        $this->db->where(array('type' => SHIPPED_BUYER_RETURNED_TIMER, 'target_id' => $refund['target_id']))->set('plan_time', 'plan_time + ' . $extend_time, false)->update('tasktimer');

        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    /**
     * 修改退货物流信息
     * @param $refund 原售后信息
     * @param $express 物流名称
     * @param $express_sn 物流编号
     * @param $supplement 补充说明
     * @param $proof_img 凭证
     * @return bool
     */
    public function modifyReturn($refund, $express, $express_sn, $supplement, $proof_img)
    {
        $this->db->trans_begin();

        //修改goods_return信息
        $this->db->where('refund_id', $refund['id'])->update('goods_return', array('return_express' => $express, 'return_express_sn' => $express_sn));

        //写入mongo的refund_log
        $this->load->library('MongoOperate');
        $node_details = $this->refund_log_node_details($refund['id'], MODIFY_MESSAGE, array('target_id' => $refund['target_id'], 'express' => $express, 'express_number' => $express_sn, 'supplement' => $supplement, 'proof' => $proof_img));
        if (!$this->mongooperate->insert('refund_log', $node_details)) {
            $this->db->trans_rollback();
            return false;
        }

        //更新refund的倒计时
        $auto_time = time() + AUTO_SHIPPED_BUYER_RETURNED;
        $this->db->where('id', $refund['id'])->update('refund', array('supplement' => $supplement, 'proof_img' => $proof_img, 'countdown' => $auto_time));
        //删除拒绝定时器，更新卖家响应定时器时间
        $this->db->where(array('type' => AUTO_SHIPPED_REFUSE_RECEIPT, 'target_id' => $refund['target_id']))->delete('tasktimer');
        $this->db->insert('tasktimer', array('dateline' => time(), 'type' => SHIPPED_BUYER_RETURNED_TIMER, 'target_id' => $refund['target_id'], 'plan_time' => $auto_time));
        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    /**
     * 申请客服介入
     * @param $refund 原售后信息
     * @param $intervene_countdown 倒计时
     * @return bool
     */
    public function applyIntervene($refund, $intervene_countdown)
    {
        $this->db->trans_begin();

        //更新退款记录
        $this->db->where('id', $refund['id'])->update('refund', array('status' => AFTERMARKET_INTERVENE, 'countdown' => time() + $intervene_countdown));

        //写入申述记录
        $this->db->where(array('status' => APPEAL_CLOSE, 'target_id' => $refund['target_id']))->delete('appeal');
        $this->db->insert('appeal', array('refund_id' => $refund['id'], 'target_id' => $refund['target_id'], 'status' => APPEAL_HANDLE, 'add_time' => time()));

        //mongo
        $this->load->library('MongoOperate');
        $node_details = $this->refund_log_node_details($refund['id'], APPLY_INTERVENE, array('target_id' => $refund['target_id']));
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
     * 售后日志模板输出
     * @param $refund_id 售后申请记录ID
     * @return array
     */
    public function refund_log($refund_id)
    {
        $this->load->library('MongoOperate');
        $refund_log = $this->mongooperate->find('refund_log', array('apply_refund_id' => $refund_id), array(), 0, 50, array('node_time' => -1));
        $log = [];
        foreach ($refund_log as $v) {
            switch ($v['node_id']) {
                case APPLY_REFUND:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '订单编号：' . $v['order_sn'],
                            '退款金额：' . $v['refund_money'] . '元',
                            '退款原因：' . $v['refund_reason'],
                            '要求：' . $v['claim'],
                            '其他说明：' . $v['supplement']
                        ),
                        'proof' => array_map("img_url", explode(',', $v['proof']))
                    );
                    break;
                case REFUSE_REFUND:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '拒绝原因：' . $v['refund_reason'],
                            '卖家说：' . $v['supplement']
                        ),
                        'proof' => array_map("img_url", explode(',', $v['proof']))
                    );
                    break;
                case MODIFY_REFUND:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '订单编号：' . $v['order_sn'],
                            '退款金额：' . $v['refund_money'] . '元',
                            '退款原因：' . $v['refund_reason'],
                            '要求：' . $v['claim'],
                            '其他说明：' . $v['supplement']
                        ),
                        'proof' => array_map("img_url", explode(',', $v['proof']))
                    );
                    break;
                case APPLY_RETURN:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '订单编号：' . $v['order_sn'],
                            '退款金额：' . $v['refund_money'] . '元',
                            '退款原因：' . $v['refund_reason'],
                            '要求：' . $v['claim'],
                            '其他说明：' . $v['supplement']
                        ),
                        'proof' => array_map("img_url", explode(',', $v['proof']))
                    );
                    break;
                /*case REFUSE_RETURN:

                    break;*/
                case MODIFY_RETURN:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '订单编号：' . $v['order_sn'],
                            '退款金额：' . $v['refund_money'] . '元',
                            '退款原因：' . $v['refund_reason'],
                            '要求：' . $v['claim'],
                            '其他说明：' . $v['supplement']
                        ),
                        'proof' => array_map("img_url", explode(',', $v['proof']))
                    );
                    break;
                case AGREE_RETURN:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '退货地址：' . $v['addr'],
                            '卖家说：' . $v['supplement']
                        )
                    );
                    break;
                case RETURN_MESSAGE:
                    $log[] = array(
                        'node' => $v['node'],
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '快递公司：' . $v['express'],
                            '快递单号：' . $v['express_number'],
                            '补充说明：' . $v['supplement']
                        ),
                        'proof' => array_map("img_url", explode(',', $v['proof']))
                    );
                    break;
                case MODIFY_MESSAGE:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '快递公司：' . $v['express'],
                            '快递单号：' . $v['express_number'],
                            '补充说明：' . $v['supplement']
                        ),
                        'proof' => array_map("img_url", explode(',', $v['proof']))
                    );
                    break;
                case APPLY_INTERVENE:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time'])//节点时间
                    );
                    break;
                case REFUND_CLOSE:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '原因：' . $v['close_reason']
                        )
                    );
                    break;
                case REFUND_SUCCESS:
                    $log[] = array(
                        'node' => $v['node'],//节点
                        'node_time' => date('Y.m.d H:i:s', $v['node_time']),//节点时间
                        'content' => array(
                            '退款成功，退款金额：' . $v['refund_money'] . '元' . PHP_EOL . '您可到互联支付账号中查看退款'
                        )
                    );
                    break;
                default:
                    break;
            }
        }
        return $log;
    }

    /**
     * 生成互联支付交易单号
     * @return string
     */
    private function _gen_refund_sn()
    {
        mt_srand((double)microtime() * 1000000);
        $refund_sn = date('YmdHis') . str_pad(mt_rand(1, 9999999999), 10, '0', STR_PAD_LEFT);
        $refund = $this->db->where('refund_sn', $refund_sn)->get('refund')->row_array();
        if ($refund) {
            $this->_gen_refund_sn();
        }
        return $refund_sn;
    }

    /**
     * 售后日志节点配置
     * @param $nodeId 节点ID
     * @return mixed|string
     */
    public function refund_log_node($nodeId)
    {
        $node = array(
            APPLY_REFUND => '买家成功提交退款申请',
            REFUSE_REFUND => '卖家拒绝了您的退款申请',
            MODIFY_REFUND => '买家修改了退款申请',
            APPLY_RETURN => '买家成功提交退款退货申请',
            MODIFY_RETURN => '买家修改了退款/退货申请',
            AGREE_RETURN => '卖家同意了您的退款/退货申请',
            RETURN_MESSAGE => '买家已提交退货信息',
            MODIFY_MESSAGE => '买家修改了退货信息',
            APPLY_INTERVENE => '买家已申请客服介入处理',
            REFUND_CLOSE => '退款关闭',
            REFUND_SUCCESS => '退款成功'
        );
        return isset($node[intval($nodeId)]) ? $node[intval($nodeId)] : '';
    }

    /**
     * 售后日志信息
     * @param $refund_id 售后ID
     * @param $nodeId 节点ID
     * @param $data 信息
     * @return array|bool
     */
    public function refund_log_node_details($refund_id, $nodeId, $data)
    {
        switch ($nodeId) {
            case APPLY_REFUND:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),//订单商品目标ID
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'order_sn' => $data['order_sn'],//订单编号
                    'refund_money' => $data['refund_money'],//退款金额
                    'refund_reason' => $data['refund_reason'],//退款原因
                    'claim' => $data['claim'],//要求
                    'supplement' => $data['supplement'],//补充说明
                    'proof' => $data['proof']//凭证
                );
                break;
            case REFUSE_REFUND:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),//订单商品目标ID
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'refuse_reason' => $data['refund_reason'],//退款原因
                    'supplement' => $data['supplement'],//补充说明
                    'proof' => $data['proof']//凭证
                );
                break;
            case MODIFY_REFUND:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),//订单商品目标ID
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'order_sn' => $data['order_sn'],//订单编号
                    'refund_money' => $data['refund_money'],//退款金额
                    'refund_reason' => $data['refund_reason'],//退款原因
                    'claim' => $data['claim'],//要求
                    'supplement' => $data['supplement'],//补充说明
                    'proof' => $data['proof']//凭证
                );
                break;
            case APPLY_RETURN:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),//订单商品目标ID
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'order_sn' => $data['order_sn'],//订单编号
                    'refund_money' => $data['refund_money'],//退款金额
                    'refund_reason' => $data['refund_reason'],//退款原因
                    'claim' => $data['claim'],//要求
                    'supplement' => $data['supplement'],//补充说明
                    'proof' => $data['proof']//凭证
                );
                break;
            /*case REFUSE_RETURN:
                break;*/
            case MODIFY_RETURN:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),//订单商品目标ID
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'order_sn' => $data['order_sn'],//订单编号
                    'refund_money' => $data['refund_money'],//退款金额
                    'refund_reason' => $data['refund_reason'],//退款原因
                    'claim' => $data['claim'],//要求
                    'supplement' => $data['supplement'],//补充说明
                    'proof' => $data['proof']//凭证
                );
                break;
            case AGREE_RETURN:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),//订单商品目标ID
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'addr' => $data['addr'],//退货地址
                    'supplement' => $data['supplement']//补充说明
                );
                break;
            case RETURN_MESSAGE:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'express' => $data['express'],//快递公司
                    'express_number' => $data['express_number'],//快递编号
                    'supplement' => $data['supplement'],//补充说明
                    'proof' => $data['proof']//凭证
                );
                break;
            case MODIFY_MESSAGE:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'express' => $data['express'],//快递公司
                    'express_number' => $data['express_number'],//快递编号
                    'supplement' => $data['supplement'],//补充说明
                    'proof' => $data['proof']//凭证
                );
                break;
            case APPLY_INTERVENE:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                );
                break;
            case REFUND_CLOSE:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'close_reason' => $data['close_reason']
                );
                break;
            case REFUND_SUCCESS:
                $details = array(
                    'apply_refund_id' => intval($refund_id),//售后申请记录ID
                    'target_id' => intval($data['target_id']),
                    'node_id' => $nodeId,//节点ID
                    'node' => $this->refund_log_node($nodeId),//节点
                    'node_time' => time(),//节点时间
                    'refund_money' => $data['refund_money']
                );
                break;
            default:
                return false;
                break;
        };
        return $details;
    }
}