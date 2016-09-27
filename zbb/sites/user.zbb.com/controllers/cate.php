<?php

/**
 * 用户中心控制器
 */
class Cate extends User_Controller {

	public function __construct() {
		parent::__construct();
        $this->load->model('cate_model');
        $this->per_page = 3;
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;
	}

	public function lists() {
        // 所有分类
        $arr = $this->cate_model->cate_seller($this->per_page, $this->offset);
        $data['cate'] = $arr['cate'];
        $data['all'] = $arr['all'];
        $data['num']=$this->cur_page;
        // 分页
        $data['rows'] = $arr['count'];
        $url_format = "/cate/lists/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['rows'] / $this->per_page), $url_format, 5, TRUE, TRUE);
		$this->load->view('cate/lists',$data);
	}

	public function cate_add() {
        $user_id = get_user();
        $post = $this->input->post(NULL,true);
        if (!$post['cate_name']) {
            echo "<script>alert('请输入正确的分类名称');history.go(-1);</script>";
            return;
        }
        $parent_id_temp = $post['id'];
        $parent_id = $parent_id_temp ? $parent_id_temp : 0;
        $sort_order_temp = $post['sort_order'];
        $sort_order = $sort_order_temp ? $sort_order_temp : 255;
        $data = array(
            'store_id'=>$user_id['id'],
            'cate_name'=>$post['cate_name'],
            'parent_id'=>$parent_id,
            'if_show' =>$post['show'],
            'sort_order'=>$sort_order,
        );
        $ret = $this->cate_model->category_add($data);
        if($ret){
            ajax_success(TRUE);
        }else{
            ajax_error('参数不全或未登录');
        }
    }

    public function cate_edit_ajax() {
        if(!IS_POST){
            return false;
        }

        $user_id = get_user();
        $cate_id=intval($this->input->post('id'));
        $result['cate_info'] = $this->cate_model->get_parent($cate_id);
        $ret = $this->cate_model->cate_children($user_id['id']);
        $result['top_cate'] = $ret;
        if($result){
            ajax_success($result);
        }else{
            ajax_error('未登录或者无信息');
        }
    }

    public function cate_edit()
    {
        if (IS_POST) {
            $cate_id=intval($this->input->post('id'));
            $result['cate_info'] = $this->cate_model->get_parent($cate_id);

            $parent_id= intval($this->input->post('pid', TRUE));
            $cate_name  = $this->input->post('cate_name', TRUE);
            $sort_order = intval($this->input->post('sort_order', TRUE));

            $arr=array('parent_id' => $parent_id,'cate_name'=>$cate_name,'sort_order'=>$sort_order);

            $result = $this->cate_model->cate_save($result['cate_info']['cate_id'], $arr);
            if($result){
                ajax_success(true);
            }else{
                ajax_error('信息未修改');
            }
        }
    }
    public function cate_del() {
        $cate_id=intval($this->input->post('id'));
        $result = $this->cate_model->sel_cate_parent($cate_id);
        if($result!=0){
            ajax_error('尚有子级未删除');
        }
        $ret=$this->cate_model->select_cate($cate_id);
        if($ret){
            ajax_success($ret);
        }else{
            ajax_error('无分类信息');
        }
    }
}