<?php

/*
 * 后台管理员管理控制器
 */

class Admin extends Admin_Controller {

	public function __construct() {
		parent::__construct();
		$this->load->model('admin_model');
		//每页显示的条数
		$this->per_page = 10;
		//当前页
		$this->cur_page = intval($this->uri->segment(3));
		if ($this->cur_page < 1) {
			$this->cur_page = 1;
		}
		//当前页从第几条数据开始
		$this->offset = ($this->cur_page - 1) * $this->per_page;
	}

	/*
	 * 默认管理员首页
	 */

	public function index() {
		$data = $this->admin_model->get_list(array('type' => 1));
		$url = '/admin/index/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['count'] / $this->per_page), $url, 5, TRUE, FALSE, $data['count']);
		$this->load->view('admin/admin_index', $data);
	}

	/*
	 * 添加管理员
	 * type == 1 管理员
	 * type == 0 普通会员
	 */

	public function add() {
		$user_id = intval($this->input->get('id',true));
		
		if ($user_id) {
			$ret = $this->admin_model->get_uc(array('uid'=>$user_id));
			$result = $this->admin_model->get_update(array('type' => 1,'password'=>$ret['password'],'salt'=>$ret['salt']), array('user_id' => $user_id));
			if ($result) {
				get_redirect('设为管理员成功', '/admin');
			} else {
				get_redirect('设为管理员失败', '/admin');
			}
		} else {
			if (IS_POST) {
				$user_name = $this->input->post('user_name', TRUE);		
				if (empty($user_name)) {
					get_redirect('用户名不能为空', '/admin/add');
				}
				
				$one = $this->admin_model->get_one($user_name);
				if (!$one) {
					get_redirect('用户名错误或该用户已经是管理员', '/admin/add');
				}
				$ret = $this->admin_model->get_uc(array('username'=>$user_name));
				$result = $this->admin_model->get_update(array('type' => 1,'password'=>$ret['password'],'salt'=>$ret['salt']), array('user_name' => $user_name));
				if ($result) {
					get_redirect('设为管理员成功', '/admin');
				} else {
					get_redirect('设为管理员失败', '/admin');
				}
			}
			$this->load->view('admin/admin_add');
		}
	}

	/*
	 * 删除管理员
	 */

	public function delete() {
		$user_id = intval($this->uri->segment(4));
		$this->admin_model->get_update(array('type' => 0, 'super_admin' => 0), array('user_id' => $user_id));
		$this->admin_model->delete($user_id);
		get_redirect('取消管理员成功', '/admin');
	}

	/*
	 * 设为超管
	 */

	public function super_admin() {
		$user_id = intval($this->uri->segment(4));
		$this->admin_model->super_admin($user_id);
		//给超管默认全部权限
		$this->admin_model->super_level($user_id);
		get_redirect('设为超管成功', '/admin');
	}

}
