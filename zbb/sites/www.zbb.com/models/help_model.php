<?php

class Help_model extends CI_Model {

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 文章分类列表
     */
    public function article_category() {
        $data = $this->db->select('*')->get('acategory')->result_array();
        return $data;
    }

    /**
     * 文章列表
     */
    public function article_list($per_page, $offset,$cate_id='') {
        $this->db->where('if_show', 1);
        if(!empty($cate_id)){
            $this->db->where('cate_id', $cate_id);
        }
        $db=clone($this->db);
        $this->db->order_by("add_time", "desc")->limit($per_page, $offset);
        $data['list']=$this->db->get('article')->result_array(); //根据添加时间来确定最新文章
        $this->db=$db;
        $data['total'] = $this->db->count_all_results('article');
        return $data;
    }

     /**
     * 文章列表
     */
    public function search($keyword) {    
        $this->db->where('if_show', 1);
        if(!empty($keyword)){
            $this->db->like('title', $keyword);
        }
        $this->db->order_by("add_time", "desc");
        $data=$this->db->get('article')->result_array(); //根据添加时间来确定最新文章
        return $data;
    }

    /**
     * 文章详细页
     */
    public function article_info($article_id) {

        $result = $this->db->where('article_id', $article_id)->get('article')->row_array();
        //根据添加时间来确定最新文章
        return $result;
    }

}
