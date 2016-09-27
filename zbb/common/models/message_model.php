<?php

class Message_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    public function msg_list($user_id, $per_page, $offset, $type = 0)
    {
        $this->db->where('to_id', $user_id);
        $this->db->where('is_sys', $type);
        $this->db->from('message');
        $this->db->join('member', 'member.user_id = message.from_id', 'left');
        $temp = clone($this->db);
        $ret['list'] = $this->db->order_by('add_time', 'desc')->limit($per_page, $offset)->get()->result_array();
        $this->db = $temp;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /*
     * 删除消息把字段del_status改成1（作为用户是否删除记录的条件）
     */

    public function remove($msg_id, $user_id)
    {
        $arr = array('del_status' => 1);
        $condition = clone($this->db->where(array('msg_id' => $msg_id, 'to_id' => $user_id)));
        $temp = $this->db->get('message')->row_array();
        if ($temp['new'] == 1) {
            $this->_stat_msg($user_id, '-');
        }
        $this->_action_total($user_id, '-');
        $this->db = $condition;
        $ret = $this->db->update('message', $arr);
        return $ret;
    }

    /*
     * 获取用户未删除信息
     */
    public function get_all_msg($user_id)
    {
        return $this->db->select('msg_id')->where('to_id', $user_id)->get('message')->result_array();
    }

    /*
     * 批量删除消息把字段del_status改成1（作为用户是否删除记录的条件）
     */

    public function remove_all($post, $user_id)
    {
        $del_status = array('del_status' => 1);
        $unread = 0;
        foreach ($post as $v) {
            $arr = $this->db->where(array('msg_id' => $v))->get('message')->row_array();
            if ($arr['new'] == 1) {
                $unread++;
            }
            $id[] = $v;
        }
        $total = count($id);
        $this->db->where('to_id', $user_id);
        $this->db->where_in('msg_id', $id);
        $ret = $this->db->update('message', $del_status);
        if ($ret) {
            $this->_stat_msg($user_id, '-', $total, $unread);
            return $ret;
        }
    }

    /*
     * 查看消息
     */

    public function view($msg_id, $user_id)
    {
        $temp = $this->db->where(array('msg_id' => $msg_id, 'to_id' => $user_id))->get('message')->row_array();

        if ($temp['new'] == 1) {

            $this->db->trans_begin();

            $this->_action_unread($user_id, '-');
            $this->db->where(array('msg_id' => $msg_id, 'to_id' => $user_id));
            $this->db->update('message', array('new' => 0));

            if ($this->db->trans_status() === FALSE) {
                $this->db->trans_rollback();
            } else {
                $this->db->trans_commit();
            }
        }
        return $temp;
    }

    /*
     * 写入消息表
     */

    protected function _add_msg($from_id, $to_id, $title, $content, $parent_id = 0)
    {
        $temp = array('from_id' => $from_id, 'to_id' => $to_id, 'title' => $title, 'content' => $content, 'add_time' => time(), 'new' => 1);
        $ret = $this->db->insert('message', $temp);
        $this->_stat_msg($to_id, '+');
        return $ret;
    }

    //给好友发信息
    public function send($from_id, $to_id, $title, $content, $parent_id = 0)
    {
        $temp = array('from_id' => $from_id, 'to_id' => $to_id, 'title' => $title, 'content' => $content, 'add_time' => time(), 'new' => 1);
        $this->db->insert('message', $temp);
        $ret = $this->db->insert_id();
        $this->_stat_msg($to_id, '+');
        return $ret;
    }

    /*
     * 待付款状态下，商家修改订单价格，买家收到短消息
     */

    public function mod_price_msg($from_id, $to_id, $order_id, $title = "商家修改订单价格")
    {
        $content = "订单号：" . $order_id . " 卖家已修改价格";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 商家发货
     */

    public function seller_ship_msg($from_id, $to_id, $order_sn, $order_id, $title = "商家发货")
    {
        $content = "订单号：" . $order_sn . " 卖家已发货";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 买家延长收货时间
     */

    public function buyer_extend_msg($from_id, $from_name, $to_id, $nums, $order_sn, $title = "买家延长收货时间")
    {
        $content = "订单号：" . $order_sn . "买家" . $from_name . "延长收货" . $nums . "天。";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 卖家延长收货时间
     */

    public function seller_extend_msg($from_id, $from_name, $to_id, $nums, $order_sn, $title = "卖家延长收货时间")
    {
        $content = "订单号：" . $order_sn . "卖家" . $from_name . "延长收货" . $nums . "天。";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 买家已付款
     */

    public function buyer_paid_msg($from_id, $to_id, $order_id, $title = "买家已付款")
    {
        $content = "订单号：" . $order_id . " 买家已付款";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 商家同意申请退款
     */

    public function seller_drawback_money_msg($from_id, $to_id, $order_id, $title = "退款已成功")
    {
        $content = "退款已成功，请您到互联支付查看收支明细。";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 商家拒绝申请退款
     */

    public function seller_deny_money_msg($from_id, $to_id, $order_id, $title = "商家拒绝退款")
    {
        $content = "商家拒绝退款，您可以进行申诉。";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 买家申请退货，卖家收到短消息
     */

    public function buyer_goods_return_msg($from_id, $to_id, $order_sn, $order_id, $title = "买家申请退货")
    {
        $content = "订单号：" . $order_sn . " 买家申请退货>";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 商家同意申请退货
     */

    public function seller_drawback_goods_msg($from_id, $to_id, $order_sn, $rec_id, $title = "退货申请成功")
    {
        $content = '订单号' . $order_sn . '退货申请成功，请您在7天内填写退货物流信息，以便卖家收到货后尽快给您退款。';
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 商家拒绝申请退货
     */

    public function seller_deny_goods_msg($from_id, $to_id, $order_id, $reason, $title = "商家拒绝退货")
    {
        $content = "卖家拒绝了您的退货申请，原因：'" . $reason . "'。您可以在7天内修改退货协议。>";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 已付款（未发货,已发货）的情况下买家申请退款，卖家收到短消息
     */

    public function buyer_apply_money_msg($from_id, $to_id, $order_sn, $order_id, $title = "买家申请退款")
    {
        $content = "订单号：" . $order_sn . " 买家申请退款";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 退款成功
     */

    public function auto_drawback_money_msg($from_id, $to_id, $order_id, $title = "退款成功")
    {
        $content = "订单号：" . $order_id . " 退款已成功.";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 商家已发货的情况下买家申请退款退货，商家超过5天未响应
     */

    public function auto_drawback_msg($from_id, $to_id, $order_id, $title = "退款成功")
    {
        $content = "您有一笔退货申请已经达成协议，请等待买家退货。>";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    public function seller_deny_return_msg($from_id, $to_id, $order_id, $title = '卖家拒绝退款')
    {
        $content = "您有一笔订单退货后，卖家拒绝退款，您可以要求客服介入或修改退货详情。>";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /**
     * 买家退货后，发送站内信给卖家
     */
    public function buyer_return_shipped_msg($from_id, $to_id, $order_sn, $order_id, $title = "买家退货")
    {
        $content = "订单号：" . $order_sn . " 买家已退货.";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /**
     * 新版退款/退货成功站内信
     */
    public function refund_success_msg($from_id, $to_id, $order_sn, $rec_id, $title = "卖家退款成功")
    {
        $content = "订单号：" . $order_sn . " 卖家已退款.";
        $ret = $this->_add_msg($from_id, $to_id, $title, $content);
        return $ret;
    }

    /*
     * 后台指定会员发送信息
     */

    public function send_msgs($temp, $to_id)
    {
        $this->db->insert('message', $temp);
        $ret = $this->db->insert_id();
        $this->_stat_msg($to_id, '+');
        return $ret;
    }

    /*
     * 没有商店的会员收到的信息
     */

    public function message_mass($type)
    {
        $arr=array($type,3);
        $res = $this->db->select('*')->where_in('to_type', $arr)->get('message_mass')->result_array();
        return $res;
    }


    /*
     * 获取用户未读信息
     */

    public function unread_msg_num($uid)
    {
        $res = $this->db->where(array('new' => 1, 'to_id' => $uid, 'is_sys' => 1))->from('message')->count_all_results();
        return $res;
    }

    /*
     * 有商店的会员收到的信息
     */

    public function store_mass()
    {
        $res = $this->db->select('*')->get('message_mass')->result_array();
        return $res;
    }

    /*
     * 会员接受到的信息
     */

    public function get_message($temp)
    {
        $this->db->insert('message', $temp);
        $ret = $this->db->insert_id();
        return $ret;
    }

    /*
     * 当前用户收到管理员的信息
     */

    public function mass($user_id)
    {
        $ret = $this->db->where('to_id', $user_id)->get('message')->result_array();
        return $ret;
    }


    /**
     * 增剪未读信息统计
     */
    public function _stat_msg($user_id, $action, $msg_total = 1, $msg_unread = 1)
    {
        $this->db->where(array('uid' => $user_id));
        if ($action == '-') {
            $this->db->where('msg_total >', 0);
            $this->db->where('msg_unread >', 0);
        }
        $this->db->set('msg_total', 'msg_total ' . $action . $msg_total, FALSE);
        $this->db->set('msg_unread', 'msg_unread ' . $action . $msg_unread, FALSE);
        $this->db->update('user_stat');
    }

    /**
     * 减少未读信息
     */
    public function _action_unread($user_id, $action, $msg_unread = 1)
    {
        $this->db->where(array('uid' => $user_id));
        $this->db->where('msg_unread > ', 0);
        $this->db->set('msg_unread', 'msg_unread ' . $action . $msg_unread, FALSE)->update('user_stat');
    }

    /*
     * 减少总数
     */

    public function _action_total($user_id, $action, $msg_total = 1)
    {
        $this->db->where(array('uid' => $user_id));
        $this->db->where('msg_total >', 0);
        $this->db->set('msg_total', 'msg_total ' . $action . $msg_total, FALSE)->update('user_stat');
    }

    /*
    * 未读消息
    */
    public function unread_msg($user_id)
    {
        $this->db->select('msg_unread');
        $this->db->where('uid', $user_id);
        $ret=$this->db->get('user_stat')->row_array();
        return $ret;
    }
    
    /*
     * 所有信息
     */
    public function msg_all_list($user_id, $per_page, $offset)
    {
    	$this->db->where('to_id', $user_id);
    	$this->db->from('message');
    	$this->db->join('member', 'member.user_id = message.from_id', 'left');
    	$temp = clone($this->db);
    	$ret['list'] = $this->db->order_by('is_sys', 'desc')->order_by('add_time', 'desc')->limit($per_page, $offset)->get()->result_array();
    	$this->db = $temp;
    	$ret['total'] = $this->db->count_all_results();
    	return $ret;
    }
    /*
     * 根据msg_id获取多条信息
     */
    public function get_msgs($user_id, $msg_id) {
    	$this->db->where('to_id', $user_id);
    	$this->db->where_in('msg_id',$msg_id);
    	$this->db->from('message');
    	return $this->db->get()->result_array();
    }
    /*
     * 根据msg_id获取一条信息
     */
    public function get_content($user_id, $msg_id){
    	return $this->db->where('to_id',$user_id)->where('msg_id',$msg_id)->get('message')->row_array();
    }
    /*
     * 根据msg_id删除多条信息
     */
    public function del_msgs($user_id, $msg_id){
    	$this->db->where('to_id', $user_id);
    	if (is_array($msg_id)) {
    		return $this->db->where_in('msg_id',$msg_id)->delete('message');
    	}
    	return $this->db->where('msg_id',$msg_id)->delete('message');
    }
    /*
     * 根据msg_id修改一条信息为已读并减少未读信息数
     */
    public function update_is_sys($user_id, $msg_id) {
    	$res['is_sys'] = $this->db->where('to_id', $user_id)->where('msg_id',$msg_id)->update('message', array('is_sys' => 0));
    	$this->db->where('uid', $user_id);
    	$this->db->where('msg_unread > ', 0);
    	$res['msg_unread'] = $this->db->set('msg_unread', 'msg_unread ' . '-1', FALSE)->update('user_stat');
    	return $res;
    }

    /*
     * 查询一条记录
     */

    public function get_one($user_id, $mass_id) {
        $arr = array('to_id' => $user_id, 'mass_id' => $mass_id);
        $row = $this->db->where($arr)->get('message')->row_array();
        return $row;
    }
    /*
     * 查询APP最后一条记录
     */
    public function app_get_one($user_id, $is_sys){
        $this->db->where(array('to_id' => $user_id, 'is_sys' => $is_sys));
        $this->db->select('msg_id,content,add_time,new');
        $row = $this->db->order_by('msg_id','desc')->limit(1)->get('message')->row_array();
        return $row;
    }
    /*
     * APP未读消息总数
     */
    public function un_all_num($user_id, $is_sys){
        $arr = array('to_id' => $user_id, 'is_sys' => $is_sys,'new'=>1);
        $row = $this->db->where($arr)->count_all_results('message');
        return $row;
    }
    /*
     * APP列表获取全部未读消息
     */
    public function get_all_num($user_id, $is_sys,$per_nums,$offset){
        $this->db->select('msg_id,title,content,add_time');
        $this->db->from('message');
        $this->db->where('to_id',$user_id);
        $this->db->where('is_sys', $is_sys);
        $this->db->where('new',1);
        $db=clone($this->db);
        $ret['list'] = $this->db->limit($per_nums, $offset)->order_by('msg_id','desc')->get()->result_array();
        $this->db=$db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }
    /*
     * APP获取单条信息
     */
    public function get_one_num($user_id,$msg_id){
        //未读消息改成已读消息
        $this->db->where('to_id', $user_id)->where('msg_id',$msg_id)->update('message', array('new' => 0));
        return $this->db->select('msg_id,title,content,add_time')->where('to_id', $user_id)->where('msg_id',$msg_id)->get('message')->row_array();
    }
}
