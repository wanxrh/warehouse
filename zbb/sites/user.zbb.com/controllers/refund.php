<?php

/**
 * 退换货控制器
 */
class Refund extends User_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('refund_model');
        $this->load->model('aftermarket_model');
        $this->load->library('MongoOperate');
    }

    /*
     * 仅退款
     */
    public function money()
    {
        //获取申请退款信息
        $rec_id = intval($this->input->get('rec_id'));
        $data['refund_info'] = $this->refund_model->refund_info($rec_id, get_user()['id']);
        $data['reason_name'] = $this->refund_model->reason_name($data['refund_info']['apply_reason']);
        $data['reason_info'] = $this->refund_model->reason_info(1);
        $data['log_arr'] = $this->refund_log($data['refund_info']['id']);
        $this->load->view('refund/money', $data);
    }

    protected function refund_log($id)
    {
        return $this->aftermarket_model->refund_log(intval($id));
    }

    /*
     * 未发货-同意退款
     */
    public function drawback()
    {
        $rec_id = intval($this->input->post('rec_id'));
        //检测退款的合法性
        $ret = $this->refund_model->refund_info($rec_id, get_user()['id']);
        if (!$ret) {
            ajax_error('无此退款申请编号');
        }
        if ($ret['type'] == 1) {
            $ret_url = $this->config->item('domain_user') . 'refund/money?rec_id=' . $ret['target_id'];
        } else {
            $ret_url = $this->config->item('domain_user') . 'refund/goods?rec_id=' . $ret['target_id'];
        }
        $arrayData = [];
        $arrayData[] = array(
            'fromOrder' => $ret['order_sn'],
            'orderNumber' => $ret['refund_sn'],
            'money' => $ret['money'],
            'toUserCode' => $ret['buyer_id'],
            'isHidden' => false,
            'order_confirm_sn' => $ret['order_confirm_sn']
        );

        //获取别的订单状态，别的订单都是
        $order_goods = $this->db->where('order_id', $ret['order_id'])->where_not_in('rec_id', $ret['target_id'])->get('order_goods')->result_array();
        $tip = 0;
        if (!array_intersect(array(ORDER_GOODS_PAID, ORDER_GOODS_SHIPPED, ORDER_GOODS_DRAWBACK, ORDER_GOODS_RETURNING), array_column($order_goods, 'order_goods_status'))) {
            if ($ret['order_balance'] > $ret['money']) {
                $arrayData[] = array(
                    'fromOrder' => $ret['order_sn'],
                    'orderNumber' => $ret['order_confirm_sn'],
                    'money' => bcsub($ret['order_balance'], $ret['money'], 2),
                    'toUserCode' => $ret['seller_id'],
                    'isHidden' => true,
                    'order_confirm_sn' => $ret['order_confirm_sn']
                );
                $tip = 1;
            }
        }
        $jsonData['tradeStatus'] = $tip ? 3 : 2;// 1:交易完成 2:交易关闭 3：金额变更 暂时写死
        $this->load->library('hulianpayment');
        $data['url'] = $this->hulianpayment->refund_payform($jsonData, $arrayData, $ret_url);
        ajax_success($data);
    }

    /*
    * 图片上传
    */
    public function upload_more()
    {
        if (!get_user()) {
            show_error("未登录不能上传");
        } else {
            $this->load->library('uploader');
            $file = $_FILES['file'];
            //上传文件不能为空
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
                $this->uploader->allowed_size(4096000);
                $this->uploader->addFile($file);
                if ($this->uploader->file_info() === false) {
                    show_error($this->uploader->get_error());
                    return false;
                }
                $ret = $this->uploader->save('proof/' . $Y . '/' . $m . '/' . $d);
            }
            ajax_success('proof/' . $Y . '/' . $m . '/' . $d . '/' . basename($ret));
        }
    }

    /*
     * 已发货-仅退款-拒绝退款操作
     */
    public function refused_money()
    {
        $rec_id = intval($this->input->post('rec_id'));
        //判断编号属于自己
        $temp = $this->refund_model->check_refund($rec_id, get_user()['id']);
        if (!$temp) {
            ajax_error('无此退货编号');
        }
        if ($temp['status'] != AFTERMARKET_HANDLE) {
            ajax_error('此退货编号状态错误');
        }

        $refuse_reason = intval($this->input->post('refuse_reason'));
        $supplement = filter_sql($this->input->post('supplement'));
        $proof_img = filter_sql($this->input->post('uploadimg'));
        $arr = array(
            'refuse_reason' => $supplement,
            'response_proof' => $proof_img,
            'refuse_time' => time(),
            'status' => AFTERMARKET_REFUSE,
            'countdown' => time() + AUTO_SHIPPED_REFUSE_DRAWBACK
        );
        //开启事务
        $this->db->trans_begin();
        $this->refund_model->update_refund($rec_id, $arr);
        //删除定时器
        $this->refund_model->del_timer(SHIPPED_DRAWBACK_TIMER, $rec_id);
        //写入定时器
        $timer_arr = array(
            'dateline' => time(),
            'type' => SHIPPED_REFUSE_DRAWBACK_TIMER,
            'target_id' => $rec_id,
            'plan_time' => time() + AUTO_SHIPPED_REFUSE_DRAWBACK
        );
        $this->refund_model->insert_timer($timer_arr);
        //写入mongo
        $node = $this->aftermarket_model->refund_log_node(REFUSE_REFUND);
        $refund_reason = $this->refund_model->reason_name($refuse_reason);
        $proof_img = explode(',', $proof_img);
        $proof_img = implode(',', $proof_img);
        $mongo_arr = array(
            'apply_refund_id' => intval($temp['id']),//售后申请记录ID
            'target_id' => intval($temp['target_id']),//申请退款/退货ID
            'node_id' => REFUSE_REFUND,//节点ID
            'node' => $node,//节点
            'node_time' => time(),//节点时间
            'refund_reason' => $refund_reason['reason'],//退款原因
            'supplement' => $supplement,//补充说明
            'proof' => $proof_img//凭证
        );
        $this->mongooperate->insert('refund_log', $mongo_arr);

        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            ajax_error('提交失败');
        } else {
            $this->db->trans_commit();
            ajax_success('提交成功');
        }
    }


    /*
	 * 退款和退货
	 */
    public function goods()
    {
        $rec_id = intval($this->input->get('rec_id'));
        $data['refund_info'] = $this->refund_model->refund_info($rec_id, get_user()['id']);
        $data['reason_name'] = $this->refund_model->reason_name($data['refund_info']['apply_reason']);
        $data['reason_info'] = $this->refund_model->reason_info(4);
        //判断是否同意退款
        $data['return_info'] = $this->refund_model->get_goods_return($data['refund_info']['id']);
        $data['log_arr'] = $this->refund_log($data['refund_info']['id']);
        $this->load->view('refund/goods', $data);
    }

    /*
    * 已发货-买家申请退货-拒绝退货操作
    */
    public function refused_goods()
    {
        $rec_id = intval($this->input->post('rec_id'));
        //判断编号属于自己
        $temp = $this->refund_model->check_refund($rec_id, get_user()['id']);
        if (!$temp) {
            ajax_error('无此退货编号');
        }

        if ($temp['status'] != AFTERMARKET_HANDLE) {
            ajax_error('此退货编号状态错误');
        }

        $refuse_reason = intval($this->input->post('refuse_reason'));
        $supplement = filter_sql($this->input->post('supplement'));
        $proof_img = filter_sql($this->input->post('uploadimg'));
        $arr = array(
            'refuse_reason' => $refuse_reason,
            'response_proof' => $proof_img,
            'refuse_time' => time(),
            'status' => AFTERMARKET_REFUSE,
            'countdown' => time() + AUTO_SHIPPED_REFUSE_RETURN
        );
        $this->db->trans_begin();
        $this->refund_model->update_refund($rec_id, $arr);
        //删除定时器
        $this->refund_model->del_timer(SHIPPED_UNRESPOND_RETURN_TIMER, $rec_id);
        //写入定时器
        $timer_arr = array(
            'dateline' => time(),
            'type' => SHIPPED_REFUSE_RETURN_TIMER,
            'target_id' => $rec_id,
            'plan_time' => time() + AUTO_SHIPPED_REFUSE_RETURN
        );
        $this->refund_model->insert_timer($timer_arr);
        //写入mongo
        $node = $this->aftermarket_model->refund_log_node(REFUSE_REFUND);
        $refund_reason = $this->refund_model->reason_name($refuse_reason);
        $mongo_arr = array(
            'apply_refund_id' => intval($temp['id']),//售后申请记录ID
            'target_id' => intval($temp['target_id']),//申请退款/退货ID
            'node_id' => REFUSE_REFUND,//节点ID
            'node' => $node,//节点
            'node_time' => time(),//节点时间
            'refund_reason' => $refund_reason['reason'],//退款原因
            'supplement' => $supplement,//补充说明
            'proof' => $proof_img//凭证
        );
        $this->mongooperate->insert('refund_log', $mongo_arr);
        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            ajax_error('提交失败');
        } else {
            $this->db->trans_commit();
            ajax_success('提交成功');
        }
    }

    /*
     * 同意退货
     */
    public function drawback_goods()
    {
        $rec_id = intval($this->input->get('rec_id'));
        //判断编号属于自己
        $data['refund_info'] = $temp = $this->refund_model->refund_info($rec_id, get_user()['id']);
        $data['reason_name'] = $this->refund_model->reason_name($temp['apply_reason']);
        if (!$temp) {
            ajax_error('无此退货编号');
        }
        //退货地址
        $data['return_address'] = $this->refund_model->return_address(get_user()['id']);
        $data['log_arr'] = $this->refund_log($data['refund_info']['id']);
        $this->load->view('refund/drawback_goods', $data);
    }

    /*
   *已发货-买家申请退货-商家同意退货
   */
    public function drawback_address()
    {
        $rec_id = intval($this->input->post('rec_id'));
        $addr_id = intval($this->input->post('addr_id'));
        $remark = filter_sql($this->input->post('remark'));
        //判断编号属于自己
        $temp = $this->refund_model->check_refund($rec_id, get_user()['id']);
        if (!$temp) {
            ajax_error('无此退货编号');
        }
        if ($temp['status'] != AFTERMARKET_HANDLE) {
            ajax_error('此退货编号状态错误');
        }
        //退货地址信息
        $addr_info = $this->refund_model->get_address($addr_id);
        $temp_arr = array(
            'refund_id' => $temp['id'],
            'consignee' => $addr_info['consignee'],
            'province_id' => $addr_info['province_id'],
            'city_id' => $addr_info['city_id'],
            'country_id' => $addr_info['country_id'],
            'region_name' => $addr_info['region_name'],
            'address' => $addr_info['address'],
            'zipcode' => $addr_info['zipcode'],
            'tel' => $addr_info['tel'],
            'mobile' => $addr_info['mobile']
        );
        $this->db->trans_begin();
        $this->refund_model->update_refund($rec_id, array('status' => AFTERMARKET_AGREE, 'countdown' => time() + AUTO_SHIPPED_AGREE_RETURN));
        $this->refund_model->insert_goods_return($temp_arr);
        //删除定时器
        $this->refund_model->del_timer(SHIPPED_UNRESPOND_RETURN_TIMER, $rec_id);
        //写入定时器
        $timer_arr = array(
            'dateline' => time(),
            'type' => SHIPPED_AGREE_RETURN_TIMER,
            'target_id' => $rec_id,
            'plan_time' => time() + AUTO_SHIPPED_AGREE_RETURN
        );
        $this->refund_model->insert_timer($timer_arr);
        //写入mongo
        $node = $this->aftermarket_model->refund_log_node(AGREE_RETURN);
        $mongo_arr = array(
            'apply_refund_id' => intval($temp['id']),//售后申请记录ID
            'target_id' => intval($temp['target_id']),//申请退款/退货ID
            'node_id' => AGREE_RETURN,//节点ID
            'node' => $node,//节点
            'addr' => $addr_info['region_name'] . $addr_info['address'] . ' ' . $addr_info['consignee'] . ' ' . $addr_info['mobile'],
            'node_time' => time(),//节点时间
            'supplement' => $remark
        );
        $this->mongooperate->insert('refund_log', $mongo_arr);

        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            ajax_error('系统繁忙');
        } else {
            $this->db->trans_commit();
            $data['url'] = '/refund/goods?rec_id=' . $rec_id;
            ajax_success($data);
        }
    }

    /*
   * 收到买家后拒绝退货页面
   */
    public function refused_money_back()
    {
        $rec_id = intval($this->input->get('rec_id'));
        $data['refund_info'] = $this->refund_model->refund_info($rec_id, get_user()['id']);
        $data['reason_name'] = $this->refund_model->reason_name($data['refund_info']['apply_reason']);
        $data['reason_info'] = $this->refund_model->reason_info(5);
        $data['log_arr'] = $this->refund_log($data['refund_info']['id']);
        $this->load->view('refund/refused_money_back', $data);
    }

    /*
    * 卖家收到退货-拒绝退款
    */
    public function refused_money_submit()
    {
        $rec_id = intval($this->input->post('rec_id'));
        //判断编号属于自己
        $temp = $this->refund_model->check_refund($rec_id, get_user()['id']);
        if (!$temp) {
            ajax_error('无此退货编号');
        }
        if ($temp['status'] != AFTERMARKET_GOODS_RETURNING) {
            ajax_error('售后状态错误');
        }
        $refuse_reason = intval($this->input->post('refuse_reason'));
        $supplement = filter_sql($this->input->post('supplement'));
        $proof_img = filter_sql($this->input->post('uploadimg'));
        $arr = array(
            'refuse_reason' => $refuse_reason,
            'response_proof' => $proof_img,
            'refuse_time' => time(),
            'status' => AFTERMARKET_REFUSE_RETURN,
            'countdown' => time() + AUTO_SHIPPED_REFUSE_RECEIPT
        );
        $this->db->trans_begin();
        $this->refund_model->update_refund($rec_id, $arr);
        //删除定时器
        $this->refund_model->del_timer(SHIPPED_BUYER_RETURNED_TIMER, $rec_id);
        //写入定时器
        $timer_arr = array(
            'dateline' => time(),
            'type' => SHIPPED_REFUSE_RECEIPT,
            'target_id' => $rec_id,
            'plan_time' => time() + AUTO_SHIPPED_REFUSE_RECEIPT
        );
        $this->refund_model->insert_timer($timer_arr);
        //写入mongo
        $node = $this->aftermarket_model->refund_log_node(REFUSE_REFUND);
        $refund_reason = $this->refund_model->reason_name($refuse_reason);
        $mongo_arr = array(
            'apply_refund_id' => intval($temp['id']),//售后申请记录ID
            'target_id' => intval($temp['target_id']),//申请退款/退货ID
            'node_id' => REFUSE_REFUND,//节点ID
            'node' => $node,//节点
            'node_time' => time(),//节点时间
            'refund_reason' => $refund_reason['reason'],//退款原因
            'supplement' => $supplement,//补充说明
            'proof' => $proof_img//凭证
        );
        $this->mongooperate->insert('refund_log', $mongo_arr);
        if ($this->db->trans_status() === FALSE) {
            $this->db->trans_rollback();
            ajax_error('系统繁忙');
        } else {
            $this->db->trans_commit();
            $data['url'] = '/refund/goods?rec_id=' . $rec_id;
            ajax_success($data);
        }

    }
}