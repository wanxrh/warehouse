<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends BaseController {
	public function __construct()
	{
	    parent::__construct();
	    $this->load->model('BaseModel');
	    $this->load->library('vcode');	    
	}
	/**
	 * 登陆
	 */
	public function index()
	{
		$this->ifLogin(__CLASS__);
		if(IS_POST){
			$username = trim( $this->input->post('username',TRUE) );
			$password = trim( $this->input->post('password',TRUE) );
			$vcode = strtolower(trim( $this->input->post('vcode',TRUE) ));
			if(!$username || !$password || !$vcode)
				ajaxError('请填写正确的账号、密码和验证码');
			$this->vcode->check($vcode,TRUE);
			
			$user_info = $this->BaseModel->getRow('admin',array('username'=>$username),'id,username,password,key,superadmin');
			if(!$user_info){
			    ajaxError('用户不存在！');
			}
			$md5pw = MD5( MD5($password).$user_info['key'] );
			if($md5pw != $user_info['password']){
			    ajaxError('密码错误！');
			}
			$_SESSION['lao337']['ADMIN'] = array(
			    'uid'=>$user_info['id'],
			    'username'=>$user_info['username'],
				'type'=>$user_info['superadmin']
			);
			exit(json_encode(array('status'=>1,'url'=>$this->loginToUrl('ADMIN'))));
		}
		$this->load->view('admin/login');
	}
	/**
     * 显示验证码
     */
    public function vcode() {       
        $this->vcode->show();
    }
	
	/**
	 *退出 
	 */
	public function logOut()
	{
		unset($_SESSION['lao337']);
		exit("<script>window.location.href='/login'</script>");
	}
}
