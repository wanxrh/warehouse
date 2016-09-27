<?php

/*
 * 后台店铺管理控制器
 */

class Appeal extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('appeal_model');
        $this->load->model('aftermarket_model');
        $this->load->library('MongoOperate');
        $this->per_page = 10;
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;
    }

    /*
     * 默认首页
     */
    public function lists()
    {
        //表单参数 
        $data['order_sn'] = $order_sn = filter_sql($this->input->get('order_sn'));
        $data['refund_sn'] = $refund_sn = filter_sql($this->input->get('refund_sn'));
        $data['goods_name'] = $goods_name = filter_sql($this->input->get('goods_name'));
        $data['buyer_name'] = $buyer_name = filter_sql($this->input->get('buyer_name'));
        $data['seller_name'] = $seller_name = filter_sql($this->input->get('seller_name'));

        $result = $this->appeal_model->un_treated($order_sn, $refund_sn, $goods_name, $buyer_name, $seller_name, $this->per_page, $this->offset, $status = 0);
        $data['list'] = $result['list'];
        if ($data['list']) {
            $user_ids = array_column($data['list'], 'seller_id');
            $ret = $this->appeal_model->user_info($user_ids);
            $temp = array_column($ret, 'user_name', 'user_id');
            foreach ($data['list'] as &$v) {
                $v['seller_name'] = $temp[$v['seller_id']];
                unset($v['seller_id']);
            }
        }

        $data['total'] = $result['total'];
        //显示页码数
        $show_page = 5;
        $url = '/appeal/lists/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url, $show_page, TRUE, FALSE, $data['total']);
        $this->load->view('appeal/lists', $data);
    }

    /*
     * 已处理
     */
    public function handled()
    {
        //表单参数
        $data['order_sn'] = $order_sn = filter_sql($this->input->get('order_sn'));
        $data['refund_sn'] = $refund_sn = filter_sql($this->input->get('refund_sn'));
        $data['goods_name'] = $goods_name = filter_sql($this->input->get('goods_name'));
        $data['buyer_name'] = $buyer_name = filter_sql($this->input->get('buyer_name'));
        $data['seller_name'] = $seller_name = filter_sql($this->input->get('seller_name'));
        $data['order_status'] = $order_status = filter_sql($this->input->get('order_status'));

        $result = $this->appeal_model->un_treated($order_sn, $refund_sn, $goods_name, $buyer_name, $seller_name, $this->per_page, $this->offset, $status = 1, $order_status);

        $data['list'] = $result['list'];
        if ($data['list']) {
            $user_ids = array_column($data['list'], 'seller_id');
            $ret = $this->appeal_model->user_info($user_ids);
            $temp = array_column($ret, 'user_name', 'user_id');
            foreach ($data['list'] as &$v) {
                $v['seller_name'] = $temp[$v['seller_id']];
                unset($v['seller_id']);
            }
        }
        $data['total'] = $result['total'];
        //显示页码数
        $show_page = 5;
        $url = '/appeal/handled/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url, $show_page, TRUE, FALSE, $data['total']);
        $this->load->view('appeal/handled', $data);
    }

    /*
     * 详情
     */
    public function detail()
    {
        $rec_id = intval($this->input->get('rec_id'));
        $data['refund_info'] = $this->appeal_model->refund_info($rec_id);
        $data['reason_name'] = $this->appeal_model->reason_name($data['refund_info']['apply_reason']);
        $data['log_arr'] = $this->refund_log($data['refund_info']['id']);
        $data['appeal_info'] = $this->appeal_model->appeal_info($rec_id);
        //判断是否已退货到卖家
        $ret = $this->appeal_model->goods_return($data['appeal_info']['refund_id']);
        if ($ret) {
            $data['is_return'] = 1;
        } else {
            $data['is_return'] = 0;
        }
        $this->load->view('appeal/detail', $data);
    }

    protected function refund_log($id)
    {
        return $this->aftermarket_model->refund_log(intval($id));
    }

    /*
     * 关闭退款申请
     */
    public function close()
    {
        $appeal_id = intval($this->input->post('appeal_id'));
        $appeal_info = $this->appeal_model->get_appeal($appeal_id);
        $ret = $this->appeal_model->close_appeal($appeal_id);
        //写入mongo
        $node = $this->aftermarket_model->refund_log_node(REFUND_CLOSE);
        $mongo_arr = array(
            'apply_refund_id' => $appeal_info['refund_id'],//售后申请记录ID
            'target_id' => $appeal_info['target_id'],
            'node_id' => REFUND_CLOSE,
            'node' => $node,//节点
            'node_time' => time(),//节点时间
            'close_reason' => '客服关闭'
        );
        $this->mongooperate->insert('refund_log', $mongo_arr);
        if ($ret) {
            ajax_success('关闭成功');
        } else {
            ajax_error('系统繁忙或编号状态错误');
        }
    }

    /*
     * 退款给买家
     */
    public function refund()
    {
        $appeal_id = intval($this->input->post('appeal_id'));
        $appeal_arr = $this->appeal_model->get_appeal($appeal_id);
        $ret = $this->appeal_model->refund($appeal_id);
        if ($ret) {
            //写入mongo
            $node = $this->aftermarket_model->refund_log_node(REFUND_SUCCESS);
            $mongo_arr = array(
                'apply_refund_id' => intval($appeal_arr['refund_id']),//售后申请记录ID
                'target_id' => intval($appeal_arr['target_id']),//申请退款/退货ID
                'node_id' => REFUND_SUCCESS,//节点ID
                'node' => $node,//节点
                'node_time' => time(),//节点时间
                'supplement' => '客服根据日志处理'
            );
            $this->mongooperate->insert('refund_log', $mongo_arr);
            ajax_success('操作成功');
        } else {
            ajax_error('操作失败');
        }

    }

    /*
     * 货款给卖家
     */
    public function refund_seller()
    {
        $appeal_id = intval($this->input->post('appeal_id'));
        $appeal_arr = $this->appeal_model->get_appeal($appeal_id);
        $ret = $this->appeal_model->refund_seller($appeal_id);
        if ($ret) {
            //写入mongo
            $node = $this->aftermarket_model->refund_log_node(REFUND_SUCCESS);
            $mongo_arr = array(
                'apply_refund_id' => intval($appeal_arr['refund_id']),//售后申请记录ID
                'target_id' => intval($appeal_arr['target_id']),//申请退款/退货ID
                'node_id' => REFUND_SUCCESS,//节点ID
                'node' => $node,//节点
                'node_time' => time(),//节点时间
                'supplement' => '客服根据日志处理'
            );
            $this->mongooperate->insert('refund_log', $mongo_arr);
            ajax_success('操作成功');
        } else {
            ajax_error('操作失败');
        }
    }

    /*
   *同意退货
   */
    public function drawback()
    {
        $appeal_id = intval($this->input->post('appeal_id'));
        $appeal_arr = $this->appeal_model->get_appeal($appeal_id);
        $refund_info = $this->appeal_model->get_refund($appeal_arr['refund_id']);
        $address = $this->appeal_model->get_address($refund_info['store_id']);
        if ($address) {
            ajax_error('没有默认退货');
        }
        $temp_arr = array(
            'refund_id' => $appeal_arr['refund_id'],
            'consignee' => $address['consignee'],
            'province_id' => $address['province_id'],
            'city_id' => $address['city_id'],
            'country_id' => $address['country_id'],
            'region_name' => $address['region_name'],
            'address' => $address['address'],
            'zipcode' => $address['zipcode'],
            'tel' => $address['tel'],
            'mobile' => $address['mobile']
        );
        $this->db->trans_begin();
        $this->appeal_model->update_refund($refund_info['target_id'], array('status' => AFTERMARKET_AGREE, 'countdown' => time() + AUTO_SHIPPED_AGREE_RETURN));
        $this->appeal_model->insert_goods_return($temp_arr);
        //删除定时器
        $this->appeal_model->del_timer(SHIPPED_UNRESPOND_RETURN_TIMER, $refund_info['target_id']);
        //写入定时器
        $timer_arr = array(
            'dateline' => time(),
            'type' => SHIPPED_AGREE_RETURN_TIMER,
            'target_id' => $refund_info['target_id'],
            'plan_time' => time() + AUTO_SHIPPED_AGREE_RETURN
        );
        $this->appeal_model->insert_timer($timer_arr);
        //写入mongo
        $node = $this->aftermarket_model->refund_log_node(AGREE_RETURN);
        $mongo_arr = array(
            'apply_refund_id' => intval($refund_info['id']),//售后申请记录ID
            'target_id' => intval($refund_info['target_id']),//申请退款/退货ID
            'node_id' => AGREE_RETURN,//节点ID
            'node' => $node,//节点
            'addr' => $address['region_name'] . $address['address'] . ' ' . $address['consignee'] . ' ' . $address['mobile'],
            'node_time' => time(),//节点时间
            'supplement' => '客服根据日志处理'
        );
        $this->mongooperate->insert('refund_log', $mongo_arr);

        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            ajax_error('系统繁忙');
        } else {
            $this->db->trans_commit();
            ajax_success('操作成功');
        }
    }
}
