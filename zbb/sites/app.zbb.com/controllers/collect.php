<?php

/*
首页控制器
 */

class Collect extends App_Controller
{
    const PAGE_SIZE = 10;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('collect_model');
    }

    /**
     *商品收藏
     * @author
     */
    public function goods_collect()
    {
        $this->check_user();
        $user_id = $this->uid;
        $page = intval($this->input->post('page'));
        $offset = ($page - 1) * self::PAGE_SIZE;
        $ret = $this->collect_model->goods_collect($user_id, self::PAGE_SIZE, $offset);
        $arr['list'] = $ret['list'];
        foreach ($arr['list'] as &$v) {
            $v['default_image'] = img_url($v['default_image']);
            if (($v['if_show'] == 1) && ($v['closed'] == 0) && ($v['is_del'] == 0)) {
                $v['is_valid'] = 1;
            } else {
                $v['is_valid'] = 0;
            }
            unset($v['if_show']);
            unset($v['closed']);
            unset($v['is_del']);
        }
        $arr['total'] = $ret['total'];
        //其他信息
        $arr['page_size'] = self::PAGE_SIZE;
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     *商品收藏
     * @author
     */
    public function shop_collect()
    {
        $this->check_user();
        $user_id = $this->uid;
        $page = $this->get_int('page');
        $per_page = 5;
        $offset = ($page - 1) * $per_page;
        $ret = $this->collect_model->shop_collect($user_id, $per_page, $offset);
        if($ret['list']){
            $arr['list'] = $ret['list'];
            //店铺被收藏数
            $temp_ids = array_column($arr['list'], 'store_id');
            $temp_collect_arr = $this->collect_model->shop_collect_num($temp_ids);
            $collect_arr = array_column($temp_collect_arr, 'collect_num', 'store_id');

            //店铺最新上新
            foreach ($arr['list'] as &$v) {
                $v['store_logo'] = empty($v['store_logo']) ? '' : img_url($v['store_logo']);
                $v['shop_goods'] = $this->collect_model->shop_new_goods($v['store_id']);
                if ($v['shop_goods']) {
                    foreach ($v['shop_goods'] as &$m) {
                        $m['default_image'] = empty($m['default_image']) ? '' : img_url($m['default_image']);
                    }
                }
                $v['collect_num'] = $collect_arr[$v['store_id']];
                $v['goods_num'] = $this->collect_model->shop_new_goods_num($v['store_id']);
            }
            $arr['total'] = $ret['total'];
        }else{
            $arr['list']=array();
            $arr['total'] = 0;
        }
        $arr['page_size'] = $per_page;
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /*
     *清除失效商品
    */
    public function del_invalid()
    {
        $this->check_user();
        $user_id = $this->uid;
        $goods_id = intval($this->input->post('goods_id'));
        $ret = $this->collect_model->del_invalid($user_id, $goods_id);
        if ($ret) {
            $this->success(1, '清除成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }
}