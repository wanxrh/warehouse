<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Mall extends BaseController
{

    public function __construct()
    {
        parent::__construct();
        $_SESSION['lao337']['MALL']['uid'] = 'o1teys8ZQeB8kfP7UQe3NHTI-d6w';
        $_SESSION['lao337']['MALL']['nickname'] = '（●—●）';
        $_SESSION['lao337']['MALL']['headimgurl'] = 'http://wx.qlogo.cn/mmopen/2ibiauvDg7obiaUSCH7X1EzGJpllf4jpksWloKUFm1AGnA5D8hGrTLGaNXKspQuwHFHZaQ1UYppaWdl5bY1Bzj5xYXVN59bSHn2/0';
        $this->ifLogin(__CLASS__);
        $this->load->model('MallModel');

    }

    public function index()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        //banner
        $data['banner'] = $this->MallModel->banner();
        // 推荐商品
        $data['recommend'] = $this->MallModel->getRecommendList();
        //全部商品
        $data['goods'] = $this->MallModel->goodsList();
        //分类
        $data['category'] = $this->_getCategory();

        $this->load->view('mall/index', $data);
    }

    public function detail($goods_id = 0)
    {
        $user_id = $this->_uid;
        if (!$goods_id) {
            return FALSE;
        }
        $data['cart_count'] = $this->_getMyCart($user_id);
        //分类
        $data['category'] = $this->_getCategory();

        $goods_id = intval($goods_id);

        $data['goods_info'] = $this->MallModel->getGoodsInfo($goods_id);
        $evaluation = $this->MallModel->evaluation($goods_id);
        $data['evaluation_num'] = $evaluation['people'];
        if (!$evaluation['people']) {
            $data['evaluation_score'] = 0;
        } else {
            $data['evaluation_score'] = bcdiv($evaluation['best'], $evaluation['people'], 2) * 100;
        }
        $this->load->view('mall/detail', $data);
    }

    public function evaluation($goods_id = 0)
    {
        $user_id = $this->_uid;
        if (!$goods_id) {
            return FALSE;
        }
        if (!isset($_GET['type'])) {
            $type = 2;
        } else {
            $type = intval($this->input->get('type', TRUE));
        }
        $data['list'] = $this->MallModel->goodsEvaluation($goods_id, $type);
        foreach ($data['list'] as &$v) {
            $v['user_name'] = $this->_substr_cut($v['user_name']);
        }

        $data['type'] = $type;
        $data['goods_id'] = $goods_id;
        $this->load->view('mall/evaluation', $data);
    }

    public function addToCollect()
    {
        if (!IS_POST) return FALSE;
        $user_id = $this->_uid;
        $goods_id = intval($this->input->post('goods_id', TRUE));

        if (!$goods_id) return FALSE;
        $goods = $this->MallModel->getRow('shop_goods', array('id' => $goods_id));
        if (!$goods) {
            ajaxError('商品已经删除！');
        } elseif (!$goods['is_show']) {
            ajaxError('商品已经下架！');
        }
        $this->MallModel->addCollect($user_id, $goods_id);
        ajaxSuccess('收藏成功！');
    }

    public function addToCart()
    {
        if (!IS_POST) return FALSE;
        $user_id = $this->_uid;
        $goods_id = intval($this->input->post('goods_id', TRUE));
        $num = intval($this->input->post('buyCount', TRUE));
        if (!$goods_id) return FALSE;
        $goods = $this->MallModel->getRow('shop_goods', array('id' => $goods_id));
        if (!$goods) {
            ajaxError('商品已经删除！');
        } elseif (!$goods['is_show']) {
            ajaxError('商品已经下架！');
        } elseif ($num > $goods['inventory']) {
            ajaxError('库存不足！');
        }

        $row = $this->MallModel->addCart($user_id, $goods, $num);
        echo $row;
        exit();
    }

    public function cart()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        if ($data['cart_count']) {
            $cart_list = $this->MallModel->cartList($user_id);
            $data['cart_list'] = array(
                'list' => '',
                'total' => 0
            );
            foreach ($cart_list as $v) {
                $data['cart_list']['list'][] = $v;
                $data['cart_list']['total'] += bcmul($v['price'], $v['num'], 2);
            }
        }
        $this->load->view('mall/cart', $data);
    }

    public function delCart()
    {
        if (!IS_POST) return FALSE;
        $user_id = $this->_uid;

        $ids = explode(',', trim($this->input->post('ids'), ','));
        if (!$ids) return FALSE;
        $row = $this->MallModel->delCart($user_id, $ids);
        echo $row;
        exit();
    }

    public function myCollect()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);

        $data['collect'] = $this->MallModel->getMyCollect($user_id);
        $this->load->view('mall/my_collect', $data);
    }

    public function myAddress()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);

        $data['address'] = $this->MallModel->getMyAddress($user_id);
        $this->load->view('mall/my_address', $data);
    }

    public function addAddress()
    {
        $user_id = $this->_uid;
        if (IS_POST) {
            $into = $this->input->post(NULL, TRUE);
            $into_id = $into['id'];
            $to = $into['from'];
            unset($into['id'], $into['from']);
            $into['uid'] = $user_id;
            $this->MallModel->dealAddress($into_id, $into);
            if ($to) {
                header('Location: /mall/chooseaddress');
            } else {
                header('Location: /mall/myaddress');
            }
            exit();
        }
        $data['from'] = intval($this->input->get('from', TRUE));
        $id = intval($this->uri->segment(3));
        $data['info'] = array(
            'id' => 0,
            'region_id' => '',
            'region_name' => '',
            'truename' => '',
            'mobile' => '',
            'address' => '',
            'is_use' => 0
        );
        $region_id = 0;
        if ($id) {
            $data['info'] = $this->MallModel->getAddressInfo($user_id, $id);
            $region_id = $data['info']['region_id'];
        }
        $init = array(
            'provice' => '',
            'city' => '',
            'country' => ''
        );
        $my = array(
            'provice' => 0,
            'city' => 0,
            'country' => 0
        );
        $this->MallModel->region($region_id, $init, $my);
        $data['region'] = $init;
        $data['myregion'] = $my;
        $this->load->view('mall/add_address', $data);
    }

    public function ajaxRegion()
    {
        if (!IS_POST) {
            return FALSE;
        }
        $parent_id = intval($this->input->post('parent_id'));
        $ret = $this->MallModel->ajaxRegion($parent_id);
        ajaxSuccess($ret);
    }

    public function confirmOrder()
    {

        if (IS_POST) {
            $data['rear'] = intval($this->input->get('rear', TRUE));
            $total_price = 0;
            $wages = 0;
            if (isset ($_POST ['goods_ids'])) {
                //Array ( [goods_ids] => Array ( [0] => 1 [1] => 2 ) [buyCount] => Array ( [1] => 3 [2] => 1 ) [checkAll] => on )
                $goods_ids = $this->input->post('goods_ids', TRUE);
                $buycount = $this->input->post('buyCount', TRUE);
                $data['list'] = $this->MallModel->confirmOrderGoods($goods_ids);

                foreach ($data['list'] as &$v) {
                    $v['num'] = $buycount[$v['id']];
                    $total_price += $v['price'] * $buycount[$v['id']];
                    $wages += bcmul($total_price, ($v['commission'] * 0.01), 2);
                }
            } else {
                //Array ( [goods_id] => 2 [buyCount] => 1 )
                $goods_id = intval($this->input->post('goods_id', TRUE));
                $buycount = intval($this->input->post('buyCount', TRUE));
                $data['list'] = $this->MallModel->confirmOrderGood($_POST['goods_id']);
                $goods = $this->MallModel->getRow('shop_goods', array('id' => $goods_id));
                $data['kill'] = $goods['kill'];

                $reserve = $this->MallModel->getRow('shop_breeding',array('goods_id'=>$goods_id));

                if ($reserve) {
                    $data['reserve'] = 1;
                    $data['reserve_time'] = $reserve['outtime'];
                } else {
                    $data['reserve'] = 0;
                }

                foreach ($data['list'] as &$v) {
                    $v['num'] = $buycount;
                    $total_price += $v['price'] * $buycount;
                    $wages += bcmul($total_price, ($v['commission'] * 0.01), 2);
                }
            }
            $data['total_price'] = $total_price;
            $data['wages'] = $wages;

            $_SESSION['confirm_order'] = $data;
        } else {
            $data = $_SESSION['confirm_order'];
        }
        $user_id = $this->_uid;
        $address_id = intval($this->input->get('address_id', TRUE));
        if ($address_id) {
            $data['address'] = $this->MallModel->getAddressInfo($user_id, $address_id);
        } else {
            $data['address'] = $this->MallModel->getOrderAddress($user_id);
        }
        $this->load->view('mall/confirm_order', $data);
    }

    public function addOrder()
    {
        $data ['uid'] = $this->_uid;
        $data ['username'] = $_SESSION['lao337']['MALL']['nickname'];
        $data ['address_id'] = intval($this->input->post('address_id', TRUE));
        if ($data['address_id']) {
            unset($data['address_id']);
        }
        $data ['remark'] = htmlspecialchars($this->input->post('remark', TRUE));

        $data ['order_number'] = $this->_gen_order_sn();
        $data ['cTime'] = time();
        $data ['pay_status'] = 0;

        //配送和宰杀
        $data['delivery'] = intval($this->input->post('delivery', true));
        $data['kill'] = intval($this->input->post('kill', true));

        $info = $_SESSION['confirm_order'];
        $data['reserve'] = $info['reserve'];
        //暂时关闭购物车，所以获取商品数组第一位
        $goods = $this->MallModel->getRow('shop_goods', array('id' => $info ['list'][0]['id']));

        $data ['total_price'] = $info ['total_price'] + $goods['kill'] * $info ['list'][0]['num'];
        $data ['wages'] = $info ['wages'];
        $data ['goods_datas'] = json_encode($info ['list']);
        if ($info['reserve']) {
            $data['reserve'] = $info['reserve'];
            $data['reserve_time'] = $info['reserve_time'];
        }
        $oid = $this->MallModel->createOrder($data);
        if (!$oid) {
            echo 0;
            exit;
        }
        if ($info['rear']) {
            $ids = array_column($info['list'], 'id');
            $this->MallModel->delUserCart($data['uid'], $ids);
        }
        echo $oid;
    }

    public function choosePay()
    {
        $user_id = $this->_uid;
        $data['order_id'] = intval($this->input->get('order_id', TRUE));

        $this->load->view('mall/choose_pay', $data);
    }

    public function doPay()
    {
        $user_id = $this->_uid;
        $paytype = intval($this->input->get('paytype', TRUE));
        $order_id = intval($this->input->get('order_id', TRUE));

        if ($paytype != 0 && $paytype != 11) {
            return FALSE;
        }
        if ($paytype == 11) {
            $data ['pay_type'] = 0;
            $data ['coupon'] = 1;
        } else {
            $data ['pay_type'] = $paytype;
        }
        $data ['status_code'] = $paytype == 10 ? 1 : 0;
        $map ['id'] = $order_id;

        $this->MallModel->updateOrderPay($map, $data);
        /*if($paytype == 10){
            $this->successJump('下单成功！','/mall/myorder');
            return;
        }*/
        $map['uid'] = $user_id;
        $map['id'] = $order_id;
        $order_info = $this->MallModel->getOrderInfo($map);
        if (!$order_info) {
            $this->errorJump('非法请求！');
            return;
        }
        $goodsdata = json_decode($order_info ['goods_datas'], TRUE);


        $param = array(
            'from' => urlencode($this->config->base_url() . 'pay/weixin'),
            'orderName' => urlencode($goodsdata [0] ['title']),
            'price' => $order_info ['total_price'],
            'token' => TOKEN,
            'wecha_id' => $order_info ['uid'],
            'paytype' => $paytype,
            'single_orderid' => $order_info ['order_number'],
            'showwxpaytitle' => 1
        );

        $payment_order = $this->MallModel->getPaymentOrder(array('single_orderid' => $order_info ['order_number']));
        if (!$payment_order) {
            $this->MallModel->addPaymentOrder($param);
            $param['paymentOid'] = $order_id;
        } else {
            $param['paymentOid'] = $order_id;
        }
        $url = '';
        foreach ($param as $k => $v) {
            $url .= $k . '=' . $v . '&';
        }
        $url = trim($url, '&');
        header('Location: /pay/weixin?' . $url);
    }

    public function chooseAddress()
    {
        $user_id = $this->_uid;
        $data['address'] = $this->MallModel->getMyAddress($user_id);
        $this->load->view('mall/choose_address', $data);
    }

    public function confirmGetGoods()
    {
        if (!IS_POST) {
            return FALSE;
        }
        $order_id = intval($this->uri->segment(3));
        if (!$order_id) {
            return FALSE;
        }
        $ret = $this->MallModel->setStatusCode($order_id, 4);
        if (!$ret) {
            ajaxError('确认失败！');
            return;
        }
        $this->load->model('CommissionModel');
        $result = $this->CommissionModel->commissionAction($order_id);
        if (!$result) {
            ajaxError('确认失败！');
            return;
        }
        ajaxSuccess('确认收货成功！');
    }

    public function comment()
    {
        if (!IS_POST) {
            return FALSE;
        }
        $user_id = $this->_uid;
        $oid = intval($this->input->post('oid', TRUE));
        $evaluation = $this->input->post('evaluation', TRUE);
        $evaluation_msg = $this->input->post('evaluation_msg', TRUE);
        $order_info = $this->MallModel->getOrderInfo(array('id' => $oid, 'uid' => $user_id));
        if (!$order_info) {
            $this->errorJump('评价失败！');
            return;
        }
        if (!$evaluation) {
            redirect('/mall/orderdetail/' . $oid);
        }
        foreach ($evaluation as $goods_id => $status) {
            $this->MallModel->commentGoods($user_id, $order_info, $goods_id, $status, trim($evaluation_msg[$goods_id]));
        }
        $this->successJump('评价成功！');
    }

    public function myOrder()
    {

        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['allClass'] = 'current';

        $map['uid'] = $user_id;
        $data['order_list'] = $this->MallModel->getOrderList($map);
        foreach ($data['order_list'] as &$v) {
            $v['goods_datas'] = json_decode($v['goods_datas'], TRUE);
            $v['status_code_name'] = $this->_status_code_name($v['status_code']);
        }
        $this->load->view('mall/order_list', $data);
    }

    public function unPayOrder()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['unPayClass'] = 'current';

        $map ['uid'] = $user_id;
        $map ['pay_status'] = 0;
        $data['order_list'] = $this->MallModel->getOrderList($map);
        foreach ($data['order_list'] as &$v) {
            $v['goods_datas'] = json_decode($v['goods_datas'], TRUE);
            $v['status_code_name'] = $this->_status_code_name($v['status_code']);
        }
        $this->load->view('mall/order_list', $data);
    }

    public function shippingOrder()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['shippingClass'] = 'current';

        $map ['uid'] = $user_id;
        $map ['is_send'] = 1;
        $data['order_list'] = $this->MallModel->getOrderList($map);
        foreach ($data['order_list'] as &$v) {
            $v['goods_datas'] = json_decode($v['goods_datas'], TRUE);
            $v['status_code_name'] = $this->_status_code_name($v['status_code']);
        }
        $this->load->view('mall/order_list', $data);
    }

    public function waitCommentOrder()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['waitClass'] = 'current';

        $map ['uid'] = $user_id;
        $map ['is_send'] = 2;
        $data['order_list'] = $this->MallModel->getOrderList($map);
        foreach ($data['order_list'] as &$v) {
            $v['goods_datas'] = json_decode($v['goods_datas'], TRUE);
            $v['status_code_name'] = $this->_status_code_name($v['status_code']);
        }
        $this->load->view('mall/order_list', $data);
    }

    public function orderDetail()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);

        $order_id = intval($this->uri->segment(3));
        if (!$order_id) return FALSE;

        $data['order_info'] = $this->MallModel->getOrderInfo(array('id' => $order_id, 'uid' => $user_id));
        if (!$data['order_info']) return FALSE;
        $data['order_info']['send_code_name'] = $this->_send_code_name($data['order_info']['send_code']);
        $data['address_info'] = $this->MallModel->getAddressInfo($user_id, $data['order_info']['address_id']);

        $data['goods_datas'] = json_decode($data['order_info']['goods_datas'], TRUE);
        $data['need_comment'] = 0;
        if ((count($data['goods_datas']) != count(array_column($data['goods_datas'], 'evaluation'))) && in_array($data['order_info']['status_code'], array(4, 5))) {
            $data['need_comment'] = 1;
        }
        $data['order_log'] = $this->MallModel->getOrderLog($order_id);
        $this->load->view('mall/order_detail', $data);
    }

    public function userCenter()
    {
        $user_id = $this->_uid;
        $data['nickname'] = $_SESSION['lao337']['MALL']['nickname'];
        $data['headimgurl'] = $_SESSION['lao337']['MALL']['headimgurl'];
        $data['cart_count'] = $this->_getMyCart($user_id);
        $this->load->view('mall/user_center', $data);
    }

    public function lists()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['category'] = $this->_getCategory();

        $data['search_key'] = trim($this->input->get('search_key', TRUE));
        $order_key = trim($this->input->get('order_key', TRUE));
        $order_type = trim($this->input->get('order_type', TRUE));
        $data['cate'] = intval($this->input->get('cate', TRUE));

        $data['list'] = $this->MallModel->searchGoodsLists($data['search_key'], $data['cate'], $order_key, $order_type);
        $this->load->view('mall/goods_lists', $data);
    }

    public function coupon()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['list'] = $this->MallModel->get_coupon($user_id);
        foreach ($data['list'] as &$v) {
            $v['goods_datas'] = json_decode($v['goods_datas'], true);
            $v['status'] = $this->coupon_type($v['status']);
        }
        $this->load->view('mall/coupon_list', $data);
    }

    public function couponView($coupon_id = 0)
    {
        if (!$coupon_id) {
            return false;
        }
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $coupon = $this->MallModel->coupon_view(array('owner_id' => $user_id, 'coupon_id' => $coupon_id));
        if (!$coupon)
            return false;
        $data['coupon'] = $coupon;
        $data['now'] = time();
        if ($coupon['status'] == 0) {
            $time = time();
            $data['confirm_coupon_url'] = 'http://pan.baidu.com/share/qrcode?w=300&h=300&url=' . $this->config->base_url() . 'coupon/exchange?id=' . $coupon['coupon_id'] . '%26time=' . $time . '%26sign=' . md5($coupon['sign'] . $time);
        }
        $order_id = $coupon['order_id'];
        $data['order_info'] = $this->MallModel->getOrderInfo(array('id' => $order_id, 'uid' => $user_id));
        if (!$data['order_info']) return FALSE;
        $data['address_info'] = $this->MallModel->getAddressInfo($user_id, $data['order_info']['address_id']);

        $data['goods_datas'] = json_decode($data['order_info']['goods_datas'], TRUE);
        $this->load->view('mall/coupon_view', $data);
    }

    private function _getCategory()
    {
        return $this->MallModel->getCategory();
    }

    private function _getMyCart($user_id)
    {
        return $this->MallModel->getCartCount($user_id);
    }

    private function _gen_order_sn()
    {
        /* 选择一个随机的方案 */
        mt_srand((double)microtime() * 1000000);
        $order_sn = date('YmdHi') . str_pad(mt_rand(1, 99999999), 8, '0', STR_PAD_LEFT);

        $orders = $this->MallModel->getRow('shop_order', array('order_number' => $order_sn));
        if (!$orders) {
            /* 否则就使用这个订单号 */
            return $order_sn;
        }
        /* 如果有重复的，则重新生成 */
        return $this->_gen_order_sn();
    }

    private function _substr_cut($user_name)
    {
        $strlen = mb_strlen($user_name, 'utf-8');
        $firstStr = mb_substr($user_name, 0, 1, 'utf-8');
        $lastStr = mb_substr($user_name, -1, 1, 'utf-8');
        return $strlen == 2 ? $firstStr . str_repeat('*', mb_strlen($user_name, 'utf-8') - 1) : $firstStr . str_repeat("*", $strlen - 2) . $lastStr;
    }

    public function reserve()
    {
        $user_id = $this->_uid;
        $search_key = trim($this->input->get('search_key', TRUE));
        $data['search_key'] = $search_key;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['list'] = $this->MallModel->reserveList($search_key);
        $this->load->view('mall/reserve', $data);
    }

    public function gift()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['list'] = $this->MallModel->get_gift($user_id);
        foreach ($data['list'] as &$v) {
            $v['status'] = $this->gift_type($v['status']);
        }
        $this->load->view('mall/gift_list', $data);
    }

    public function giftView($id = 0)
    {
        if (!$id) {
            return false;
        }
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $gift = $this->MallModel->gift_view(array('owner_id' => $user_id, 'shop_voucherinfo.id' => $id));
        if (!$gift)
            return false;
        $data['gift'] = $gift;
        $data['now'] = time();
        if ($gift['status'] == 1) {
            $time = time();
            $data['confirm_gift_url'] = 'http://pan.baidu.com/share/qrcode?w=300&h=300&url=' . $this->config->base_url() . 'coupon/present?id=' . $gift['id'] . '%26time=' . $time . '%26sign=' . md5($gift['sign'] . $time);
        }

        $data['gift'] = $gift;
        $this->load->view('mall/gift_view', $data);
    }

    public function lingyang()
    {
        $user_id = $this->_uid;

        $map['uid'] = $user_id;
        $map['reserve'] = 1;
        $data['list'] = $this->MallModel->getLingYangList($map);
        foreach ($data['list'] as &$v) {
            $v['goods_datas'] = json_decode($v['goods_datas'], TRUE);
            $v['status_code_name'] = $this->_status_code_name($v['status_code']);
        }
        $this->load->view('mall/lingyang_list', $data);
    }

    public function lingyangview()
    {
        $user_id = $this->_uid;

        $order_id = intval($this->uri->segment(3));
        if (!$order_id) return FALSE;

        $data['order_info'] = $this->MallModel->getOrderInfo(array('id' => $order_id, 'uid' => $user_id));
        if (!$data['order_info']) return FALSE;
        $data['order_info']['send_code_name'] = $this->_send_code_name($data['order_info']['send_code']);

        $data['address_info'] = '';
        if ($data['order_info']['address_id']) {
            $data['address'] = $this->MallModel->getAddressInfo($user_id, $data['order_info']['address_id']);
        } else {
            $address_id = intval($this->input->get('address_id', TRUE));
            if ($address_id) {
                $data['address'] = $this->MallModel->getAddressInfo($user_id, $address_id);
            } else {
                $data['address'] = $this->MallModel->getOrderAddress($user_id);
            }
        }
        $data['goods_datas'] = json_decode($data['order_info']['goods_datas'], TRUE);
        $data['need_comment'] = 0;
        if ((count($data['goods_datas']) != count(array_column($data['goods_datas'], 'evaluation'))) && in_array($data['order_info']['status_code'], array(4, 5))) {
            $data['need_comment'] = 1;
        }
        $data['order_log'] = $this->MallModel->getOrderLog($order_id);

        $this->load->view('mall/lingyang_detail', $data);
    }

    public function submit_lingyang()
    {
        if (!IS_POST) {
            return false;
        }
        $order_id = intval($this->input->post('oid'));
        $addr_id = intval($this->input->post('address_id'));
        $delivery = intval($this->input->post('delivery'));
        $kill = intval($this->input->post('kill'));

        $data['delivery'] = $delivery;
        $data['kill'] = $kill;
        if ($addr_id) {
            $data['address_id'] = $addr_id;
        }
        $result = $this->MallModel->update('shop_order', array('id' => $order_id), $data);
        if($delivery == 2){
            $order = $this->MallModel->getRow('shop_order', array('id' => $order_id));
            $coupon = array(
                'owner_id' => $order['uid'],
                'sign' => md5($order['id'] . $order['order_number'] . $order['cTime'] . $order['uid'] . $order['uid']),
                'order_id' => $order['id'],
                'get_time' => time()
            );
            $this->MallModel->insert('shop_coupon', $coupon);
        }
        if (!$result) {
            $this->errorJump('确认失败');
            return;
        }
        if($delivery == 2){
            $this->successJump('确认成功', '/mall/coupon');
        }else{
            $this->successJump('确认成功', '/mall/lingyangview/' . $order_id);
        }

    }

    public function service()
    {
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['list'] = $this->MallModel->get_store();
        $this->load->view('mall/service_point', $data);
    }

    public function serviceInfo()
    {
        $id = intval($this->uri->segment(3));
        $user_id = $this->_uid;
        $data['cart_count'] = $this->_getMyCart($user_id);
        $data['list'] = $this->MallModel->get_store_info($id);
        if (!$data['list']) {
            $this->errorJump('获取信息失败！');
            return;
        }
        $data['store_goods'] = $this->MallModel->get_store_goods($data['list']['id']);
        $this->load->view('mall/service_point_info', $data);
    }
    public function farming(){
        $this->per_page = 1;
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;
        $data = $this->MallModel->shop_breeding($this->per_page, $this->offset);
        $url_format = "/admin/breeding/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
        $data['cur_page'] = $this->cur_page;
        //计算分页
        $start = $this->cur_page-1;
        if($start==0)$start=1;
        $data['start'] = $start;
        $end = $this->cur_page+1;
        if($end>$data['total'])$end =$data['total'];
        $data['end'] = $end;
        $this->load->view('mall/farming',$data);
    }
}
