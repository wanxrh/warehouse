<?php

/*
  用户地址模型
 */

class Address_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 获取用户所有的地址
     */
    public function get_address($user_id){
        $ret=$this->db->where('user_id',$user_id)->order_by('addr_id', 'desc')->get('address')->result_array();
        return $ret;
    }

    /**
     * 获取某条地址
     */
    public function get_addr_info($addr_id,$user_id){
          $ret=$this->db->get_where(array('addr_id'=>$addr_id,'user_id'=>$user_id))->get('address')->row_array();
          return $ret;   
    }

    /*
     *删除地址
     */

    public function delete_addr($addr_id,$user_id) {
        return $this->db->where(array('addr_id'=>$addr_id,'user_id'=>$user_id))->delete('address');
    }

    /*
      添加配送地址
     */

    public function add_addr($data) {
		$this->db->insert('address',$data);
        $ret = $this->db->insert_id();
        return $ret;	       
    }
    /**
     * 修改地址
     */
    public function edit_addr($addr_id=0,$user_id,$data){
        if($addr_id>0){
            return $this->db->where(array('addr_id'=>$addr_id,'user_id'=>$user_id))->update('address',$data);
        }else{
            return $this->db->where(array('user_id'=>$user_id))->update('address',$data);
        }

    }

    /**
     * 获取下级地址信息
     */
    public function get_region($parent_id=0) {
        $this->db->select('region_id,region_name');
        $ret=$this->db->where(array('parent_id' => $parent_id))->get('region')->result_array();
        return $ret;
    }
}
