<?php

/**
 * 商品模型
 */
require "app_model.php";

class Profile_model extends App_model
{
    public function __construct()
    {
        parent::__construct();
    }
    /*
    *用户信息
     */
    public function user_info($user_id){
        $this->db->select('gender,portrait,location,background_img');
        $ret=$this->db->where('user_id',$user_id)->get('member')->row_array();
        return $ret;
    }

    /*
    *用户手机
     */
    public function get_mobile($user_id){
        $this->uc_db= $this->load->database('uc', TRUE);
        $this->uc_db->select('mobile');
        $ret=$this->uc_db->where('uid',$user_id)->get('members')->row_array();
        return $ret;
    }

    /*
    *用户头像
     */
    public function save_portrait($user_id,$img){
        $this->db->where('user_id',$user_id);
        $ret=$this->db->update('member',array('portrait'=>$img));
        return $ret;
    }
    /*
    *背景图
     */
    public function save_background($user_id,$img){
        $this->db->where('user_id',$user_id);
        $ret=$this->db->update('member',array('background_img'=>$img));
        return $ret;
    }
    /*
     * 修改性别
     */
    public function save_gender($user_id,$gender){
        $this->db->where('user_id',$user_id);
        $ret=$this->db->update('member',array('gender'=>$gender));
        return $ret;
    }

    /*
     * 获取地区信息
     */
    public function get_region($pid){
        $this->db->select('region_id,region_name');
        $this->db->where('parent_id',$pid);
        $result = $this->db->get('region')->result_array();
        return $result;
    }

    /*
     * 保存地区信息
     */
    public function save_address($user_id,$data){
        $this->db->where('user_id',$user_id);
        $ret=$this->db->update('member',$data);
        return $ret;
    }

    public function ship_address($user_id){
        return $this->db->where('user_id',$user_id)->count_all_results('address');
    }

}