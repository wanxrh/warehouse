<?php

/**
 * 商品模型
 */
require "app_model.php";

class Goods_model extends App_model
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 商品幻灯片
     * @param $condition 查询条件
     * @return mixed
     */
    public function goods_slideshow($condition)
    {
        return $this->db->select('image_id,image_url')->where($condition)->order_by('sort_order', 'asc')->get('goods_image')->result_array();
    }

    /**
     * 获取商品信息
     * @param $condition
     * @return mixed
     */
    public function get_goods($condition)
    {
        return $this->db->select('store_id,goods_id,goods_name,if_show,closed,is_del,price,cost_price,enable_sku')->where($condition)->get('goods')->row_array();
    }

    /**
     * 商品SKU信息
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_goods_sku($condition)
    {
        return $this->db->select('properties,price,cost_price,stock,sku_id')->where($condition)->get('goods_sku')->result_array();
    }

    /**
     * 属性名称数组
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_attr_name($condition)
    {
        return $this->db->select('attr_name_id,attr_name')->where($condition)->get('attr_name')->result_array();
    }

    /**
     * 属性值数组
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_attr_value($condition)
    {
        return $this->db->select('attr_value_id,attr_value')->where($condition)->get('attr_value')->result_array();
    }

    /**
     * 商品属性全部组合
     * @param $sku_team
     * @return mixed
     */
    public function get_goods_attr($sku_team)
    {
        return $this->db->select('attr_name_id,attr_value_id')->where_in('sku_id', $sku_team)->get('goods_attr')->result_array();
    }

    public function unable_sku($goods_id)
    {
        return $this->db->select('sku_id,stock')->where(array('goods_id' => $goods_id))->get('goods_sku')->row_array();
    }

    /**
     * 同个店铺下，相同店铺分类商品
     * @param $goods_id 商品ID
     * @return mixed
     */
    public function same_gcate_goods($goods_id)
    {
        $cate = $this->db->select('cate_id')->where(array('goods_id' => $goods_id, 'inside' => 1, 'level' => 1))->get('goods_cate')->row_array();
        if (!$cate)
            return '';
        $goods = $this->db->select('goods_id')->where(array('cate_id' => $cate['cate_id'], 'goods_id <> ' => $goods_id))->get('goods_cate')->result_array();
        if (!$goods)
            return '';
        return $this->db->select('goods_id,default_image,goods_name,price,cost_price')->where_in('goods_id', array_column($goods, 'goods_id'))->limit(50)->order_by('add_time', 'desc')->get('goods')->result_array();
    }

    /**
     * 获取商品详情信息
     * @param $goods_id 商品ID
     * @return mixed
     */
    public function get_goods_extm($goods_id)
    {
        return $this->db->where('goods_id', $goods_id)->get('goods_extm')->row_array();
    }

    /**
     * 查询收藏夹
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_collect($conditon)
    {
        return $this->db->where($conditon)->get('collect')->row_array();
    }

    /**
     * 获取店铺信息
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_store($conditon)
    {
        return $this->db->select('region_name,im_qq')->where($conditon)->get('store')->row_array();
    }

    /**
     * 获取商品分类
     * @param $conditon 查询条件
     * @return mixed
     */
    public function get_goods_cate($conditon)
    {
        return $this->db->where($conditon)->get('goods_cate')->row_array();
    }
}