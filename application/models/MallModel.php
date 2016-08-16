<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require "BaseModel.php";
class MallModel extends BaseModel {
	public function __construct()
	{
		parent::__construct();
	}
	public function banner(){
		return $this->db->where('is_show',1)->order_by('sort')->get('shop_slideshow')->result_array();
	}
	public function getRecommendList(){
		$this->db->order_by('sort','ASC');
		return $this->getRows('shop_goods',array('is_show'=>1,'is_recommend'=>1),'id,title,price,cover');
	}
	public function goodsList(){
		$this->db->order_by('sort','ASC');
		return $this->db->select('id,title,price,cover')->where(array('is_show'=>1))->limit(20)->order_by('sale_count','desc')->get('shop_goods')->result_array();
	}
	public function getCategory(){
		return $this->db->select('id,title')->where(array('is_show'=>1))->order_by('sort','asc')->get('shop_goods_category')->result_array();
	}
	public function getGoodsInfo($goods_id){
		return $this->getRow('shop_goods',array('id'=>$goods_id,'is_show'=>1));
	}
	public function evaluation($goods_id){
		return $this->getRow('shop_goods_evaluation',array('goods_id'=>$goods_id));
	}
	public function goodsEvaluation($goods_id,$type){
		 return $this->getRows('shop_evaluation',array('goods_id'=>$goods_id,'status'=>$type));
	}
	public function addCollect($user_id,$goods_id){
		$result = $this->getRow('shop_collect', array('goods_id'=>$goods_id,'uid'=>$user_id));
		if(!$result){
			$this->insert('shop_collect', array('goods_id'=>$goods_id,'uid'=>$user_id,'cTime'=>time()));
		}		
	}
	public function addCart($user_id,$goods,$num){
		$result = $this->getRow('shop_cart',array('uid'=>$user_id,'goods_id'=>$goods['id']));
		if($result){
			$this->db->where( array('uid'=>$user_id,'goods_id'=>$goods['id']) )->set('num','num +'.$num,FALSE)->update('shop_cart');
		}else{
			$this->insert('shop_cart', array(
					'uid'=>$user_id,
					'goods_id'=>$goods['id'],
					'num'=>$num,
					'price'=>$goods['price']
			));
		}				
		return $this->getCartCount($user_id);
	}
	public function getCartCount($user_id){
		$this->db->where(array(
			'uid'=>$user_id,
			'inventory >'=>0,
			'is_show'=>1
		));
		return $this->db->join('shop_goods','shop_goods.id = shop_cart.goods_id','inner')->count_all_results('shop_cart');
	}
	public function cartList($user_id){
		$this->db->where(array(
				'uid'=>$user_id,
				'inventory >'=>0,
				'is_show'=>1
		));
		return $this->db->select('shop_goods.price,shop_goods.title,shop_goods.cover,shop_cart.num,shop_cart.id,shop_cart.goods_id')->join('shop_goods','shop_goods.id = shop_cart.goods_id','inner')->get('shop_cart')->result_array();
	}
	public function delCart($user_id,$ids){
		$this->db->where_in('id',$ids)->delete('shop_cart');
		return $this->db->affected_rows();
	}
	public function getMyCollect($user_id){
		$this->db->where(array(
				'uid'=>$user_id,
				'inventory >'=>0,
				'is_show'=>1
		));
		return $this->db->select('shop_goods.price,shop_goods.title,shop_goods.cover,shop_goods.id')->join('shop_goods','shop_goods.id = shop_collect.goods_id','inner')->get('shop_collect')->result_array();
	}
	public function getMyAddress($user_id){
		return $this->getRows('shop_address',array('uid'=>$user_id));
	}
	public function getAddressInfo($user_id,$id){
		return $this->getRow('shop_address',array('uid'=>$user_id,'id'=>$id));
	}
	public function dealAddress($id,$data){
		if($id){
			if($data['is_use']){
				$this->update('shop_address', array('uid'=>$data['uid']), array('is_use'=>0));
			}
			$this->update('shop_address', array('id'=>$id), $data);
		}else{
			$this->insert('shop_address', $data);
		}
		return $this->db->affected_rows();
	}
	public function region($region_id,&$init,&$my){
		
		if(!$region_id){
						
			$init['provice'] = $this->getRows('shop_nation',array('parent'=>0),'id,name');
			
		}else{
			$result = $this->getRow('shop_nation',array('id'=>$region_id),'parent');
			if($result){
				if( !$init['provice'] && !$init['city'] && !$init['country'] ){
					$my['country'] = $region_id;
					$init['country'] = $this->getRows('shop_nation',array('parent'=>$result['parent']),'id,name');
					
				}elseif ( !$init['city'] && !$init['city'] && $init['country'] ){
					$my['city'] = $region_id;
					$init['city'] = $this->getRows('shop_nation',array('parent'=>$result['parent']),'id,name');
					
				}elseif ( !$init['provice'] && $init['city'] && $init['country'] ){
					$my['provice'] = $region_id;
					$init['provice'] = $this->getRows('shop_nation',array('parent'=>$result['parent']),'id,name');
					
				}
				$this->region($result['parent'],$init,$my);
			}
		}
		return TRUE;
	}
	public function ajaxRegion($parent_id){
		return $this->getRows('shop_nation',array('parent' => $parent_id),'id,name');
	}
	public function getOrderAddress($user_id){
		$this->db->order_by('is_use desc,id desc');
		return $this->getRow('shop_address',array('uid'=>$user_id));
	}
	public function confirmOrderGood($goods_id){
		return $this->getRows('shop_goods',array('id'=>$goods_id),'id,cover,title,price,commission');
	}
	public function confirmOrderGoods($goods_ids){
		return $this->db->select('id,cover,title,price,commission')->where_in('id',$goods_ids)->get('shop_goods')->result_array();
	}
	public function createOrder($data){
		$this->insert('shop_order', $data);
		return $this->db->insert_id();
	}
	public function delUserCart($uid,$ids){
		$this->db->where_in('goods_id',$ids)->where('uid',$uid)->delete('shop_cart');
		return $this->db->affected_rows();
	}
	public function getOrderList($condition){
	    $this->db->where('pay_type <> ',11);
		$this->db->order_by('id','desc');
		$result = $this->getRows('shop_order',$condition);
		
		return $result;
	}
	public function getOrderInfo($conditon){
		return $this->getRow('shop_order',$conditon);
	}
	public function getOrderLog($order_id){
		$this->db->order_by('status_code desc,cTime desc');
		return $this->getRows('shop_order_log',array('order_id'=>$order_id));
	}
	public function updateOrderPay($condition,$data){
		$this->update('shop_order', $condition, $data);
	}
	public function getPaymentOrder($condition){
		return $this->getRow('payment_order',$condition);
	}
	public function addPaymentOrder($data){
		$this->insert('payment_order', $data);
		return $this->db->insert_id();
	}
	public function searchGoodsLists($search_key,$cate,$order_key,$order_type){
		if($search_key){
			$this->db->like('title',$search_key);
		}
		if($cate){
			$this->db->where('category_id',$cate);
		}
		if($order_key && $order_type){
			$this->db->order_by($order_key,$order_type);
		}else{
			$this->db->order_by('sort','ASC');
		}
		$this->db->select('id,title,price,cover')->where(array('is_show'=>1));
		return $this->db->get('shop_goods')->result_array();
	}
	public function commentGoods($user_id,$order_info,$goods_id,$status,$evaluation_msg){
		//开启事务
		$this->db->trans_start();
		$this->db->where('goods_id',$goods_id)->set('score','score + '.$status,FALSE);
		$this->db->set('people','people + 1',FALSE);
		switch ($status) {
			case 0:
				$this->db->set('bad','bad + 1',FALSE);
			break;
			case 1:
				$this->db->set('normal','normal + 1',FALSE);;
			break;
			case 2:
				$this->db->set('best','best + 1',FALSE);;
			break;
			default:
			break;
		}
		$this->db->update('shop_goods_evaluation');
		if($evaluation_msg){
			$this->db->insert('shop_evaluation',array(
				'goods_id'=>$goods_id,
				'order_id'=>$order_info['id'],
				'buyer_openid'=>$user_id,
				'user_name'=>$order_info['username'],
				'status'=>$status,
				'msg'=>$evaluation_msg,
				'datetime'=>time()
			));
		}
		$goods_arr = json_decode($order_info['goods_datas'],TRUE);
		foreach ($goods_arr as $k=>$v){
			if( $v['id'] ==$goods_id ){
				$goods_arr[$k]['evaluation'] = array(
					'status'=>$status,
					'msg'=>$evaluation_msg
				);
			}
			$this->db->where('id',$order_info['id'])->update('shop_order',array('goods_datas'=>json_encode($goods_arr,TRUE)));
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

	public function get_coupon($uid){
	    $this->db->where('owner_id',$uid);
        $this->db->join('shop_order','shop_order.id = shop_coupon.order_id','inner');
        return $this->db->get('shop_coupon')->result_array();
    }

    public function coupon_view($condition)
    {
        return $this->getRow('shop_coupon',$condition);
    }
}
