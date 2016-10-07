<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Event extends BaseController {
	public function __construct()
	{
	    parent::__construct();
	    $this->load->model('EventModel');
	}
	public function index(){
		/* $json = '{"signature":"c7e4f334316233c5424519b9710fe44c7a6cb2c7","timestamp":"1462779571","nonce":"1948898592","encrypt_type":"aes","msg_signature":"49cb779687131ef1263e3f0919d09431e33c0c13"}';
		$_GET = json_decode($json,TRUE);
		$GLOBALS['HTTP_RAW_POST_DATA'] = '<xml><ToUserName><![CDATA[gh_4b0e165e7609]]></ToUserName><Encrypt><![CDATA[tXmOhWLkXjHBeTYX+IUv9OquinXwf+BJ2DxlWx6d50gDWTXbnirwmif9ziQ8sKFg+9Y5PgVqanYHmkE8vrws12proo2wkvbk0nWnsQ553RUEedr468IWxvNyD+I0Y79Zw/9aFoZkxwm8bT9E1N0QWbyu6f7qhA92QGUxiwEfSbulB4fixYqJURCRxo0DFM465ggXUPGYaiVD5Ahi/ra5Zp5pQ3YDSbUtPrbLIXODEInja+NZuwGQ4ASvwRoSJbj7ROnsSHs3Ujx603BrimlAnFQpvWspFU2R9+d0CwFJi3s4RIKNPDMXxLONyDSdDlLUBxhWDIhDGbn1/VzMpNW+Dw3HwqYGTrbcWM+g/+NVdivegqSoFf4eKSFV1A29Xv7LYjLNLNn4mTLO6nqVBRact7xDUjMEDMk1iBx1zzqYTVtFNjizrGfss07a48eUD8UKDwS3SNn9h+cH9nwgu4nX0Q==]]></Encrypt></xml>';  */
		include_once ('WXBizMsgCrypt/WXBizMsgCrypt.php');
		$wxcpt = new WXBizMsgCrypt(TOKEN, EncodingAESKey, APPID);
		
		$timestamp  = $_GET['timestamp'];
		$nonce = $_GET["nonce"];
		$msg_signature  = $_GET['msg_signature'];

		$sMsg = "";  // 解析之后的明文
		$errCode = $wxcpt->DecryptMsg($msg_signature, $timestamp, $nonce, $GLOBALS['HTTP_RAW_POST_DATA'], $sMsg);
		if($errCode !=0){
			return FALSE;
		}
		libxml_disable_entity_loader(true);
		$content = json_decode(json_encode(simplexml_load_string($sMsg, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
		$resultStr = '';
		switch ($content['Event']) {
			case 'subscribe':
				$this->subscribeAction($content);
			break;
			case 'unsubscribe':
				$this->unsubscribeAction($content);
			break;
			case 'CLICK':
				$resultStr = $this->responseMsg($content);
			break;
			default:
				return FALSE;
			break;
		}
		echo $resultStr;
	}
	
	private function subscribeAction($param){
		if( !isset($param['EventKey']) ){
			return;
		}
		$info = $this->EventModel->getQrcodeInfo(substr($param['EventKey'],8));
		if($info && $info['openid']){
			$this->EventModel->bindAgent($info['openid'],$param['FromUserName']);
		}
	}
	private function unsubscribeAction($param){
		$info = $this->EventModel->getBindInfo($param['FromUserName']);
		if($info){
			$this->EventModel->cancelBind($info['id']);
		}
	}
	private function responseMsg($param){
		switch ($param['EventKey']) {
			case 'SERVICE_TEL':
				$result = $this->transmitText($param,'4000422330');
			break;
			case 'HOW_AGENT':
				$msg = '老山圈代理指南
						1、代理规则：
						     代理不收取任何费用。您申请成为老山圈的代理后，系统会自动生成一个唯一 的二维码，您可通过各种推广方式让客户从您的二维码进入老山圈消费。凡是通过您的二维码关注老山圈的均属于您的客户，系统会自动记录，今后他的每一次消费您都可以拿到一定比例的佣金。您还可在后台实时查看佣金数额并申请提现。  
						2、申请代理方法：
						     进入老山圈公众号 → 点菜单的“合作代理” → 点“我的代理” → 输入您的手机号码 → 点“确定” → 申请成功，成为代理。
						3、获取您的推广二维码方法：
							 点击菜单中的“合作代理” → 点我的代理 → 点“推广二维码” → 把二维码发送给朋友或保存到手机。
						4、查看佣金数据方法：
							 点击菜单中的“合作代理 → 点”我的代理“即可查看您的客户数及佣金数据';
				$result = $this->transmitText($param,$msg);
			break;
			case 'MERCHANTS_DEFAULT_MSG':
				$msg = '如果您有产品想在我们平台上卖，您可以
						1、把产品资料及联系方式发送至邮箱1247565402@qq.com上，如产品审核通过，我们的工作人员将会与你联系相谈合作事宜。
						2、致电全国统一客服电话4000422330。';
				$result = $this->transmitText($param,$msg);
			break;
			
			default:
			break;
		}
		return $result;
	}
	private function transmitText($object, $content, $funcFlag = 0) {
		$textTpl = "<xml>
		<ToUserName><![CDATA[%s]]></ToUserName>
		<FromUserName><![CDATA[%s]]></FromUserName>
		<CreateTime>%s</CreateTime>
		<MsgType><![CDATA[text]]></MsgType>
		<Content><![CDATA[%s]]></Content>
		<FuncFlag>%d</FuncFlag>
		</xml>";
		$resultStr = sprintf ( $textTpl, $object['FromUserName'], $object['ToUserName'], time (), $content, $funcFlag );
		return $resultStr;
	}
	private function transmitNews($object, $arr_item, $funcFlag = 0) {
		// 首条标题28字，其他标题39字
		if (! is_array ( $arr_item ))
			return;
		
		$itemTpl = "<item>
        <Title><![CDATA[%s]]></Title>
        <Description><![CDATA[%s]]></Description>
        <PicUrl><![CDATA[%s]]></PicUrl>
        <Url><![CDATA[%s]]></Url>
    	</item>";
		$item_str = "";
		foreach ( $arr_item as $item )
			$item_str .= sprintf ( $itemTpl, $item ['Title'], $item ['Description'], $item ['PicUrl'], $item ['Url'] );
		
		$newsTpl = "<xml>
		<ToUserName><![CDATA[%s]]></ToUserName>
		<FromUserName><![CDATA[%s]]></FromUserName>
		<CreateTime>%s</CreateTime>
		<MsgType><![CDATA[news]]></MsgType>
		<Content><![CDATA[]]></Content>
		<ArticleCount>%s</ArticleCount>
		<Articles>
		$item_str
		</Articles>
		<FuncFlag>%s</FuncFlag>
		</xml>";
		
		$resultStr = sprintf ( $newsTpl, $object['FromUserName'], $object['ToUserName'], time (), count ( $arr_item ), $funcFlag );
		return $resultStr;
	}
	//激活微信服务器配置验证
	private function checkSignature()
	{
		$signature = $_GET["signature"];
		$timestamp = $_GET["timestamp"];
		$nonce = $_GET["nonce"];
	
		$token = TOKEN;
		$tmpArr = array($token, $timestamp, $nonce);
		sort($tmpArr, SORT_STRING);
		$tmpStr = implode( $tmpArr );
		$tmpStr = sha1( $tmpStr );
	
		if( $tmpStr == $signature ){
			//return true;
			echo $_GET["echostr"];
			exit;
		}else{
			return false;
		}
	}
}
