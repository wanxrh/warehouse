<?php

/*
 * 后台地区管理控制器
 */

class Region extends Admin_Controller {

	public function __construct() {
		parent::__construct();
		$this->load->model('region_model');
	}

	/*
	 * 默认首页
	 */

	public function index() {
		$data['list'] = $this->region_model->get_more('region', array('parent_id' => 0));
		$this->load->view('region/region_index', $data);
	}

	public function info() {
		$region_id = intval($this->input->get('id', true));
		$data['list'] = $this->region_model->get_more('region', array('parent_id' => $region_id));
		$this->load->view('region/region_index', $data);
	}

	/*
	 * 编辑
	 */

	public function edit() {
		$region_id = intval($this->input->get('id', true));
		$data['row'] = $this->region_model->get_one('region', array('region_id' => $region_id));
		if ($data['row']['parent_id'] != 0) {
			$row = $this->region_model->get_one('region', array('region_id' => $data['row']['parent_id']));
			$data['region'] = $this->region_model->get_more('region', array('parent_id' => $row['parent_id']));
		}
		if (IS_POST) {
			$edit = $this->input->post(NULL, TRUE);
			$result = $this->region_model->get_edit('region', $edit, array('region_id' => $region_id));
			if ($result) {
				get_redirect('更新成功', '/region');
			} else {
				get_redirect('更新失败', '/region');
			}
		}
		$this->load->view('region/region_edit', $data);
	}

	/*
	 * 删除
	 */

	public function delete() {
		$region_id = intval($this->input->get('id', true));
		$this->del_category($region_id);
		get_redirect('删除成功', '/region');
	}

	/*
	 * 新增
	 */

	public function add() {
		$data['region'] = $this->region_model->get_more('region', array('parent_id' => 0));
		if (IS_POST) {
			$add = $this->input->post(NULL, TRUE);
			if ($add['region_name'] == '') {
				echo '<script>alert("请输入地区名称");window.history.go(-1);</script>';
				exit;
			}
			if ($add['parent_id'] == '') {
				echo '<script>alert("请选择上级分类");window.history.go(-1);</script>';
				exit;
			}
			$id = $this->region_model->get_add('region', $add);
			if ($id) {
				get_redirect('新增成功', '/region');
			} else {
				get_redirect('新增失败', '/region');
			}
		}
		$this->load->view('region/region_add', $data);
	}

	/*
	 * 新增下级
	 */

	public function add_next() {
		$region_id = intval($this->input->get('id', true));
		if (IS_POST) {
			$add = $this->input->post(NULL, TRUE);
			$add['parent_id'] = $region_id;
			$id = $this->region_model->get_add('region', $add);
			get_redirect('新增成功', '/region');
		}
		$this->load->view('region/region_add');
	}

	/**
	 * 删除分类的方法
	 * @param $region_id 地区ID
	 * @return $delete 返回删除结果
	 */
	private function del_category($region_id) {
		$result = $this->region_model->get_more('region', array('parent_id' => $region_id));
		foreach ($result as $key => $val) {
			$child_id = $val['region_id'];
			$this->region_model->delete('region', array('region_id' => $child_id));
			$this->del_category($child_id);
		}
		$delete = $this->region_model->delete('region', array('region_id' => $region_id));
		return $delete;
	}

}