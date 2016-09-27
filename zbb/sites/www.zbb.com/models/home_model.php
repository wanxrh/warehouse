<?php

/**
 * 首页模型
 * @author feimo
 * @version 2013-10
 */
class Home_model extends CI_Model {

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 获取推荐商品
     */
    public function get_goods($cid,$fiter='') {
        $this->db->select('img,target_id,title,price,cost_price,dateline');
        if(is_array($cid)){
            $this->db->where_in('cid',$cid)->limit(5);
        }else{
            $this->db->where('cid',$cid)->where('target_id !=',$fiter);
        }
        $ret=$this->db->order_by('id','desc')->get('common_link')->result_array();
        return $ret;
    }


    /**
     * 获取商品信息
     * @param $condition
     * @return mixed
     */
    public function goods_info($goods_id)
    {
        $this->db->select('goods_id,default_image,goods_name,price,cost_price,store_id');
        $ret=$this->db->where('goods_id',$goods_id)->get('goods')->row_array();
        return $ret;
    }

    /**
     * 获取商品图片
     * @param $goods_id
     * @return mixed
     */
    public function goods_img($goods_id){
        $ret=$this->db->where('goods_id',$goods_id)->limit(5)->get('goods_image')->result_array();
        return $ret;
    }
    /**
     * 获取商品规格名
     * @param $goods_id
     * @return mixed
     */
    public function get_spec_name($goods_id){
        $ret=$this->db->where('goods_id',$goods_id)->get('attr_name')->result_array();
        return $ret;
    }
    

    /**
     * 获取商品规格值
     * @param $goods_id
     * @return mixed
     */
    public function get_spec_value($goods_id){
        $ret=$this->db->where('goods_id',$goods_id)->get('attr_value')->result_array();
        return $ret;
    }

     /**
     * 获取商品详情
     * @param $goods_id
     * @return mixed
     */
    public function goods_etxm($goods_id){
        $ret=$this->db->where('goods_id',$goods_id)->get('goods_extm')->row_array();
        return $ret;
    }

    /**
     * 获取商品总库存
     * @param $goods_id
     * @return mixed
     */
    public function get_stock($goods_id){
        $this->db->select_sum('stock');
        $ret=$this->db->where('goods_id',$goods_id)->get('goods_sku')->row_array();
        return $ret;
    }

    /**
     * 店铺信息
     * @param $goods_id
     * @return mixed
     */
    public function get_store($stroe_id){
        $this->db->select('store_name');
        $ret=$this->db->where('store_id',$stroe_id)->get('store')->row_array();
        return $ret;
    }

   /*
    * 9块9
    */
    public function get_nine_goods($cid)
    {

        $this->db->from('common_link');
        $this->db->select('id,cid,img,price,cost_price,dateline,title,target_id as goods_id');
        $this->db->where('cid', $cid);

        $now = time();
        $today = strtotime(date('Y-m-d', $now));
        $time_today = $today + 3600 * 10;//今天10点
        $time_yesterday = $today - 3600 * 14;//今天10点
        $where_time =$now < $time_today?$time_yesterday:$time_today;

        $this->db->where('dateline <', $where_time);
        $ret = $this->db->limit(48)->order_by('dateline', 'asc')->get()->result_array();
        return $ret;
    }


}