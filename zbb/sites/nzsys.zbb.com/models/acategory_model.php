<?php

/**
 * @name 后台文章分类模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Acategory_model extends CI_Model {
    /*
     * 继承父级构造方法
     * 实例化两个数据库方法
     */

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 顶部广告
     */

    public function get_info() {
        $data = $this->db->select('*')->limit(20)->get('goods')->result_array();
        return $data;
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
     * 新增数据
     * @param $table 表名
     * @param $data 要新增的数据
     * @return $id 新增数据的ID
     */
    public function get_add($table, $data) {
        $this->db->insert($table, $data);
        $id = $this->db->insert_id();
        return $id;
    }

    /**
     * 删除数据
     * @param $where 要新增的数据
     * @return $result 删除的结果
     */
    public function delete($where){
        $result = $this->db->delete('acategory',$where);
        return $result;
    }
}

?>
