<?php

/*
 * 交易控制器
 */

class Business extends App_Controller
{
    const EXTEND_CONFIRM_TIME = 259200;//延长确认收货时间,3天*86400 = 259200

    public function __construct()
    {
        parent::__construct();
        $this->load->model('business_model');
    }

    /**
     * 商品加入购物车
     * @author 王立
     */
    public function add_cart()
    {
        $goods_id = $this->get_uint('goods_id');
        $sku_id = $this->get_uint('sku_id');
        $quantity = $this->get_uint('quantity');
        $this->check_user();
        $uid = $this->uid;

        $this->check_goods($uid, $goods_id);
        $goods_sku = $this->check_stock($goods_id, $sku_id, $quantity);

        $cart_info = $this->check_cart(array('user_id' => $uid, 'sku_id' => $sku_id, 'del' => 0), false);
        if (!$cart_info) {
            $spec_info = $this->business_model->spec_info($sku_id, $goods_id);
            $data = array(
                'goods_id' => $goods_id,
                'sku_id' => $sku_id,
                'user_id' => $uid,
                'specification' => $spec_info,
                'quantity' => $quantity
            );
            $result = $this->business_model->insert_cart($data);
        } else {
            $muns = $cart_info['quantity'] + $quantity;
            $data['quantity'] = $muns;
            if ($muns > $goods_sku['stock'])
                $data['invalid'] = 1;
            $result = $this->business_model->update_cart(array('id' => $cart_info['id']), $data);
        }

        if (!$result) {
            $this->failure(0, '加入购物车失败');
        }
        $this->success(1, '加入购物车成功');
    }

    /**
     * 改变购物车数量
     * @author 王立
     */
    public function change_cart_quantity()
    {
        $cart_id = $this->get_uint('cart_id');
        $quantity = $this->get_uint('quantity');
        $this->check_user();
        $uid = $this->uid;

        $cart = $this->check_cart(array('id' => $cart_id, 'user_id' => $uid));
        $this->check_goods($uid, $cart['goods_id']);
        $this->check_stock($cart['goods_id'], $cart['sku_id'], $quantity);
        if ($quantity == $cart['quantity']) {
            $this->success(1, '购物车商品数量未改变');
        }
        $result = $this->business_model->update_cart(array('id' => $cart['id']), array('quantity' => $quantity));
        if (!$result) {
            $this->failure(0, '购物车商品数量修改失败');
        }
        $this->success(2, '购物车商品数量修改成功');
    }

    /**
     * 修改购物车商品属性前置操作
     * @author 王立
     */
    public function pre_cart_spec()
    {
        $cart_id = $this->get_uint('cart_id');
        $this->check_user();
        $uid = $this->uid;

        $cart_info = $this->check_cart(array('user_id' => $uid, 'id' => $cart_id));
        //商品是否开启SKU
        $goods = $this->check_goods($uid, $cart_info['goods_id']);
        if ($goods['enable_sku'] == 0) {
            $this->failure(0, '此商品无SKU,不支持此操作');
        }
        $data['cart_id'] = $cart_info['id'];
        //获取该商品SKU
        $data['skuMap'] = $this->business_model->sku_map($cart_info['goods_id']);
        $data['skuPart'] = $this->business_model->sku_part($cart_info['goods_id']);
        $goods_attr = $this->business_model->get_goods_attr(array('sku_id' => $cart_info['sku_id']));
        foreach ($goods_attr as $v) {
            $data['current_sku'][] = $v['attr_name_id'] . ':' . $v['attr_value_id'];
        }
        $data['quantity'] = $cart_info['quantity'];
        $this->success(1, '启动SKU成功', $data);
    }

    /**
     * 修改购物车商品属性后置操作
     * @author 王立
     */
    public function post_cart_spec()
    {
        $cart_id = $this->get_uint('cart_id');
        $sku_id = $this->get_uint('sku_id');
        $quantity = $this->get_uint('quantity');
        $this->check_user();
        $uid = $this->uid;

        /*$cart_id = 9;
        $sku_id = 2250;
        $quantity = 1;
        $uid = 2091722698;*/

        $cart_info = $this->check_cart(array('user_id' => $uid, 'id' => $cart_id));
        $goods = $this->check_goods($uid, $cart_info['goods_id']);
        if ($goods['enable_sku'] == 0) {
            $this->failure(0, '此商品无SKU,不支持此操作');
        }
        if ($cart_info['sku_id'] == $sku_id && $cart_info['quantity'] == $quantity) {
            $this->success(1, '购物车商品无需改变');
        }
        $cart_repeat = $this->check_cart(array('user_id' => $uid, 'sku_id' => $sku_id, 'del' => 0), false);
        if ($cart_repeat && $cart_info['sku_id'] != $sku_id) {
            $goods_sku = $this->check_goods_sku($cart_info['goods_id'], $sku_id);
            $change['quantity'] = $cart_repeat['quantity'] + $quantity;
            if ($change['quantity'] > $goods_sku['stock'])
                $change['invalid'] = 1;
            $result = $this->business_model->update_cart(array('id' => $cart_repeat['id']), $change);
        } else {
            $specification = $this->business_model->spec_info($sku_id, $goods['goods_id']);
            $result = $this->business_model->update_cart(array('id' => $cart_id), array('sku_id' => $sku_id, 'specification' => $specification, 'quantity' => $quantity));
        }
        if (!$result) {
            $this->failure(0, '购物车商品修改失败');
        }
        $this->success(2, '购物车商品修改成功');
    }

    /**
     * 删除购物车
     * @author 王立
     */
    public function del_cart()
    {
        $cart_id = $this->get_uint('cart_id');
        $this->check_user();
        $uid = $this->uid;

        $this->check_cart(array('id' => $cart_id, 'user_id' => $uid), true, false);
        $result = $this->business_model->update_cart(array('id' => $cart_id), array('del' => 1));
        if (!$result) {
            $this->failure(0, '购物车商品删除失败');
        }
        $this->success(1, '购物车商品删除成功');
    }

    /**
     * 我的购物车
     * @author 王立
     */
    public function my_cart()
    {
        $this->check_user();
        $uid = $this->uid;
        $mycart = $this->business_model->mycart($uid);
        $failure = array();
        $effective = array();
        foreach ($mycart as $v) {
            $v['store_id'] || $this->failure(0, '店铺编号:' . $v['store_id'] . '不存在');
            $v['goods_id'] || $this->failure(0, '商品编号:' . $v['goods_id'] . '不存在');

            $invalid = $v['invalid'];
            if ($invalid == 0) {
                $v['if_show'] != 1 && $invalid = 1;
                $v['closed'] == 1 && $invalid = 1;
                $v['is_del'] == 1 && $invalid = 1;
                $v['sku_id'] || $invalid = 1;
            }
            if ($v['quantity'] > $v['stock']) {
                $invalid = 1;
            }

            $info = array(
                'cart_id' => $v['id'],
                'goods_id' => $v['goods_id'],
                'goods_img' => img_url($v['default_image']),
                'goods_name' => $v['goods_name'],
                'enable_spec' => $v['specification'] ? 1 : 0,
                'specification' => $v['specification'],
                'price' => $v['price'],
                'quantity' => $v['quantity'],
                'invalid' => $invalid
            );

            if ($invalid) {
                if (!isset($failure[$v['store_id']])) {
                    $failure[$v['store_id']]['store_id'] = $v['store_id'];
                    $failure[$v['store_id']]['store_name'] = $v['store_name'];
                    $failure[$v['store_id']]['goods'][] = $info;
                } else {
                    $failure[$v['store_id']]['goods'][] = $info;
                }
            } else {
                if (!isset($effective[$v['store_id']])) {
                    $effective[$v['store_id']]['store_id'] = $v['store_id'];
                    $effective[$v['store_id']]['store_name'] = $v['store_name'];
                    $effective[$v['store_id']]['goods'][] = $info;
                } else {
                    $effective[$v['store_id']]['goods'][] = $info;
                }
            }
        }
        $data = array_merge(array_values($effective), array_values($failure));
        $this->success(0, '我的购物车', $data);
    }

    /**
     * 商品收藏
     * @author 王立
     */
    public function goods_collect()
    {
        $goods_id = $this->get_uint('goods_id');
        $this->check_user();
        $uid = $this->uid;

        $this->check_goods($uid, $goods_id);
        $this->check_collect(array('user_id' => $uid, 'type' => 1, 'target_id' => $goods_id), true);
        $collect = array(
            'user_id' => $uid,
            'target_id' => $goods_id,
            'add_time' => time()
        );
        $result = $this->business_model->add_collect($collect);
        if (!$result) {
            $this->failure(0, '收藏失败，请稍后重试');
        }
        $this->success(1, '收藏成功');
    }

    /**
     * 店铺收藏
     * @author 王立
     */
    public function store_collect()
    {
        $store_id = $this->get_uint('store_id');
        $this->check_user();
        $uid = $this->uid;

        $this->check_store($uid, $store_id);
        $this->check_collect(array('user_id' => $uid, 'type' => 2, 'target_id' => $store_id), true);
        $collect = array(
            'user_id' => $uid,
            'target_id' => $store_id,
            'type' => 2,
            'add_time' => time()
        );
        $result = $this->business_model->add_collect($collect);
        if (!$result) {
            $this->failure(0, '收藏失败，请稍后重试');
        }
        $this->success(1, '收藏成功');
    }

    /**
     * 删除收藏
     * @author 王立
     */
    public function del_collect()
    {
        $collect_id = $this->get_uint('collect_id');
        $this->check_user();
        $uid = $this->uid;

        $this->check_collect(array('user_id' => $uid, 'id' => $collect_id));
        $result = $this->business_model->del_collect(array('id' => $collect_id));
        if (!$result) {
            $this->failure(0, '删除失败，请稍后重试');
        }
        $this->success(1, '删除成功');
    }

    /**
     * 商品详情下单
     * @author 王立
     */
    public function buy_from_goods()
    {
        $goods_id = $this->get_uint('goods_id');
        $sku_id = $this->get_uint('sku_id');
        $quantity = $this->get_uint('quantity');
        $this->check_user();
        $uid = $this->uid;

        //商品信息
        $goods = $this->check_goods($uid, $goods_id);
        //属性信息
        $goods_sku = $this->check_stock($goods_id, $sku_id, $quantity);
        //获取收货地址
        $addr = $this->business_model->default_addr(array('user_id' => $uid));

        $data['store_id'] = $goods['store_id'];
        $data['store_name'] = $goods['store_name'];
        $data['goods'][] = array(
            'goods_id' => $goods_id,
            'sku_id' => $sku_id,
            'goods_img' => img_url($goods['default_image']),
            'goods_name' => $goods['goods_name'],
            'price' => $goods_sku['price'],
            'quantity' => $quantity,
            'spec_info' => $this->business_model->spec_info($sku_id, $goods_id)
        );
        $data['total'] = $goods_sku['price'] * $quantity;
        $output['addr'] = $addr;
        $output['info'][] = $data;
        $output['from_cart'] = 0;
        //支付方式
        $output['payment'] = array_column($this->business_model->get_payment(), 'payment_id');
        $this->load->library('Hulianpay');
        $output['balance'] = $this->hulianpay->get_user_amount($uid);
        if ($this->hulianpay->hlpay_error) {
            $this->failure(1, $this->hulianpay->hlpay_error);
        }
        $this->success(1, '确认订单成功', $output);
    }

    /**
     * 购物车下单
     * @author 王立
     */
    public function buy_from_cart()
    {
        $cartIds_json = $this->get_string('cartIds_json');
        $this->check_user();
        $uid = $this->uid;

        $cartIds = json_decode($cartIds_json, true);
        if (!is_array($cartIds) || !$cartIds) {
            $this->failure(0, 'json解析错误，json=' . $cartIds_json);
        }
        $mycart = $this->business_model->mycart($uid, $cartIds);
        if (count($cartIds) != count($mycart)) {
            $this->failure(0, '与购物车商品不匹配');
        }
        foreach ($mycart as $v) {
            $v['store_id'] || $this->failure(0, '店铺编号:' . $v['store_id'] . '不存在');
            $v['goods_id'] || $this->failure(0, '商品编号:' . $v['goods_id'] . '不存在');
            $v['sku_id'] || $this->failure(0, 'SKU编号:' . $v['sku_id'] . '不存在');

            $v['invalid'] == 1 && $this->failure(0, '购物车编号:' . $v['id'] . '失效');
            if ($v['invalid'] == 0) {
                $v['if_show'] != 1 && $this->failure(0, '商品下架，购物车编号:' . $v['id'] . '失效');
                $v['closed'] == 1 && $this->failure(0, '商品禁售，购物车编号:' . $v['id'] . '失效');
                $v['is_del'] == 1 && $this->failure(0, '商品删除，购物车编号:' . $v['id'] . '失效');
            }
            if ($v['quantity'] > $v['stock']) {
                $this->failure(0, '数量大于商库存，购物车编号:' . $v['id'] . '失效');
            }
            $goods_group = array(
                'goods_id' => $v['goods_id'],
                'sku_id' => $v['sku_id'],
                'goods_img' => img_url($v['default_image']),
                'goods_name' => $v['goods_name'],
                'price' => $v['price'],
                'quantity' => $v['quantity'],
                'spec_info' => $v['specification']
            );
            if (!isset($data[$v['store_id']])) {
                $data[$v['store_id']]['store_id'] = $v['store_id'];
                $data[$v['store_id']]['store_name'] = $v['store_name'];
                $data[$v['store_id']]['goods'][] = $goods_group;
            } else {
                $data[$v['store_id']]['goods'][] = $goods_group;
            }
            if (!isset($data[$v['store_id']]['total']))
                $data[$v['store_id']]['total'] = 0;

            $data[$v['store_id']]['total'] += $v['price'] * $v['quantity'];
        }
        //获取收货地址
        $addr = $this->business_model->default_addr(array('user_id' => $uid));
        $output['addr'] = $addr;
        $output['info'] = array_values($data);
        $output['from_cart'] = 1;
        //支付方式
        $output['payment'] = array_column($this->business_model->get_payment(), 'payment_id');
        $this->load->library('Hulianpay');
        $output['balance'] = $this->hulianpay->get_user_amount($uid);
        if ($this->hulianpay->hlpay_error) {
            $this->failure(1, $this->hulianpay->hlpay_error);
        }
        $this->success(1, '确认订单成功', $output);
    }

    /**
     * 买家订单列表购买
     * @author 王立
     */
    public function buy_from_order()
    {
        $orderIds_json = $this->get_string('orderIds_json');
        $this->check_user();
        $uid = $this->uid;
        $orderIds = json_decode($orderIds_json, true);

        if (!is_array($orderIds) || !$orderIds) {
            $this->failure(0, 'json解析错误，json=' . $orderIds_json);
        }
        $orders = $this->business_model->check_order(array('buyer_id' => $uid, 'order_status' => ORDER_UNPAY), $orderIds);
        if (count($orderIds) != count($orders)) {
            $this->failure(0, '订单状态错误');
        }
        $data['ordersSn'] = array_column($orders, 'order_sn');
        $data['ordersIds'] = array_column($orders, 'order_id');
        $data['total'] = array_sum(array_column($orders, 'discount'));
        $data['payment'] = array_column($this->business_model->get_payment(), 'payment_id');
        $this->load->library('Hulianpay');
        $data['balance'] = $this->hulianpay->get_user_amount($uid);
        if ($this->hulianpay->hlpay_error) {
            $this->failure(1, $this->hulianpay->hlpay_error);
        }

        $this->success(1, '确认订单成功', $data);
    }

    /**
     * 删除订单
     * @author 王立
     */
    public function del_order()
    {
        $this->check_user();
        $uid = $this->uid;

        $order_id = $this->get_uint('order_id');
        $this->check_order($order_id, $uid, array(ORDER_CANCELED, ORDER_FINISHED));
        $result = $this->business_model->update_order(array('order_id' => $order_id), array('del_status' => 1));
        if (!$result) {
            $this->failure(3, '删除失败');
        }
        $this->success(1, '删除成功');
    }

    /**
     * 取消订单
     * @author 王立
     */
    public function cancel_order()
    {
        $this->check_user();
        $uid = $this->uid;
        $order_id = $this->get_uint('order_id');

        $this->check_order($order_id, $uid, ORDER_UNPAY);
        $result = $this->business_model->cancelOrder($order_id);
        if (!$result) {
            $this->failure(2, '取消失败');
        }
        $this->success(1, '取消成功');
    }

    /**
     * 延长收货
     * @author 王立
     */
    public function extend_confirm()
    {
        $this->check_user();
        $uid = $this->uid;
        $order_id = $this->get_uint('order_id');

        $order = $this->check_order($order_id, $uid, ORDER_SHIPPED);
        if ($order['extend_confirm']) {
            $this->failure(2, '订单已经延长确认收货');
        }
        if ((($order['auto_comfirm_time'] - time())) > self::EXTEND_CONFIRM_TIME) {
            $this->failure(3, '当前时间不可延长');
        }
        $result = $this->business_model->extendConfirm($order_id, self::EXTEND_CONFIRM_TIME);
        if (!$result) {
            $this->failure(4, '延长收货失败');
        }
        $this->success(1, '延长收货成功');
    }

    /**
     * 属性组存在
     * @param $goods_id 商品ID
     * @param $sku_id skuid
     * @return mixed
     * @author 王立
     */
    protected function check_goods_sku($goods_id, $sku_id)
    {
        $sku_info = $this->business_model->get_goods_sku(array('goods_id' => $goods_id, 'sku_id' => $sku_id));
        if (!$sku_info) {
            $this->failure(1, '该商品SKUID不存在');
        }
        return $sku_info;
    }

    /**
     * 检测商品库存和购买数
     * @param $goods_id 商品ID
     * @param $sku_id skuid
     * @param $quantity 购买数量
     * @return mixed
     * @author 王立
     */
    protected function check_stock($goods_id, $sku_id, $quantity)
    {
        $goods_sku = $this->check_goods_sku($goods_id, $sku_id);
        if ($goods_sku['stock'] == 0) {
            $this->failure(2, '该商品库存为0');
        }
        if ($quantity > $goods_sku['stock']) {
            $this->failure(3, '数量大于商品库存');
        }
        return $goods_sku;
    }

    /**
     * 检查商品ID
     * @param $user_id 用户ID
     * @param $goods_id 商品ID
     * @return mixed
     * @author 王立
     */
    protected function check_goods($user_id, $goods_id)
    {
        $goods_info = $this->business_model->get_goods(array('goods_id' => $goods_id));
        if (!$goods_info) {
            $this->failure(4, '该商品不存在');
        }
        if ($goods_info['is_del'] == 1) {
            $this->failure(5, '该商品已删除');
        }
        if ($goods_info['closed'] == 1) {
            $this->failure(6, '该商品已被禁售');
        }
        if ($goods_info['if_show'] != 1) {
            $this->failure(7, '该商品未上架');
        }
        if ($goods_info['store_id'] == $user_id) {
            $this->failure(8, '该商品为自己的商品');
        }
        return $goods_info;
    }

    /**
     * 检测购物车
     * @param $conditon 查询条件
     * @param bool $check_null 对查询结果为空是否敏感，默认敏感
     * @param bool $check_invalid 是否检测商品失效，默认检测
     * @param bool $err_display 是否输出错误模板，默认输出
     * @return bool
     * @author 王立
     */
    protected function check_cart($conditon, $check_null = true, $check_invalid = true, $err_display = true)
    {
        $cart = $this->business_model->get_cart($conditon);
        if ($check_null === true) {
            if (!$cart) {
                $err_display && $this->failure(9, '购物车中该商品不存在');
                return false;
            } elseif (isset($cart['del']) && $cart['del'] == 1) {
                $err_display && $this->failure(10, '购物车中该商品已删除');
                return false;
            } elseif (isset($cart['invalid']) && $check_invalid === true && $cart['invalid'] == 1) {
                $err_display && $this->failure(11, '购物车中该商品已失效');
                return false;
            }
        }
        return $cart;
        /*if (!$cart && $check_null === true) {
            $err_display && $this->failure(9, '购物车中该商品不存在');
            return false;
        }
        if (isset($cart['del']) && $cart['del'] == 1) {
            $err_display && $this->failure(10, '购物车中该商品已删除');
            return false;
        }
        if (isset($cart['invalid']) && $check_invalid === true && $cart['invalid'] == 1) {
            $err_display && $this->failure(11, '购物车中该商品已失效');
            return false;
        }
        return $cart;*/
    }

    /**
     * 检测店铺
     * @param $user_id 用户ID
     * @param $store_id 店铺ID
     * @return mixed
     * @author 王立
     */
    protected function check_store($user_id, $store_id)
    {
        $store = $this->business_model->get_store(array('store_id' => $store_id));
        if (!$store) {
            $this->failure(12, '该店铺不存在');
        }
        if ($store['status'] == 0) {
            $this->failure(13, '该店铺已关闭');
        }
        if ($store_id == $user_id) {
            $this->failure(14, '该店铺为自己的店铺');
        }
        return $store;
    }

    /**
     * 检测收藏
     * @param $conditon 条件
     * @param null $existed 检测类型，null不存在报错，true存在报错
     * @return mixed
     * @author 王立
     */
    protected function check_collect($conditon, $existed = null)
    {
        $collect = $this->business_model->check_collect($conditon);
        if ($existed) {
            $collect && $this->failure(15, '该收藏已存在');
        } else {
            $collect || $this->failure(16, '该收藏不存在');
        }
        return $collect;
    }

    /**
     * 检测订单
     * @param $order_id 订单ID
     * @param $uid 用户ID
     * @param $order_status 订单状态条件
     * @return mixed
     * @author 王立
     */
    protected function check_order($order_id, $uid, $order_status = null)
    {
        $order = $this->business_model->get_order(array('order_id' => $order_id, 'buyer_id' => $uid));
        if (!$order) {
            $this->failure(0, '订单不存在');
        }
        if ($order['del_status'] != 0) {
            $this->failure(1, '订单已删除');
        }
        if ($order_status) {
            if (is_array($order_status)) {
                in_array($order['order_status'], $order_status) || $this->failure(2, '订单状态错误');
            } else {
                if ($order['order_status'] != $order_status) $this->failure(2, '订单状态错误');
            }
        }
        return $order;
    }
}