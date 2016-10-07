<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require "BaseModel.php";
class AgentModel extends BaseModel {
	public function __construct()
	{
		parent::__construct();
	}
	public function getQrcodeOpenId($id,$code){
		return $this->getRow('shop_qrcode',array('id'=>$id),'id,openid');
	}
	public function getAgentInfo($openid){
		return $this->getRow('shop_qrcode',array('openid'=>$openid));
	}
	public function activatQrcode($id,$code,$openid,$mobile){
		$this->db->trans_begin();		
		$condition = array(
			'id'=>$id,
			'activatcode'=>$code,
			'openid'=>''
		);
		$this->db->where($condition)->update('shop_qrcode',array('openid'=>$openid,'mobile'=>$mobile,'agenttime'=>time()));
		$this->insert('shop_agent_balance', array('agent_openid'=>$openid));
		
		if ($this->db->trans_status() === FALSE)
		{
			$this->db->trans_rollback();
			return FALSE;
		}
		else
		{
			$this->db->trans_commit();
			return TRUE;
		}		
	}
	public function initQrcodeOnline($openid,$mobile){
		$this->insert('shop_qrcode', array('openid'=>$openid,'mobile'=>$mobile,'cTime'=>time()) );
		return $this->db->insert_id();
	}
	public function activatQrcodeOnline($id,$openid,$ticket,$focus_url){
		$this->db->trans_begin();
		
		$this->update('shop_qrcode', array('id'=>$id), array('focus_url'=>$focus_url,'ticket'=>$ticket,'agenttime'=>time()));
		
		$this->insert('shop_agent_balance', array('agent_openid'=>$openid));
	
		if ($this->db->trans_status() === FALSE)
		{
			$this->db->trans_rollback();
			return FALSE;
		}
		else
		{
			$this->db->trans_commit();
			return TRUE;
		}
	}
	public function getAgentBalance($openid){
		return $this->getRow('shop_agent_balance',array('agent_openid'=>$openid),'balance');
	}
	public function getFocusNum($openid){
		$today = strtotime(date('Y-m-d',time()));
		$condition = array(
			'agent_openid'=>$openid,
			'bind_time >= '=>$today,
			'bind_time <= '=>$today+86400
		);
		$result['today'] = $this->db->where($condition)->count_all_results('shop_bind');
		$result['total'] = $this->db->where(array('agent_openid'=>$openid))->count_all_results('shop_bind');
		return $result;
	}
	public function getCommissionLog($openid){
		$today = strtotime(date('Y-m-d',time()))-7*86400;
		$condition = array(
				'agent_openid'=>$openid,
				'time >= '=>$today
		);
		$this->db->order_by('time','DESC');
		return $this->getRows('shop_commission_log',$condition);
	}
	public function applyCach($openid,$alipay,$money){
		$this->db->trans_begin();
		$this->db->set('balance','balance - '.$money,false)->where('agent_openid',$openid)->update('shop_agent_balance');
		$this->db->insert('shop_cash',array(
			'openid'=>$openid,
			'apply_time'=>time(),
			'alipay'=>$alipay,
			'apply_money'=>$money
		));
		if ($this->db->trans_status() === FALSE)
		{
			$this->db->trans_rollback();
			return FALSE;
		}
		else
		{
			$this->db->trans_commit();
			return TRUE;
		}
	}
}
