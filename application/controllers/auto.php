<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auto extends BaseController {
	public function __construct()
	{
	    parent::__construct();
	}
	
	public function index(){
		/*if(isset($_SESSION['lao337']['MALL'])){
			redirect($this->config->base_url().'mall');
			exit();
		}*/
		$callback = $this->getCurUrl();
		$callback = urldecode($callback);
		
		if (strpos($callback, '?') === false) {
			$callback .= '?';
		} else {
			$callback .= '&';
		}
		$param['appid'] = APPID;
		
		if (! isset($_GET['getOpenId'])) {
			$param['redirect_uri'] = $callback . 'getOpenId=1';
			$param['response_type'] = 'code';
			$param['scope'] = 'snsapi_userinfo';
			$param['state'] = 1;
		
			$url = 'https://open.weixin.qq.com/connect/oauth2/authorize?' . http_build_query($param) . '#wechat_redirect';
			//echo $url;exit;
			redirect($url);
		} else if ($_GET['state']) {
			$param['secret'] = APPSECRET;
			$param['code'] = $this->input->get('code',TRUE);
			$param['grant_type'] = 'authorization_code';
			
			$url = 'https://api.weixin.qq.com/sns/oauth2/access_token?' . http_build_query($param);
			$output = $this->soapCall($url);
			if( !isset($output['openid']) ){
				exit('/(ㄒoㄒ)/~~授权失败！');
			}
			$data['access_token'] = $output['access_token'];
			$data['openid'] = $output['openid'];
			$data['lang'] = 'zh_CN';
			
			$url = 'https://api.weixin.qq.com/sns/userinfo?' . http_build_query($data);
			$outuser = $this->soapCall($url);
			if( !isset($outuser['openid']) ){
				exit('o(╯□╰)o授权失败！');
			}
			$_SESSION['lao337']['MALL'] = array(
					'uid' => $outuser['openid'],
					'nickname' => $outuser['nickname'],
					'headimgurl' => $outuser['headimgurl']
			);
            if($outuser['openid'] != 'o1teys0U4AM_Ex-buqh9BJhJHIjw'){
                exit('<h1>系统正在更新~</h1>');
            }
            if($url = $this->input->get('gourl',true)){
                redirect($url);
                exit();
            }
			redirect($this->config->base_url().'mall');
		}			
	}
	
}
