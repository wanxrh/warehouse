<?php

/**
 *	互联支付接口插件
 *	用互联支付余额支付接口
 */
include('basepayment.php');

class Hulianpay_payment extends Basepayment
{
	public $_gateway	= HLPAY_GATEWAY;//'http://www.weipay.com/Trade/pay';
	public $_code		= 'hulianpay';
	private $_hlpay_key	= HLPAY_KEY;
	private $_hlcharge_key	= HLCHARGE_KEY;
	private $_guarantee_key = HLPAY_KEY;
	private $_charge_to_pay_key = CHARGE_TO_PAY_KEY;
	private $_site		= HLPAY_SITE;
	private $_type_pay		= 12; //订单支付
	private $_type_refund	= 13; //商家退款
	private $_type_finish	= 14; //确认收货
	
	
	/**
	 * 支付表单
	 */
	public function get_payform($orders_info,$payway,$rechargebank){
		if(!$payway){
			$form = $this->charge_payform($orders_info,$rechargebank);
		}else{
			$form = $this->remain_payform($orders_info);
		}
		return $form;
	}
	/**
	 * 支付表单
	 */
	public function get_guaranteeform($guarantee_info,$payway,$rechargebank){
		if(!$payway){
			$form = $this->charge_guaranteeform($guarantee_info,$rechargebank);
		}else{
			$form = $this->remain_guaranteeform($guarantee_info);
		}
		return $form;
	}
	/**
	 * APP支付表单
	 */
	public function get_app_payform($orders_info,$payway,$rechargebank){
		if(!$payway){
			$form = $this->charge_app_payform($orders_info,$rechargebank);
		}else{
			$form = $this->remain_app_payform($orders_info);
		}
		return $form;
	}

	/**
	 * 充值支付表单
	 */
	public function charge_payform($orders_info,$rechargebank){
		$arrayData = array();
		foreach($orders_info as $info){
		$ArrayData = array();
			$ArrayData['orderNumber'] = $info['order_sn'];
			$ArrayData['money'] = $info['real_pay'];
			$ArrayData['title'] = '衣扮网购物支出-'.$info['order_sn'];
			$ArrayData['toUserCode'] = $info['seller_id'];
			$ArrayData['fromUserCode'] = $info['buyer_id'];
			$ArrayData['isHidden'] = false;
			$arrayData[] = $ArrayData;
			$isCombo = false; 
			if($info['cash_id']){
				$CashData = array();
				$CashData['orderNumber'] = $info['order_sn'].'3';
				$CashData['money'] = $info['order_amount'] - $info['real_pay'];
				$CashData['title'] = '衣扮网购物现金券支出-'.$info['order_sn'];
				$CashData['toUserCode'] = $info['seller_id'];
				$CashData['fromUserCode'] = YIBAN_CASH_HLID;
				$CashData['isHidden'] = true;
				$arrayData[] = $CashData;
				$isCombo = true;
			}
		}
		$buyer = array_column($orders_info,'buyer_id');
		$payJsonData = array();
		$payJsonData['site'] = $this->_site;
		$payJsonData['notifyUrl'] = $this->_create_paid_notify_url(base64_encode(json_encode(array_column($orders_info,'order_id'))));
		$payJsonData['returnUrl'] = $this->_create_paid_return_url(base64_encode(json_encode(array_column($orders_info,'order_id'))));
		$payJsonData['payMoney'] = array_sum(array_column($orders_info,'real_pay'));
		$payJsonData['fromUserCode'] = $buyer['0'];
		$payJsonData['isCombo'] = $isCombo;
		$payJsonData['arrayData'] = $arrayData;
		$payJsonData = json_encode($payJsonData,TRUE);
		
		$jsonData = array();
		$jsonData['site'] = $this->_site;
		$jsonData['money'] = array_sum(array_column($orders_info,'real_pay'));
		$jsonData['userCode'] = $buyer['0'];
		$jsonData['title'] = '衣扮网充值支付';
		$jsonData['dateTime'] = date('YmdHis',time());
		$jsonData['notifyUrl'] = '';
		$jsonData['returnUrl'] =$this->_create_paid_return_url(base64_encode(json_encode(array_column($orders_info,'order_id'))));
		$jsonData = json_encode($jsonData,TRUE);
		$sign = MD5($jsonData.NEW_CHARGE_TO_PAY_KEY);
		$paySign = MD5($payJsonData.GUARANTEE_TRADING_KEY);
		$params = array(
				'payJsonData' =>$payJsonData,
				'jsonData'=>$jsonData,
				'payType'=>2,
				'paySign'	=>$paySign,
				'sign'=>	$sign,
				'rechargeBank'=>$rechargebank	
		);
		if($rechargebank == 'WEIXINPAY'){
			$this->_gateway = NEW_HL_WEIXIN_PAY;
		}elseif ($rechargebank == 'EBANK'){
			$this->_gateway = NEW_HL_EBANK_PAY;
			unset($params['rechargeBank']);
		}else{
			$this->_gateway = NEW_HL_CHARGE_TO_PAY;
		}
		
		return $this->_create_payform('POST', $params);
	}
	/**
	 * 充值支付表单
	 */
	public function charge_guaranteeform($guarantee_info,$rechargebank){
		$arrayData = array();
		
		$ArrayDate = array();
		$ArrayDate['orderNumber'] = $guarantee_info['guarantee_sn'];
		$ArrayDate['money'] = $guarantee_info['pay_money'];
		$ArrayDate['title'] = '衣扮网诚信金冻结 - '.$guarantee_info['guarantee_sn'];
		$ArrayDate['toUserCode'] = '2093019150';
		$arrayData[] = $ArrayDate;
		
		
		$payJsonData = array();
		$payJsonData['site'] = $this->_site;
		$payJsonData['notifyUrl'] = $this->_guarantee_notify_url($guarantee_info['store_id']);
		$payJsonData['returnUrl'] = $this->_guarantee_return_url();
		$payJsonData['payMoney'] = $guarantee_info['pay_money'];
		$payJsonData['fromUserCode'] = $guarantee_info['store_id'];
		$payJsonData['arrayData'] = $arrayData;
		$payJsonData = json_encode($payJsonData,TRUE);
	
		$jsonData = array();
		$jsonData['site'] = $this->_site;
		$jsonData['money'] = $guarantee_info['pay_money'];
		$jsonData['userCode'] = $guarantee_info['store_id'];
		$jsonData['title'] = '衣扮网充值支付';
		$jsonData['dateTime'] = date('YmdHis',time());
		$jsonData['notifyUrl'] = '';
		$jsonData['returnUrl'] =$this->_guarantee_return_url();
		$jsonData = json_encode($jsonData,TRUE);
		$sign = MD5($jsonData.NEW_CHARGE_TO_PAY_KEY);
		$paySign = MD5($payJsonData.GUARANTEE_TRADING_KEY);
		$params = array(
				'payJsonData' =>$payJsonData,
				'jsonData'=>$jsonData,
				'payType'=>2,
				'paySign'	=>$paySign,
				'sign'=>	$sign,
				'rechargeBank'=>$rechargebank
		);
		if($rechargebank == 'WEIXINPAY'){
			$this->_gateway = NEW_HL_WEIXIN_PAY;
		}elseif ($rechargebank == 'EBANK'){
			$this->_gateway = NEW_HL_EBANK_PAY;
			unset($params['rechargeBank']);
		}else{
			$this->_gateway = NEW_HL_CHARGE_TO_PAY;
		}
		
		return $this->_create_payform('POST', $params);
	}
	public function remain_guaranteeform($guarantee_info){
	
		$arrayData = array();
		
		$ArrayDate = array();
		$ArrayDate['orderNumber'] = $guarantee_info['guarantee_sn'];
		$ArrayDate['money'] = $guarantee_info['pay_money'];
		$ArrayDate['title'] = '衣扮网诚信金冻结 - '.$guarantee_info['guarantee_sn'];
		$ArrayDate['toUserCode'] = 2093019150;//'2093019150';
		$arrayData[] = $ArrayDate;
		

		$jsondata = array();
		$jsondata['site'] = $this->_site;
		$jsondata['notifyUrl'] = $this->_guarantee_notify_url($guarantee_info['store_id']);
		$jsondata['returnUrl'] = $this->_guarantee_return_url();
		$jsondata['payMoney'] = $guarantee_info['pay_money'];
		$jsondata['fromUserCode'] = $guarantee_info['store_id'];
		$jsondata['createTime'] = date('Y-m-d H:i:s',time());
		$jsondata['arrayData'] = $arrayData;
		$jsonData = json_encode($jsondata,TRUE);
		$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);
	
		$params = array(
				'jsonData' => $jsonData,
				'sign' => $sign
		);
		$this->_gateway = GUARANTEE_TRADING_FREEZE;
		return $this->_create_payform('POST', $params);
	}
	/**
	 *	获取支付表单
	 */
	public function remain_payform($orders_info){
		
		$arrayData = array();
		foreach($orders_info as $info){
			$ArrayData = array();
			$ArrayData['orderNumber'] = $info['order_sn'];
			$ArrayData['money'] = $info['real_pay'];
			$ArrayData['title'] = '衣扮网购物支出-'.$info['order_sn'];
			$ArrayData['toUserCode'] = $info['seller_id'];
			$ArrayData['fromUserCode'] = $info['buyer_id'];
			$ArrayData['isHidden'] = false;
			$arrayData[] = $ArrayData;
			$isCombo = false; 
			if($info['cash_id']){
				$CashData = array();
				$CashData['orderNumber'] = $info['order_sn'].'3';
				$CashData['money'] = $info['order_amount'] - $info['real_pay'];
				$CashData['title'] = '衣扮网购物现金券支出-'.$info['order_sn'];
				$CashData['toUserCode'] = $info['seller_id'];
				$CashData['fromUserCode'] = YIBAN_CASH_HLID;
				$CashData['isHidden'] = true;
				$arrayData[] = $CashData;
				$isCombo = true;
			}
		}
		$buyer = array_column($orders_info,'buyer_id');
		$jsondata = array();
		$jsondata['site'] = $this->_site;
		$jsondata['notifyUrl'] = $this->_create_paid_notify_url(base64_encode(json_encode(array_column($orders_info,'order_id'))));
		$jsondata['returnUrl'] = $this->_create_paid_return_url(base64_encode(json_encode(array_column($orders_info,'order_id'))));
		$jsondata['payMoney'] = array_sum(array_column($orders_info,'real_pay'));
		$jsondata['fromUserCode'] = $buyer['0'];
		$jsondata['createTime'] = date('Y-m-d H:i:s',time());		
		$jsondata['isCombo'] = $isCombo;
		$jsondata['arrayData'] = $arrayData;
		$jsonData = json_encode($jsondata,TRUE);
		$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);
		
		$params = array(
			'jsonData' => $jsonData,
			'sign' => $sign
		);
		$this->_gateway = GUARANTEE_TRADING_FREEZE;
		return $this->_create_payform('POST', $params);
	}
	/**
	 * APP充值支付表单
	 */
	public function charge_app_payform($orders_info,$rechargebank){
		$arrayData = array();
		foreach($orders_info as $info){
			$ArrayData = array();
			$ArrayData['orderNumber'] = $info['order_sn'];
			$ArrayData['money'] = $info['real_pay'];
			$ArrayData['title'] = '衣扮网购物支出-'.$info['order_sn'];
			$ArrayData['toUserCode'] = $info['seller_id'];
			$ArrayData['fromUserCode'] = $info['buyer_id'];
			$ArrayData['isHidden'] = false;
			$arrayData[] = $ArrayData;
			$isCombo = false;
			if($info['cash_id']){
				$CashData = array();
				$CashData['orderNumber'] = $info['order_sn'].'3';
				$CashData['money'] = $info['order_amount'] - $info['real_pay'];
				$CashData['title'] = '衣扮网购物现金券支出-'.$info['order_sn'];
				$CashData['toUserCode'] = $info['seller_id'];
				$CashData['fromUserCode'] = YIBAN_CASH_HLID;
				$CashData['isHidden'] = true;
				$arrayData[] = $CashData;
				$isCombo = true;
			}
		}
		$buyer = array_column($orders_info,'buyer_id');
		$payJsonData = array();
		$payJsonData['site'] = $this->_site;
		$payJsonData['notifyUrl'] = $this->_create_paid_notify_url(base64_encode(json_encode(array_column($orders_info,'order_id'))));
		$payJsonData['returnUrl'] = '';
		$payJsonData['payMoney'] = array_sum(array_column($orders_info,'real_pay'));
		$payJsonData['fromUserCode'] = $buyer['0'];
		$payJsonData['isCombo'] = $isCombo;
		$payJsonData['arrayData'] = $arrayData;
		$payJsonData = json_encode($payJsonData,TRUE);

		$jsonData = array();
		$jsonData['site'] = $this->_site;
		$jsonData['money'] = array_sum(array_column($orders_info,'real_pay'));
		$jsonData['userCode'] = $buyer['0'];
		$jsonData['title'] = '衣扮网充值支付';
		$jsonData['dateTime'] = date('YmdHis',time());
		$jsonData['notifyUrl'] = '';
		$jsonData['returnUrl'] ='1';
		$jsonData = json_encode($jsonData,TRUE);
		$sign = MD5($jsonData.NEW_CHARGE_TO_PAY_KEY);
		$paySign = MD5($payJsonData.GUARANTEE_TRADING_KEY);
		$params = array(
			'payJsonData' =>$payJsonData,
			'jsonData'=>$jsonData,
			'payType'=>2,
			'paySign'	=>$paySign,
			'sign'=>	$sign,
			'rechargeBank'=>$rechargebank
		);
		if($rechargebank == 'WEIXINPAY'){
			$this->_gateway = NEW_HL_APP_WEIXIN_PAY;
		}elseif ($rechargebank == 'EBANK'){
			$this->_gateway = NEW_HL_APP_EBANK_PAY;
			unset($params['rechargeBank']);
		}else{
			$this->_gateway = NEW_HL_APP_CHARGE_TO_PAY;
		}
		$str = $this->_gateway.'?';
		foreach ($params as $k => $v){
			$str .= $k.'='.$v.'&';
		}
		return substr($str, 0,-1);
	}
	/**
	 *	APP获取支付表单
	 */
	public function remain_app_payform($orders_info){

		$arrayData = array();
		foreach($orders_info as $info){
			$ArrayData = array();
			$ArrayData['orderNumber'] = $info['order_sn'];
			$ArrayData['money'] = $info['real_pay'];
			$ArrayData['title'] = '衣扮网购物支出-'.$info['order_sn'];
			$ArrayData['toUserCode'] = $info['seller_id'];
			$ArrayData['fromUserCode'] = $info['buyer_id'];
			$ArrayData['isHidden'] = false;
			$arrayData[] = $ArrayData;
			$isCombo = false;
			if($info['cash_id']){
				$CashData = array();
				$CashData['orderNumber'] = $info['order_sn'].'3';
				$CashData['money'] = $info['order_amount'] - $info['real_pay'];
				$CashData['title'] = '衣扮网购物现金券支出-'.$info['order_sn'];
				$CashData['toUserCode'] = $info['seller_id'];
				$CashData['fromUserCode'] = YIBAN_CASH_HLID;
				$CashData['isHidden'] = true;
				$arrayData[] = $CashData;
				$isCombo = true;
			}
		}
		$buyer = array_column($orders_info,'buyer_id');
		$jsondata = array();
		$jsondata['site'] = $this->_site;
		$jsondata['notifyUrl'] = $this->_create_paid_notify_url(base64_encode(json_encode(array_column($orders_info,'order_id'))));
		$jsondata['returnUrl'] = '';
		$jsondata['payMoney'] = array_sum(array_column($orders_info,'real_pay'));
		$jsondata['fromUserCode'] = $buyer['0'];
		$jsondata['createTime'] = date('Y-m-d H:i:s',time());
		$jsondata['isCombo'] = $isCombo;
		$jsondata['arrayData'] = $arrayData;
		$jsonData = json_encode($jsondata,TRUE);
		$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);

		$params = array(
			'jsonData' => $jsonData,
			'sign' => $sign
		);
		$this->_gateway = APP_GUARANTEE_TRADING_FREEZE;
		$str = $this->_gateway.'?';
		foreach ($params as $k => $v){
			$str .= $k.'='.$v.'&';
		}
		return substr($str, 0,-1);
	}	
	/**
	 * 获取退款表单
	 */
	public function get_refundform($order_info,$goods_info,$refund_money,$shipping){
		
		$ArrayData = array();
		$ArrayData['fromOrder'] = $order_info['order_sn'];
		$ArrayData['orderNumber'] = $order_info['order_sn'].$goods_info['rec_id'].'3';
		$ArrayData['title'] = $goods_info['goods_name'].'-退款';
		$ArrayData['money'] = $refund_money;
		$ArrayData['toUserCode'] = $order_info['buyer_id'];
		$arrayData[] = $ArrayData;
		//判断为完全还是部分退款$complete完全2，部分3
		if( !isset($this->db) ){
			$CI = &get_instance();
			$this->db = $CI ->load->database('zbb', TRUE);
		}
		$complete_order_info = $this->db->where('order_id',$order_info['order_id'])->get('order_goods')->result_array();
		$tip = 0;
		if( count($complete_order_info) == 1 ){
			if( $refund_money == $order_info['real_pay'] ){
				$complete = 1;
			}elseif ( $refund_money < $order_info['real_pay'] && $refund_money >0 ){
				$complete = 0;
				$tip = 1;
				$balance = array();
				$balance['fromOrder'] = $order_info['order_sn'];
				$balance['orderNumber'] = $order_info['order_sn'].'2';
				$balance['title'] = '衣扮网-'.$order_info['order_sn'].'退款余额返还';
				$balance['money'] = bcsub($order_info['real_pay'],$refund_money,2);
				$balance['toUserCode'] = $order_info['seller_id'];
				$balance['isHidden'] = true;
				$arrayData[] = $balance;
			}else{
				return FALSE;
			}
		}else{
			$status = array_column($complete_order_info,'status','rec_id');
			unset($status[$goods_info['rec_id']]);
			$rule = array_intersect($status, array(ORDER_ACCEPTED,ORDER_SHIPPED,ORDER_DRAWBACK,ORDER_RETURNING));
			if( !empty( $rule ) ){
				//非最后一个
				$complete = 0;
			}else{
				
				//重组数组，只获取退款成功的
				$refund_status_arr = array();
				foreach ($status as $key => $val){
					if($val == ORDER_CANCELED){
						$refund_status_arr[] = $key;
					}
				}
				$refunded_money = 0.00;
				if(!empty($refund_status_arr) ){
					$refund_conditions = array(
							'state'=>1,
							'result'=>1,
							'undo'=>0,
							//'end'=>0
					);
					$return_conditions = array(
							'type'=>1,
							'undo'=>0,
							//'end'=>0
					);
					$drawback = $this->db->select('rec_id,refund_money')->where($refund_conditions)->where_in('rec_id',$refund_status_arr)->get('drawback')->result_array();
					$goods_return = $this->db->select('rec_id,refund_money')->where($return_conditions)->where_in('rec_id',$refund_status_arr)->get('goods_return')->result_array();
					
					$refund_money_arr = array();
					if($drawback&& $goods_return){
						foreach (array_column($drawback,'refund_money','rec_id') as $k => $v){
							$refund_money_arr[$k]=$v;
						}
						foreach (array_column($goods_return,'refund_money','rec_id') as $k => $v){
							$refund_money_arr[$k]=$v;
						}
					}else{
						$refund_money_arr = $drawback?array_column($drawback,'refund_money','rec_id'):array_column($goods_return,'refund_money','rec_id');
					}
					$refunded_money = array_sum($refund_money_arr);
				}
							
				//重组确定收货的数组
				$finish_status_arr = array();
				foreach ($status as $key => $val){
					if($val == ORDER_FINISHED){
						$finish_status_arr[] = $key;
					}
				}
				$finish_money = 0.00;
				if(!empty($finish_status_arr)){
					$finish = $this->db->select('discounted_price,rec_id')->where_in('rec_id',$finish_status_arr)->get('order_goods')->result_array();
					$finish_money_arr = array();
					foreach ($finish as $val){
						$finish_money_arr[$val['rec_id']] = $val['discounted_price'];
					}
					$finish_money = array_sum($finish_money_arr);
				}
				$tip_money = bcsub($order_info['real_pay'] , $refund_money + $finish_money +$refunded_money,2);
				if( $tip_money > 0 ){
					$complete = 0;
					$tip = 1;
					$balance = array();
					$balance['fromOrder'] = $order_info['order_sn'];
					$balance['orderNumber'] = $order_info['order_sn'].'2';
					$balance['title'] = '衣扮网-'.$order_info['order_sn'].'退款余额返还';
					$balance['money'] = $tip_money;
					$balance['toUserCode'] = $order_info['seller_id'];
					$balance['isHidden'] = true;
					$arrayData[] = $balance;
				}else{
					$complete = 1;
				}			
			}
		}
		if($order_info['cash_id']){
			$CashData = array();
			$CashData['fromOrder'] = $order_info['order_sn'].'3';
			$CashData['orderNumber'] = $order_info['order_sn'].'3'.$goods_info['rec_id'];
			$CashData['title'] = '衣扮网现金券返还-'.$order_info['order_sn'].$goods_info['rec_id'];
			$CashData['money'] = bcsub($goods_info['price']*$goods_info['quantity'],$goods_info['discounted_price'],2);
			$CashData['toUserCode'] = YIBAN_CASH_HLID;
			$CashData['isHidden'] = true;
			$arrayData[] = $CashData;
		}
		
		$jsondata = array();
		$jsondata['site'] =$this->_site;
		$jsondata['notifyUrl'] = $this->_create_refund_notify_url($goods_info['rec_id']);
		$jsondata['returnUrl'] = $this->_create_refund_return_url($goods_info['rec_id']);
		$jsondata['tradeStatus'] = $complete ? 2 : 3;
		$jsondata['createTime'] = date('Y-m-d H:i:s',time());
		$jsondata['arrayData'] = $arrayData;
		$jsonData = json_encode($jsondata,TRUE);
		$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);
		$params = array(
				'jsonData' => $jsonData,
				'sign' => $sign,
				'balance'=>$tip
		);
		$this->_gateway = GUARANTEE_TRADING_PAY;
		return $this->_create_payform('POST', $params);
	}
	/**
	 * 确认收货
	 * @param 订单详情 $order_info
	 * @param 商品详情 $goods_info
	 * @return 互联支付表单
	 */
	public function get_finishform($order_info,$goods_info,$shipping,$complete){
		//判断技术服务费情况
		$ob = array(
				'1'=>YIBAN_HL_ID,
				'2'=>YIBAN_HL_ID,
				'3'=>YIBAN_HLCHARGE_ID,
				'4'=>YIBAN_HLCHARGE_ID,
				'5'=>YIBAN_HLCHARGE_ID
		);
		$is_free = $this->privilege_free($order_info['seller_id']);
		$arrayData = array();
		$cashmoney = 0;
		foreach ($goods_info as $goods){
				
			$push = array();
			$servicemoney = 0;
			if(!$is_free){
				$service_relation = $this->get_servicemoney_rate($goods['goods_id']);

				$servicemoney = round($goods['price']*$goods['quantity']*$service_relation['2'],2);						
				$ArrayData['fromOrder'] = $order_info['order_sn'];
				$ArrayData['orderNumber'] = $order_info['order_sn'].$goods['rec_id'].'2';
				$ArrayData['title'] = $goods['goods_name'].'-技术服务费';
				$ArrayData['money'] = $servicemoney;
				$ArrayData['isHidden'] = false;
				$ArrayData['toUserCode'] = $ob[$order_info['payment_id']];
				$push[] = $ArrayData;

				//更新技术服务费
				$CI=&get_instance();
				$error = $CI->db->where('rec_id',$goods['rec_id'])->get('service_log')->row_array();
				if(!$error){
					$this->add_service_log($order_info,$goods,$service_relation,$servicemoney);
				}else{
					$CI->db->where('rec_id',$goods['rec_id'])->update('service_log',array('trading_time'=>time(),'service_fee'=>$servicemoney));
				}
			}
			
			$ArrayData['fromOrder'] = $order_info['order_sn'];
			$ArrayData['orderNumber'] = $order_info['order_sn'].$goods['rec_id'].'0';
			$ArrayData['title'] = $goods['goods_name'];
			$ArrayData['money'] = bcsub( $goods['discounted_price'] ,$servicemoney,2);
			$ArrayData['isHidden'] = false;
			$ArrayData['toUserCode'] = $order_info['seller_id'];
			$push[] = $ArrayData;

			krsort($push);
			$arrayData = array_merge($arrayData,$push);
			
			$cashmoney += bcsub($goods['price']*$goods['quantity'],$goods['discounted_price'],2);
		}
		if($cashmoney >0){
			$CashData['fromOrder'] = $order_info['order_sn'].'3';
			$CashData['orderNumber'] = $order_info['order_sn'].'30';
			$CashData['title'] = '衣扮网现金券返款-'.$order_info['order_sn'];
			$CashData['money'] = $cashmoney;
			$CashData['isHidden'] = true;
			$CashData['toUserCode'] = $order_info['seller_id'];
			$arrayData[] = $CashData;
		}
		//邮费参数传递
		if($shipping > 0){
			$arrayData[] = array(
					'fromOrder' => $order_info['order_sn'],
					'orderNumber' => $order_info['order_sn'].'1',
					'title' => '商品邮费-'.$order_info['order_sn'],
					'money' => $shipping,
					'isHidden' => false,
					'toUserCode' => $order_info['seller_id']
			);
		}
		
		$jsondata = array();
		$jsondata['site'] = $this->_site;
		$jsondata['notifyUrl'] = $this->_create_finish_notify_url($order_info['order_id'],array_column($goods_info,'rec_id'));
		$jsondata['returnUrl'] = $this->_create_finished_return_url($order_info['order_id'],base64_encode(json_encode(array_column($goods_info,'rec_id'))));
		$jsondata['tradeStatus'] = 1;
		$jsondata['createTime'] = date('Y-m-d H:i:s',time());
		$jsondata['arrayData'] = $arrayData;
		$jsonData = json_encode($jsondata,TRUE);
		$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);
		
		$params = array(
				'jsonData' => $jsonData,
				'sign' => $sign
		);
		$this->_gateway = GUARANTEE_TRADING_PAY;
		return $this->_create_payform('POST', $params);
	}
	/**
	 * APP确认收货
	 * @param 订单详情 $order_info
	 * @param 商品详情 $goods_info
	 * @return 互联支付表单
	 */
	public function get_app_finishform($order_info,$goods_info,$shipping,$complete){
		//判断技术服务费情况
		$is_free = $this->privilege_free($order_info['seller_id']);
		$arrayData = array();
		foreach ($goods_info as $goods){	
			$push = array();
			$servicemoney = 0;
			if(!$is_free){
				$service_relation = $this->get_servicemoney_rate($goods['goods_id']);
				$servicemoney = bcmul($goods['price'],$service_relation['2'],2);
				$ArrayDate['fromOrder'] = $order_info['order_sn'];
				$ArrayDate['orderNumber'] = $order_info['order_sn'].$goods['rec_id'].'2';
				$ArrayDate['title'] = $goods['goods_name'].'-技术服务费';
				$ArrayDate['money'] = $servicemoney*$goods['quantity'];
				$ArrayDate['toUserCode'] = YIBAN_HL_ID;
				$push[] = $ArrayDate;
				//更新技术服务费
				$CI=&get_instance();
				$error = $CI->db->where('rec_id',$goods['rec_id'])->get('service_log')->row_array();
				if(!$error){
					$this->add_service_log($order_info,$goods,$service_relation,$servicemoney);
				}else{
					$CI->db->where('rec_id',$goods['rec_id'])->update('service_log',array('trading_time'=>time(),'service_fee'=>$servicemoney));
				}
			}
			$ArrayDate['fromOrder'] = $order_info['order_sn'];
			$ArrayDate['orderNumber'] = $order_info['order_sn'].$goods['rec_id'].'0';
			$ArrayDate['title'] = $goods['goods_name'];
			$ArrayDate['money'] = ( $goods['price']-($servicemoney?$servicemoney:0) )*$goods['quantity'];
			$ArrayDate['toUserCode'] = $order_info['seller_id'];
			$push[] = $ArrayDate;
			krsort($push);
			$arrayData = array_merge($arrayData,$push);
		}
		//邮费参数传递
		if($shipping > 0){
			$arrayData[] = array(
					'fromOrder' => $order_info['order_sn'],
					'orderNumber' => $order_info['order_sn'].'1',
					'title' => '商品邮费-'.$order_info['order_sn'],
					'money' => $shipping,
					'toUserCode' => $order_info['seller_id']
			);
		}
	
		$jsondata = array();
		$jsondata['site'] = $this->_site;
		$jsondata['notifyUrl'] = $this->_create_appfinish_notify_url($order_info['order_id'],array_column($goods_info,'rec_id'));
		$jsondata['returnUrl'] = '';
		$jsondata['tradeStatus'] = $complete?1:3;
		$jsondata['arrayData'] = $arrayData;
		$jsonData = json_encode($jsondata,TRUE);
		$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);
	
		$params = array(
				'jsonData' => $jsonData,
				'sign' => $sign
		);
		$this->_gateway = APP_GUARANTEE_TRADING_PAY;
		$str = $this->_gateway.'?';
		foreach ($params as $k => $v){
			$str .= $k.'='.$v.'&';
		}
		return substr($str, 0,-1);
	}
	/**
	 *技术服务费支付中 
	 */
	public function add_service_log($order_info,$goods,$service_relation,$servicemoney){
		$CI=&get_instance();
		$data = array();
		$data['order_id']=$order_info['order_id'];
		$data['rec_id']=$goods['rec_id'];
		$data['store_id']=$order_info['seller_id'];
		$data['service_fee']=$servicemoney;
		$data['cate_type']=$service_relation['1'];
		$data['trading_time']=time();
		$data['payment_id']=$order_info['payment_id'];
		$data['status']=1;//1.支付中 2.支付完成
		$CI->db->insert('service_log',$data);
	}
	
	/**
	 * 店铺是否为免技术服务费
	 */
	public function privilege_free($store_id){
		$CI = &get_instance();
		$this->db = $CI ->load->database('zbb', TRUE);
		//是否为4.1前店铺
		$privilege_free = $this->db->select('privilege_free')->where('store_id',$store_id)->get('store')->row_array();
		if($privilege_free['privilege_free'] == 0){
			return TRUE;
		}
		return FALSE;
	}
	
	/**
	 * 获取技术服务费率
	 */
	public function get_servicemoney_rate($goods_id){
		
		$CI = &get_instance();
		$this->db = $CI ->load->database('zbb', TRUE);
		$this->db->select('shop_gcategory.cate_type')->from('order_goods')->join('goods','order_goods.goods_id = goods.goods_id','left');
		$this->db->join('gcategory','gcategory.cate_id = goods.cate_id','left');
		$reslut =$this->db->where('order_goods.goods_id',$goods_id)->get()->row_array();
		/* $config = array(
			'1'=>'nv',
			'2'=>'nan',
			'3'=>'mama',
			'4'=>'yunfu',
			'5'=>'tong',
		);
		$key = $config[$reslut['cate_type']]?$config[$reslut['cate_type']]:'0';
		$cate = $CI->config->item($key);
		if(!$cate){
			$ret = $this->db->select('percent')->where('cate_type',$reslut['cate_type'])->get('cate_service_relation')->row_array();
			$cate = $ret['percent'];
		} */
		$cate = 0.05;
		return array(
			'1'=>$reslut['cate_type'],
			'2'=>$cate
		);
	}
	
	private function _get_charge_form($order_info, $money)
	{
		$params = array(
				'uid' 			=> $order_info['buyer_id'],
				'type'			=> $this->_site,
				'title' 		=> '商城购物-充值',
				'money'			=> $money,
				'sign'			=> '',
				'backurl'		=> $this->_charge_return_url($order_info['order_id'])
		);
		$params['sign'] = md5($params['uid'].$params['money'].$this->_hlcharge_key);
		$this->_gateway = HLPAY_CHARGE;
		return $this->_create_payform('POST', $params);
	}
	
	/**
	 * 
	 * @param unknown $guarantee_info
	 */
	public function guarantee_return($guarantee_info,$log_info)
	{
		
		try{
			
			$ArrayData = array();
			$ArrayData['fromOrder'] = $guarantee_info['guarantee_sn'];
			$ArrayData['orderNumber'] = $log_info['order_sn'];
			$ArrayData['title'] = '衣扮网诚信金解冻 - '.$log_info['order_sn'];
			$ArrayData['money'] = $guarantee_info['remain_money'];
			$ArrayData['toUserCode'] = $guarantee_info['store_id'];
			$arrayData[] = $ArrayData;
			$jsondata = array();
			$jsondata['site'] =$this->_site;
			$jsondata['notifyUrl'] = '';
			$jsondata['returnUrl'] = '';
			$jsondata['tradeStatus'] = 2;
			$jsondata['createTime'] = date('Y-m-d H:i:s',time());
			$jsondata['arrayData'] = $arrayData;
			$jsonData = json_encode($jsondata,TRUE);
			$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);
			$params = array(
					'jsonData' => $jsonData,
					'sign' => $sign,
			);
			
			$o = '';
			foreach ($params as $k=>$v)
			{
				$o.= "$k=".urlencode($v)."&";//使用字符串比使用数组更稳定;
			}
			$post_data=substr($o,0,-1);
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_HEADER, 0);
			curl_setopt($ch, CURLOPT_POST, TRUE);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);//如果成功只将结果返回，不自动输出任何内容
			curl_setopt($ch, CURLOPT_URL,AUTOMATIC_GUARANTEE_TRADING_PAY);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
			$result =intval( curl_exec($ch) );
			curl_close($ch);
		} catch (Exception $e) {
			$status = 'n';
			$msg = '连接互联支付失败';
        }
        if($result === 1){
        	$status = 'y';
        	$msg = '操作成功';
        }else{
        	$status = 'n';
        	$msg = $result;
        }
        return array('status'=>$status,'msg'=>$msg);
	}
	public function guarantee_deduct($guarantee_info,$log_info,$money)
	{
		$tradeStatus = 1;
		/* if($guarantee_info['remain_money'] > $money){
			$tradeStatus = 3;
		} */
		try{
				
			$ArrayData = array();
			$ArrayData['fromOrder'] = $guarantee_info['guarantee_sn'];
			$ArrayData['orderNumber'] = $log_info['order_sn'];
			$ArrayData['title'] = '衣扮网诚信金扣除 - '.$log_info['order_sn'];
			$ArrayData['money'] = $money;
			$ArrayData['toUserCode'] = 2093019150;
			$arrayData[] = $ArrayData;
			$jsondata = array();
			$jsondata['site'] =$this->_site;
			$jsondata['notifyUrl'] = '';
			$jsondata['returnUrl'] = '';
			$jsondata['tradeStatus'] = $tradeStatus;
			$jsondata['createTime'] = date('Y-m-d H:i:s',time());
			$jsondata['arrayData'] = $arrayData;
			$jsonData = json_encode($jsondata,TRUE);
			$sign = MD5($jsonData.GUARANTEE_TRADING_KEY);
			$params = array(
					'jsonData' => $jsonData,
					'sign' => $sign,
			);
				
			$o = '';
			foreach ($params as $k=>$v)
			{
				$o.= "$k=".urlencode($v)."&";//使用字符串比使用数组更稳定;
			}
			$post_data=substr($o,0,-1);
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_HEADER, 0);
			curl_setopt($ch, CURLOPT_POST, TRUE);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);//如果成功只将结果返回，不自动输出任何内容
			curl_setopt($ch, CURLOPT_URL,AUTOMATIC_GUARANTEE_TRADING_PAY);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
			$result =intval( curl_exec($ch) );
			curl_close($ch);
		} catch (Exception $e) {
			$status = 'n';
			$msg = '连接互联支付失败';
		}
		if($result === 1){
			$status = 'y';
			$msg = '操作成功';
		}else{
			$status = 'n';
			$msg = $result;
		}
		return array('status'=>$status,'msg'=>$msg);
	}
	/**
	 * 查询订单商品信息
	 * @param int $order_info 订单编号
	 */
	private function _get_order_goods($order_id)
	{
		$CI = &get_instance();
		$this->db = $CI ->load->database('zbb', TRUE);
		$order_goods = $this->db->where(array('order_id'=>$order_id))->get('order_goods')->result_array();
		return $order_goods;
		/* $model_ordergoods =& m('ordergoods');
		$order_goods = $model_ordergoods->find("order_id={$order_id}");
		return $order_goods; */
	}
	
	/**
	 * 构建商品数据
	 * @param array $order_goods 订单商品数组
	 * @return string
	 */
	private function _build_authdata($order_goods)
	{
		$auhdata='';
		if (!empty($order_goods) && is_array($order_goods))
		{
			foreach ($order_goods as $rec_id => $goods)
			{
				$auhdata .= $goods['goods_id'].','.$goods['price'].','.$goods['quantity'].';';
			}
			$auhdata = trim($auhdata, ';');
		}
		return $auhdata;
	}
	
	/**
	 * 构建商品名称标题
	 * @param array $order_goods 订单商品数组
	 * @param array $order_info 订单信息
	 * @return string
	 */
	private function _build_guaranteeTitle($order_goods, $order_info, $refund=FALSE)
	{
		$guaranteeTitle='商城购物-';
		if ($refund){
			$guaranteeTitle = '退款-'.$guaranteeTitle;
		}
		if (!empty($order_goods) && is_array($order_goods))
		{
			foreach ($order_goods as $rec_id => $goods)
			{
				$guaranteeTitle .= $goods['goods_name'].'-'.$goods['goods_id'].',';
			}
			$guaranteeTitle = trim($guaranteeTitle, ',');
		}
		return $guaranteeTitle;
	}
	
	/**
	 * 构建邮费标题
	 * @param array $order_goods 订单商品数组
	 * @param array $order_info 订单信息
	 * @return string
	 */
	private function _build_postagetitle($order_goods, $order_info, $refund=FALSE)
	{
		$postagetitle='商城购物-';
		if ($refund) {
			$postagetitle = '退款-'.$postagetitle;
		}
		$postagetitle = $postagetitle . '邮费';
		return $postagetitle;
	}
	
	/**
	 * 构建技术服务费标题
	 */
	private function _build_servicemoney_title($order_goods){
		$servicemoney_title = '衣扮网技术服务费-';
		if (!empty($order_goods) && is_array($order_goods))
		{
			foreach ($order_goods as $rec_id => $goods)
			{
				$servicemoney_title .= $goods['goods_name'].'-'.$goods['goods_id'].',';
			}
			$servicemoney_title = trim($servicemoney_title, ',');
		}
		return $servicemoney_title;
	}

	/**
	 * 返回通知结果
	 */
	public function verify_notify(){
		/* 初始化所需数据 */
		$notify =   $this->_get_notify();
		/* 严格验证 */
		$verify_result = $this->_query_notify($notify);
		if(!$verify_result){
			/* 来路不可信 */
			return FALSE;
		}
		return TRUE;
	}
	
	/**
	 *	返回通知结果
	 *
	 *	@author	Garbin
	 *	@param	 array $order_info
	 *	@param	 bool  $strict
	 *	@return	array
	 */
	public function verify_notify1($order_info, $strict = false)
	{
		if (empty($order_info)){
			//$this->_error('order_info_empty');
			return false;
		}
		/* 初始化所需数据 */
		$notify =   $this->_get_notify();
		/* 验证来路是否可信 */
		if ($strict){
			
			//充值支付，暂时if判断，后期根据全部修改再修改
			if(isset($notify['trade_status']) && $notify['trade_status'] == 'TRADE_PAID'){
				$backsign = MD5( MD5( $notify['jsonData'].$this->_charge_to_pay_key ).$this->_charge_to_pay_key );
				if($backsign != $notify['sign']){
					return false;
				}
				$ArrayData = json_decode($notify['jsonData'],TRUE);
				if ($order_info['order_amount'] != $ArrayData['Money'] ){
					
					return false;
				}
				return array(
						'target'	=>  ORDER_ACCEPTED,
						'action'	=>  'PAID'
				);
			}
			
			/* 严格验证 */
			$verify_result = $this->_query_notify($notify);
			if(!$verify_result){
				/* 来路不可信 */
				//$this->_error('notify_unauthentic');
				return false;
			}
		}
		
		/* 验证通知是否可信 */
		$sign_result = $this->_verify_sign($notify);
		if (!$sign_result){
			/* 若本地签名与网关签名不一致，说明签名不可信 */
			//$this->_error('sign_inconsistent');
			return false;
		}
		
		/* 这里不只是付款通知，有可能是退款通知，确认收货通知 */
		if ($order_info['out_trade_sn'] != $notify['pNo']){
			/* 通知中的订单与欲改变的订单不一致 */
			//$this->_error('order_inconsistent');
			return false;
		}
		if ($order_info['order_amount'] != ($notify['guaranteeMoney']+$notify['postage'])){
			/* 支付的金额与实际金额不一致 */
			//$this->_error('price_inconsistent');
			return false;
		}

		if(isset($notify['serviceMoney'])){
			if(bcmul($order_info['goods_amount'],$this->get_servicemoney_rate($order_info['order_id']),2) != $notify['serviceMoney']){
				return FALSE;
			}
		}
		//至此，说明通知是可信的，订单也是对应的，可信的
		/* 按通知结果返回相应的结果 */
		if(isset($notify['trade_status'])){
			switch ($notify['trade_status']){
				case 'TRADE_PAID':	//买家已付款，等待卖家发货
					$order_status = ORDER_ACCEPTED;
					$order_action = 'PAID';
					break;
				case 'TRADE_FINISHED':	//确认收货，交易结束
					$order_status = ORDER_FINISHED;
					$order_action = 'FINISHED';
					break;
				case 'TRADE_REFUND':	//商家退款，交易关闭
					$order_status = ORDER_CANCELED;
					$order_action = 'REFUND';
					break;
				default:
					$this->_error('undefined_status');
					return false;
			}
		}
		
		if(isset($notify['refund_status'])){
			switch ($notify['refund_status']){
				case 'REFUND_SUCCESS':			  //退款成功，取消订单
					$order_status = ORDER_CANCELED;
					$order_action = 'REFUND';
					break;
			}
		}
	
		return array(
			'target'	=>  $order_status,
			'action'	=>  $order_action,
		);
	}
	
	/**
	 * 返回保证金通知结果
	 */
	public function verify_guarantee_notify($guarantee_info, $strict = false){
		if(!$guarantee_info){
			return FALSE;
		}
		/* 初始化所需数据 */
		$notify =   $this->_get_notify();
		if($strict){
			$backsign = MD5( MD5( $notify['jsonData'].$this->_charge_to_pay_key ).$this->_charge_to_pay_key );
			if($backsign != $notify['sign']){
				return false;
			}
			
			if ($guarantee_info['pay_money'] != $this->_get_guarantee()){
				/* 支付的金额与实际金额不一致 */
				return false;
			}
			
			return array(
					'type'	=>  $type = 1,//（1.收入，2.扣除，3.解冻）后期改用配置常量
					'status'	=>  $status = 1,//（2.申请，1.完成）后期改用配置常量
					'action'	=>  $action = 'GUARANTEE_PAID',
			);
		}
	}
	
	/**
	 * 获取诚信金额
	 */
	public function _get_guarantee(){
		$CI = &get_instance();
		$guarantee = $CI->config->item('guarantee');
		if(!$guarantee){			
			$result = $CI->db->select('key_value')->where('key_name','guarantee')->row_array();
			$guarantee = $result['key_value'];
		}
		return $guarantee;
	}
	/**
	 *	验证通知是否有效
	 *	@param	 string $notify
	 *	@return	string
	 */
/* 	private function _query_notify($notify)
	{
		//互联支付通知校验
		if(!isset($notify['jsonData']) || !isset($notify['sign']) || !isset($notify['notifySign'])){
			return FALSE;
		}
		if(!$notify['jsonData'] || !$notify['sign'] || !$notify['notifySign']){
			return FALSE;
		}
		$query_sign = MD5($notify['jsonData'].GUARANTEE_TRADING_KEY);
		$query_notifysign = MD5($query_sign.GUARANTEE_TRADING_KEY);
		return ( ($notify['sign'] == $query_sign) && ($notify['notifySign'] == $query_notifysign) && !isset($notify['jsonData']['notifyUrl']) );
	}
 */
	/**
	 *	验证通知是否有效
	 *	@param	 string $notify
	 *	@return	string
	 */
	private function _query_notify($notify)
	{
		//互联支付通知校验
		if(!isset($notify['jsonData']) || !isset($notify['sign'])){
			return FALSE;
		}
		if(!$notify['jsonData'] || !$notify['sign']){
			return FALSE;
		}
		$back_jsonData = $notify['jsonData'];
		$back_sign = $notify['sign'];
		return ($back_sign == MD5($back_jsonData.GUARANTEE_TRADING_KEY));
	}
	/**
	 *	验证通知是否有效
	 *	@param	 string $notify
	 *	@return	string
	 */
	private function _query_notify1($notify)
	{
		// 互联支付没有对应的接口暂不做判断
		switch ($notify['trade_status']) {
			case 'TRADE_PAID':
				$local_sign = $this->_get_pay_sign($notify);
				break;
			case 'TRADE_FINISHED':
				$local_sign = $this->_get_finish_sign($notify);
				break;
			case 'TRADE_REFUND':
				$local_sign = $this->_get_refund_sign($notify);
				break;
			default:
				$local_sign = '';
				break;
			
		}
		return ($notify['backsign'] == md5($local_sign . $this->_hlpay_key));
	}

	/**
	 *	获取支付签名字符串
	 *	@param	 array $params
	 *	@return	string
	 */
	private function _get_pay_sign($params)
	{
		return md5($params['uid'].$params['touid'].$params['pNo'].$params['authdata'].$params['guaranteeMoney'].$params['postage'].$this->_site.$this->_hlpay_key);
	}
	
	/**
	 *	获取退款签名字符串
	 *	@param	 array $params
	 *	@return	string
	 */
	private function _get_refund_sign($params)
	{
		return md5($params['uid'].$params['pNo'].$this->_site.$this->_hlpay_key);
	}
	
	/**
	 *	获取确认收货签名字符串
	 *	@param	 array $params
	 *	@return	string
	 */
	private function _get_finish_sign($params)
	{
		return md5($params['uid'].$params['pNo'].$params['guaranteeOrder'].$params['postageOrder'].$this->_site.$this->_hlpay_key);
	}

	/**
	 *	验证签名是否可信
	 *	@param	 array $notify
	 *	@return	bool
	 */
	private function _verify_sign($notify)
	{
		switch ($notify['trade_status']) {
			case 'TRADE_PAID':
				$local_sign = $this->_get_pay_sign($notify);
				break;
			case 'TRADE_FINISHED':
				$local_sign = $this->_get_finish_sign($notify);
				break;
			case 'TRADE_REFUND':
				$local_sign = $this->_get_refund_sign($notify);
				break;	
			default:
				$local_sign = '';
				break;
		}
		return ($local_sign == $notify['key']);
	}

	/**
	 *    将验证结果反馈给网关
	 *    @param     bool   $result
	 *    @return    void
	 */
	public function verify_result($result)
	{
		if ($result)
		{
			echo 'true';
		}
		else
		{
			echo 'false';
		}
	}
	
	/**
	 * 创建充值回调路径
	 * @param number $order_id  订单号ID
	 * @return string
	 */
	private function _charge_return_url($order_id)
	{
		$CI=&get_instance();
		return $CI->config->item('domain_item') . 'cashier?order_id='.$order_id;
	}
	
	/**
	 * 支付通知地址
	 */
	public function _create_paid_notify_url($order){
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/paid?order='.$order;
	}
	
	/**
	 * 确认收货通知地址
	 */
	public function _create_finish_notify_url($order_id,$rec_arr){
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/finished?order='.$order_id.'&rec='.base64_encode(json_encode($rec_arr));
	}
	public function _create_appfinish_notify_url($order_id,$rec_arr){
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/appfinished?order='.base64_encode(json_encode(array('order_id'=>$order_id,'rec'=>implode(',',$rec_arr))));
	}
	/**
	 * 退款通知地址
	 */
	public function _create_refund_notify_url($rec_id){
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/refunded?rec='.$rec_id;
	}
	
	/**
	 *    获取通知地址
	 *    @param     int $store_id
	 *    @param     int $order_id
	 *    @return    string
	 */
	public function _create_notify_url($order_id)
	{
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/notify?order_id='.$order_id;
	}
	
	/**
	 *    获取返回地址
	 *    @param     int $store_id
	 *    @param     int $order_id
	 *    @return    string
	 */
	public function _create_return_url($order_id)
	{
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify?order='.$order_id;
	}
	
	/**
	 * 退款回调地址
	 */
	public function _create_refund_return_url($rec_id){
		$CI=&get_instance();
		return  $CI->config->item('domain_user') . 'seller/order/refund_success?rec='.$rec_id;
	}
	/**
	 * 支付回调地址
	 */
	public function _create_paid_return_url($data){
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/paid_return?order='.$data;
	}
	/**
	 * APP支付回调地址
	 */
	public function _create_app_paid_return_url($data){
		$CI=&get_instance();
		return  $CI->config->item('domain_app') . 'orders/pay_success?order='.$data;
	}
	/**
	 * 确认收货回调地址
	 */
	public function _create_finished_return_url($order_id,$data){
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/finished_return?order='.$order_id.'&rec='.$data;
	}
	/**
	 * APP确认收货回调地址
	 */
	public function _create_app_finished_return_url($order_id){
		$CI=&get_instance();
		return  $CI->config->item('domain_app') . 'orders/finished_success?order='.$order_id;
	}
	
	/**
	 * 保证金通知地址
	 */
	private  function _guarantee_notify_url($store_id){
		$CI=&get_instance();
		return  $CI->config->item('domain_item') . 'paynotify/guaranteed?p='.$store_id;
	}
	/**
	 * 保证金回调地址
	 */
	private  function _guarantee_return_url(){
		$CI=&get_instance();
		return  $CI->config->item('domain_user') . 'seller/guarantee';
	}
	/**
	 * 获取互联支付绑定ID
	 */
	public function _get_hlid($user_id){
		$CI=&get_instance();
		$this->db = $CI ->load->database('zbb', TRUE);
		$result = $this->db->where('yibanID',$user_id)->get('hlbind')->row_array();
		if($result){
			return $result['hlpayID'];
		}
		return $user_id;
	}
}

?>