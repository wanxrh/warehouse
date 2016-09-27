<?php

/*
 * 支付模型
 */
require "app_model.php";

class Pay_model extends App_model
{

    public $_order_sn = null;
    public $_order_confirm_sn = null;
    public $_service_charges_sn = null;

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 确认订单前，参数验证
     * @param $data 数据
     * @return mixed
     */
    public function _get_goods_info($data)
    {
        $sql = '';
        foreach ($data as $v) {
            $sql .= sprintf('(store_id = %u AND goods_id = %u AND sku_id = %u AND stock >= %u)OR', $v['store_id'], $v['goods_id'], $v['sku_id'], $v['quantity']);
        }
        $sql = trim($sql, 'OR');
        $this->db->where($sql, null, false);
        return $this->db->get('goods_sku')->result_array();
    }

    /**
     * 生成单个或多个订单，已经尽量避免for操作数据库，还有待优化空间
     * @param $user 用户信息数组
     * @param $payment_id 支付ID
     * @param $data 原始数据组
     * @param $goods_info 商品详情
     * @param $addr_info 地址详细
     * @param $from_cart 来源购物车
     * @return bool
     */
    public function create_orders($user, $payment_id, $data, $goods_info, $addr_info, $from_cart)
    {
        //开启事务
        $this->db->trans_begin();

        //查询相应的商品名称和默认图片
        $goodsIds = array_column($goods_info, 'goods_id');
        $goods_arr = $this->db->select('goods_id,goods_name,default_image')->where_in('goods_id', $goodsIds)->get('goods')->result_array();
        foreach ($goods_arr as $v) {
            $goods_sup[$v['goods_id']] = $v;
        }
        //查询相应的店铺信息
        $storeIds = array_column($data, 'store_id');
        $store_sup = $this->db->select('store_id,store_name,is_free,cate_id')->where_in('store_id', $storeIds)->get('store')->result_array();
        $store_name_sup = array_column($store_sup, 'store_name', 'store_id');
        $store_free_sup = array_column($store_sup, 'is_free', 'store_id');
        //购买数量
        $quantity_sup = [];
        foreach ($data as $v) {
            foreach ($v['goods'] as $good) {
                $quantity_sup[$good['sku_id']] = $good['quantity'];
            }
        }
        //构建order_goods参数，并计算出总价
        foreach ($goods_info as $goods) {
            $_handle_goods[$goods['store_id']]['goods'][] = array(
                'goods_id' => $goods['goods_id'],
                'goods_name' => $goods_sup[$goods['goods_id']]['goods_name'],
                'sku_id' => $goods['sku_id'],
                'specification' => $this->spec_info($goods['sku_id'], $goods['goods_id']),
                'price' => $goods['price'],
                'quantity' => $quantity_sup[$goods['sku_id']],
                'discounted_price' => bcmul($goods['price'], $quantity_sup[$goods['sku_id']], 2),
                'goods_image' => $goods_sup[$goods['goods_id']]['default_image'],
                'order_goods_status' => ORDER_GOODS_UNPAY
            );

            if (isset($_handle_goods[$goods['store_id']]['total'])) {
                $_handle_goods[$goods['store_id']]['total'] += $quantity_sup[$goods['sku_id']] * $goods['price'];
            } else {
                $_handle_goods[$goods['store_id']]['total'] = $quantity_sup[$goods['sku_id']] * $goods['price'];
            }

        }
        //技术服务费
        $storeCate = array_column($store_sup,'cate_id','store_id');
        $service_cate = config_item('service_charges');
        foreach ($_handle_goods as $store_id => &$value) {
            if (isset($store_free_sup[$store_id]) && $store_free_sup[$store_id] == 0) {
                $service_rate = (!isset($storeCate[$store_id]) || !isset($service_cate[$storeCate[$store_id]])) ? $service_cate[0] : $service_cate[$storeCate[$store_id]];
                $value['service_charges'] = $this->order_service_charges($value['total'], $service_rate);
                $last_key = count($value['goods']) - 1;
                $service_charges = 0;
                foreach ($value['goods'] as $current => &$goods) {
                    $goods['service_fee'] = $this->order_goods_service_charges($current, $last_key, $goods['discounted_price'], $value['service_charges'], $service_charges, $service_rate);
                    $service_charges += $goods['service_fee'];
                }
            }
        }
        //构建order表数据写入表，返回insert_id arr
        $postscript = array_column($data, 'postscript', 'store_id');
        foreach (array_column($store_sup, 'store_id') as $store_id) {
            $_handle_order_info[] = array(
                'order_sn' => $this->_gen_order_sn(),
                'order_confirm_sn' => $this->_gen_order_confirm_sn(),
                'service_charges_sn' => $this->_gen_service_charges_sn(),
                'seller_id' => $store_id,
                'store_name' => $store_name_sup[$store_id],
                'buyer_id' => $user['id'],
                'buyer_name' => $user['name'],
                'order_status' => ORDER_UNPAY,
                'add_time' => time(),
                'payment_id' => $payment_id,
                'discount' => $_handle_goods[$store_id]['total'],
                'order_amount' => $_handle_goods[$store_id]['total'],
                'order_balance' => $_handle_goods[$store_id]['total'],
                'service_charges' => isset($_handle_goods[$store_id]['service_charges']) ? $_handle_goods[$store_id]['service_charges'] : 0,
                'postscript' => isset($postscript[$store_id]) ? $postscript[$store_id] : '',
                'auto_order_cancle' => time() + AUTO_CANCEL
            );
            $order_store[] = $store_id;
        }
        $this->db->insert_batch('order', $_handle_order_info);
        $order_rows = $this->db->affected_rows();//插入行数
        $start_order_id = $this->db->insert_id();//CI批量插入，返回第一条ID
        for ($i = 0; $i < $order_rows; $i++) {
            $orderIds[$order_store[$i]] = ($start_order_id + $i);
        }
        //写入order_extm收货地址表
        foreach ($orderIds as $v) {
            $order_extm[] = array(
                'order_id' => $v,
                'consignee' => $addr_info['consignee'],
                'province_id' => $addr_info['province_id'],
                'city_id' => $addr_info['city_id'],
                'country_id' => $addr_info['country_id'],
                'region_name' => $addr_info['region_name'],
                'address' => $addr_info['address'],
                'zipcode' => $addr_info['zipcode'],
                'tel' => $addr_info['tel'],
                'mobile' => $addr_info['mobile']
            );
        }
        $this->db->insert_batch('order_extm', $order_extm);
        //写入order_goods订单商品表
        foreach ($_handle_goods as $store_id => $goods_data) {
            foreach ($goods_data['goods'] as $v) {
                $order_goods[] = array(
                    'order_id' => $orderIds[$store_id],
                    'goods_id' => $v['goods_id'],
                    'goods_name' => $v['goods_name'],
                    'sku_id' => $v['sku_id'],
                    'specification' => $v['specification'],
                    'price' => $v['price'],
                    'quantity' => $v['quantity'],
                    'discounted_price' => $v['discounted_price'],
                    'order_goods_balance' => $v['discounted_price'],
                    'service_fee' => isset($v['service_fee']) ? $v['service_fee'] : 0,
                    'goods_image' => $v['goods_image'],
                    'order_goods_status' => $v['order_goods_status']
                );
            }
        }
        $this->db->insert_batch('order_goods', $order_goods);
        //减库存操作
        $sql = '';
        $sku_str = '';
        foreach ($quantity_sup as $sku_id => $quantity) {
            $sql .= ' WHEN sku_id = ' . $sku_id . ' AND stock >= ' . $quantity . ' THEN stock - ' . $quantity;
            $sku_str .= $sku_id . ',';
        }
        $sql = 'UPDATE ' . $this->db->dbprefix . 'goods_sku SET stock = CASE' . $sql . ' ELSE stock END WHERE `sku_id` IN (' . trim($sku_str, ',') . ')';
        $this->db->query($sql);
        //写入自动取消订单定时器
        foreach ($orderIds as $v) {
            $timer[] = array(
                'dateline' => time(),
                'type' => CANCEL_TIMER,
                'target_id' => $v,
                'plan_time' => time() + AUTO_CANCEL
            );
        }
        $this->db->insert_batch('tasktimer', $timer);
        if ($from_cart) {
            $this->db->where(array('user_id' => $user['id'], 'del' => 0))->where_in('sku_id', array_column($goods_info, 'sku_id'))->update('cart', array('del' => 1));
        }

        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return $orderIds;
        }
    }

    /**
     * 检测地址
     * @param $condition 条件
     * @return mixed
     */
    public function check_buyer_addr($condition)
    {
        return $this->db->where($condition)->get('address')->row_array();
    }

    /**
     * 获取支付方式
     * @param $condition 查询条件
     * @return mixed
     */
    public function payment($condition)
    {
        return $this->db->where($condition)->get('payment')->row_array();
    }

    /**
     * 获取多条订单信息
     * @param $condition 查询条件
     * @param $orderIds 订单编号数组
     * @return mixed
     */
    public function get_orders($condition, $orderIds)
    {
        return $this->db->where($condition)->where_in('order_id', $orderIds)->get('order')->result_array();
    }

    /**
     * 更新订单支付渠道
     * @param $orderIds 订单ID数组
     * @param $payment_id 支付渠道ID
     */
    public function update_order_payment($orderIds, $payment_id)
    {
        $this->db->where_in('order_id', $orderIds)->update('order', array('payment_id' => $payment_id));
    }

    /**
     * 生成订单号
     */
    protected function _gen_order_sn()
    {
        /* 选择一个随机的方案 */
        mt_srand((double)microtime() * 1000000);
        $order_sn = date('YmdHi') . str_pad(mt_rand(1, 99999999), 8, '0', STR_PAD_LEFT);
        if ($this->_order_sn) {
            if (in_array($order_sn, $this->_order_sn))
                return $this->_gen_order_sn();
        }
        $info = $this->db->where('order_sn', $order_sn)->get('order')->row_array();
        if (!$info) {
            /* 否则就使用这个订单号 */
            $this->_order_sn[] = $order_sn;
            return $order_sn;
        }
        /* 如果有重复的，则重新生成 */
        return $this->_gen_order_sn();
    }


    /**
     * 生成外部订单号
     */
    protected function _gen_order_confirm_sn()
    {
        /* 选择一个随机的方案 */
        mt_srand((double)microtime() * 1000000);
        $order_confirm_sn = date('ymdHis') . str_pad(mt_rand(1, 99999999), 8, '0', STR_PAD_LEFT);
        if ($this->_order_confirm_sn) {
            if (in_array($order_confirm_sn, $this->_order_confirm_sn))
                return $this->_gen_order_confirm_sn();
        }
        $info = $this->db->where('order_confirm_sn', $order_confirm_sn)->get('order')->row_array();
        if (!$info) {
            /* 否则就使用这个订单号 */
            $this->_order_confirm_sn[] = $order_confirm_sn;
            return $order_confirm_sn;
        }
        /* 如果有重复的，则重新生成 */
        return $this->_gen_order_confirm_sn();
    }

    /**
     * 生成技术服务费交易号
     * @return string
     */
    protected function _gen_service_charges_sn()
    {
        /* 选择一个随机的方案 */
        mt_srand((double)microtime() * 1000000);
        $service_charges_sn = date('YmdHis') . str_pad(mt_rand(1, 99999999), 8, '0', STR_PAD_LEFT);
        if ($this->_service_charges_sn) {
            if (in_array($service_charges_sn, $this->_service_charges_sn))
                return $this->_gen_service_charges_sn();
        }
        $info = $this->db->where('service_charges_sn', $service_charges_sn)->get('order')->row_array();
        if (!$info) {
            /* 否则就使用这个订单号 */
            $this->_service_charges_sn[] = $service_charges_sn;
            return $service_charges_sn;
        }
        /* 如果有重复的，则重新生成 */
        return $this->_gen_service_charges_sn();
    }

    /**
     * 计算订单总技术服务费
     * @param $money 订单价格
     * @param $service_rate 技术服务费费率
     * @return float
     */
    private function order_service_charges($money, $service_rate)
    {
        return round($money * $service_rate, 2);
    }

    /**
     * 计算订单商品技术服务费，最后一个商品使用总技术服务费-之前商品的总技术服务费
     * @param $current 当前商品索引
     * @param $last 最后商品索引
     * @param $goods_price 商品价格
     * @param $order_service_charges 订单总技术服务费
     * @param $before_money 之前商品服务费综合
     * @param $service_rate 技术服务费费率
     * @return float
     */
    private function order_goods_service_charges($current, $last, $goods_price, $order_service_charges, $before_money, $service_rate)
    {
        if ($current == $last) {
            $service_charges = $order_service_charges - $before_money;
        } else {
            $service_charges = round($goods_price * $service_rate, 2);
        }
        return $service_charges;
    }
}