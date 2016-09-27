<?php

/*
 * 技术服务费管理
 */

class Service extends Admin_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('service_fee_model');
        $this->per_page = 10;     //每页显示条数;
        $this->cur_page = intval($this->uri->segment(3));  //获取地址第3段的参数;
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;  //偏移量;
    }

    /*
     * 服务费列表
     */

    public function index() {
        $add_time_from = $this->input->get('add_time_from', TRUE);
        $add_time_to = $this->input->get('add_time_to', TRUE);
        $time_from = strtotime($add_time_from);
        $time_to = strtotime($add_time_to);

        $result = $this->service_fee_model->get_search($this->per_page, $this->offset, $time_from, $time_to);
        $url_format = '/service/index/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING'])); 
        $data['list'] = $result['list'];
        $data['amount'] = $result['amount'];
        $nums = $result['total'];   //总记录
        $data['page'] = page($this->cur_page, ceil($nums / $this->per_page), $url_format, 5, TRUE, FALSE, $nums);
        // 格式化是否开启
        foreach ($data['list'] as $k => $v) {
        	$data['list'][$k]['add_time'] = date('Y-m-d H:i:s' , $v['add_time']);
        }
        $this->load->view('gold/service_index', $data);
    }

    /*
     * 后台服务费处理
     */

    public function service_pay() {

        $log_id = intval($this->input->post('log_id',TRUE));
        $trading_time = strtotime($this->input->post('trading_time'));
        $result = $this->service_fee_model->pay($log_id,$trading_time);
        if ($result) {
            get_redirect('处理成功', '/service');
        } else {
            get_redirect('处理失败', '/service');
        }
    }

       /*
     * 后台服务费处理
     */

    public function del_log() {

        $log_id = intval($this->input->get('log_id'));
        $result = $this->service_fee_model->del_log($log_id);
        if ($result) {
            get_redirect('删除成功', '/service');
        } else {
            get_redirect('删除失败', '/service');
        }
    }

    /**
     * 导出xls
     */
    function export_xls() {
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment; filename=' . date("Ymd", time()) . '.xls');
        header('Pragma: no-cache');
        header('Expires: 0');
        $data = $this->_get_try_list();
        $title = array(
            '编号',
            '订单编号',
            '店铺名称',
            '商家会员名',
            '支付方式',
            '订单金额',
            '技术服务费',
            '交易时间',
            '操作'
        );
        $time_form = array(
            '时间--开始',
            '',
            '',
            '',
            '',
            '',
            '',
            $data['add_time_form'] ? $data['add_time_form'] : '无'
        );
        $time_to = array(
            '时间--结束',
            '',
            '',
            '',
            '',
            '',
            '',
            $data['add_time_to'] ? $data['add_time_to'] : '无'
        );
        $arr = array();
        $pay_arr=array('1'=>'旧数据','2'=>'金币支付','3'=>'支付宝','4'=>'微信支付','5'=>'网银支付');
        // 数据字段处理
        foreach ($data['list'] as $key => $value) {
            $arr [$key] ['order_id'] = $value ['order_id'];
            $arr [$key] ['order_sn'] = "sn:".$value ['order_sn'];
            $arr [$key] ['store_name'] = $value ['store_name'];
            $arr [$key] ['owner_name'] = $value ['owner_name'];
            $arr [$key] ['pay_id'] =  $pay_arr[$value['pay_id']];
            $arr [$key] ['order_amount'] = $value ['order_amount'];
            $arr [$key] ['service_fee'] = $value ['service_fee'];
            $arr [$key] ['trading_time'] = '#' . date('Y-m-d H:i:s', $value['trading_time']);
            $arr [$key] ['fee_status'] = $value ['fee_status'] == 1 ? '支付中' : '支付完成';
        }
        $total = array(
            '支付完成总金',
            '',
            '',
            '',
            '',
            '',
            '',
            $data['total_money']['service_fee']
        );
        // 写入excle
        echo iconv('utf-8', 'gbk', implode("\t", $time_form)) . "\n";
        echo iconv('utf-8', 'gbk', implode("\t", $time_to)) . "\n";
        echo iconv('utf-8', 'gbk', implode("\t", $total)) . "\n";
        echo iconv('utf-8', 'gbk', implode("\t", $title)) . "\n";
        foreach ($arr as $v) {
            echo iconv('utf-8', 'gbk', implode("\t", $v)) . "\n";
        }
    }

    private function _get_try_list() {
        $pay_type = $this->input->get('pay_type', TRUE);
        $store = $this->input->get('store', TRUE);
        $order_id = $this->input->get('order_id', TRUE);
        $add_time_from = $this->input->get('add_time_from', TRUE);
        $add_time_to = $this->input->get('add_time_to', TRUE);
        $payment_id = intval( $this->input->get('payment_id', TRUE) );
        $time_from = strtotime($add_time_from);
        if ($add_time_to != '') {
            $time_to = strtotime($add_time_to) + 3600 * 24;
        } else {
            $time_to = strtotime($add_time_to);
        }
        $order_by = intval($this->uri->segment(3));    //排序判断参数  
        $data = $this->service_fee_model->get_search_xls($pay_type, $store, $order_id, $time_from, $time_to, $order_by,$payment_id);
        $data['add_time_form'] = $add_time_from;
        $data['add_time_to'] = $add_time_to;
        return $data;
    }

}