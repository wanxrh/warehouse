<?php

/**
 * 商品模型
 */
require "app_model.php";

class Activity_model extends App_model
{
    public function __construct()
    {
        parent::__construct();
    }

    /*
    *页面商品
     */
    public function get_goods($cid,$per_page,$offset)
    {

        $this->db->from('common_link');
        $this->db->select('id,cid,img,price,cost_price,dateline,title,target_id as goods_id');
        $this->db->where('cid', $cid);
        $now = time();
        $today = strtotime(date('Y-m-d', $now));

        switch($cid){
            case 16:
                $where_time = $today + 3600 * 9;//今天9点
                break;
            case 17:
                $where_time = $today + 3600 * 11;//今天11点
                break;
            case 18:
                $where_time = $today + 3600 * 15;//今天15点
                break;
            case 19:
                $where_time = $today + 3600 * 20;//今天20点
                break;
            default:
                $time_today = $today + 3600 * 10;//今天10点
                $time_yesterday = $today - 3600 * 14;//今天10点
                $where_time =$now < $time_today?$time_yesterday:$time_today;
        }
        $this->db->where('dateline <', $where_time);
        $db = clone($this->db);
        $ret['list'] = $this->db->order_by('dateline', 'asc')->limit($per_page, $offset)->get()->result_array();
        $this->db = $db;
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

    /*
 *商品库存
  */
    public function one_rush_goods($cid,$per_page,$offset)
    {
        $this->db->select('id,cid,img,price,cost_price,dateline,title,target_id as goods_id');
        $this->db->where('cid',$cid);
        $db=clone($this->db);
        $ret['list']=$this->db->limit($per_page, $offset)->get('common_link')->result_array();
        $this->db=$db;
        $ret['total'] = $this->db->count_all_results('common_link');
        return $ret;
    }

    public function one_paid($user_id,$goodsIds)
    {
        return $this->db->where('user_id',$user_id)->where_in('goods_id',$goodsIds)->get('one_pay')->result_array();
    }

    /*
     * 获取图片推送
     */
    public function get_pic($cid){
        $this->db->select('img,url');
        $ret=$this->db->where('cid',$cid)->get('common_link')->result_array();
        return $ret;
    }
}