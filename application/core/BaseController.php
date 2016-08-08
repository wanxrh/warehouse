<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class BaseController extends CI_Controller {
	public $_uid = 0;
	public function __construct()
	{		
		parent::__construct();
		session_start();
	}
	
	/**
	 * 检验是否登陆
	 */
	public function ifLogin($clsname = NULL)
	{
		if( !$clsname ) return FALSE;
		$clsname = strtoupper($clsname);
		if(!isset( $_SESSION['lao337'][$clsname]) ){
			if($clsname == 'LOGIN'){
				return;
			}
			if( $clsname == 'MALL'){
				redirect('/auto');
			}
			redirect('/login');
		}
		
		if( !isset($_SESSION['lao337'][$clsname])){
			if($clsname == 'LOGIN'){
				$key = array_keys($_SESSION['lao337']);
				$clsname = $key[0];
			}
			redirect( $this->loginToUrl($clsname) );
		}
		$this->_uid = $_SESSION['lao337'][$clsname]['uid'];
	}
	/**
	 * 用户登录跳转路径
	 */
	public function loginToUrl($type){
		$url = array(
			'ADMIN'=>'/admin/',
			'MERCHANT'=>'/merchant/',
			'AGENT'=>'/agent/'
		);
		if( !isset($url[$type]) )
			return FALSE;
		return $url[$type];
	}
	/**
	 * 操作错误跳转的快捷方法
	 *
	 * @access protected
	 * @param string $message
	 *        	错误信息
	 * @param string $jumpUrl
	 *        	页面跳转地址
	 * @param mixed $ajax
	 *        	是否为Ajax方式 当数字时指定跳转时间
	 * @return void
	 */
	protected function errorJump($message = '', $jumpUrl = '', $ajax = false) {
		$this->dispatchJump ( $message, 0, $jumpUrl, $ajax );
	}
	
	/**
	 * 操作成功跳转的快捷方法
	 *
	 * @access protected
	 * @param string $message
	 *        	提示信息
	 * @param string $jumpUrl
	 *        	页面跳转地址
	 * @param mixed $ajax
	 *        	是否为Ajax方式 当数字时指定跳转时间
	 * @return void
	 */
	protected function successJump($message = '', $jumpUrl = '', $ajax = false) {
		$this->dispatchJump ( $message, 1, $jumpUrl, $ajax );
	}
	/**
	 * 默认跳转操作 支持错误导向和正确跳转
	 * 调用模板显示 默认为public目录下面的success页面
	 * 提示页面为可配置 支持模板标签
	 *
	 * @param string $message
	 *        	提示信息
	 * @param Boolean $status
	 *        	状态
	 * @param string $jumpUrl
	 *        	页面跳转地址
	 * @param mixed $ajax
	 *        	是否为Ajax方式 当数字时指定跳转时间
	 * @access private
	 * @return void
	 */
	private function dispatchJump($message, $status = 1, $jumpUrl = '', $ajax = false) {
		if (is_int ( $ajax ))
			$data['waitSecond'] = $ajax;
		if (! empty ( $jumpUrl ))
			$data['jumpUrl'] = $jumpUrl;
		// 提示标题
		$data['msgTitle'] = $status ? '操作成功' : '操作失败';
		// 状态
		$data['status'] = $status;
		if ($status) { // 发送成功信息
			$data['message'] = $message; // 提示信息
			// 成功操作后默认停留1秒
			if (! isset ( $data['waitSecond'] ))
				$data['waitSecond'] = 1;
			// 默认操作成功自动返回操作前页面
			if (! isset ( $data['jumpUrl'] ))
				$data['jumpUrl'] = $_SERVER ["HTTP_REFERER"];
			
		} else {
			// 提示信息
			$data['error'] = $message;
			// 发生错误时候默认停留3秒
			if (! isset ( $data['waitSecond'] ))
				$data['waitSecond'] = 3;
			// 默认发生错误的话自动返回上页
			if (! isset ( $data['jumpUrl'] ))
				$data['jumpUrl'] = 'javascript:history.back(-1);';
		}
		return $this->load->view('errors/dispatch_jump',$data);
	}
	
	function _status_code_name($code) {
		$status_code = array (
				0 => '待支付',
				1 => '待商家确认',
				2 => '待发货',
				3 => '配送中',
				4 => '确认已收货',
				5 => '确认已收款',
				6 => '待评价',
				7 => '已评论'
		);
		return $status_code [$code];
	}
	function _pay_type($code) {
		if($code === NULL){
			return '';
		}
		$status_code = array (
				0 => '微信支付',
				1 => '支付宝',
				2 => '财付通wap',
				3 => '财付通',
				4 => '银行卡支付',
				10 => '货到付款'
		);
		return $status_code [$code];
	}
	function _send_code_name($code) {
		if(!$code){
			return '';
		}
		$status_code = array (
			"intra-city"=>'同城派送',
			"sf" => '顺丰',
			"sto" => '申通',
			"yt" => '圆通',
			"yd" => '韵达',
			"tt" => '天天',
			"ems" => 'EMS',
			"zto" => '中通',
			"ht" => '汇通',
			"qf" => '全峰' 
		);
		return $status_code [$code];
	}
    function coupon_type($code) {
        $status_code = array (
            0 => '未使用',
            1 => '已使用',
            2 => '已赠好友'
        );
        return $status_code [intval($code)];
    }
	protected function soapCall($url,$data = NULL){
		try {
			$ch = curl_init() ;
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
			curl_setopt($ch, CURLOPT_HEADER, FALSE);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); //将curl_exec()获取的信息以文件流的形式返回，而不是直接输出。
			if($data){
				curl_setopt($ch, CURLOPT_POST, 1);
				curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
			}
			$output = curl_exec($ch);
			$output=json_decode($output,true);
		}catch (Exception $e) {
			print_r($e->getMessage());
			return;
		}
		return $output;
	}	
	// php获取当前访问的完整url地址
	protected function getCurUrl() {
		$url = 'http://';
		if (isset ( $_SERVER ['HTTPS'] ) && $_SERVER ['HTTPS'] == 'on') {
			$url = 'https://';
		}
		if ($_SERVER ['SERVER_PORT'] != '80') {
			$url .= $_SERVER ['HTTP_HOST'] . ':' . $_SERVER ['SERVER_PORT'] . $_SERVER ['REQUEST_URI'];
		} else {
			$url .= $_SERVER ['HTTP_HOST'] . $_SERVER ['REQUEST_URI'];
		}
	
		return $url;
	}
}
