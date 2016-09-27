<?php

/**
 * 用户中心控制器
 */
class Address extends User_Controller {
	
	//定义分页所需的属性
	private $per_page; // 每页显示条数
	private $cur_page; // 当前页
	private $offset; // 页数偏移量

	public function __construct() {
		parent::__construct();
		$this->load->model('address_model');
		// 初始化分页属性
		$this->per_page = 8;
		$this->cur_page = intval($this->uri->segment(3));
		if ($this->cur_page < 1) {
			$this->cur_page = 1;
		}
		$this->offset = ($this->cur_page - 1) * $this->per_page;
	}

	/**
	 * 退货地址列表
	 */
	public function lists() {
		// 地址列表
		$arr = $this->address_model->address($this->per_page, $this->offset);
		$data ['arr'] = $arr['address'];
		// 分页
		$data['rows'] = $arr['count'];
		$url_format = "/address/lists/%d?" . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data ['rows'] / $this->per_page), $url_format);
		
		$addr_arr = $this->address_model->get_addrs(get_user()['id']);
		$data['limit'] = count($addr_arr);

		$this->load->view('address/lists', $data);
	}
	
	/**
	 * 增加退货地址AJAX
	 */
	public function addr_add() {
		$user_id = get_user();
		if (!$user_id['id']){
			return FALSE;
		}
		// 限制地址最多20条
		$this->addr_limit($user_id['id']);
        //判断是否有地址
        $temp=$this->address_model->get_addrs($user_id['id']);
        if($temp){
            $is_default=0;
        }else{
            $is_default=1;
        }

		$post = $this->input->post(NULL,true);
		$data = array(
				'user_id' => $user_id['id'],
				'type' => '1',
				'consignee' => $post['name'],
				'country_id' => $post['region_id'],
				'region_name' => $post['region_name'],
				'address' => $post['addr'],
				'zipcode' => $post['zip'],
				'mobile' => $post['phone'],
                'is_default'=>$is_default
		);
		$result = $this->address_model->add_addr($data);
		if ($result) {
			ajax_success('添加成功！');
		} else {
			ajax_error('添加失败,参数不全或未登录！');
		}
	}
	
	/**
	 * 删除地址的AJAX
	 */
	public function addr_del() {
		if(!IS_POST){
			return FALSE;
		}
		$user_id = get_user();
		if (!$user_id['id']){
			return FALSE;
		}
		// 获取页面传来的地址Id
		$addr_id = intval($this->input->post('addr_id',TRUE));
		if (!$addr_id) {
			return FALSE;
		}
		$result = $this->address_model->delete_addr($addr_id);
		if ($result) {
			ajax_success('删除成功！');
		} else {
			ajax_error('删除失败,未登录或者无信息！');
		}
	}
	
	/**
	 * 修改地址页面
	 */
	public function addr_view() {
		if(!IS_POST){
			return FALSE;
		}
		$user_id = get_user();
		if (!$user_id['id']){
			return FALSE;
		}
		$addr_id = intval($this->input->post('addr_id', TRUE));
		
		$address = $this->address_model->one_addr($addr_id);
		// 区级Id
		$country_id = $address['country_id'];
		// 所有地区
		$data['region'] = $this->address_model->region($country_id);
		// 当前选中地区
		$data['my_region'] = $this->address_model->my_region($country_id);
		if ($data) {
			ajax_success($data);
		} else {
			ajax_error('未登录或者无信息！');
		}
	}
	
	/**
	 * 修改地址的AJAX
	 */
	public function addr_edit() {
		if(!IS_POST){
			return FALSE;
		}
		$user_id = get_user();
		if (!$user_id['id']){
			return FALSE;
		}
		$post = $this->input->post(NULL,true);
		$addr_id = intval($post['addr_id']);
		if (!$addr_id) {
			ajax_error('修改失败,获取不到该条信息！');
		}
		$data = array(
				'user_id' => $user_id['id'],
				'type' => '1',
				'consignee' => $post['name'],
				'country_id' => $post['region_id'],
				'region_name' => $post['region_name'],
				'address' => $post['addr'],
				'zipcode' => $post['zip'],
				'mobile' => $post['phone'],
		);
		$result = $this->address_model->set_addr($addr_id, $data);
		if ($result) {
			ajax_success('修改成功！');
		} else {
			ajax_error('修改失败,参数不全或未登录！');
		}
	}
	
	/**
	 * 设置默认地址AJAX
	 */
	public function set_default() {
		if(!IS_POST){
			return FALSE;
		}
		$user_id = get_user();
		if (!$user_id['id']){
			return FALSE;
		}
		// 获取页面传来的地址Id
		$addr_id = intval($this->input->post('addr_id',TRUE));
		if (!$addr_id) {
			return FALSE;
		}
		$result = $this->address_model->set_default($addr_id);
		if ($result) {
			ajax_success('设置成功！');
		} else {
			ajax_error('设置失败,未登录或者无信息！');
		}
	}
	
	/**
	 * 获取所有省份信息的AJAX
	 */
	public function get_province() {
		$parent_id=intval($this->input->post('parent_id'));
		$result = $this->address_model->get_provice($parent_id);
		if ($result) {
			ajax_success($result);
		} else {
			ajax_error('参数不全或未登录');
		}
	}
	
	/**
	 * 退货地址20条限制
	 */
	public function addr_limit($user_id) {
		$arr = $this->address_model->get_addrs($user_id);
		if (count($arr) < 20) {
			return TRUE;
		} else {
			ajax_error('添加失败,地址不能超过20条！');
		}
	}
}