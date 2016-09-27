<?php

/*
首页控制器
 */

class Store extends App_Controller
{
    const PAGE_SIZE = 10;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('store_model');
    }

    /**
     *店铺首页
     * @author
     */
    public function index()
    {
        $store_id = intval($this->input->post('store_id'));//动作
        $page = intval($this->input->post('page'));//分页
        $user_id = intval($this->input->post('user_id'));
        $type = intval($this->input->post('type'));
        $sort_cate = intval($this->input->post('sort_cate'));
        $cate_id = intval($this->input->post('cate_id'));
        $sort_type = intval($this->input->post('sort_type'));
        $keyword = filter_sql($this->input->post('keyword'));

        $offset = ($page - 1) * self::PAGE_SIZE;
        $ret = $this->store_model->get_goods($store_id, self::PAGE_SIZE, $offset, $type,$sort_cate,$sort_type,$keyword,$cate_id);
        $arr['list'] = $ret['list'];
        foreach ($arr['list'] as &$v) {
            $v['default_image'] = img_url($v['default_image']);
        }
        $arr['total'] = $ret['total'];
        if (!$user_id) {
            $arr['is_collect'] = 0;
        } else {
            //查询是用户已收藏
            $temp = $this->store_model->check_collect($user_id, $store_id);
            if ($temp) {
                $arr['is_collect'] = 1;
            } else {
                $arr['is_collect'] = 1;
            }
        }
        //获取店铺信息
        $store_info = $this->store_model->get_store($store_id);
        $arr['store_logo'] = isset($store_info['store_logo'])?img_url($store_info['store_logo']):'';
        $arr['store_name'] = isset($store_info['store_name'])?$store_info['store_name']:'';
        $arr['tel'] = isset($store_info['tel'])?$store_info['tel']:'';
        $arr['im_qq'] = isset($store_info['im_qq'])?$store_info['im_qq']:'';
        //其他信息
        $arr['page_size'] = self::PAGE_SIZE;
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '暂无数据');
        }
    }

    /**
     *店铺分类
     * @author
     */
    public function get_cate(){
        $store_id = $this->get_int('store_id');
        $parent_id=intval($this->input->post('parent_id'));
        $ret=$this->store_model->get_cate($store_id,$parent_id);
        $arr['list']=$ret;
        if($ret){
            $this->success(1, '数据返回成功', $arr);
        }else{
            $this->failure(0, '暂无数据');
        }
    }

}