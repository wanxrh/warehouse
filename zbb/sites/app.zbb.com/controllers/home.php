<?php

/*
首页控制器
 */

class Home extends App_Controller
{
    const PER_NUMS = 20;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('home_model');
    }

    /**
     *
     * @author
     */
    public function index()
    {
        $type = $this->get_int('type');//动作
        $page = intval($this->input->post('page'));//分页
        $is_reload = $this->get_int('is_reload');//单独获取特卖数据还是全部数据 0--全部  1--特卖
        if (empty($page)) $page = 1;
        $arr = array();
        //app首页图片
        if ($is_reload == 0) {
            $flash = $this->home_model->get_img(array(1, 2));
            if (!$flash) $arr['list_flash'] = array();
            foreach ($flash as &$v) {
                $v['img'] = img_url($v['img']);
                $v['type_id']=$v['title'];
                unset($v['title']);
                //轮播
                if ($v['cid'] == 1) $arr['list_flash'][] = $v;
                //限时特购
                if ($v['cid'] == 2) $arr['list_time'][] = $v;
            }
            $ret = $this->home_model->get_goods_info(7);
            if (!$ret) $arr['list_hot'] = array();

            foreach ($ret as &$v) {
                $v['img'] = img_url($v['img']);
                //9.9抢爆款
                $arr['list_hot'][] = $v;
            }
        }
        $offset = ($page - 1) * self::PER_NUMS;
        //获取特卖数据
        $special = $this->home_model->get_goods(8, $type, self::PER_NUMS, $offset);
        if (empty($special['list'])) {
            $arr['list_buy'] = array();
        } else {
            $stock_status = $this->get_goods_status($special['list']);
            foreach ($special['list'] as $v) {
                $v['img'] = img_url($v['img']);
                $v['is_buy'] = $stock_status[$v['goods_id']] == 0 ? 2 : 1;
                $v['is_buy'] = $type == 2 ? 0 : 1;
                $arr['list_buy'][] = $v;
            }
        }
        $arr['total'] = $special['total'];
        $arr['page_size'] = self::PER_NUMS;
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    protected function get_goods_status($arr)
    {
        $goods_arr = array_column($arr, 'goods_id');
        $stock_info = $this->home_model->get_stock($goods_arr);
        $stock_arr = array_column($stock_info, 'stock', 'goods_id');
        return $stock_arr;
    }

    //轮播
    public function flash()
    {

        $flash = $this->home_model->get_img(array(1, 2));
        if (!$flash) $this->success(1, '没有数据', $arr = array());
        foreach ($flash as &$v) {
            $v['img'] = img_url($v['img']);
            //轮播
            if ($v['cid'] == 1) $arr['list_flash'][] = $v;
            //限时特购
            if ($v['cid'] == 2) $arr['list_time'][] = $v;
        }
        $ret = $this->home_model->get_goods_info(7);
        if (!$ret) $this->success(1, '没有数据', $arr = array());
        foreach ($ret as &$v) {
            $v['img'] = img_url($v['img']);
            //9.9抢爆款
            $arr['list_hot'][] = $v;
        }
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    //特卖专区
    public function special()
    {
        $type = $this->get_int('type');//动作
        $page = intval($this->input->post('page'));//分页
        if (empty($page)) $page = 1;
        $offset = ($page - 1) * self::PER_NUMS;
        $special = $this->home_model->get_goods(8, $type, self::PER_NUMS, $offset);
        if (!$special['list']) $this->success(1, '没有数据', $arr = array());
        $stock_status = $this->get_goods_status($special['list']);
        foreach ($special['list'] as $v) {
            $v['img'] = img_url($v['img']);
            $v['is_buy'] = $type == 2 ? 0 : 1;
            $v['is_buy'] = $stock_status[$v['goods_id']] == 0 ? 2 : 1;
            $arr['list_buy'][] = $v;
        }
        $arr['total'] = $special['total'];
        $arr['page_size'] = self::PER_NUMS;
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    public function apk(){
        $version = filter_sql($this->input->post('version'));
        $ret = $this->home_model->get_info();
        if($ret['version']!=$version){
            $this->success(1, '数据返回成功', $ret);
        }else{
            $this->failure(0, '暂无更新');
        }
    }

}