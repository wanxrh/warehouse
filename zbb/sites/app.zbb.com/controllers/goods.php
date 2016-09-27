<?php

class Goods extends App_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('goods_model');
    }

    /**
     * 商品详情
     * @author 王立
     */
    public function details()
    {
        $goods_id = $this->get_uint('goods_id');
        //商品是否存在
        $goods_info = $this->goods_model->get_goods(array('goods_id' => $goods_id));
        if (!$goods_info) {
            $this->failure(1, '此商品不存在');
        }
        $store = $this->goods_model->get_store(array('store_id' => $goods_info['store_id']));
        if (!$store) {
            $this->failure(1, '店铺不存在');
        }
        $store_addr = '';
        if (count($addr_arr = explode(' ', $store['region_name'])) == 3) {
            $store_addr = $addr_arr[0] . ' ' . $addr_arr[1];
        }
        //商品滚动图
        $data['slideshow'] = $this->goods_model->goods_slideshow(array('goods_id' => $goods_id));
        foreach ($data['slideshow'] as &$v) {
            $v['image_url'] = img_url($v['image_url']);
        }
        $collect = 0;
        if (intval($this->input->get_post('uid'))) {
            $this->check_user();
            $uid = $this->uid;
            $goods_collect = $this->goods_model->get_collect(array('user_id' => $uid, 'type' => 1, 'target_id' => $goods_id));
            $collect = $goods_collect ? 1 : 0;
        }
        $goods_cate = $this->goods_model->get_goods_cate(array('goods_id' => $goods_id, 'inside' => 0, 'level' => 1));
        //商品标题，默认价格，默认原价等基本信息
        $data['goods'] = array(
            'cid' => $goods_cate['cate_id'],
            'store_id' => $goods_info['store_id'],
            'addr' => $store_addr,
            'goods_id' => $goods_id,
            'title' => $goods_info['goods_name'],
            'price' => $goods_info['price'],
            'cost_price' => $goods_info['cost_price'],
            'attributes' => $this->config->item('domain_app') . 'goods/attributes/' . $goods_id,
            'description' => $this->config->item('domain_app') . 'goods/description/' . $goods_id,
            'collect' => $collect,
            'service_qq' => $store['im_qq']
        );
        //禁售，下架，删除无需显示SKU,评价，详情，参数等
        $data['tradeStatus'] = 0;
        if ($goods_info['is_del'] == 1 || $goods_info['closed'] == 1 || $goods_info['if_show'] != 1) {
            //TODO 显示推荐商品
            $data['recommend'] = $this->goods_model->same_gcate_goods($goods_id);
            foreach ($data['recommend'] as &$v) {
                $v['default_image'] = img_url($v['default_image']);
            }
            $this->success(1, '商品已经下架', $data);
        }
        //可购买sku
        $sku = $this->goods_model->get_goods_sku(array('goods_id' => $goods_id, 'stock <>' => 0));
        if (empty($sku)) {
            //TODO 显示推荐商品
            $data['recommend'] = $this->goods_model->same_gcate_goods($goods_id);
            foreach ($data['recommend'] as &$v) {
                $v['default_image'] = img_url($v['default_image']);
            }
            $this->success(1, '商品已经售罄', $data);
        }
        $data['tradeStatus'] = $goods_info['enable_sku'] ? 1 : 2;
        //商品是否启用SKU
        if ($goods_info['enable_sku'] == 1) {
            $data['skuMap'] = $this->goods_model->sku_map($goods_id, $sku);
            $data['skuPart'] = $this->goods_model->sku_part($goods_id, $sku);
        } else {
            $unable = $this->goods_model->unable_sku($goods_id);
            $data['goods']['sku_id'] = $unable['sku_id'];
            $data['goods']['stock'] = $unable['stock'];
        }
        $this->success(1, '商品可购买', $data);
    }

    /**
     * 商品的规格表
     * @param $goods_id
     * @author 王立
     */
    public function attributes($goods_id)
    {
        $data = $this->goods_model->get_goods_extm($goods_id);
        $this->load->view('attributes', $data);
    }

    /**
     * 商品详情
     * @param $goods_id
     * @author 王立
     */
    public function description($goods_id)
    {
        $data = $this->goods_model->get_goods_extm($goods_id);
        $this->load->view('description', $data);
    }
}