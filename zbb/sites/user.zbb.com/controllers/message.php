<?php
/**
 * 我的信息控制器
 */
class Message extends User_Controller{
	public function __construct(){
		parent::__construct();
		$this->load->model('message_model');
		// 初始化分页属性
		$this->per_page = 10;
		$this->cur_page = intval($this->uri->segment(3));
		if ($this->cur_page < 1) {
			$this->cur_page = 1;
		}
		$this->offset = ($this->cur_page - 1) * $this->per_page;
	}
	public function lists() {
		$user_id = get_user()['id'];
		$arr = $this->message_model->msg_all_list($user_id, $this->per_page, $this->offset);
		$data['message'] = $arr['list'];
		// 分页
		$total = $arr['total'];
		$url_format = "/message/lists/%d?" . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($total / $this->per_page), $url_format);
		// 格式化添加时间
		foreach ($data['message'] as $k => $v) {
			$data['message'][$k]['add_time'] = date('Y-m-d H:i:s' , $v['add_time']);
		}
		$this->load->view('message/lists', $data);
	}
	/**
	 * AJAX显示信息内容
	 */
	public function content_message() {
		$user_id = get_user()['id'];
		$msg_id = intval($this->input->post('msg_id', TRUE));
		$message = $this->message_model->get_content($user_id, $msg_id);
		$content = $message['content'];
		$is_sys = $message['is_sys'];
		if ($is_sys == 1) {
			// 改为已读状态并减少未读信息数
			$res = $this->message_model->update_is_sys($user_id, $msg_id);
		}
		if ($message) {
			ajax_success($content);
		} else {
			ajax_error('读取信息失败!');
		}
	}
	
	/**
	 * AJAX删除一条信息内容
	 */
	public function del_message(){
		$user_id = get_user()['id'];
		$msg_id = intval($this->input->post('msg_id', TRUE));
		$message = $this->message_model->get_content($user_id, $msg_id);
		$is_sys = $message['is_sys'];
		$res['del'] = $this->message_model->del_msgs($user_id, $msg_id);
		// 减少总数
		$res['total'] = $this->message_model->_action_total($user_id, '-');
		// 如果删除的是未读信息,要同时减少未读信息数
		if ($is_sys == 1) {
			$res['unread'] = $this->message_model->_action_unread($user_id, '-');
		}
		if ($res) {
			ajax_success('删除信息成功');
		} else {
			ajax_error('删除信息失败,或无此条信息!');
		}
	}
	
	/**
	 * AJAX删除多条信息内容
	 */
	public function del_all_message(){
		$user_id = get_user()['id'];
		$msg_id = $this->input->post('msg_id', TRUE);
		$res['message'] = $this->message_model->get_msgs($user_id, $msg_id);
		foreach ($res['message'] as $k => $v) {
			// 减少总数
			$res['total'] = $this->message_model->_action_total($user_id, '-');
			// 如果删除的是未读信息,要同时减少未读信息数
			if ($v['is_sys'] == 1) {
				$res['unread'] = $this->message_model->_action_unread($user_id, '-');
			}
		}
		$res['del'] = $this->message_model->del_msgs($user_id, $msg_id);
		if ($res) {
			ajax_success('删除信息成功');
		} else {
			ajax_error('删除信息失败,或无此条信息!');
		}
	}
	
	/**
	 * 获取当前用户未读信息的AJAX
	 */
	public function get_unread() {
		$user_id = get_user()['id'];
		$res = $this->message_model->unread_msg($user_id);
		if ($res) {
			ajax_success($res ['msg_unread']);
		} else {
			ajax_error('获取信息错误!');
		}
	}
}