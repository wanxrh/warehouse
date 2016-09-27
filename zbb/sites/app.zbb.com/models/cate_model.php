<?php

/**
 * 商品模型
 */
require "app_model.php";

class Cate_model extends App_model
{
    public function __construct()
    {
        parent::__construct();
    }
    /*
    首页图片
     */
    public function get_img($cid){
        $this->db->select('id,cid,img,title');
        if(is_array($cid)){
            $this->db->where_in('cid',$cid);
        }else{
            $this->db->where('cid',$cid);
        }
        $ret=$this->db->order_by('dateline','asc')->get('common_link')->result_array();
        return $ret;
    }
    /*
	 *分类
	 */
    public function get_cate(){
        $result = $this->db->select('cate_id,cate_name,cate_images')->where('parent_id',0)->where('store_id',0)->order_by('sort_order', 'asc')->get('gcategory')->result_array();
        return $result;
    }
    /*
     * 分类商品
     */
    public function get_goods($cate_id='',$type=0,$max_sort,$min_sort,$keyword='',$per_nums,$offset){

        if(!empty($cate_id)){
            $this->db->select('goods_id')->where('cate_id',$cate_id);
            $ids_arr=$this->db->get('goods_cate')->result_array();
            if(empty($ids_arr)) return false;
            $cate_ids=array_column($ids_arr, 'goods_id');
            $this->db->where_in('goods.goods_id',$cate_ids);
        }
        $this->db->from('goods');
        $this->db->select('goods.goods_id,goods.goods_name,goods.price,goods.cost_price,goods.default_image');
        if($keyword!=''){
            $this->db->like('goods.goods_name',$keyword);
        }

        if($max_sort==0 && $min_sort==0){
            switch ($type){
                case '0'://人气
                    $this->db->join('goods_stat','goods_stat.goods_id=goods.goods_id','left');
                    $this->db->order_by('goods_stat.views','desc');
                    break;
                case '1'://销 量
                    $this->db->join('goods_stat','goods_stat.goods_id=goods.goods_id','left');
                    $this->db->order_by('goods_stat.sales','desc');
                    break;
                case '2'://新品
                    $this->db->order_by('add_time','desc');
                    break;
                case '3'://价格降序
                    $this->db->order_by('price','desc');
                    break;
                case '4'://价格升序
                    $this->db->order_by('price','asc');
                    break;
            }
        }else{
            $this->db->where('price >',$min_sort);
            $this->db->where('price <',$max_sort);
            switch ($type){
                case '0':
                    $this->db->join('goods_stat','goods_stat.goods_id=goods.goods_id','left');
                    $this->db->order_by('goods_stat.views','desc');
                    break;
                case '1':
                    $this->db->join('goods_stat','goods_stat.goods_id=goods.goods_id','left');
                    $this->db->order_by('goods_stat.sales','desc');
                    break;
                case '2':
                    $this->db->order_by('add_time','desc');
                    break;
                case '3':
                    $this->db->order_by('price','desc');
                    break;
            }
        }
        $db=clone($this->db);
        $ret['list']=$this->db->limit($per_nums, $offset)->get()->result_array();
        $this->db=$db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    public function search(){
        $this->db->select('title')->where('cid',14);
        $ret=$this->db->order_by('dateline','asc')->get('common_link')->result_array();
        return $ret;
    }

    public function get_cart($uid){
        $this->db->where(array('user_id'=>$uid,'del'=>0));
        $ret=$this->db->count_all_results('cart');
        return $ret;
    }

}