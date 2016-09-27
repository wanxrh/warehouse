<?php

/*
  用户地址模型
 */

class Address_model extends CI_Model {

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    public function address($page, $offset) {
        $user_id = get_user()['id'];

        $arr['address'] = $this->db->where('user_id', $user_id)
                ->limit($page, $offset)
                ->order_by('addr_id', 'desc')
                ->get('address')
                ->result_array();
        //总数
        $arr['count'] = $this->db->where('user_id', $user_id)->count_all_results('address');

        return $arr;
    }
    
    /**
     * 获取用户所有的地址
     */
    public function get_addrs($user_id){
    	return $this->db->where('user_id',$user_id)->get('address')->result_array();
    }

    /*
      配送删除
     */

    public function delete_addr($id) {
        return $this->db->where('addr_id', $id)->delete('address');
    }

    /*
      添加配送地址
     */

    public function add_addr($data) {
		return $this->db->insert('address',$data);	       
    }
    /**
     * 修改配送方式
     */
    public function set_addr($addr_id,$data){
    	return $this->db->where(array('addr_id'=>$addr_id))->update('address',$data);
    }

    /**
     * 获取所有省
     */
    public function get_provice($parent_id = 0) {
        return $this->db->select('region_id,region_name')->where(array('parent_id' => $parent_id))->get('region')->result_array();
        
    }
    
    /**
     * 获取用户所在三级数组
     */
	public function region($region_id){
		/* $parent_id = $this->db->where(array('region_id'=>$region_id))->select('parent_id')->get('region')->row_array();
		$arr[$k]= $this->db->where(array('parent_id'=>$parent_id['parent_id']))->select('region_id,region_name')->get('region')->result_array();
		if(!empty($arr[$k])){
			self::region($parent_id['parent_id'],$k+1);
		}
		return 	$arr;	 */
		$arr =array();
		$parent_id = $this->db->where(array('region_id'=>$region_id))->select('parent_id')->get('region')->row_array();
		$arr['country'] = $this->db->where(array('parent_id'=>$parent_id['parent_id']))->select('region_id,region_name')->get('region')->result_array();
		
		$c_parent_id = $this->db->where(array('region_id'=>$parent_id['parent_id']))->select('parent_id')->get('region')->row_array();
		$arr['city'] = $this->db->where(array('parent_id'=>$c_parent_id['parent_id']))->select('region_id,region_name')->get('region')->result_array();
		
		$p_parent_id = $this->db->where(array('region_id'=>$c_parent_id['parent_id']))->select('parent_id')->get('region')->row_array();
		$arr['province'] = $this->db->where(array('parent_id'=>$p_parent_id['parent_id']))->select('region_id,region_name')->get('region')->result_array();
		return $arr;
	}
	public function my_region($region_id){
		$arr =array();
		$arr['country'] = $region_id;
		$parent_id = $this->db->where(array('region_id'=>$region_id))->select('parent_id')->get('region')->row_array();
		$arr['city'] = $parent_id['parent_id'];
	
		$parent_id = $this->db->where(array('region_id'=>$arr['city']))->select('parent_id')->get('region')->row_array();
		$arr['province'] = $parent_id['parent_id'];
		return $arr;
	}
    /**
     * 获取指定地址
     */
    public function one_addr($id) {
        return $this->db->where('addr_id', $id)->get('address')->row_array();
    }

    /**
     * 获取指定地址
     */
    public function set_default($id) {
        //判断地址id是否为本人的
        $ret = $this->db->get_where('address', array('addr_id' => $id, 'user_id' => get_user()['id']))->row_array();
        if ($ret) {
            //先把所有的取消默认
            $this->db->where('user_id', get_user()['id'])->update('address', array('is_default' => 0));
            //设置当前为默认
            $this->db->where('addr_id', $id)->update('address', array('is_default' => 1));
            return TRUE;
        } else {
            return FALSE;
        }
    }
    /**
     * 根据条件查询地域
     */
	public function get_region($data){
		$res=$this->db->get_where('region',$data)->result_array();
		return $res;
	}
	
	/**
	 * 获得默认地址
	 */
	public function get_default() {
		$user_id = get_user()['id'];
		return $this->db
			->select('addr_id')
			->where('user_id', $user_id)
			->where('is_default', '1')
			->get('address')->row_array();
	}
}
