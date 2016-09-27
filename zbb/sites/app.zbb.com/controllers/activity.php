<?php

/*
首页控制器
 */

class Activity extends App_Controller
{
    const PER_NUMS = 20;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('activity_model');
        define('PER_NUMS', '20');//每页数量
    }

    /**
     *九块九页面
     * @author
     */
    public function free()
    {
        $cid = $this->get_int('cid');
        $page = intval($this->input->post('page'));
        if (empty($page)) $page = 1;
        $offset = ($page - 1) * self::PER_NUMS;
        $ret = $this->activity_model->get_goods($cid, self::PER_NUMS, $offset);
        if (!$ret['list']) $this->failure(0, '暂无数据');
        foreach ($ret['list'] as &$v) {
            $v['img'] = img_url($v['img']);
        }
        $arr['list'] = $ret['list'];
        $arr['total'] = $ret['total'];
        $arr['page_size'] = PER_NUMS;
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);;
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     *限时抢购
     * @author
     */
    public function rush()
    {
        $cid = intval($this->input->post('cid'));
        $cid_arr = array('16' => 9, '17' => 11, '18' => 15, '19' => 20);
        if (!array_key_exists($cid, $cid_arr)) {
            $this->failure(0, '参数不对');
        }
        $page = intval($this->input->post('page'));
        if (empty($page)) $page = 1;
        $offset = ($page - 1) * self::PER_NUMS;

        $arr['cur_time'] = time();

        $ret = $this->activity_model->get_goods($cid, self::PER_NUMS, $offset);
        if (!$ret['list']) {
            $this->success(1, '暂无数据', $arr);
        }

        $goods_arr = array_column($ret['list'], 'goods_id');
        $stock_info = $this->activity_model->get_stock($goods_arr);
        $stock_arr = array_column($stock_info, 'stock', 'goods_id');

        $now = time();
        $today = strtotime(date('Y-m-d', $now));
        $time_today = $today + 3600 * $cid_arr[$cid];//今天某点
        $time_yesterday = $today - 3600 * (24 - $cid_arr[$cid]);//昨天某点

        foreach ($ret['list'] as &$v) {
            $v['img'] = img_url($v['img']);
            $v['is_buy'] = $v['dateline'] > $time_yesterday ? 0 : 1;
            $v['is_buy'] = $now > $time_today ? 1 : 0;
            if ($stock_arr[$v['goods_id']] == 0) $v['is_buy'] = 2;
        }

        $arr['list'] = $ret['list'];
        $arr['total'] = $ret['total'];
        $arr['page_size'] = self::PER_NUMS;
        $this->success(1, '数据返回成功', $arr);
    }

    /**
     *一元抢购
     * @author
     */
    public function one_pay()
    {
        $img_list = $this->activity_model->get_pic(21);
        $user_id = intval($this->input->get_post('uid'));
        if ($img_list) {
            foreach ($img_list as &$m) {
                $m['img'] = img_url($m['img']);
            }
            $arr['img_list'] = $img_list;
        } else {
            $arr['img_list'] = array();
        }

        $cid = 20;
        $page = intval($this->input->post('page'));
        if (empty($page)) $page = 1;
        $offset = ($page - 1) * self::PER_NUMS;
        $ret = $this->activity_model->one_rush_goods($cid, self::PER_NUMS, $offset);
        if (!$ret['list']) {
            $arr['list'] = array();
        } else {
            $one_paid = array();
            if ($user_id) {
                $one_paid = $this->activity_model->one_paid($user_id, array_column($ret['list'], 'goods_id'));
            }
            $one_paid = array_column($one_paid, 'used', 'goods_id');
            foreach ($ret['list'] as &$v) {
                unset($v['id'], $v['cid'], $v['dateline']);
                $v['img'] = img_url($v['img']);
                $v['price'] = '1.00';
                if (isset($one_paid[$v['goods_id']])) {
                    $v['lock'] = 0;
                    $v['used'] = $one_paid[$v['goods_id']] ? 1 : 0;
                } else {
                    $v['lock'] = 1;
                    $v['used'] = 0;
                }
            }
        }

        $arr['list'] = $ret['list'];
        $arr['total'] = $ret['total'];
        $arr['page_size'] = self::PER_NUMS;
        $this->success(1, '数据返回成功', $arr);
    }
}