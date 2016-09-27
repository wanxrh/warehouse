<?php

class Main extends Admin_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('home_model');
    }

    /*
     * 默认管理员首页
     */

    public function index() {


        $this->load->view('main');
    }

    /*
     * 顶部
     */

    public function top() {
        $user_id = get_admin();
        $data = $this->home_model->level_id($user_id);
        $this->load->view('top',$data);
    }

    /*
     * 左边
     */

    public function left() {
        $user_id = get_admin();
        $data = $this->home_model->level_id($user_id);
        $this->load->view('left', $data);
    }

    /*
     * 右边
     */

    public function right() {
	   $start_time = $this->input->get('start_time', TRUE);
	   $end_time = $this->input->get('end_time', TRUE);
	if(empty($start_time) && empty($end_time)){
	   $mstart_time= mktime(0,0,0,date('m'),date('d'),date('Y')); //今天开始的时间戳
       $mend_time = mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1; //今天结束的时间戳
	}else{
	   $mstart_time=strtotime($start_time);
	   $mend_time=strtotime($end_time)+(24*3600-1);  
	} 
		//系统信息 
       $data['goods_total'] = $this->home_model->today_goods($mstart_time,$mend_time); //新添的商品
       $res = $this->home_model->xin_pay($mstart_time,$mend_time);  
       $data['pay_total'] = $res['order_amount'];//成交量
	   $data['yiban_reg_total'] = $this->home_model->yiban_reg($mstart_time,$mend_time); //衣扮网注册
	   $data['log_total'] = $this->home_model->yinban_log($mstart_time,$mend_time); //衣扮网登录量
       $data['store_total'] = $this->home_model->xin_store($mstart_time,$mend_time);  //新增商店
       $this->load->view('right', $data);
    }

}
