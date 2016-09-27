<?php

/**
 * 商品模型
 */
require "app_model.php";

class Home_model extends App_model
{
    public function __construct()
    {
        parent::__construct();
    }
    /*
    首页图片
     */
    public function get_img($cid){
        $this->db->select('id,cid,img,title,url');
        if(is_array($cid)){
            $this->db->where_in('cid',$cid);
        }else{
            $this->db->where('cid',$cid);
        }
        $ret=$this->db->order_by('dateline','asc')->get('common_link')->result_array();
        return $ret;
    }
    /*
    首页9.9抢爆款商品
     */
    public function get_goods_info($cid){
        $this->db->select('id,cid,img,price,cost_price,target_id as goods_id');
        if(is_array($cid)){
            $this->db->where_in('cid',$cid);
        }else{
            $this->db->where('cid',$cid);
        }
        $ret=$this->db->order_by('dateline','asc')->get('common_link')->result_array();
        return $ret;
    }
    /*
    首页商品
    * @type 1:今日特卖;2:明日上新;3
     */
    public function get_goods($cid=8,$type=1,$per_nums,$offset){

        $this->db->from('common_link');
        $this->db->select('id,cid,img,price,cost_price,title,target_id as goods_id');
        $this->db->where('cid',$cid);
        $now = time();
        $today = strtotime(date('Y-m-d',$now));
        $time_yesterday = $today - 3600*14;//昨天十点
        $time_today = $today + 3600*10;//今天十点

        switch ($type){
            case '1':
            $this->db->where('dateline >',$time_yesterday);
            $this->db->where('dateline <',$time_today);
            break;

            case '2':
            $this->db->where('dateline >',$time_today);
            break;

            case '3':
            $this->db->where('dateline <',$time_yesterday);
            break;
        }
        $db=clone($this->db);
        $ret['list']=$this->db->order_by('dateline','asc')->limit($per_nums, $offset)->get()->result_array();
        $this->db=$db;
        $ret['total'] = $this->db->count_all_results();
        return $ret;
    }

    /*
*商品库存
 */
    public function get_stock($goods_arr)
    {
        $this->db->select('goods_id,sum(stock) as stock');
        $this->db->where_in('goods_id',$goods_arr);
        $ret=$this->db->group_by('goods_id')->get('goods_sku')->result_array();
        return $ret;
    }
    /**
     * 获取信息
     */
    public function get_info()
    {
        return $this->db->select('version,content,is_open,url')->where(array('key' => 2))->get('common_content')->row_array();
    }
}