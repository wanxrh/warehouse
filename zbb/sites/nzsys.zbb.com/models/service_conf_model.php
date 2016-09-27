<?php

/**
 * @name 后台服务费率诚信金的配置
 * @author qzh
 */
class Service_conf_model extends CI_Model {
    /*
     * 继承父级构造方法
     * 实例化两个数据库方法
     */

    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 查看服务费率
     */

    public function percent_get() {
	 $res=$this->db->get('cate_service_relation')->result_array();	
	 return $res;	
     }
	 /*
	  *修改服务费率
	  */
	public function percent_edit($ret) {
	$res=$this->db->update_batch('cate_service_relation', $ret,'cate_type'); 
	$query=$this->db->affected_rows();
    return $query;	
     }
   /**
    * 将诚信存入数据库
    */  
   public function gua_preset($val){
	   $res=$this->db->update_batch('sys_config',$val,'key_name'); 
       $query=$this->db->affected_rows();
       return $query;
   }
   
  /**
   * 获取系统配置表数据
   */ 
  public function get_sys_conf(){
      $result=$this->db->get('sys_config')->result_array();
      return $result;
  }
     
 }
?>
