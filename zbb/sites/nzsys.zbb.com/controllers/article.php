<?php

/*
 * 后台文章管理控制器
 */

class Article extends Admin_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('article_model');
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
        //获取关键字
        $title = $this->input->get('title', TRUE);
        //获取文章分类id
        $cate_id = intval($this->input->get('cate_id', TRUE));
        //显示页码数
        $show_page = 5;
        //根据用户输入的条件进行订单查询，结合分页类使用
        $data = $this->article_model->get_search($title, $cate_id);
        $data['list'] = $this->get_again($data['list']);
        $url = '/article/index/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['count'] / $this->per_page), $url, $show_page, TRUE, FALSE, $data['count']);
        //查询的文章分类
        $data['acategory'] = $this->category();
        $this->load->view('article/article_index', $data);
    }

    /*
     * 新增
     */

    public function add() {
        if (IS_POST) {
            $add = $this->input->post(NULL);
            if ($add['title'] == '') {
                echo '<script>alert("请输入标题");window.history.go(-1);</script>';
                exit;
            }
            if ($add['cate_id'] == '') {
                echo '<script>alert("请选择分类");window.history.go(-1);</script>';
                exit;
            }
            $add['add_time'] = time();
            $result = $this->article_model->article_add($add);

            if ($result) {
                get_redirect('新增成功', '/article');
            } else {
                get_redirect('新增失败', '/article');
            }
        }
        $data['acategory'] = $this->category();
        $this->load->view('article/article_add', $data);
    }

    /*
     * 编辑
     */

    public function edit() {
        $article_id = intval($this->uri->segment(4));
        $data['acategory'] = $this->category();
        $data['row'] = $this->article_model->get_one('article', array('article_id' => $article_id));
        if (IS_POST) {
            $edit = $this->input->post(NULL);
            if ($edit['title'] == '') {
                echo '<script>alert("请输入标题");window.history.go(-1);</script>';
                exit;
            }
            if ($edit['cate_id'] == '') {
                echo '<script>alert("请选择分类");window.history.go(-1);</script>';
                exit;
            }
            $this->article_model->get_edit('article', $edit, array('article_id' => $article_id));
            get_redirect('更新成功', '/article');
        }
        $this->load->view('article/article_edit', $data);
    }

    /*
     * 删除文章
     */

    public function delete() {
        $article_id = intval($this->uri->segment(4));
        $this->article_model->article_del($article_id);
        get_redirect('删除成功', '/article');
    }

    /*
     * kindedit插件的图片上传处理
     */
    public function upload() {
        if (!get_admin()) {
            show_error("未登录不能上传");
        } else {
            $this->load->library('uploader');
            $file = $_FILES['imgFile'];
            //上传文件不能为空
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
                $this->uploader->allowed_size(4000000);
                $this->uploader->addFile($file);
                if ($this->uploader->file_info() === false) {
                    show_error($this->uploader->get_error());
                    return false;
                }
                $ret = $this->config->item('domain_img') . $this->uploader->save('article/' . $Y . '/' . $m . '/' . $d);
            }
            echo json_encode(array('error' => 0, 'url' => $ret));
            exit;
        }
    }

    /**
     * 文章列表重组数组
     * @param $data article表的数据
     * @return $result 返回满足条件的数组
     */
    public function get_again($data) {
        foreach ($data as $key => $val) {
            if ($val['if_show'] == 1) {
                $data[$key]['if_show'] = '是';
            } elseif ($val['if_show'] == 0) {
                $data[$key]['if_show'] = '否';
            }
        }
        return $data;
    }

    /**
     * 无极分类方法
     * @param $id 默认为0
     * @param $list 空数组
     * @param $status 标识
     * @return $list 返回无极分类数组，父类下面接子类
     */
    public function category($id = 0, $list = array(), $status = 0) {
        $result = $this->article_model->get_more('acategory', array('parent_id' => $id));
        foreach ($result as $key => $val) {
            for ($i = 0; $i < $status; $i++) {
                $val['cate_name'] = '<font color="#FF0000">|-</font>' . $val['cate_name'];
            }
            $list[] = $val;
            $id = $val['cate_id'];
            $list = $this->category($id, $list, $status + 1);
        }
        return $list;
    }
	
	/*
	 *预览
	 */
	public function preview(){
    $article_id=$this->cur_page = intval($this->uri->segment(4));  //获取地址第四段的参数
    $data['article']=$this->article_model->article_lan($article_id);
	$this->load->view('article/article_info', $data);	
}
		
}