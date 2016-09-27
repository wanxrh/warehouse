<?php

/*
 * 后台店铺管理控制器
 */

class Store extends Admin_Controller {

	public function __construct() {
		parent::__construct();
		$this->load->model('store_model');
		$this->load->model('message_model');
		$this->load->model('user_model');
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
        $status = $this->input->get('status');
        $store_name = $this->input->get('store_name');
        $result = $this->store_model->get_store($status,$store_name,$this->per_page, $this->offset);

        $data['list'] = $result['list'];
        $data['total'] = $result['total'];

		//显示页码数
		$show_page = 5;
		$url = '/store/index/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url, $show_page, TRUE, FALSE, $data['total']);

		$this->load->view('store/store_index', $data);
	}



	/*
	 * 推荐
	 */

	public function recommended() {
		$store_id = intval($this->input->get('id', true));
		$row = $this->store_model->get_one(array('store_id' => $store_id));
		if ($row['recommended'] == 0) {
			$result = $this->store_model->get_edit(array('recommended' => 1), array('store_id' => $store_id));
		} else {
			$result = $this->store_model->get_edit(array('recommended' => 0), array('store_id' => $store_id));
		}
		if ($result) {
			get_redirect('设置成功', '/store');
		} else {
			get_redirect('设置失败', '/store');
		}
	}



	/*
	 * 执照证件
	 */

	public function info() {
		$data['store_id'] = intval($this->input->get('store_id', TRUE));
		$data['row'] = $this->store_model->get_one(array('store_id' => $data['store_id']));
		if (IS_POST) {
			$arr = $this->input->post(NULL, TRUE);
			$time = mktime(0, 0, 0, 4, 1, 2015);
			if (time() > $time) {
				$arr['privilege_free'] = 1;
			}
			$res = $this->store_model->get_edit($arr, array('store_id' => $data['store_id']));
			header("location:" . $this->config->item('domain_nzsys') . 'store/edit?id=' . $data['store_id'] . '&type=' . $res);
		}

		$this->load->view('store/store_info', $data);
	}

	/*
	 * 申请店铺列表
	 */
    public function apply(){
        $status = $this->input->get('status');
        $result = $this->store_model->get_apply($status,$this->per_page, $this->offset);
        $data['list'] = $result['list'];

        $data['rows'] = $result['total'];
        $url_format = "/store/apply/%d?" . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data ['page'] = page($this->cur_page, ceil($data ['rows'] / $this->per_page), $url_format, 5, TRUE, FALSE, $data['rows']);
        $this->load->view('store/store_apply',$data);
    }

    /*
     * 申请店铺状态
     */
    public function store_status(){
        $id = $this->input->get('id');
        $result = $this->store_model->get_store_info($id);
        $data = array(
            'store_id' => $result['user_id'],
            'store_name' => $result['store_name'],
            'cate_id' =>$result['cate_1'],
            'add_time' => time(),
            'status' =>1,
        );
        $this->store_model->add_store($id,$data);
        get_redirect('操作成功', '/store/apply');
    }
    /*
     * 申请店铺查看
     */
    public function store_look(){
        $id = $this->input->get('id');
        $result = $this->store_model->get_store_info($id);
        $card_imgs = explode(',',$result['card_imgs']);
        $company_img = explode(',',$result['company_img']);
        $data['card_imgs'] = $card_imgs;//身份证图片
        $data['company_img'] = $company_img;//公司图片
        $data['store'] = $result;
        $this->load->view('store/store_look',$data);
    }
    /*
     * 通过ajax把数据传递到弹出框
     */
    public function store_comment(){
        $apply_id = $this->input->post('id');
        $store_list = $this->store_model->get_store_info($apply_id);
        $comments = $store_list['comment'];
        ajax_success($comments);
    }

    /**
     * 店铺状态
     */
    public function update_store_status(){
        $store_id = $this->input->get('id');
        $status = $this->input->get('status');
        $temp = $this->store_model->update_store_status($store_id,$status);
        if(!$temp){
            get_redirect('操作失败', '/store/index');
        }else{
            get_redirect('操作成功', '/store/index');
        }
    }
    /*
     * 修改弹出框的内容
     */
    public function comment_update()
    {
        $id = $this->input->post('box_id');
        $comment = $this->input->post('comment');
        $status = $this->store_model->up_com($id, $comment);
        //改变状态
        $this->store_model->store_update($id, 2);
        if(!$status){
            get_redirect('修改失败', '/store/apply');
        }else{
            get_redirect('修改成功', '/store/apply');
        }
    }

}
