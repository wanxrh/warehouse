<?php

/**
 * @name 后台权限模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Level_model extends CI_Model {
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

    /*
     * 首页列表
     */
    public function get_list() {
        $data['count'] = $this->db->from('level_user')->count_all_results();
        $data['list'] = $this->db->join('member', 'member.user_id=level_user.user_id')->select('level_user.*,member.super_admin')->get('level_user', $this->per_page, $this->offset)->result_array();
        return $data;
    }

    /**
     * 关联address表查询一条数据
     * @param $where order表的数据
     * @return $row 返回满足条件的一条数据
     */
    public function get_one($table, $where) {
        //$row = $this->db->join('address', 'address.user_id = order.buyer_id')->get_where('order', $where)->row_array();
        $row = $this->db->get_where($table, $where)->row_array();
        return $row;
    }

    /**
     * 获取level表的全部内容
     * @return $list 返回全部数据
     */
    public function get_more() {
        $list = $this->db->get('level')->result_array();
        return $list;
    }

    /**
     * 根据条件更新数据
     * @param $where 条件
     * @param $table 表名
     * @param $data 数据
     * @return $result 返回满足条件的结果
     */
    public function get_edit($table, $data, $where) {
        $result = $this->db->update($table, $data, $where);
        return $result;
    }

    /**
     * 根据父级ID查询子级
     * @return $arr 返回数组
     */
    public function category() {
        $list = $this->db->get_where('level', array('parent_id' => 0))->result_array();
        foreach ($list as $key => $val) {
            $level_id = $val['level_id'];
            $arr[] = $val;
            $result = $this->db->get_where('level', array('parent_id' => $level_id))->result_array();
            foreach ($result as $v) {
                $arr[$key]['child'][] = $v;
            }
        }
        return $arr;
    }

    /**
     * 根据用户名判断是否为管理员
     * @return $row['user_id']  返回管理员ID
     */
    public function get_aid($user_name) {
        $row = $this->db->get_where('member', array('user_name' => $user_name, 'type' => 1))->row_array();
        if (empty($row)) {
            get_redirect('请输入正确的管理员名称', '/level/add');
        } else {
            return $row['user_id'];
        }
    }

    /**
     * 新增数据
     * @param $table 表名
     * @param $data 数据
     * @return $result  返回新增数据的ID
     */
    public function get_add($table, $data) {
        $this->db->insert($table, $data);
        $result = $this->db->insert_id();
        return $result;
    }

    /**
     * 根据条件获取数据
     * @param $table 表名
     * @param $where 条件
     * @return $result 返回满足条件的数组
     */
    public function get_level($table, $where) {
        $result = $this->db->get_where($table, $where)->result_array();
        return $result;
    }

    /*
     * 无极分类查询
     */
    public function more($id){
        $list = $this->db->get_where('level', array('parent_id' => $id))->result_array();
        return $list;
    }
}

?>
