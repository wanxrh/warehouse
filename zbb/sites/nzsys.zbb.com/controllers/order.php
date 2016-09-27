<?php

/*
 * 后台订单管理控制器
 */

class Order extends Admin_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('order_model');
        $this->load->model('payment_model');
        //每页显示的条数
        $this->per_page = 10;
        //当前页
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        //当前页从第几条数据开始
        $this->offset = ($this->cur_page - 1) * $this->per_page;
    }

    /*
     * 默认首页
     */

    public function index() {

        //获取关键字
        $field = $this->input->get('field', TRUE);
        $search_name = $this->input->get('search_name', TRUE);
        //获取订单状态
        $status = $this->input->get('order_status', TRUE);
        $payment_id =$this->input->get('payment_id', TRUE);
        //获取下单时间（订单生成时间）。
        $add_time_from = $this->input->get('add_time_from', TRUE);
        $add_time_to = $this->input->get('add_time_to', TRUE);
        if ($add_time_to != '') {
            $time_to = strtotime($add_time_to) + 3600 * 24;
        } else {
            $time_to = strtotime($add_time_to);
        }
        $pay_time_from = $this->input->get('pay_time_from', TRUE);
        $pay_time_to = $this->input->get('pay_time_to', TRUE);
        if ($pay_time_to != '') {
        	$pay_time_to = strtotime($pay_time_to) + 3600 * 24;
        } else {
        	$pay_time_to = strtotime($pay_time_to);
        }
        //获取订单金额
        $order_amount_from = $this->input->get('order_amount_from', TRUE);
        $order_amount_to = $this->input->get('order_amount_to', TRUE);
        //显示页码数
        $show_page = 5;
        //根据用户输入的条件进行订单查询，结合分页类使用
        $data = $this->order_model->get_search($field, $search_name, $status, strtotime($add_time_from), $time_to,strtotime($pay_time_from), $pay_time_to, $order_amount_from, $order_amount_to, $payment_id);        
        //获取所有的支付方式
        $data['payment'] = $this->payment_model->get_payments();
        $url = '/order/index/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['count'] / $this->per_page), $url, $show_page, TRUE, FALSE, $data['count']);
        $data['status_arr'] = empty($status) ? array() : $status;
        $this->load->view('order/order_index', $data);
    }
    
    /**
     * 订单商品列表
     */
    public function order_goods(){
    	$field = $this->input->get('field', TRUE);
    	$search_name = $this->input->get('search_name', TRUE);
		//获取下单时间（订单生成时间）。
        $add_time_from = strtotime($this->input->get('add_time_from', TRUE));
        $add_time_to = $this->input->get('add_time_to', TRUE);
		if ($add_time_to != '') {
            $time_to = strtotime($add_time_to) + 3600 * 24;
        } else {
            $time_to = strtotime($add_time_to);
        }
		//付款时间
		$pay_time_from = strtotime($this->input->get('pay_time_from', TRUE));
        $pay_time_to = $this->input->get('pay_time_to', TRUE);
        if ($pay_time_to != '') {
        	$pay_time_to = strtotime($pay_time_to) + 3600 * 24;
        } else {
        	$pay_time_to = strtotime($pay_time_to);
        }
        $finished_time_from = strtotime($this->input->get('finished_time_from', TRUE));
        $finished_time_to = $this->input->get('finished_time_to', TRUE);
        if ($finished_time_to != '') {
        	$finished_time_to = strtotime($finished_time_to) + 3600 * 24;
        } else {
        	$finished_time_to = strtotime($finished_time_to);
        }
    	//获取订单状态
    	$status = $this->input->get('status', TRUE);
    	//显示页码数
    	$show_page = 5;
    	//根据用户输入的条件进行订单查询，结合分页类使用
    	$data = $this->order_model->get_goods_search($field, $search_name, $status,$add_time_from,$time_to,$pay_time_from, $pay_time_to,$finished_time_from, $finished_time_to);
    	$url = '/order/order_goods/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
    	$data['page'] = page($this->cur_page, ceil($data['count'] / $this->per_page), $url, $show_page, TRUE, FALSE, $data['count']);
    	$data['status_arr'] = empty($status) ? array() : $status;
    	$total = 0;
    	foreach ($data['total'] as $v){
    		$total += $v['price']*$v['quantity'];
    	}
    	$data['total'] = $total;
    	$this->load->view('order/order_goods_index', $data);
    }

    /*
     * 查看详情
     */
    public function info() {
        $order_id = intval($this->input->get('id'));
        $data['order_info'] = $this->order_model->order_info($order_id);
        $data['goods'] = $this->order_model->get_goods($order_id);
        $this->load->view('order/order_info', $data);
    }
    /**
     * 订单商品详情
     */
    public function goods_info(){
    	$rec_id = intval($this->input->get('id'));
        $data['goods']=$this->order_model->get_order_goods($rec_id);
        $this->load->library('MongoOperate');
        $temp=$this->order_model->get_refund($rec_id);
        if($temp) {
            $data['log_arr'] = $this->refund_log($temp['id']);
        }
    	$this->load->view('order/order_goods_info', $data);
    }

    protected function refund_log($id)
    {
        //操作日志
        $where = array('apply_refund_id' => intval($id));
        $sort = array('apply_refund_id' => -1);
        return $this->mongooperate->find('refund_log', $where, array(), 0, 50, $sort);
    }

    /**
     * 物流信息
     */
    public function get_invoice_no($invoice_no,$shipping_name) {
        $this->load->library('express');
        $html = $this->express->getorder($invoice_no, $shipping_name);
        return $html;
    }

    /**
     * 导出xls
     */
    function exportxls() {
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment; filename=' . date("Ymd", time()) . '.xls');
        header('Pragma: no-cache');
        header('Expires: 0');

        $data = $this->_get_try_data();
        $title = array(
            '编号',
            '店铺名称',
            '订单号',
            '下单时间',
            '买家名称',
            '支付方式',
            '订单总价',
            '支付状态',
        );
        $arr = array();
        foreach ($data['list'] as $k => $v) {
        	$arr[$k]['order_id'] = $v['order_id'];
        	$arr[$k]['store_name'] = $v['store_name'];
        	$arr[$k]['order_sn'] = $v['add_time'];
        	$arr[$k]['add_time'] = date_formate($v['add_time'], $formate = TRUE);
        	$arr[$k]['buyer_name'] = $v['buyer_name'];
        	$arr[$k]['payment_name'] = $v['pay_time']?$v['payment_name']:'';
        	$arr[$k]['order_amount'] = $v['order_amount'];
        	$arr[$k]['pay_time'] = $v['pay_time']?'已支付：'.date_formate($v['pay_time'], $formate = TRUE):'未支付';
        }
        $arr[]['order_amount'] = '总金额：'.$data['total']['order_amount'];
        // 写入excle
        echo iconv('utf-8', 'gbk', implode("\t", $title)) . "\n";
        foreach ($arr as $val) {
        	echo iconv('utf-8', 'gbk', implode("\t", $val)) . "\n";
        }
    }

     /**
     * 订单商品导出xls
     */
    function export_xls() {
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment; filename=' . date("Ymd", time()) . '.xls');
        header('Pragma: no-cache');
        header('Expires: 0');
        $data = $this->_get_try_list();
        $title = array(
            '编号',
            '订单号',
			'店铺名称',
            '商品名称',
            '尺码颜色',
            '价格*数量',
            '商品状态',
			'小计'
        );	
        $arr = array();
        // 数据字段处理
        foreach ($data['list'] as $key => $value) {
            $arr [$key] ['rec_id'] = $value ['rec_id'];
			$arr [$key] ['order_sn'] = $value ['order_sn'];
            $arr [$key] ['store_name'] = $value ['store_name'];
            $arr [$key] ['goods_name'] = $value ['goods_name'];
            $arr [$key] ['specification'] = $value ['specification'];
            $arr [$key] ['goods_price'] = $value ['price'].'*'.$value ['quantity'];
            $arr [$key] ['order_goods_status'] = $value ['order_goods_status'];
			$arr [$key] ['goods_sum'] = $value ['price']*$value ['quantity'];
        }
        $arr[]['order_amount'] = '总金额：'.$data['total'];
        echo iconv('utf-8', 'gbk', implode("\t", $title)) . "\n"; 
        foreach ($arr as $v) {
            echo iconv('utf-8', 'gbk', implode("\t", $v)) . "\n";
        }
    }


    private function _get_try_data() {
        //获取关键字
        $field = $this->input->get('field', TRUE);
        $search_name = $this->input->get('search_name', TRUE);
        //获取订单状态
        $status = $this->input->get('order_status', TRUE);
        $payment_id =$this->input->get('payment_id', TRUE);
        //获取下单时间（订单生成时间）。
        $add_time_from = $this->input->get('add_time_from', TRUE);
        $add_time_to = $this->input->get('add_time_to', TRUE);
        if ($add_time_to != '') {
            $time_to = strtotime($add_time_to) + 3600 * 24;
        } else {
            $time_to = strtotime($add_time_to);
        }
        $pay_time_from = $this->input->get('pay_time_from', TRUE);
        $pay_time_to = $this->input->get('pay_time_to', TRUE);
        if ($pay_time_to != '') {
        	$pay_time_to = strtotime($pay_time_to) + 3600 * 24;
        } else {
        	$pay_time_to = strtotime($pay_time_to);
        }
        //获取订单金额
        $order_amount_from = $this->input->get('order_amount_from', TRUE);
        $order_amount_to = $this->input->get('order_amount_to', TRUE);
        //根据用户输入的条件进行订单查询，结合分页类使用
        $data = $this->order_model->get_xls_search($field, $search_name, $status, strtotime($add_time_from), $time_to,strtotime($pay_time_from), $pay_time_to, $order_amount_from, $order_amount_to, $payment_id);
        //获取所有的支付方式
        $data['payment'] = $this->payment_model->get_payments();
        $data['status'] = $status;
        $data['add_time_form'] = $add_time_from;
        $data['add_time_to'] = $add_time_to;
        $data['pay_time_from'] = $pay_time_from;
        $data['pay_time_to'] = $pay_time_to;
        return $data;
    }
	
	
	 private function _get_try_list() {
	 	$field = $this->input->get('field', TRUE);
	 	$search_name = $this->input->get('search_name', TRUE);
	 	//获取下单时间（订单生成时间）。
	 	$add_time_from = strtotime($this->input->get('add_time_from', TRUE));
	 	$add_time_to = $this->input->get('add_time_to', TRUE);
	 	if ($add_time_to != '') {
	 		$time_to = strtotime($add_time_to) + 3600 * 24;
	 	} else {
	 		$time_to = strtotime($add_time_to);
	 	}
	 	//付款时间
	 	$pay_time_from = strtotime($this->input->get('pay_time_from', TRUE));
	 	$pay_time_to = $this->input->get('pay_time_to', TRUE);
	 	if ($pay_time_to != '') {
	 		$pay_time_to = strtotime($pay_time_to) + 3600 * 24;
	 	} else {
	 		$pay_time_to = strtotime($pay_time_to);
	 	}
	 	$finished_time_from = strtotime($this->input->get('finished_time_from', TRUE));
	 	$finished_time_to = $this->input->get('finished_time_to', TRUE);
	 	if ($finished_time_to != '') {
	 		$finished_time_to = strtotime($finished_time_to) + 3600 * 24;
	 	} else {
	 		$finished_time_to = strtotime($finished_time_to);
	 	}
	 	//获取订单状态
	 	$status = $this->input->get('status', TRUE);
	 	//根据用户输入的条件进行订单查询，结合分页类使用
	 	$data = $this->order_model->get_goods_xls($field, $search_name, $status,$add_time_from,$time_to,$pay_time_from, $pay_time_to,$finished_time_from, $finished_time_to);
	 	$temp_goods_name = order_goods_status_name();//订单商品状态
	 	foreach ($data['list'] as $k => $v) {
	 		$data['list'][$k]['order_goods_status'] = $temp_goods_name[$v['order_goods_status']];
	 	}
	 	$total = 0;
	 	foreach ($data['total'] as $v){
	 		$total += $v['price']*$v['quantity'];
	 	}
	 	$data['total'] = $total;
        return $data;
    }

}
