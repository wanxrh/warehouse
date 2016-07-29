<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Agent extends BaseController {
	public $_openid = '';

	/**
	 * Agent constructor.
     */
	public function __construct()
	{
	    parent::__construct();
	    $this->load->model('AgentModel');
	    
	   	/* $_SESSION['lao337']['AGENT']['uid'] = 'o1teys--QgpSDXlTwHqBcEWKJTfY';
		$_SESSION['lao337']['AGENT']['nickname'] = '（●—●）';
		$_SESSION['lao337']['AGENT']['headimgurl'] = 'http://wx.qlogo.cn/mmopen/2ibiauvDg7obiaUSCH7X1EzGJpllf4jpksWloKUFm1AGnA5D8hGrTLGaNXKspQuwHFHZaQ1UYppaWdl5bY1Bzj5xYXVN59bSHn2/0'; */
	    //暂时这样
	    if(isset($_SESSION['lao337']['AGENT']['uid'])){
	    	$this->_openid = $_SESSION['lao337']['AGENT']['uid'];
	    }else{
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
	    		$this->_openid = $outuser['openid'];
	    		$_SESSION['lao337']['AGENT'] = array(
					'uid' => $outuser['openid'],
					'nickname' => $outuser['nickname'],
					'headimgurl' => $outuser['headimgurl']
				);
	    	}
	    }
	}
	public function index(){
		$openid = $this->_openid;
		$data['nickname'] = $_SESSION['lao337']['AGENT']['nickname'];
		$data['headimgurl'] = $_SESSION['lao337']['AGENT']['headimgurl'];
		$ifAgent = $this->AgentModel->getAgentInfo($openid);
		if(!$ifAgent){
			header('Location: '.$this->config->base_url().'agent/online');
			exit();
		}else{
			$data['focus_url'] = $ifAgent['focus_url'];
			$data['balance'] = $this->AgentModel->getAgentBalance($openid);
			$data['balance'] = $data['balance']['balance']?$data['balance']['balance']:'0.00';
			$num = $this->AgentModel->getFocusNum($openid);
			$data['today'] = $num['today'];
			$data['total'] = $num['total'];
			$data['list'] = $this->AgentModel->getCommissionLog($openid);
		}
		$this->load->view('agent/agent_msg',$data);
	}
	public function cash()
	{
		$openid = $this->_openid;
		$ifAgent = $this->AgentModel->getAgentInfo($openid);
		if(!$ifAgent){
			header('Location: '.$this->config->base_url().'agent/online');
			exit();
		}else{
			$data['id'] = $ifAgent['id'];
			$data['balance'] = $this->AgentModel->getAgentBalance($openid);
			$data['balance'] = $data['balance']['balance']?$data['balance']['balance']:'0.00';
		}
		if(IS_POST){
			$b_id = intval($this->input->post('id',true));
			$alipay = trim($this->input->post('alipay',true));
			$money = (int)$this->input->post('money',true);
			if($b_id != $ifAgent['id'] || !$alipay || !$money || $money<0 || $money > floor($data['balance'])){
				return false;
			}
			$result = $this->AgentModel->applyCach($openid,$alipay,$money);
			if(!$result){
				$this->errorJump('提现失败！');
				return;
			}
			$this->successJump('申请成功，提现周期为3-5个工作日！','/agent');
			return;
		}
		$this->load->view('agent/cash',$data);
	}
	public function activat($id = 1,$code = 1){
		
		$openid = $this->_openid;
		$ifAgent = $this->AgentModel->getAgentInfo($openid);
		if($ifAgent){
			header('Location: '.$this->config->base_url().'agent');
			exit();
		}
		if(IS_POST){
			$qr_id = intval( $this->input->post('id',TRUE) );
			$mobile = trim( $this->input->post('mobile',TRUE) );
			if(!$mobile){
				$this->errorJump('手机号码不能为空！');
				return;
			}
			$ret = $this->AgentModel->activatQrcode($id,$code,$openid,$mobile);
			if(!$ret){
				$this->errorJump('激活失败！');
				return;				
			}
			$this->successJump('恭喜你成为代理！',$this->config->base_url().'agent');
			return;
		}else{			
			$data['info'] = $this->AgentModel->getQrcodeOpenId($id,$code);			
		}		
		$this->load->view('agent/activat',$data);
	}
	public function online(){
		$openid = $this->_openid;
		$ifAgent = $this->AgentModel->getAgentInfo($openid);
		if($ifAgent){
			header('Location: '.$this->config->base_url().'agent');
			exit();
		}
		if(IS_POST){
			$mobile = trim( $this->input->post('mobile',TRUE) );
			if(!$mobile){
				$this->errorJump('手机号码不能为空！');
				return;
			}
			$id = $this->AgentModel->initQrcodeOnline($openid,$mobile);
			if(!$id){
				$this->errorJump('激活失败！');
				return;
			}
			
			$param['grant_type'] = 'client_credential';
			$param['appid'] = APPID;
			$param['secret'] = APPSECRET;
			$url = 'https://api.weixin.qq.com/cgi-bin/token?'.http_build_query($param);
			$output = $this->soapCall($url);
			if(!$output){
				return FALSE;
			}
			if(isset( $output['errcode'] ) ){
				return FALSE;
			}
			$access_token = $output['access_token'];
			
			$qr['action_name'] = 'QR_LIMIT_STR_SCENE';
			$qr['action_info']['scene'] = array(
					'scene_str'=>$id
			);
			$json_qr = json_encode($qr,TRUE);
			$url = 'https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token='.$access_token;
			$out = $this->soapCall($url,$json_qr);
			if(!isset($out['ticket'])){
				return FALSE;
			}			
			$focus_url = 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket='.$out['ticket'];			
			$ret = $this->AgentModel->activatQrcodeOnline($id,$openid,$out['ticket'],$focus_url);
			if(!$ret){
				$this->errorJump('激活失败！');
				return;
			}
			$this->successJump('恭喜你成为代理！',$this->config->base_url().'agent');
			return;
		}
		$this->load->view('agent/online');
	}
}
