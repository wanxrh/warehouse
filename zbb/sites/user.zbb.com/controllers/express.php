<?php

/**
 * 用户中心控制器
 */
class Express extends User_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('express_model');
    }

    public function lists()
    {
        $this->load->view('express/lists');
    }

    public function send()
    {
        $user_id = get_user()['id'];
        $order_id = intval($this->input->get('order_id'));
        //判断订单是否输入自己的
        $ret = $this->express_model->check_order($order_id, $user_id);
        if (!$ret) {
            show_error('不属于自己的订单');
        }
        $order_id = $ret['order_id'];
        $data['order_info'] = $ret;
        $data['order_goods'] = $this->express_model->order_goods($order_id);
        $data['order_extm'] = $order_extm = $this->express_model->get_order_extm($order_id);
        //分别获取省市先数据
        $data['province'] = $this->express_model->get_region(0);
        $data['city'] = $this->express_model->get_region($order_extm['province_id']);
        $data['country'] = $this->express_model->get_region($order_extm['city_id']);


        //判断是否有退货地址
        $address = $this->express_model->check_order_address($user_id);
        $data['address'] = $address ? 1 : 0;

        $this->load->view('express/send', $data);
    }

    public function get_region()
    {
        $parent_id = intval($this->input->post('parent_id'));
        $ret = $this->express_model->get_region($parent_id);
        ajax_success($ret);

    }

    public function address_ajax()
    {
        $posts = $this->input->post(NULL, TRUE);
        $post = json_decode($posts['add'], true);
        $order_id = $posts['order_id'];
        $data = array(
            'consignee' => $post['consignee'],
            'province_id' => $post['province_id'],
            'city_id' => $post['city_id'],
            'country_id' => $post['country_id'],
            'region_name' => $post['region_name'],
            'address' => $post['address'],
            'zipcode' => $post['zipcode'],
            'tel' => $post['tel'],
            'mobile' => $post['mobile'],
        );
        $ret = $this->express_model->update_address($order_id, $data);

        if ($ret) {
            ajax_success('修改成功');
        } else {
            ajax_error('修改失败');
        }
    }

    //发货信息
    public function shipments()
    {
        if(!IS_POST){
            return false;
        }
        $user_id = get_user()['id'];
        $order_id = filter_sql($this->input->post('order_id'));
        $express_name = filter_sql($this->input->post('express_name'));//快递公司
        $invoice_no = filter_sql($this->input->post('invoice_no'));//快递单号
        $comment = filter_sql($this->input->post('comment'));//备注

        if(!$express_name || !$invoice_no){
            ajax_error('发货信息不全');
        }

        if (!$this->express_model->check_order($order_id, $user_id, ORDER_PAID)) {
            show_error('订单或者订单状态错误');
        }

        $ret = $this->express_model->save_shipments($order_id, $express_name, $invoice_no, $comment);

        if (!$ret) {
            ajax_error('发货失败');
        }
        ajax_success('发货成功');
    }
}