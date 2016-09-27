<?php

class Help extends CI_Controller {

    public function __construct() {
        parent::__construct();
        header("content-type:text/html; charset=utf-8");
        $this->load->model('help_model');   //加载model;
    }

    public function index($cur_page = 1) {
        $data=$this->common();
        $per_page = 10;     //每页显示条数;
        $offset = ($cur_page - 1) * $per_page;  //偏移量;
        $ret = $this->help_model->article_list($per_page, $offset);
        $data['article_list'] = $ret['list'];
        $nums = $ret['total'];   //总记录
        $url_format = "/list-%d.html"; //要分页页面的路径
        $data ['page'] = page($cur_page, ceil($nums / $per_page), $url_format, 5, TRUE, TRUE);
//        print_r($data);die;
        $this->load->view('help/index', $data);   //加载视图；
    }
    /*
     * 列表页
     */
    public function article($cate_id) {
        $data=$this->common();
        $per_page =10;     //每页显示条数;
        $cur_page = intval($this->uri->segment(4));  //获取地址第四段的参数
        $offset = ($cur_page - 1) * $per_page;  //偏移量;
        $ret = $this->help_model->article_list($per_page, $offset,$cate_id);
        $data['article_list'] = $ret['list'];
        $nums = $ret['total'];   //总记录
        $url_format = "/help/article/" . $cate_id . "/%d"; //要分页页面的路径
        $data ['page'] = page($cur_page, ceil($nums / $per_page), $url_format, 5, TRUE, TRUE, $nums);
//        print_r($data);die;
        $this->load->view('help/article', $data);
    }

    /*
     * 搜索页
     */
    public function search($cur_page = 1) {
        $keyword=filter_sql($this->input->get('keyword'));
        $data=$this->common();
        if(!$keyword){
            $data['is_ok']=0;
        }else{
            $data['is_ok']=1;
        }
        $data['article_list']= $this->help_model->search($keyword);
        $this->load->view('help/search', $data);
    }

    /*
     * 文章详细页
     */
    public function article_info($article_id) {
        $data = $this->common();  //调用方法；
        $data['info'] = $this->help_model->article_info($article_id);
//        print_r($data);die;
        $this->load->view('help/article_info', $data);
    }
    /*
   *分类最新文章
   */
    private function common() {
        $data['cate_list'] = $this->help_model->article_category();
        return $data;
    }
}