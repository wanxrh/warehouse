<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require "BaseModel.php";
class EventModel extends BaseModel {
	public function __construct()
	{
		parent::__construct();
	}
	public function getQrcodeInfo($id){
		return $this->getRow('shop_qrcode',array('id'=>$id));
	}
	public function bindAgent($agent_id,$user_id){
		$ret = $this->getBindInfo($user_id);
		if(!$ret){
			$data = array(
					'agent_openid'=>	$agent_id,
					'from_user_openid'=>$user_id,
					'bind_time'=>time()
			);
			$this->insert('shop_bind', $data);
			return $this->db->insert_id();
		}		
	}
	public function getBindInfo($from_user_id){
		return $this->getRow('shop_bind',array('from_user_openid'=>$from_user_id));
	}
	public function cancelBind($id){
		$this->delete('shop_bind', array('id'=>$id));
		return $this->db->affected_rows();
	}
}
