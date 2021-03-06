<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require "BaseModel.php";
class PayModel extends BaseModel {
	public function __construct()
	{
		parent::__construct();
	}
	public function change_order_status($order_number){
		//开启事务
		$this->db->trans_start();
		
		$order = $this->getRow('shop_order',array('order_number'=>$order_number),'id,goods_datas,coupon,order_number,cTime,uid');
		$this->update('payment_order', array('single_orderid'=>$order_number), array('status'=>1));
		$this->update('shop_order', array('id'=>$order['id']), array('pay_status'=>1));
		foreach (json_decode($order['goods_datas'],TRUE) as $v){
			$this->db->where('id',$v['id'])->set('sale_count','sale_count+'.$v['num'],FALSE)->update('shop_goods');
		}
		$this->setStatusCode($order['id'],1);
        if($order['delivery'] == 2){
            $coupon = array(
                'owner_id'=>$order['uid'],
                'sign'=>md5($order['id'].$order['order_number'].$order['cTime'].$order['uid'].$order['uid']),
                'order_id'=>$order['id'],
                'get_time'=>time()
            );
            $this->insert('shop_coupon',$coupon);
        }
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
