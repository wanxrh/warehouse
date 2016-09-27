<?php

/*
 * 后台权限管理控制器
 */

class Level extends Admin_Controller {

	public function __construct() {
		parent::__construct();
		$this->load->model('level_model');
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
	 * 默认首页
	 */

	public function index() {
		$data = $this->level_model->get_list();
		$data['list'] = $this->re_array($data);
		$url = '/level/index/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['count'] / $this->per_page), $url, 5, TRUE, FALSE, $data['count']);
		$this->load->view('level/level_index', $data);
	}

	/*
	 * 修改权限
	 */

	public function edit() {
		$id = intval($this->uri->segment(4));
		$data['row'] = $this->level_model->get_one('level_user', array('id' => $id));
		$data['level_id'] = explode(',', $data['row']['level_id']);
		$data['level'] = $this->level_model->category();
		if (IS_POST) {
			$arr_id = $this->input->post('level_id', TRUE);
			$level_id = implode(",", $arr_id);
			$this->level_model->get_edit('level_user', array('level_id' => $level_id), array('id' => $id));
			get_redirect('修改成功', '/level');
		}
		$this->load->view('level/level_edit', $data);
	}

	/*
	 * 添加管理员权限
	 */

	public function add() {
		$data['level'] = $this->level_model->category();
		if (IS_POST) {
			$arr_id = $this->input->post('level_id', TRUE);
			if (empty($arr_id)) {
				echo '<script>alert("请选择权限");window.history.go(-1);</script>';
				exit;
			}
			$add['level_id'] = implode(",", $arr_id);
			$add['user_name'] = $this->input->post('user_name', TRUE);
			if ($add['user_name'] == '') {
				get_redirect('请输入管理员名称', '/level/add');
				exit;
			}
			$add['user_id'] = $this->level_model->get_aid($add['user_name']);
			$result = $this->level_model->get_add('level_user', $add);
			if ($result) {
				get_redirect('新增成功', '/level');
			} else {
				get_redirect('新增失败', '/level/add');
			}
		}
		$this->load->view('level/level_add', $data);
	}

	/*
	 * 权限列表
	 */

	public function level_list() {
		$data['list'] = $this->get_category();
		$this->load->view('level/level_list', $data);
	}

	/*
	 * 新增权限
	 */

	public function level_add() {
		$data['level'] = $this->level_model->get_level('level', array('parent_id' => 0));
		if (IS_POST) {
			$add = $this->input->post(NULL, TRUE);
			if ($add['level_name'] == '') {
				echo '<script>alert("请输入权限名称");window.history.go(-1);</script>';
				exit;
			}
			$result = $this->level_model->get_add('level', $add);
			if ($result) {
				get_redirect('新增成功', '/level/level_list');
			} else {
				get_redirect('新增失败', '/level/level_add');
			}
		}
		$this->load->view('level/level_join', $data);
	}

	/*
	 * 权限名称修改
	 */

	public function level_edit() {
		$level_id = intval($this->uri->segment(4));
		$data['row'] = $this->level_model->get_one('level', array('level_id' => $level_id));
		if (IS_POST) {
			$edit = $this->input->post(NULL, TRUE);
			$this->level_model->get_edit('level', $edit, array('level_id' => $level_id));
			get_redirect('修改成功', '/level/level_list');
		}
		$this->load->view('level/level_save', $data);
	}

	/*
	 * 列表重组数组
	 */

	public function re_array($data) {
		foreach ($data['list'] as $key => $val) {
			$data['list'][$key]['level_id'] = explode(",", $val['level_id']);
		}
		$a = $this->level_model->get_more();
		foreach ($a as $key => $val) {
			$arr[$val['level_id']] = $val;
		}
		$level_id = array_column($arr, 'level_id');
		foreach ($data['list'] as $key => $val) {
			foreach ($val['level_id'] as $k => $v) {
				if (in_array($v, $level_id)) {
					$data['list'][$key]['level_id'][$k] = $arr[$v]['level_name'];
				}
			}
		}
		foreach ($data['list'] as $key => $val) {
			$data['list'][$key]['level_id'] = implode(",", $val['level_id']);
		}
		foreach ($data['list'] as $key => $val) {
			if ($val['super_admin'] == 1) {
				$data['list'][$key]['super_admin'] = '超管';
			} else {
				$data['list'][$key]['super_admin'] = '普通管理员';
			}
		}
		return $data['list'];
	}

	/**
	 * 无极分类方法
	 * @param $id 默认为0
	 * @param $list 空数组
	 * @param $status 标识
	 * @return $list 返回无极分类数组，父类下面接子类
	 */
	private function get_category($id = 0, $list = array(), $status = 0) {
		$result = $this->level_model->more($id);
		foreach ($result as $val) {
			for ($i = 0; $i < $status; $i++) {
				$val['level_name'] = '<font color="#FF0000">|-</font>' . $val['level_name'];
			}
			$list[] = $val;
			$id = $val['level_id'];
			$list = $this->get_category($id, $list, $status + 1);
		}
		return $list;
	}

}
