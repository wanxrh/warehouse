<?php

/**
 * 改变货物的状态，包括货物浏览量、用户收藏量、购物车添加量、
 * 包含该货物的订单总数、交易量、评论数量
 */
class Goods_state_model extends CI_Model{
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }
    /**
     * 浏览量+1
     * @param type $goods_id
     * @return type
     */
    public function views_plus($goods_id){
        $update_result=$this->db->where(array('goods_id'=>$goods_id))->set('views', 'views+1',FALSE)->update('goods_statistics');
        return $update_result;
    }
    /**
     * 收藏量+1
     * @param type $goods_id
     * @return type
     */
    public function collects_plus($goods_id){
        $update_result=$this->db->where(array('goods_id'=>$goods_id))->set('collects', 'collects+1',FALSE)->update('goods_statistics');
        return $update_result;
    }
    /**
     * 添加购物车量+1
     * @param type $goods_id
     * @return type
     */
    public function carts_plus($goods_id){
        $update_result=$this->db->where(array('goods_id'=>$goods_id))->set('carts', 'carts+1',FALSE)->update('goods_statistics');
        return $update_result;
    }
    /**
     * 加入订单量+1
     * @param type $goods_id
     * @return type
     */
    public function orders_plus($goods_id){
       $update_result=$this->db->where(array('goods_id'=>$goods_id))->set('orders', 'orders+1',FALSE)->update('goods_statistics');
        return $update_result;
    }
    /**
     * 交易量+1
     * @param type $goods_id
     * @return type
     */
    public function sales_plus($goods_id){
        $update_result=$this->db->where(array('goods_id'=>$goods_id))->set('sales', 'sales+1',FALSE)->update('goods_statistics');
        return $update_result;
    }
    /**
     * 评论数+1
     * @param type $goods_id
     * @return type
     */
    public function comments_plus($goods_id){
       $update_result=$this->db->where(array('goods_id'=>$goods_id))->set('comments', 'comments+1',FALSE)->update('goods_statistics');
        return $update_result;
    }
}
