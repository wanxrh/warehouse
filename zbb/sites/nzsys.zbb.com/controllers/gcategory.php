<?php

/*
 * 后台分类管理
 */

class Gcategory extends Admin_Controller {

    public function __construct() {
        parent::__construct();
        header("content-type:text/html; charset=utf-8");
        $this->load->model('gcategory_model');
    }

    /*
     * 商品分类列表
     */

    public function index() {
        $cate_id = 0;
        $data['gcategory'] = $this->gcategory_model->get_more($cate_id);
        $this->load->view('gcategory/gcategory_index.php', $data);
    }

    /*
     * 下级分类
     */

    public function next_level() {
        $cate_id = intval($this->uri->segment(4));
        $data['gcategory'] = $this->gcategory_model->get_more($cate_id);
        $this->load->view('gcategory/gcategory_index.php', $data);
    }

    /*
     * 新增分类
     */

    public function add() {
        
        // 获取频道下的分类（默认女装特卖-1）
        $result = $this->gcategory_model->cate_children();
        $data['top_cate']  = $result['top_cate'];
        $data['second_cate']  = $result['second_cate'];    
        
        if (IS_POST) {
            $parent_id= intval($this->input->post('parent_id', TRUE));
            $cate_name  = $this->input->post('cate_name', TRUE);
            $sort_order = intval($this->input->post('sort_order', TRUE));
            
            $arr=array(
                'parent_id' => isset($parent_id)?$parent_id:0,
                'cate_name'=>$cate_name,
                'sort_order'=>$sort_order,
                'if_show'=>1
                );
            
            $res = $this->gcategory_model->cate_add($arr);
            if ($res) {
                get_redirect('添加成功', '/gcategory');
                $this->log_model->insert_log('进行了添加商品分类操作',get_admin());
            } else {
                get_redirect('添加失败', '/gcategory');
            }
        }
        $this->load->view('gcategory/gcategory_add.php', $data);
    }

    /*
     * 编辑分类
     */

    public function save() {
        
        $cate_id = intval($this->uri->segment(4));
        $data['cate_info'] = $this->gcategory_model->get_cate($cate_id);
        $ret = $this->gcategory_model->cate_children();
        $data['top_cate']  = $ret['top_cate'];
        $data['second_cate']  = $ret['second_cate'];

        if (IS_POST) {

            $file = $_FILES['category'];
            if ($file['name'] != '') {
                $img = $this->_upload_image();
                $cate_images = $img;
            }else{
                $cate_images='';
            }



            $parent_id= intval($this->input->post('parent_id', TRUE));
            $cate_name  = $this->input->post('cate_name', TRUE);
            $sort_order = intval($this->input->post('sort_order', TRUE));


            $arr=array('parent_id' => $parent_id,'cate_name'=>$cate_name,'sort_order'=>$sort_order,'cate_images'=>$cate_images);

            $res = $this->gcategory_model->cate_save($data['cate_info']['cate_id'], $arr);
            if ($res) {
                get_redirect('修改成功', '/gcategory');
                $this->log_model->insert_log('进行了修改商品分类编号:'.$cate_id.'操作',get_admin());
            } else {
                get_redirect('修改失败', '/gcategory');
            }
        }
        $this->load->view('gcategory/gcategory_save.php', $data);
    }

    /*
     * 删除
     */

    public function delete() {
        
        $redirect_url = $_SERVER['HTTP_REFERER'];
        $cate_id = intval($this->uri->segment(4));
        $this->gcategory_model->del_category($cate_id);
        header("location:" . $redirect_url);
    }

    /*
     * 显示
     */

    public function gcategory_show() {
        $cate_id = intval($this->uri->segment(4));
        $result = $this->gcategory_model->get_cate($cate_id);
        if ($result['if_show'] == 1) {
            $res = $this->gcategory_model->hidden_cate($cate_id);
            if ($res) {
                get_redirect('修改成功', '/gcategory');
            }
        } else {
            $res = $this->gcategory_model->show_cate($cate_id);
            if ($res) {
                get_redirect('修改成功', '/gcategory');
            }
        }
        $result = $this->gcategory_model->get_cate($cate_id);
    }
    
    /**
     * AJAX获取频道下分类
     */
    public function cate_children()
    {
        // 获取频道下的分类，默认女装频道
        $cate_type  = $this->input->get('cate_type', TRUE);
        $result= $this->gcategory_model->cate_children($cate_type);
        
        $gcategories= $result['gcategory'];
        $top_cate  = $result['top_cate'];
        
        $html = '<option value="0">作为频道</option><option value="'. $top_cate .'">顶级</option><option value="">请选择...</option>';
        foreach ($gcategories as $gcategory) {
            $html .= '<option value="'. $gcategory['cate_id'] .'">'. $gcategory['cate_name'] .'</option>';
        }
        ajax_success($html);
        return;
    }

    /* 上传图片 */
    function _upload_image() {
        $this->load->library('uploader');
        $this->uploader->allowed_size(600000); // 400KB
        $file = $_FILES['category'];

        if ($file['error'] == UPLOAD_ERR_OK) {
            if (empty($file)) {
                return false;
            }
            $this->uploader->addFile($file);
            if (!$this->uploader->file_info()) {
                show_error($this->uploader->get_error());
            }
            $info = $this->uploader->file_info();
            $type = $info['extension'];
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            $dirname = 'www/' . $Y . '/' . $m . '/' . $d;
            $filename = 'category_' . time() . rand(1000, 9999);
            $this->uploader->save($dirname, $filename);
        }
        return 'www/' . $Y . '/' . $m . '/' . $d . '/' . $filename . '.' . $type;
    }
    

}