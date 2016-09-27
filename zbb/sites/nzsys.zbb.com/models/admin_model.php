<?php

/**
 * @name 后台管理员模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Admin_model extends CI_Model {

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
        $this->uc_db = $this->load->database('uc', TRUE);
    }


    /**
     * 根据条件以及用户输出的内容更新数据
     * @param $where 查询条件
     * @param $data 用户输入的内容
     * @return $result 更改之后的结果 
     */
    public function get_update($data, $where) {
        $result = $this->db->update('member', $data, $where);
        return $result;
    }

    /**
     * 根据条件查询多条数据，结合分页
     * @param $where 查询条件
     * @return $result 返回满足条件的数组 
     */
    public function get_list($where) {
        $data['count'] = $this->db->where($where)->from('member')->count_all_results();
        $data['list'] = $this->db->where($where)->get('member', $this->per_page, $this->offset)->result_array();
        return $data;
    }
    
    /*
     * 设为超管
     */
    public function super_admin($user_id){
        $result = $this->db->update('member',array('super_admin'=>1),array('user_id'=>$user_id));
        return $result;   
    }
    
    /*
     * 给超管默认全部权限
     */
    public function super_level($user_id){
        $level_list = $this->db->select('level_id')->get('level')->result_array();
        $level_id = array_column($level_list,'level_id');
        $level_str = implode(",", $level_id);
        $result = $this->db->update('level_user',array('level_id'=>$level_str),array('user_id'=>$user_id));
        return $result;
    }
   
	 public function get_one($user_name){
		 $row = $this->db->get_where('member',array('user_name'=>$user_name,'type'=>0))->row_array();
		 return $row;
	 }
	 
	 public function delete($user_id){
		 $res = $this->db->delete('level_user',array('user_id'=>$user_id));
		 return $res;
	 }
	 public function get_uc($condition){
	 	return $this->uc_db->where($condition)->get('members')->row_array();
	 }
}

?>
