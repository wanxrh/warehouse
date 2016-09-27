<?php

/**
 * 商品模型
 */
require "app_model.php";

class Collect_model extends App_model
{
    public function __construct()
    {
        parent::__construct();
    }

    /*
    *收藏商品列表
     */
    public function goods_collect($user_id, $per_page, $offset)
    {
        $this->db->select('goods_id,default_image,goods_name,price,cost_price,if_show,closed,is_del');
        $this->db->from('collect');
        $this->db->where('collect.user_id', $user_id)->where('collect.type', 1);
        $this->db->join('goods', 'collect.target_id=goods.goods_id');
        $db = clone($this->db);
        $ret['list'] = $this->db->limit($per_page, $offset)->order_by('collect.id', 'desc')->get()->result_array();
        $this->db = $db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /*
    *收藏店铺列表
     */
    public function shop_collect($user_id, $per_page, $offset)
    {
        $this->db->select('store_id,store_name,store_logo');
        $this->db->from('collect');
        $this->db->where('collect.user_id', $user_id)->where('collect.type', 2);
        $this->db->join('store', 'collect.target_id=store.store_id');
        $db = clone($this->db);
        $ret['list'] = $this->db->limit($per_page, $offset)->order_by('collect.id', 'desc')->get()->result_array();
        $this->db = $db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /*
   *店铺被收藏数
    */
    public function shop_collect_num($store_ids)
    {
        $this->db->select('target_id as store_id,count(1) as collect_num');
        $this->db->where_in('target_id', $store_ids);
        $this->db->where('type', 2);
        $this->db->group_by('store_id');
        $ret = $this->db->get('collect')->result_array();
        return $ret;
    }

    /*
    *店铺上新商品
    */
    public function shop_new_goods($store_id)
    {
        $this->db->select('goods_id,default_image');
        $this->db->where('store_id', $store_id);
        $temp_time = time() - 30 * 86400;
        $this->db->where('add_time >', $temp_time);//上新
        $ret = $this->db->limit(4)->order_by('goods_id', 'desc')->get('goods')->result_array();
        return $ret;

    }

    /*
    *店铺上新商品数量
    */
    public function shop_new_goods_num($store_id)
    {
        $this->db->where('store_id', $store_id);
        $temp_time = time() - 30 * 86400;
        $this->db->where('add_time >', $temp_time);//上新
        $ret = $this->db->count_all_results('goods');
        return $ret;
    }

    /*
    *店铺上新商品数量
    */
    public function del_invalid($user_id, $goods_id = '')
    {
        if ($goods_id>0) {
            $this->db->where(array('user_id' => $user_id, 'type' => 1, 'target_id' => $goods_id));
            $ret = $this->db->delete('collect');
            return $ret;
        } else {
            $this->db->select('target_id,if_show,closed,is_del');
            $this->db->from('collect');
            $this->db->where(array('user_id' => $user_id, 'type' => 1));
            $this->db->join('goods', 'collect.target_id=goods.goods_id');
            $temp=$this->db->get()->result_array();
            foreach ($temp as $v){
                if(($v['if_show']==0)&&($v['closed']==1)&&($v['is_del']==1)){
                    $ids[]=$v[target_id];
                }
            }
            $this->db->where_in('target_id',$goods_id);
            $ret = $this->db->delete('collect');
            return $ret;
        }
    }
}