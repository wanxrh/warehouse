<?php

/**
 * 首页模型
 * @author feimo
 * @version 2013-10
 */
class Home_model extends CI_Model {

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 顶部广告
     */
    public function get_info() {
        $data = $this->db->select('*')->limit(20)->get('goods')->result_array();
        return $data;
    }

    /*
     * 商品数
     */

    public function today_goods($day_start, $day_end) {
		if(!empty($day_start)){
        $this->db->where('add_time >', $day_start);
		}
		if(!empty($day_end)){
        $this->db->where('add_time <', $day_end);
		}
        $res = $this->db->count_all_results('goods');
        return $res;
    }

    /*
     * 已支付
     */

    public function xin_pay($day_start, $day_end) {
		if(!empty($day_start)){
        $this->db->where('pay_time >', $day_start);
		}
		if(!empty($day_end)){
        $this->db->where('pay_time <', $day_end);
		}
        $res = $this->db->select_sum('order_amount')->get('order')->row_array();
        return $res;
    }
     
	 /*
     * 衣扮网注册量
     */

    public function yiban_reg($day_start, $day_end) {
		if(!empty($day_start)){
        $this->db->where('reg_time >', $day_start);
		}
		if(!empty($day_end)){
        $this->db->where('reg_time <', $day_end);
		}
		$this->db->where('reg_site',1);
        $res = $this->db->count_all_results('member');
        return $res;
    }

 
    /*
     * 商铺
     */

    public function xin_store($day_start, $day_end) {
		if(!empty($day_start)){
        $this->db->where('add_time >', $day_start);
		}
		if(!empty($day_end)){
        $this->db->where('add_time <', $day_end);
		}
        $res = $this->db->count_all_results('store');
        return $res;
    }
	
	 /*
     * 衣扮网登录人数
     */

    public function yinban_log($day_start, $day_end) {
		if(!empty($day_start)){
        $this->db->where('last_login >', $day_start);
		}
		if(!empty($day_end)){
        $this->db->where('last_login <', $day_end);
		}
        $res = $this->db->count_all_results('member');
        return $res;
    }
	
	

    public function level_id($user_id){
        $row = $this->db->get_where('level_user', array('user_id' => $user_id))->row_array();
        empty($row) ? $row['level_id'] = '' : $row;
        $data['level_id'] = explode(',', $row['level_id']);
        return $data;
    }
}
