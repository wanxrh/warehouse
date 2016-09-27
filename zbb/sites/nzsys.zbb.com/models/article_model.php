<?php

/**
 * @name 后台文章模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Article_model extends CI_Model {
    /*
     * 继承父级构造方法
     * 实例化两个数据库方法
     */

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 根据用户输入的条件进行订单查询，结合分页类使用
     * @param $title 输入的关键字
     * @param $cate_id 文章类型
     * @param $page 当前页
     * @param $show_page 显示的页码数
     * @return $data 返回满足条件的订单列表data['list']和订单分页data['page']（二维数组）
     */
    public function get_search($title, $cate_id) {
        $this->db = $this->search_where($title, $cate_id);
        $temp = clone($this->db);
        $data['count'] = $this->db->from('article')->count_all_results(); //总条数
        $this->db = $temp;
        $data['list'] = $this->db->join('acategory', 'acategory.cate_id = article.cate_id','left')->select('article.*,acategory.cate_name')->order_by('article_id desc')->get('article', $this->per_page, $this->offset)->result_array();
		  return $data;
    }

    /**
     * 根据用户输入的条件进行查询 
     * @param $title 关键字
     * @param $cate_id 分类ID 
     */
    protected function search_where($title, $cate_id) {

        if ($title != '') {
            $this->db->like('title', $title);
        }
        if ($cate_id != '') {
            $this->db->where("article.cate_id = $cate_id");
        }
        return $this->db;
    }



    /**
     * 根据条件查询多条
     * @param $where 查询条件
     * @return $result 返回满足条件的数组
     */
    public function get_more($table, $where) {
        $result = $this->db->get_where($table, $where)->result_array();
        return $result;
    }

    /**
     * 根据条件查询一条
     * @param $where 查询条件
     * @return $result 返回满足条件的数组
     */
    public function get_one($table, $where) {
        $row = $this->db->get_where($table, $where)->row_array();
        return $row;
    }

    /**
     * 根据条件更新一条数据
     * @param $where 更新条件
     * @param $table 表名
     * @param $data 数据
     * @return $result 返回更新的结果
     */
    public function get_edit($table, $data, $where) {
        $result = $this->db->update($table, $data, $where);
        return $result;
    }

    /**
     * 根据用户输入的内容新增文章
     * @return $id 返回新增数据的ID
     */
    public function article_add($add) {
        $this->db->insert('article', $add);
        $id = $this->db->insert_id();
        return $id;
    }

    /*
     * 删除文章
     */

    public function article_del($article_id) {
        $result = $this->db->delete('article', array('article_id' => $article_id));
        return $result;
    }
    /*
	 *文章预览
	 */
     public function article_lan($article_id) {
        $result = $this->db->where('article_id',$article_id)->get('article')->row_array($article_id);
        return $result;

    }
}

?>
