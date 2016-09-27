<?php

/**
 * Express.class.php 快递查询类 v1.0
 *
 * @copyright        福星高照
 * @license          http://www.25531.com
 * @lastmodify       2014-08-22
 */
class Express {

	public function __construct() {
		//TODO 
	}

	/*
	 * 网页内容获取方法
	 */

	private function get_content($url) {
		if (function_exists("file_get_contents")) {
			$file_contents = file_get_contents($url);
		} else {
			$ch = curl_init();
			$timeout = 5;
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
			$file_contents = curl_exec($ch);
			curl_close($ch);
		}
		return $file_contents;
	}


	/*
	 * 返回$data array      快递数组查询失败返回false
	 * @param $order        快递的单号
	 * $data['ischeck'] ==1 已经签收
	 * $data['data']        快递实时查询的状态 array
	 */

	public function get_order($order, $shipping_name) {
		if(empty(cache('sn-'.$order))){
		    $shipping_name=get_ship_en($shipping_name);
		    $key="8b9a42408777445f90c11504663099ca";
		    $url="http://www.aikuaidi.cn/rest/?key=".$key."&order=".$order."&id=".$shipping_name."&ord=desc";
		    $result = $this->get_content($url);
		    $data = json_decode($result, true);
		    cache('sn-'.$order,$data,7200);
		    return $data;
		}else{
			return cache('sn-'.$order);
		}
		
		
	}

}