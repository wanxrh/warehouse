<?php
defined('BASEPATH') OR exit('No direct script access allowed');

//require "BaseModel.php";
class CommissionModel extends BaseModel {
	public function __construct()
	{
		parent::__construct();
	}
	public function commissionAction($order_id){
				
		$order = $this->getRow('shop_order',array('id'=>$order_id),'uid,order_number,total_price,wages');
		$agent = $this->getRow('shop_bind',array('from_user_openid'=>$order['uid']),'agent_openid');
		if($agent){
			$this->db->trans_begin();
			
			$this->db->where('agent_openid',$agent['agent_openid'])->set('balance','balance +'.$order['wages'],FALSE)->update('shop_agent_balance');
			$this->db->insert('shop_commission_log',array(
				'agent_openid'=>$agent['agent_openid'],
				'order_id'=>$order_id,					
				//'msg'=>'您从****'.substr($order['order_number'], 16).'订单(总价'.$order['total_price'].'元)中获得'.$order['wages'].'元佣金',
				'msg'=>'您从*'.substr($order['order_number'], 16).'订单中获得'.$order['wages'].'元佣金',
				'time'=>time()
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
		return TRUE;
	}
}
