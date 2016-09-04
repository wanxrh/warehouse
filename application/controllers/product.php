<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Product extends BaseController {
	public function __construct()
	{
	    parent::__construct();
	    //$_SESSION['lao337']['ADMIN']['uid'] = 1;
	    //$this->ifLogin(__CLASS__);
	    $this->load->model('AdminModel');
	}
	//产品追溯详情
	public function index(){
        $id = intval($this->uri->segment(3));
        $data['list'] = $this->AdminModel->getRow('shop_source',array('id'=>$id));
		$this->load->view('product/index',$data);
	}

} 
