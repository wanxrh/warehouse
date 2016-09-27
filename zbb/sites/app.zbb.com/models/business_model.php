<?php

/*
 * 交易模型
 */
require "app_model.php";

class Business_model extends App_model
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 获取单条订单
     * @param $condition 条件
     * @return mixed
     */
    public function get_order($condition)
    {
        return $this->db->where($condition)->get('order')->row_array();
    }

    /**
     * 获取订单商品
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_order_goods($condition)
    {
        return $this->db->where($condition)->get('order_goods')->row_array();
    }

    /**
     * 获取一条商品属性组信息
     * @param $condition
     * @return mixed
     */
    public function get_goods_sku($condition)
    {
        return $this->db->where($condition)->get('goods_sku')->row_array();
    }

    /**
     * 获取商品信息
     * @param $condition
     * @return mixed
     */
    public function get_goods($condition)
    {
        return $this->db->select('store.store_name,goods.*')->where($condition)->join('store', 'goods.store_id = store.store_id', 'left')->get('goods')->row_array();
    }

    /**
     * 获取地址
     * @param $condition 条件
     * @param int $type 地址类型
     * @return mixed
     */
    public function default_addr($condition, $type = 0)
    {
        $this->db->select('addr_id,consignee,mobile,region_name,address')->where('type', $type);
        return $this->db->where($condition)->order_by('is_default,addr_id', 'desc')->get('address')->row_array();
    }

    /**
     * 获取商品属性名称
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_attr_name($condition)
    {
        return $this->db->where($condition)->get('attr_name')->result_array();
    }

    /**
     * 获取商品属性值
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_attr_value($condition)
    {
        return $this->db->where($condition)->get('attr_value')->result_array();
    }

    /**
     * 获取商品属性
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_goods_attr($condition)
    {
        return $this->db->where($condition)->get('goods_attr')->result_array();
    }

    /**
     * 加入购物车
     * @param $data 数据
     * @return mixed
     */
    public function insert_cart($data)
    {
        $this->db->insert('cart', $data);
        return $this->db->insert_id();
    }

    /**
     * 购物车商品信息
     * @param $condition 条件
     * @return mixed
     */
    public function get_cart($condition)
    {
        return $this->db->where($condition)->get('cart')->row_array();
    }

    /**
     * 更新购物车商品
     * @param $conditon
     * @param $data
     * @return mixed
     */
    public function update_cart($conditon, $data)
    {
        $this->db->where($conditon)->update('cart', $data);
        return $this->db->affected_rows();
    }

    /**
     * 我的购物车查询
     * @param $user_id 用户ID
     * @param null $in_cartId where in $cart_id
     * @return mixed
     */
    public function mycart($user_id, $in_cartId = null)
    {
        $this->db->select('store.store_name,store.store_id,cart.id,cart.quantity,cart.specification,cart.invalid,goods.goods_id,goods.goods_name,goods.default_image,goods.if_show,goods.closed,goods.is_del,goods_sku.sku_id,goods_sku.stock,goods_sku.price');
        $this->db->where(array('user_id' => $user_id, 'del' => 0));
        if ($in_cartId) {
            $this->db->where_in('cart.id', $in_cartId);
        }
        $this->db->join('goods', 'goods.goods_id = cart.goods_id', 'inner');
        $this->db->join('goods_sku', 'goods_sku.sku_id = cart.sku_id', 'inner');
        $this->db->join('store', 'store.store_id = goods.store_id', 'inner');
        $this->db->order_by('invalid', 'ASC');
        $this->db->order_by('cart.id', 'DESC');
        return $this->db->get('cart')->result_array();
    }

    /**
     * 全部可用支付渠道
     * @return mixed
     */
    public function get_payment()
    {
        return $this->db->select('payment_id')->where('enabled', 1)->order_by('sort_order', 'ASC')->get('payment')->result_array();
    }

    /**
     * 订单查询
     * @param $conditon 查询条件
     * @param $orderIds orderID数组
     * @return mixed
     */
    public function check_order($conditon, $orderIds)
    {
        return $this->db->where($conditon)->where_in('order_id', $orderIds)->get('order')->result_array();
    }

    /**
     * 检查收藏表
     * @param $condition 参训条件
     * @return mixed
     */
    public function check_collect($condition)
    {
        return $this->db->where($condition)->get('collect')->row_array();
    }

    /**
     * 加入收藏夹
     * @param $data 数据
     * @return mixed
     */
    public function add_collect($data)
    {
        $this->db->insert('collect', $data);
        return $this->db->affected_rows();
    }

    /**
     * 删除收藏
     * @param $condition 条件
     * @return mixed]
     */
    public function del_collect($condition)
    {
        $this->db->where($condition)->delete('collect');
        return $this->db->affected_rows();
    }

    /**
     * 获取店铺信息
     * @param $condition 查询条件
     * @return mixed
     */
    public function get_store($condition)
    {
        return $this->db->where($condition)->get('store')->row_array();
    }

    /**
     * 更新订单信息，删除状态等等
     * @param $condition 查询条件
     * @param $data 更新数据
     * @return mixed
     */
    public function update_order($condition, $data)
    {
        $this->db->where($condition)->update('order', $data);
        return $this->db->affected_rows();
    }

    /**
     * 取消订单
     * @param $order_id 订单ID
     * @return bool
     */
    public function cancelOrder($order_id)
    {
        $this->db->trans_begin();

        $this->db->where('order_id', $order_id)->update('order', array('finished_time' => time(), 'order_status' => ORDER_CANCELED));
        $this->db->where('order_id', $order_id)->update('order_goods', array('order_goods_status' => ORDER_GOODS_CANCELED));
        //删除取消订单，定时器
        $this->db->where(array('type' => CANCEL_TIMER, 'target_id' => $order_id))->delete('tasktimer');
        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }

    /**
     * 延长确认收货
     * @param $order_id 订单ID
     * @param $extend_confirm_time 延长时间
     * @return bool
     */
    public function extendConfirm($order_id, $extend_confirm_time)
    {
        $this->db->trans_begin();

        $this->db->where('order_id', $order_id)->set(array('auto_comfirm_time' => 'auto_comfirm_time + ' . $extend_confirm_time, 'extend_confirm' => 1), null, false)->update('order');
        $this->db->where(array('type' => COMFIRM_TIMER, 'target_id' => $order_id))->set('plan_time', 'plan_time + ' . $extend_confirm_time, false)->update('tasktimer');

        if ($this->db->trans_status() === false) {
            $this->db->trans_rollback();
            return false;
        } else {
            $this->db->trans_commit();
            return true;
        }
    }
}