<?php

class Store_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 获取站点分类
     */
    public function get_cate($parent_id=0) {
        $this->db->select('cate_id,cate_name');
        $this->db->where(array('parent_id'=>$parent_id,'store_id'=>0));
        $ret=$this->db->get('gcategory')->result_array();
        return $ret;
    }
    /**
     * 获取店铺信息
     */
    public function store_info($store_id) {
        $ret=$this->db->get_where('store',array('store_id'=>$store_id))->row_array();
        return $ret;
    }
    /*
     * 获取地区信息
     */
    public function get_region($id){
        $this->db->select('region_id,region_name');
        $this->db->where('parent_id',$id);
        $result = $this->db->get('region')->result_array();
        return $result;
    }

    /*
     * 企业信息保存
     */
    public function company_save($arr){
        $ret=$this->db->insert('store_apply',$arr);
        return $ret;
    }

    /*
     * 申请信息
     */
    public function apply_info($user_id){
        $this->db->select('*');
        $ret=$this->db->where('user_id',$user_id)->get('store_apply')->row_array();
        return $ret;
    }
    /*
     * 店铺申请信息保存
    */
    public function apply_save($user_id,$apply_arr){
        $ret=$this->db->where('user_id',$user_id)->update('store_apply',$apply_arr);
        return $ret;
    }
    /*
     * 店铺链接保存
    */
    public function save_url($user_id,$check_url){
        $ret=$this->db->where('user_id',$user_id)->update('store_apply',array('check_url'=>$check_url,'step'=>2,'status'=>0));
        return $ret;
    }
    /*
     * 店铺信息修改
     */
    public function store_save($id,$arr){
        $this->db->where('store_id',$id)->update('store',$arr);
    }
    /*
     * 获取地区名字
     */
    public function get_region_name($region_id){
       return $this->db->select('region_name')->where('region_id',$region_id)->get('region')->row_array();
    }
}
