<?php

/*
 * 各站点
 */

class Logs extends Admin_Controller {

	public function __construct() {
		parent::__construct();
		$this->load->model('logs_model');
		$this->per_page = 10;     //每页显示条数;
        $this->cur_page = intval($this->uri->segment(3));  //获取地址第四段的参数;
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;  //偏移量;
	}

	/*
	 * 各站点列表
	 */
	public function index() {
		$temp=array_slice(scandir(SRCPATH.'sites/'),2);
		$fiter=array('web','static','src','gulpfile.js','package.json');
		$data['site_list']=$this->_fiter_site($temp,$fiter);
		$this->load->view('logs/index',$data);
	}

	/*
	 * 查看列表
	 */
	public function log_list() {
		$data['site_folder']=$this->input->get('site_folder',true);
		$fiter=array('log','');
		$temp=array_slice(scandir(SRCPATH.'sites/'.$data['site_folder'].'/logs/',1),0,7);
		$data['cur_logs']=$this->_fiter_site($temp,$fiter);
		$this->load->view('logs/log_list',$data);
	}

	/*
	 * 查看列表
	 */
	public function log_view() {
		$site_folder=$this->input->get('site_folder',true);
		$data['file_name']=$this->input->get('file_name',true);
		$data['log_info']=file($cur_file=SRCPATH.'sites/'.$site_folder.'/logs/'.$data['file_name']);
		$this->load->view('logs/log_view',$data);
	}

	private function _fiter_site($arr,$fiter){
		foreach ($arr as $key=>$v) {
			$temp=explode('.',$v);
			if(in_array($temp[0],$fiter)){
				unset($arr[$key]);
			}
		}
		return $arr;
	}

	public function look() {
		//获取编号
        $op_uid = $this->input->get('op_uid', TRUE);
        //获取时间（生成时间）。
        $add_time_from = $this->input->get('add_time_from', TRUE);
        $add_time_to = $this->input->get('add_time_to', TRUE);
        if ($add_time_to != '') {
            $time_to = strtotime($add_time_to) + 3600 * 24;
        } else {
            $time_to = strtotime($add_time_to);
        }

		$arr = $this->logs_model->get_search_log($op_uid,strtotime($add_time_from), $time_to,$this->per_page, $this->offset);
		$data['list'] = $arr['list'];

        $url_format = "/logs/look/%d?" . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data ['page'] = page($this->cur_page, ceil($arr['total'] / $this->per_page), $url_format, 5, TRUE, FALSE, $arr['total']);
        $this->load->view('log/log_look', $data);
	}

}