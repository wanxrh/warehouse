<?php
class Vcode {
	
	/**
	 * 输出错误并终止
	 */
	protected function _show_error($code, $data) {
		ajax_error ( array (
				'code' => $code,
				'data' => $data 
		) );
		exit ();
	}
	
	/**
	 * 显示验证码
	 */
	public function show() {
		$ci = &get_instance ();
		$ci->load->library ( 'Captcha' );
		captcha::$useImgBg = false; // 是否使用背景图片
		captcha::$useNoise = false; // 是否添加杂点
		captcha::$useCurve = false; // 是否绘制干扰线
		captcha::$useZh = false; // 是否使用中文验证码
		captcha::$fontSize = 16; // 验证码字体大小(像素)
		captcha::$length = 4; // 验证码字符数
		captcha::$imageL = 120;
		captcha::$imageH = 48;
		captcha::entry (); // 输出图片
		exit ();
	}
	
	/**
	 * 判断验证码是否正确
	 */
	public function check($account, $output = FALSE) {
		/* $cache_key = 'login_error_' . $account;
		$err_num = cache ( $cache_key );
		$err_num = $err_num ? $err_num : 0;
		if ($err_num < 5) {
			return TRUE;
		} */
		
		// 没有传递验证码
		if (! isset ( $_POST ['vcode'] ) || empty ( $_POST ['vcode'] )) {
			$output && $this->_show_error ( 'NEED_VCODE', '请输入验证码！' );
			return FALSE;
		}
		
		// 判断验证码是否正确
		$ci = &get_instance ();
		$ci->load->library ( 'Captcha' );
		if (! $ci->captcha->check ( $_POST ['vcode'] )) {
			$output && $this->_show_error ( 'ERROR_VCODE', '验证码输入错误！' );
			return FALSE;
		}
		
		return TRUE;
	}
	
	/**
	 * 记录用户操作失败的次数
	 */
	public function error($account) {
		$cache_key = 'login_error_' . $account;
		$data = cache ( $cache_key );
		$data = $data ? $data : 0;
		cache ( $cache_key, $data + 1, 3600 * 3 );
	}
	
	/**
	 *  重置用户操作失败的次数
	 */
	public function reset_error($account) {
		$cache_key = 'login_error_' . $account;
		cache ( $cache_key, FALSE );
	}
	
	/**
	 * 清除验证码记录
	 *
	 * @param
	 * $account
	 */
	public function clean() {
		$ci = &get_instance ();
		$ci->load->library ( 'Captcha' );
		$ci->captcha->clean ();
	}
}
