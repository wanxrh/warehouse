<?php
/**
 * 店铺模型
 */
require "app_model.php";

class Store_model extends App_model
{
    public function __construct()
    {
        parent::__construct();
    }

    /*
    店铺首页数据
     */
    public function get_goods($store_id, $per_page, $offset, $type = 2, $sort_cate = 1, $sort_type = 1, $keyword = '',$cate_id='')
    {
        if(!empty($cate_id)){
            $goods_info=$this->db->select('goods_id')->where('cate_id',$cate_id)->get('goods_cate')->result_array();
            $goods_ids=array_column($goods_info,'goods_id');
            if($goods_ids){
                $this->db->where_in('goods.goods_id',$goods_ids);
            }else{
                $ret['list']=array();
                $ret['total']=0;
                return $ret;
            }
        }

        $this->db->select('goods.goods_id,goods_name,price,cost_price,default_image');
        $this->db->from('goods');
        if(!empty($store_id)){
            $this->db->where('store_id',$store_id);
        }
        $this->db->where(array('if_show' => 1, 'closed' => 0, 'is_del' => 0));
        if ($type == 1) {
            $this->db->where('is_recom', 1);//店铺首页
            $this->db->order_by('goods.goods_id', 'desc');
        }
        if ($type == 3) {
            $temp_time = time() - 30 * 86400;
            $this->db->where('add_time >', $temp_time);//上新
            $this->db->order_by('goods.goods_id', 'desc');
        }
        if ($type == 2) {
            if ($keyword != '') {
                $this->db->like('goods_name', $keyword);//关键字
            }
            switch ($sort_cate) {
                case 1:
                    $this->db->join('goods_stat', 'goods.goods_id=goods_stat.goods_id');//人气
                    $this->db->order_by('goods_stat.views', 'desc');
                    break;
                case 2:
                    $this->db->join('goods_stat', 'goods.goods_id=goods_stat.goods_id');//销量
                    $this->db->order_by('goods_stat.sales', 'desc');
                    break;
                case 3:
                    $this->db->order_by('goods.goods_id', 'desc');
                    break;
                case 4:
                    $temp = $sort_type > 0 ? 'asc' : 'desc';
                    $this->db->order_by('goods.price', $temp);
                    break;
            }
        }
        $db = clone($this->db);
        $ret['list'] = $this->db->limit($per_page, $offset)->get()->result_array();
        $this->db = $db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /*
     *检查店铺是否收藏
    */
    public function check_collect($user_id, $store_id)
    {
        return $this->db->get_where('collect', array('user_id' => $user_id, 'target_id' => $store_id))->row_array();
    }

    /*
     *获取店铺信息
     */
    public function get_store($store_id)
    {
        return $this->db->get_where('store', array('store_id' => $store_id))->row_array();
    }

    /*
     *获取店铺分类
     */
    public function get_cate($store_id, $parent_id)
    {
        $this->db->select('cate_id,cate_name');
        $this->db->where(array('store_id' => $store_id, 'parent_id' => $parent_id));
        return $this->db->get('gcategory')->result_array();
    }

}