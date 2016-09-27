<?php

/**
 * 退换货控制器
 */
class Service extends User_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('service_model');
        // 初始化分页属性
        $this->per_page = 8;
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;
    }

    /*
     * 退款管理
     */
    public function lists()
    {
        //表单参数
        $data['order_sn'] = $order_sn = filter_sql($this->input->get('order_sn'));
        $data['refund_sn'] = $refund_sn = filter_sql($this->input->get('refund_sn'));
        $data['buyer_name'] = $buyer_name = filter_sql($this->input->get('buyer_name'));
        $data['status'] = $order_status = filter_sql($this->input->get('status'));

        $result=$this->service_model->refund_list($order_sn,$refund_sn,$buyer_name,$order_status,get_user()['id'],$this->per_page,$this->offset);
        $total = $result['total'];
        $url_format = "/service/lists/%d?" . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($total / $this->per_page), $url_format);
        $data['list'] = $result['list'];
        $this->load->view('service/lists',$data);
    }
    /**
     * 导出xls
     */
    function exportxls()
    {
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment; filename=' . date("Ymd", time()) . '.xls');
        header('Pragma: no-cache');
        header('Expires: 0');
        $data = $this->_get_try_data();
        $title = array(
            '退款编号',
            '订单编号',
            '宝贝名称',
            '买家名称',
            '交易金额',
            '退款金额',
            '申请时间',
            '退款状态',
        );
        $arr = array();
        // 数据字段处理
        $res = get_aftermarket_status();
        if($data) {
            foreach ($data as $key => $value) {
                $arr [$key] ['refund_sn'] = '#' . $value ['refund_sn'];
                $arr [$key] ['order_sn'] = $value ['order_sn'];
                $arr [$key] ['goods_name'] = $value ['goods_name'];
                $arr [$key] ['buyer_name'] = $value ['buyer_name'];
                $arr [$key] ['discounted_price'] = $value ['discounted_price'];
                $arr [$key] ['money'] = $value ['money'];
                $arr [$key] ['apply_time'] = '#' . date('Y-m-d H:i:s',$value ['apply_time']);
                $arr [$key] ['status'] = $res[$value ['status']];
            }
        }
        echo iconv('utf-8', 'gbk', implode("\t", $title)) . "\n";
        foreach ($arr as $v) {
            echo iconv('utf-8', 'gbk', implode("\t", $v)) . "\n";
        }
    }

    private function _get_try_data()
    {
        //表单参数
        $data['order_sn'] = $order_sn = filter_sql($this->input->get('order_sn'));
        $data['refund_sn'] = $refund_sn = filter_sql($this->input->get('refund_sn'));
        $data['buyer_name'] = $buyer_name = filter_sql($this->input->get('buyer_name'));
        $data['status'] = $order_status = filter_sql($this->input->get('status'));

        $data=$this->service_model->refund_list_xls($order_sn,$refund_sn,$buyer_name,$order_status,get_user()['id']);
        return $data;
    }

}