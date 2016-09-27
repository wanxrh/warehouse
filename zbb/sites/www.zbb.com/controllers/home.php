<?php

class Home extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        header("content-type:text/html; charset=utf-8");
        $this->load->model('home_model');
    }

    public function index()
    {
        $this->load->view('home');
    }

    public function attract()
    {
        $this->load->view('attract');
    }

    public function mobile()
    {
        $this->load->view('mobile');
    }

    //值得买页面
    public function buy()
    {
        $cid = 6;
        $data = $this->get_data($cid);
        $this->load->view('buy', $data);
    }

    //9.9包邮页面
    public function free($cid = 3)
    {
        $data = $this->get_data($cid);
        $this->load->view('free', $data);
    }

    //获取商品信息
    private function get_data($cid)
    {
        $data['cid'] = intval($cid);
        $data['goods_list'] = $this->home_model->get_nine_goods($data['cid']);
        $data['new_total'] = 0;
        if ($data['goods_list']) {
            foreach ($data['goods_list'] as &$v) {
                $v['img'] = img_url($v['img']);
                $v['url'] = goods_url($v['target_id']);
                $v['discount'] = round(10 / ($v['cost_price'] / $v['price']), 1);
                //判断
                $cur_date = date('Y-m-d', time());
                if ($v['dateline'] > strtotime($cur_date)) $data['new_total']++;
            }
        } else {
            $data['goods_list'] = array();
        }
        return $data;
    }

    public function details($goods_id = '')
    {
        //商品是否存在
        $data['goods_info'] = $this->home_model->goods_info($goods_id);
        if (!$data['goods_info']) {
            show_error('此商品不存在');
        }
        //商品滚动图
        $data['goods_img'] = $this->home_model->goods_img($goods_id);
        //规格名
        $spec_name = $this->home_model->get_spec_name($goods_id);
        //规格值
        $spec_value = $this->home_model->get_spec_value($goods_id);
        $data['spec_info'] = array();
        foreach ($spec_name as $v) {
            foreach ($spec_value as $m) {
                if ($v['attr_name_id'] == $m['attr_name_id']) {
                    $data['spec_info'][$v['attr_name']][] = $m;
                }
            }
        }
        //商品总库存
        $stock_info = $this->home_model->get_stock($goods_id);
        $data['stock'] = $stock_info['stock'];
        //店铺名称
        $store_info = $this->home_model->get_store($data['goods_info']['store_id']);
        $data['store_name'] = $store_info['store_name'];
        //商品介绍
        $data['goods_etxm'] = $this->home_model->goods_etxm($goods_id);
        //推荐商品
        $arr_recom = array(3, 4, 5);
        $data['goods_recom'] = $this->home_model->get_goods($arr_recom, $goods_id);

        $this->load->view('details', $data);
    }

    /*
     * 检测登录
     */
    public function check_login()
    {
        $user_id = get_user()['id'];
        if ($user_id) {
            $data['url'] = $this->config->item('domain_user');
            ajax_success($data);
        } else {
            ajax_error("未登录");
        }
    }

}