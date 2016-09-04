<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require "BaseModel.php";
class AdminModel extends BaseModel {
	public function __construct()
	{
		parent::__construct();
	}
	public function goodsList($keyword,$per_page, $offset){
		if($keyword){
			$this->db->like('shop_goods.title',$keyword);
		}
		$clone = clone($this->db);
		
		$this->db->select('shop_goods.id,shop_goods.cover,shop_goods.title,shop_goods.price,shop_goods.inventory,shop_goods.sale_count,shop_goods.sale_count,shop_goods.is_show,shop_goods.sort,shop_goods_category.title as gtitle');
		$this->db->join('shop_goods_category','shop_goods_category.id = shop_goods.category_id','left');
		$result['list'] = $this->db->limit($per_page, $offset)->order_by('id','desc')->get('shop_goods')->result_array();
		$this->db = $clone;
		$result['total'] = $this->db->count_all_results('shop_goods');
		return $result;
	}
	public function categoryList($keyword,$per_page, $offset){
		if($keyword){
			$this->db->like('title',$keyword);
		}
		$clone = clone($this->db);
		
		$result['list'] = $this->db->limit($per_page, $offset)->order_by('sort','asc')->get('shop_goods_category')->result_array();
		$this->db = $clone;
		$result['total'] = $this->db->count_all_results('shop_goods_category');
		return $result;
	}
	public function setGoodsShow($goods_id){
		$info = $this->getRow('shop_goods',array('id'=>$goods_id),'is_show');
		if(!$info){
			return FALSE;
		}
		$change = $info['is_show']?0:1;
		$this->update('shop_goods', array('id'=>$goods_id), array('is_show'=>$change));
		return $this->db->affected_rows();
	}
	public function delGoods($goods_id){
		$this->delete('shop_goods', array('id'=>$goods_id));
		return $this->db->affected_rows();
	}
	public function delCategory($cate_id){
		$this->delete('shop_goods_category', array('id'=>$cate_id));
		return $this->db->affected_rows();
	}
	public function delMoreGoods($ids){
		$this->db->where_in('id',$ids)->delete('shop_goods');
		return $this->db->affected_rows();
	}
	public function delMoreCategorys($ids){
		$this->db->where_in('id',$ids)->delete('shop_goods_category');
		return $this->db->affected_rows();
	}
	public function getCategory(){
		return $this->db->select('id,title')->where(array('is_show'=>1))->order_by('sort','asc')->get('shop_goods_category')->result_array();
	}
	public function getCategoryInfo($cate_id){
		return $this->getRow('shop_goods_category',array('id'=>$cate_id));
	}
	public function addGoods($data){
		$this->insert('shop_goods', $data);
		$goods_id = $this->db->insert_id();
		$this->insert('shop_goods_evaluation', array('goods_id'=>$goods_id));
		return $this->db->affected_rows();
	}
	public function addCategory($data){
		$this->insert('shop_goods_category', $data);
		$goods_id = $this->db->insert_id();
		return $this->db->affected_rows();
	}
	public function getGoodsInfo($goods_id){
		return $this->getRow('shop_goods',array('id'=>$goods_id));
	}
	public function updateGoodsInfo($goods_id,$data){
		$this->update('shop_goods', array('id'=>$goods_id), $data);
		return $this->db->affected_rows();
	}
	public function updateCategoryInfo($id,$data){
		$this->update('shop_goods_category', array('id'=>$id), $data);
		return $this->db->affected_rows();
	}
	public function getSlideShow(){
		$this->db->order_by('sort','asc');
		return $this->getRows('shop_slideshow');
	}
	public function slideShowInfo($id){
		return $this->getRow('shop_slideshow',array('id'=>$id));
	}
	public function updateSlideShow($id,$data){
		$this->update('shop_slideshow', array('id'=>$id), $data);
		return $this->db->affected_rows();
	}
	public function addSlide($data){
		$this->insert('shop_slideshow', $data);
		return $this->db->affected_rows();
	}
	public function delSlideShow($id){
		$this->delete('shop_slideshow', array('id'=>$id));
		return $this->db->affected_rows();
	}
	public function delMoreSlideShow($ids){
		$this->db->where_in('id',$ids)->delete('shop_slideshow');
		return $this->db->affected_rows();
	}
	public function orderList($keyword,$per_page, $offset){
		if($keyword){
			if(is_numeric($keyword)){
				$this->db->where('order_number',$keyword);
			}else{
				$this->db->like('username',$keyword);
			}
		}
		$clone = clone($this->db);
	
		$this->db->select('id,goods_datas,username,order_number,total_price,pay_type,status_code,cTime');
		$result['list'] = $this->db->limit($per_page, $offset)->order_by('cTime','desc')->get('shop_order')->result_array();
		$this->db = $clone;
		$result['total'] = $this->db->count_all_results('shop_order');
		return $result;
	}
	public function setStatusCode($order_id,$code){
		$this->update('shop_order', array('id'=>$order_id), array('status_code'=>$code));
		return $this->db->affected_rows();
	}
	public function getOrderInfo($id){
		return $this->getRow('shop_order',array('id'=>$id));
	}
	public function getAddressInfo($address_id){
		return $this->getRow('shop_address',array('id'=>$address_id));
	}
	public function updateOrder($id,$data,$pay = FALSE){
		//开启事务
		$this->db->trans_start();
		
		$this->update('shop_order', array('id'=>$id), $data);
		if($pay){
			$info = $this->getRow('shop_order',array('id'=>$id),'goods_datas');
			foreach (json_decode($info['goods_datas'],TRUE) as $v){
				$this->db->where('id',$v['id'])->set('sale_count','sale_count+'.$v['num'],FALSE)->update('shop_goods');
			}
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
	public function qrcodeList($mobile,$per_page, $offset){
		if($mobile){
			$this->db->where('mobile',$mobile);
		}
		$this->db->join('shop_agent_balance','shop_agent_balance.agent_openid = shop_qrcode.openid','left');
		$clone = clone($this->db);
		$result['list'] = $this->db->select('shop_agent_balance.balance,shop_qrcode.id,shop_qrcode.openid,shop_qrcode.agenttime,shop_qrcode.mobile')->limit($per_page, $offset)->get('shop_qrcode')->result_array();
		$this->db = $clone;
		$result['total'] = $this->db->count_all_results('shop_qrcode');
		return $result;
	}
	public function billList($openid,$order_sn,$per_page, $offset){
		if($order_sn){
			$this->db->where('order_number',$order_sn);
		}
		$this->db->where('agent_openid',$openid)->join('shop_order','shop_order.id = shop_commission_log.order_id','inner');
		$clone = clone($this->db);
		$result['list'] = $this->db->select('shop_order.id,order_number,goods_datas,total_price,wages,pay_type,username')->where('agent_openid',$openid)->order_by('time','DESC')->limit($per_page, $offset)->get('shop_commission_log')->result_array();
		$this->db = $clone;
		$result['total'] = $this->db->count_all_results('shop_commission_log');
		return $result;
	}
	public function createQrcode(){
		$this->insert('shop_qrcode', array('cTime'=>time()));
		return $this->db->insert_id();
	}
	public function updateQrcodeInfo($id,$data){
		$this->update('shop_qrcode', array('id'=>$id), $data);
		return $this->db->affected_rows();
	}
	public function getQrcodeInfo($id){
		return $this->getRow('shop_qrcode',array('id'=>$id));
	}
	public function updateQrcode($id,$data){
		$this->update('shop_qrcode', array('id'=>$id), $data);
		return $this->db->affected_rows();
	}
	public function getOrderIds($condition){
		return $this->getRows('shop_order',$condition,'id');
	}
	public function getUnfinishLogId($ids,$map){
		return $this->db->select('order_id')->where_in('order_id',$ids)->where($map)->get('shop_order_log')->result_array();
	}
	public function getAgentBalance($openid){
		return $this->getRow('shop_agent_balance',array('agent_openid'=>$openid),'balance');
	}
	public function cashList($status,$per_page, $offset){
		if($status){
			$this->db->where('status',$status);
		}
		$clone = clone($this->db);

		$result['list'] = $this->db->limit($per_page, $offset)->order_by('id','desc')->get('shop_cash')->result_array();
		$this->db = $clone;
		$result['total'] = $this->db->count_all_results('shop_cash');
		return $result;
	}
	public function cashInfo($consfiton){
		return $this->getRow('shop_cash',$consfiton);
	}
	public function confirmCash($consfiton,$data){
		$this->update('shop_cash',$consfiton,$data);
		return $this->db->affected_rows();
	}
	public function productList($per_page,$offset){
        $result['list'] = $this->db->limit($per_page, $offset)->order_by('id','desc')->get('shop_source')->result_array();
        $result['total'] = $this->db->count_all_results('shop_source');
        return $result;
    }
    public function delProduct($ids){
        $this->db->where_in('id',$ids)->delete('shop_product');
        return $this->db->affected_rows();
    }
    //商品兑换卷
    public function shop_voucher($keyword,$per_page, $offset){
        if($keyword){
            if(is_numeric($keyword)){
                $this->db->where('goods_id',$keyword);
            }
        }
        $clone = clone($this->db);

        $this->db->select('*');
        $result['list'] = $this->db->limit($per_page, $offset)->order_by('id','desc')->get('shop_voucherinfo')->result_array();
        $this->db = $clone;
        $result['total'] = $this->db->count_all_results('shop_voucherinfo');
        return $result;
    }
    //批量删除
    public function delVouchert($ids){
        $this->db->where_in('id',$ids)->delete('shop_voucherinfo');
        return $this->db->affected_rows();
    }
    public function shop_daili_store($openid,$per_page,$offset){
        if($openid){
            $this->db->where('open_id',$openid);
        }
        $this->db->join('shop_order','shop_order.id = shop_commission_log.order_id','inner');
        $clone = clone($this->db);
        $result['list'] = $this->db->select('shop_order.id,order_number,goods_datas,total_price,wages,pay_type,username')->where('agent_openid',$openid)->order_by('time','DESC')->limit($per_page, $offset)->get('shop_commission_log')->result_array();
        $this->db = $clone;
        $result['total'] = $this->db->count_all_results('shop_commission_log');
        return $result;
    }
}
