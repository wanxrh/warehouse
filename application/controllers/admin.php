<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Admin extends BaseController {
	public function __construct()
	{
	    parent::__construct();
	    //$_SESSION['lao337']['ADMIN']['uid'] = 1;
	    $this->ifLogin(__CLASS__);
	    $this->load->model('AdminModel');
	    
	    $this->per_page = 5;
	    $this->cur_page = intval($this->uri->segment(3));
	    if ($this->cur_page < 1) {
	    	$this->cur_page = 1;
	    }
	    $this->offset = ($this->cur_page - 1) * $this->per_page;
	}
	
	public function index(){
		$keyword = trim( $this->input->get('keyword',TRUE) );		
		$data = $this->AdminModel->goodsList($keyword,$this->per_page, $this->offset);
		$url_format = "/admin/index/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
		$data['cur_page'] = $this->cur_page;
		$data['keyword'] = $keyword;
		$this->load->view('admin/goods_lists',$data);	
	}
	public function setshow(){
		$goods_id = intval($this->uri->segment(3));
		if(!$goods_id){
			$this->errorJump('非法操作');
			return;
		}
		$result = $this->AdminModel->setGoodsShow($goods_id);
		if(!$result){
			$this->errorJump('非法操作');
			return;
		}
		$this->successJump('操作成功');
	}
	public function del(){
		$goods_id = intval($this->uri->segment(3));
		if(!$goods_id){
			$this->errorJump('非法操作');
			return;
		}
		$result = $this->AdminModel->delGoods($goods_id);
		if(!$result){
			$this->errorJump('非法操作');
			return;
		}
		$this->successJump('操作成功','/admin/');
	}
	public function delMore(){
		if(!IS_POST){
			return FALSE;
		}
		$ids = $this->input->post('ids',TRUE);
		if( empty($ids) ){
			ajaxError('请选择操作数据');
		}
		$result = $this->AdminModel->delMoreGoods($ids);
		if(!$result){
			ajaxError('请选择操作数据');
		}
		ajaxSuccess('删除成功！',array('url'=>'/admin'));
	}
	public function addGoods(){
		if(IS_POST){
			$parm = $this->input->post(NULL,TRUE);
			if(!$parm['title']){
				ajaxError('商品名不能为空！');
			}
			if($parm['price'] <= 0 || $parm['inventory'] <= 0 || $parm['old_price'] <= 0 || $parm['commission'] <= 0){
				ajaxError('价格，仓库不能小于或等于0 ！');
			}
			$ims = explode(',', $parm['imgs']);
			$parm['cover'] = $ims[0];
            $parm['reserve_time'] = strtotime($parm['reserve_time']);
			$row = $this->AdminModel->addGoods($parm);
			if(!$row){
				ajaxError('添加失败！');
			}
			ajaxSuccess('操作成功',array('url'=>'/admin'));
		}
		$data['category'] = $this->_getCategory();
		$this->load->view('admin/goods_add',$data);
	}
	public function editGoods(){
		if(IS_POST){
			$parm = $this->input->post(NULL,TRUE);
			$id = $parm['id'];
			unset($parm['id']);
			if(!$id){
				ajaxError('数据不存在！');
			}			
			if(!$parm['title']){
				ajaxError('商品名不能为空！');
			}
			if($parm['price'] <= 0 || $parm['inventory'] <= 0 || $parm['old_price'] <= 0 || $parm['commission'] <= 0){
				ajaxError('价格，仓库等不能小于或等于0 ！');
			}
			$ims = explode(',', $parm['imgs']);
			$parm['cover'] = $ims[0];
            $parm['reserve_time'] = strtotime($parm['reserve_time']);
			$row = $this->AdminModel->updateGoodsInfo($id,$parm);
			if(!$row){
				ajaxError('操作失败！');
			}
			ajaxSuccess('操作成功',array('url'=>'/admin'));
		}
		$goods_id = intval( $this->uri->segment(3) );
		if(!$goods_id){
			return FALSE;
		}
		$data['info'] = $this->AdminModel->getGoodsInfo($goods_id);
		$data['category'] = $this->_getCategory();
		$this->load->view('admin/goods_edit',$data);
	}
	public function category(){
		$keyword = trim( $this->input->get('keyword',TRUE) );
		$data = $this->AdminModel->categoryList($keyword,$this->per_page, $this->offset);
		$url_format = "/admin/c
		ategory/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
		$data['cur_page'] = $this->cur_page;
		$data['keyword'] = $keyword;
		$this->load->view('admin/category_lists',$data);
	}
	public function delCategory(){
		$cate_id = intval($this->uri->segment(3));
		if(!$cate_id){
			$this->errorJump('非法操作');
			return;
		}
		$result = $this->AdminModel->delCategory($cate_id);
		if(!$result){
			$this->errorJump('非法操作');
			return;
		}
		$this->successJump('操作成功','/admin/category');
	}
	public function delMoreCategory(){
		if(!IS_POST){
			return FALSE;
		}
		$ids = $this->input->post('ids',TRUE);
		if( empty($ids) ){
			ajaxError('请选择操作数据');
		}
		$result = $this->AdminModel->delMoreCategorys($ids);
		if(!$result){
			ajaxError('请选择操作数据');
		}
		ajaxSuccess('删除成功！',array('url'=>'/admin/category'));
	}
	public function addCategory(){
		if(IS_POST){
			$param = $this->input->post(NULL,TRUE);
			if(!$param['title']){
				ajaxError('名称不能为空！');
			}
			$row = $this->AdminModel->addCategory($param);
			if(!$row){
				ajaxError('添加失败！');
			}
			ajaxSuccess('操作成功',array('url'=>'/admin/category'));
		}
		$this->load->view('admin/category_add');
	}
	public function editCategory(){
		if(IS_POST){
			$param = $this->input->post(NULL,TRUE);
			$id = $param['id'];
			unset($param['id']);
			if(!$id){
				ajaxError('数据不存在！');
			}
			if(!$param['title']){
				ajaxError('名称不能为空！');
			}
			$row = $this->AdminModel->updateCategoryInfo($id,$param);
			if(!$row){
				ajaxError('操作失败！');
			}
			ajaxSuccess('操作成功',array('url'=>'/admin/category'));
		}
		$cate_id = intval( $this->uri->segment(3) );
		if(!$cate_id){
			return FALSE;
		}
		$data['info'] = $this->AdminModel->getCategoryInfo($cate_id);
		$this->load->view('admin/category_edit',$data);
	}
	public function upload() {
    $this->load->library('Uploader');
    $file = $_FILES['file'];
    //上传文件不能为空
    $Y = date("Y", time());
    $m = date("m", time());
    $d = date("d", time());
    if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
        $this->uploader->allowed_size(4096000);
        $this->uploader->addFile($file);
        if ($this->uploader->file_info() === false) {
            show_error($this->uploader->get_error());
            return false;
        }
        $ret = $this->uploader->save('goods/' . $Y . '/' . $m . '/' . $d);
    }
    ajaxSuccess('goods/' . $Y . '/' . $m . '/' . $d . '/' . basename($ret));
    //ajax_success($ret);
    //ajax_success('goods/' . $Y . '/' . $m . '/' . $d . '/' . basename($ret));
    }
    //上传图片或者视频
    public function upload2() {
        //最小几K
        $minsize    = isset($_POST['minsize']) ? $_POST['minsize']:0;
        //最大几M
        $size 		= isset($_POST['size']) ? $_POST['size'] : 50;
        if($minsize>0){
            $size = 5;
        }
        $Y = date("Y", time());
        $m = date("m", time());
        $d = date("d", time());
        $type 		= isset($_POST['type']) ? $_POST['type'] : 'zip,rar,doc,docx,xls,xlsx,png,jpg,jpeg,gif,bmp,pdf';
        $fileTypes 	= explode(',', $type);
        $fileElementName = isset($_POST['file_name']) ? $_POST['file_name'] : 'fileupload';
        $error = '';

        if(!empty($_FILES[$fileElementName]['error']))
        {
            switch($_FILES[$fileElementName]['error'])
            {
                case '1':
                    $error = 'The uploaded file exceeds the upload_max_filesize directive in php.ini';
                    break;
                case '2':
                    $error = 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form';
                    break;
                case '3':
                    $error = 'The uploaded file was only partially uploaded';
                    break;
                case '4':
                    $error = "没有选择上传文件";
                    break;
                case '6':
                    $error = 'Missing a temporary folder';
                    break;
                case '7':
                    $error = 'Failed to write file to disk';
                    break;
                case '8':
                    $error = 'File upload stopped by extension';
                    break;
                default:
                    $error = 'No error code avaiable';
            }
        }elseif(empty($_FILES[$fileElementName]['tmp_name']) || $_FILES[$fileElementName]['tmp_name'] == 'none')
        {
            $error = "没有选择上传文件";
        }else{
            if (!empty($_FILES)) {
                $fileParts = pathinfo($_FILES[$fileElementName]['name']);
                if (isset($fileParts['extension']) && in_array(strtolower($fileParts['extension']),$fileTypes)) {
                    $tempSize = $_FILES[$fileElementName]['size'];
                    if ($tempSize < 1024*1024*$size && $tempSize > 1024*$minsize)
                    {
                        $upload_dir = 'imgs/product/' . $Y . '/' . $m . '/' . $d;
                        !file_exists($upload_dir) ? mkdir($upload_dir,'0755',true) : '';
                        $tempFile 			= $_FILES[$fileElementName]['tmp_name'];
                        $targetPath 		= $upload_dir;
                        $guid = date("YmdHis", time()) . rand(1000, 10000);
                        !file_exists($targetPath) ? mkdir($targetPath,'0755',true) : '';
                        if('jpeg'==strtolower($fileParts['extension'])){
                            $fileParts['extension'] = 'jpg';
                        }
                        $temptargetfile 	= explode('.',$_FILES[$fileElementName]['name']);
                        $temptargetfile 	= $Y.$m.$d.$guid . '.' . $fileParts['extension'];
                        $targetFile 		= rtrim($targetPath,'/') . '/'. $temptargetfile;
                        move_uploaded_file($tempFile,$targetFile);
                        echo json_encode(array('success'=>'上传成功','path'=>$targetFile,'name'=>$temptargetfile));exit;
                    }
                }
            }
        }
        echo json_encode(array('error'=>$error));exit;
    }

	public function editorUpload() {
		$this->load->library('Uploader');
		$file = $_FILES['imgFile'];
		//上传文件不能为空
		$Y = date("Y", time());
		$m = date("m", time());
		$d = date("d", time());
		if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
			$this->uploader->allowed_size(4096000);
			$this->uploader->addFile($file);
			if ($this->uploader->file_info() === false) {
				show_error($this->uploader->get_error());
				return false;
			}
			$ret = $this->uploader->save('goods/' . $Y . '/' . $m . '/' . $d);
		}
		echo json_encode(array('error' => 0, 'url' => $this->config->base_url().'imgs/'.$ret));
		exit;
		//ajax_success($ret);
		//ajax_success('goods/' . $Y . '/' . $m . '/' . $d . '/' . basename($ret));
	}
	public function slideShow(){
		$data['list'] = $this->AdminModel->getSlideShow();	
		$this->load->view('admin/slide_show',$data);
	}
	public function addSlideShow(){
		if(IS_POST){
			$data = $this->input->post(NULL,TRUE);
			if(!$data['img']){
				ajaxError('图片不能为空');
			}
			$row = $this->AdminModel->addSlide($data);
			if(!$row){
				ajaxError('添加失败！');
			}
			ajaxSuccess('操作成功',array('url'=>'/admin/slideshow'));
		}
		$this->load->view('admin/slideshow_add');
	}
	public function editSlideShow(){
		if(IS_POST){
			$parm = $this->input->post(NULL,TRUE);
			$id = $parm['id'];
			unset($parm['id']);
			if(!$parm['img']){
				ajaxError('图片不能为空！');
			}
			$row = $this->AdminModel->updateSlideShow($id,$parm);
			if(!$row){
				ajaxError('操作失败！');
			}
			ajaxSuccess('操作成功',array('url'=>'/admin/slideshow'));
		}
		$slide_id = intval( $this->uri->segment(3) );
		if(!$slide_id) return FALSE;
		$data['info'] = $this->AdminModel->slideShowInfo($slide_id);
		$this->load->view('admin/slideshow_edit',$data);
	}
	public function delSlide(){
		$id = intval($this->uri->segment(3));
		if(!$id){
			$this->errorJump('非法操作');
			return;
		}
		$result = $this->AdminModel->delSlideShow($id);
		if(!$result){
			$this->errorJump('非法操作');
			return;
		}
		$this->successJump('操作成功','/admin/slideshow');
	}
	public function delMoreSlide(){
		if(!IS_POST){
			return FALSE;
		}
		$ids = $this->input->post('ids',TRUE);
		if( empty($ids) ){
			ajaxError('请选择操作数据');
		}
		$result = $this->AdminModel->delMoreSlideShow($ids);
		if(!$result){
			ajaxError('请选择操作数据');
		}
		ajaxSuccess('删除成功！',array('url'=>'/admin/slideshow'));
	}
	private function _getCategory(){
		return $this->AdminModel->getCategory();
	}
	public function order(){
		$keyword = trim( $this->input->get('keyword',TRUE) );
		$data = $this->AdminModel->orderList($keyword,$this->per_page, $this->offset);
		foreach ($data['list'] as &$v){
			$v['goods_datas'] = json_decode($v['goods_datas'],TRUE);
			$v['pay_type_name'] = $this->_pay_type($v['pay_type']);
			$v['status_code_name'] = $this->_status_code_name($v['status_code']);
		}
		$url_format = "/admin/order/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
		$data['keyword'] = $keyword;
		$this->load->view('admin/order_list',$data);
	}
	public function setConfirm(){
		$order_id = intval($this->uri->segment(3));
		if(!$order_id){
			$this->errorJump('非法操作');
			return;
		}
		$row = $this->AdminModel->setStatusCode($order_id,2);
		if(!$row){
			$this->errorJump('操作失败');
		}
		$this->successJump('设置成功');
	}
	public function orderDetail(){
		$order_id = intval($this->uri->segment(3));
		if(!$order_id){
			return FALSE;
		}
		$data['info'] = $this->AdminModel->getOrderInfo($order_id);

		$data['info']['goods_datas'] = json_decode($data['info']['goods_datas'],TRUE);
		$data['info']['pay_type_name'] = $this->_pay_type($data['info']['pay_type']);
		$data['info']['send_code_name'] = $this->_send_code_name($data['info']['send_code']);
		$data['address'] = $this->AdminModel->getAddressInfo($data['info']['address_id']);
		$this->load->view('admin/order_detail',$data);
	}
	public function doSend(){
		if(!IS_POST){
			return FALSE;
		}
		$order_id = intval( $this->input->post('order_id',TRUE) );
		$send_code = trim( $this->input->post('send_code',TRUE) );
		$send_number = trim( $this->input->post('send_number',TRUE) );
		if(!$order_id){
			$this->errorJump('非法操作');
			return;
		}
		if(!$send_code){
			$this->errorJump('请选择物流公司');
			return;
		}
		if($send_code !='intra-city' && !$send_number){
			$this->errorJump('请填写快递号');
			return;
		}
		$map['send_code'] = $send_code;
		$map['send_number'] = $send_number;
		if($send_code =='intra-city'){
			$map['is_send'] = 1;			
		}else{
			$map['is_send'] = 2;
		}
		$ret = $this->AdminModel->updateOrder($order_id,$map);
		if($ret){
			$this->AdminModel->setStatusCode($order_id, 3);
			$this->successJump('发货成功');
			return;
		}
		$this->errorJump('发货失败');
	}
	public function setPay(){
		if(!IS_POST){
			return FALSE;
		}
		$order_id = intval($this->input->post('id',TRUE));
		if(!$order_id){
			return FALSE;
		}
		$save ['pay_status'] = 1;
		$ret = $this->AdminModel->updateOrder($order_id,$save,TRUE);
		if($ret){
			$this->AdminModel->setStatusCode($order_id, 5);
		}
		echo 1;
	}
	public function setFinish(){
		$over_time = time() - 15 * 24 * 3600; // 15天后自动设置为已收货
		
		$map ['status_code'] = 3;
		$map ['pay_status'] = 1;
		$map ['cTime < '] = $over_time;
		$ids = $this->AdminModel->getOrderIds($map);
		if( !$ids ){
			$this->errorJump('没有可操作的订单');
			return ;
		}
		/*$logmap['status_code'] = 3;
		$logmap['cTime < '] = $over_time;
		$ids = $this->AdminModel->getUnfinishLogId(array_column($ids,'id'),$logmap);
		if(!$ids){
			$this->errorJump('没有可操作的订单');
			return ;
		}*/
		$this->load->model('CommissionModel');
		foreach ( array_column($ids, 'id') as $id ) {
			$this->AdminModel->setStatusCode ( $id, 4 );		
			$this->CommissionModel->commissionAction($id);
		}
		$this->successJump('操作完成！');
	}
	public function qrcode(){
		$this->per_page = 15;
		$this->cur_page = intval($this->uri->segment(3));
	    if ($this->cur_page < 1) {
	    	$this->cur_page = 1;
	    }
	    $this->offset = ($this->cur_page - 1) * $this->per_page;
		$mobile = trim( $this->input->get('mobile',TRUE) );
		$data = $this->AdminModel->qrcodeList($mobile,$this->per_page, $this->offset);
		$url_format = "/admin/qrcode/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
		$data['mobile'] = $mobile;
		$this->load->view('admin/qrcode_list',$data);
	}
	public function addQrcode(){
		//grant_type=client_credential&appid=APPID&secret=APPSECRET
		$param['grant_type'] = 'client_credential';
		$param['appid'] = APPID;
		$param['secret'] = APPSECRET;
		$url = 'https://api.weixin.qq.com/cgi-bin/token?'.http_build_query($param);
		$output = $this->soapCall($url);
		if(!$output){
			$this->errorJump('请求失败');
			return;
		}
		if(isset( $output['errcode'] ) ){
			$this->errorJump($output['errmsg']);
			return;
		}
		$access_token = $output['access_token'];

		$id = $this->AdminModel->createQrcode();
		if(!$id){
			$this->errorJump('请求失败！');
			return;
		}
		$qr['action_name'] = 'QR_LIMIT_STR_SCENE';
		$qr['action_info']['scene'] = array(
			'scene_str'=>$id
		);
		$json_qr = json_encode($qr,TRUE);		
		$url = 'https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token='.$access_token;
		$out = $this->soapCall($url,$json_qr);
		if(!isset($out['ticket'])){
			$this->errorJump('ticket获取失败！');
			return;
		}
		$focus_url = 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket='.$out['ticket'];
		$ActivatCode = $this->_getActivatCode();
		$agent_url = 'http://pan.baidu.com/share/qrcode?w=430&h=430&url='.$this->config->base_url().'agent/activat/'.$id.'/'.$ActivatCode;
		$row = $this->AdminModel->updateQrcodeInfo($id,array('focus_url'=>$focus_url,'agent_url'=>$agent_url,'activatcode'=>$ActivatCode,'ticket'=>$out['ticket']));
		if(!$row){
			$this->errorJump('添加失败！');
			return;
		}
		$this->successJump('添加成功！','/admin/qrcode');
	}
	public function bill($openid = NULL){
		if(!$openid){
			return FALSE;
		}
		$this->cur_page = intval($this->uri->segment(4));
		if ($this->cur_page < 1) {
			$this->cur_page = 1;
		}
		$this->offset = ($this->cur_page - 1) * $this->per_page;
		$order_sn = trim( $this->input->get('order_sn',TRUE) );
		$data = $this->AdminModel->billList($openid,$order_sn,$this->per_page, $this->offset);
		foreach ($data['list'] as &$v){
			$v['goods_datas'] = json_decode($v['goods_datas'],TRUE);
			$v['pay_type_name'] = $this->_pay_type($v['pay_type']);
		}
		$url_format = "/admin/bill/".$openid."/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
		$data['order_sn'] = $order_sn;
		$balance = $this->AdminModel->getAgentBalance($openid);
		$data['balance'] = $balance['balance']?$balance['balance']:'0.00';
		$data['openid'] = $openid;
		$this->load->view('admin/bill_list',$data);
	}
	public function viewQrcode($id = 0){
		if(IS_POST){
			$param = $this->input->post(NULL,TRUE);
			$qr_id = $param['id'];
			unset($param['id'],$param['openid'],$param['agenttime']);
			$row = $this->AdminModel->updateQrcode($qr_id,$param);
			if(!$row){
				ajaxError('操作失败！');
			}
			ajaxSuccess('操作成功',array('url'=>'/admin/qrcode'));
		}
		$id = intval($id);
		if(!$id){
			return FALSE;
		}
		$data['info'] = $this->AdminModel->getQrcodeInfo($id);
		$this->load->view('admin/qrcode_edit',$data);
	}
	private function _getActivatCode($length = 10) {
		$chars = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$len = strlen($chars);
		$code = '';
		for ($i = 0; $i < $length; $i ++) {
			$code .= $chars [mt_rand(0, $len - 1)];
		}
		$ret = $this->AdminModel->getRow('shop_qrcode',array('activatcode'=>$code));
		if($ret){
			$this->_getActivatCode();
		}
		return $code;
	}
	public function cash(){
		$this->per_page = 10;
		$this->cur_page = intval($this->uri->segment(3));
		if ($this->cur_page < 1) {
			$this->cur_page = 1;
		}
		$this->offset = ($this->cur_page - 1) * $this->per_page;

		$status = trim( $this->input->get('status',TRUE) );
		$data = $this->AdminModel->cashList($status,$this->per_page, $this->offset);

		$url_format = "/admin/cash/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
		$data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
		$data['status'] = $status;
		$this->load->view('admin/cash_list',$data);
	}
	public function finishCash($id = 0){
		if(!$id){
			$this->errorJump('非法请求','/admin/cash');
			return;
		}
		$info = $this->AdminModel->cashInfo(array('id'=>$id));
		if(!$info || $info['status'] != 1){
			$this->errorJump('无效申请记录','/admin/cash');
			return;
		}
		$result = $this->AdminModel->confirmCash(array('id'=>$id),array('status'=>2));
		if(!$result){
			$this->errorJump('确认失败','/admin/cash');
			return;
		}
		$this->successJump('确认成功','/admin/cash');
	}
	/* private function getImage($url){
		
		$ext = strrchr($url, "."); // 得到$url的图片格式
		$type = substr($ext, 1);
		if (!in_array($type, $this->config->item('_allowed_file_type'))) {
			return false;
		}
		$filename = date("YmdHis", time()) . rand(1111, 9999) . $ext; // 用天月面时分秒来命名新的文件名
		//创建保存目录
		$now = time();
		$Y = date("Y", $now);
		$m = date("m", $now);
		$d = date("d", $now);
		$path = $this->config->item('_root_dir') . '/qrcode/' . $Y . '/' . $m . '/' . $d . '/';

		$ch=curl_init();
		curl_setopt($ch,CURLOPT_URL,$url);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
		curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,5);
		$img=curl_exec($ch);
		curl_close($ch);
		echo 1;exit;
		//$size=strlen($img);
		//文件大小
		$fp2=@fopen($path . $filename,'a');
		fwrite($fp2,$img);
		fclose($fp2);
		unset($img,$url);
		return 'qrcode/' .$Y . '/' . $m . '/' . $d . '/'. $filename;
	}*/
	
	public function welcome(){
		
	}
	public function product(){
        $data = $this->AdminModel->productList($this->per_page, $this->offset);
        $url_format = "/admin/product/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
        $data['cur_page'] = $this->cur_page;
        $this->load->view('admin/product_list',$data);
    }
    public function addProduct(){
        if(IS_POST){
            $parm = $this->input->post(NULL,TRUE);
            if(!$parm['product_cource']){
                ajaxError('种苗及来源不能为空！');
            }
            if(!$parm['product_trait']){
                ajaxError('请填写产品特点！');
            }
            if(!$parm['farm']){
                ajaxError('请填写养殖场介绍！');
            }
            if(!$parm['record']){
                ajaxError('请填写用药防疫记录！');
            }
            if(!$parm['node']){
                ajaxError('请填写关键节点！');
            }
            if(!$parm['importance']){
                ajaxError('请填写重要事件！');
            }
            if(!$parm['farmer_info']){
                ajaxError('请填写农夫文字信息！');
            }
            if(!$parm['cook']){
                ajaxError('请填写图文推荐吃法 ！');
            }
            $row = $this->AdminModel->insert('shop_source',$parm);
            if(!$row){
                ajaxError('添加失败！');
            }
            ajaxSuccess('操作成功',array('url'=>'/admin/product'));
        }
        $this->load->view('admin/product_add');
    }
    public function editProduct(){
        if(IS_POST){
            $param = $this->input->post(NULL,TRUE);
            $id = $param['id'];
            unset($param['id']);
            if(!$id){
                ajaxError('数据不存在！');
            }
            if(!$param['title']){
                ajaxError('名称不能为空！');
            }
            $row = $this->AdminModel->update('shop_product',array('id'=>$id),$param);
            if(!$row){
                ajaxError('操作失败！');
            }
            ajaxSuccess('操作成功',array('url'=>'/admin/product'));
        }
        $cate_id = intval( $this->uri->segment(3) );
        if(!$cate_id){
            return FALSE;
        }
        $data['info'] = $this->AdminModel->getRow('shop_source',array('id'=>$cate_id));
        $this->load->view('/admin/product_edit',$data);
    }
    public function delProduct(){
        $id = intval($this->uri->segment(3));
        if(!$id){
            $this->errorJump('非法操作');
            return;
        }
        $result = $this->AdminModel->delete('shop_source',array('id'=>$id));
        if(!$result){
            $this->errorJump('非法操作');
            return;
        }
        $this->successJump('操作成功','/admin/product');
    }
    public function delMoreProduct(){
        if(!IS_POST){
            return FALSE;
        }
        $ids = $this->input->post('ids',TRUE);
        if( empty($ids) ){
            ajaxError('请选择操作数据');
        }
        $result = $this->AdminModel->delProduct($ids);
        if(!$result){
            ajaxError('请选择操作数据');
        }
        ajaxSuccess('删除成功！',array('url'=>'/admin/product'));
    }
    //商品兑换卷
    public function voucher(){
        $keyword = trim( $this->input->get('keyword',TRUE) );
        $data = $this->AdminModel->shop_voucher($keyword,$this->per_page, $this->offset);
        $url_format = "/admin/voucher/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['total'] / $this->per_page), $url_format, 5, TRUE, TRUE,$data['total']);
        $data['cur_page'] = $this->cur_page;
        $data['keyword'] = $keyword;
        $this->load->view('admin/voucher',$data);
    }
    //商品兑换卷
    public function addVoucher(){
        if(IS_POST){
            $time = time();
            $post = $this->input->post(NULL,TRUE);
            if(!$post['goods_id']){
                ajaxError('商品ID不能为空！');
            }
            if(!$post['number']){
                ajaxError('数量不能为空！');
            }
            if(!$post['owner_id']){
                ajaxError('电子券拥有者微信ID不能为空！');
            }
            if(!$post['get_time']){
                ajaxError('转电子券时间不能为空！');
            }
            if(!$post['use_time']){
                ajaxError('使用时间不能为空！');
            }
            //去查有没有这个商品
            $row = $this->AdminModel->getRow('shop_goods',array('id'=>$post['goods_id']));
            if(!$row){
                ajaxError('该商品ID不存在');
            }
            //去检查有没有这个微信ID
            $row2 = $this->AdminModel->getRow('shop_qrcode',array('openid'=>$post['owner_id']));
            if(!$row2){
                ajaxError('该微信ID不存在');
            }
            $post['use_time'] = strtotime($post['use_time']);
            $post['get_time'] = strtotime($post['get_time']);
            $post['sign'] = md5($time.$post['goods_id']);
            $post['addtime'] = $time;
            $result = $this->AdminModel->insert('shop_voucherinfo',$post);
            if($result){
                ajaxSuccess('添加成功！',array('url'=>'/admin/voucher'));
            }
        }
        $this->load->view('admin/voucher_add');
    }
    public function delVoucher(){
        $id = intval($this->uri->segment(3));
        if(!$id){
            $this->errorJump('非法操作');
            return;
        }
        $result = $this->AdminModel->delete('shop_voucherinfo',array('id'=>$id));
        if(!$result){
            $this->errorJump('非法操作');
            return;
        }
        $this->successJump('操作成功','/admin/voucher');
    }
    public function delMoreVoucher(){
        if(!IS_POST){
            return FALSE;
        }
        $ids = $this->input->post('ids',TRUE);
        if( empty($ids) ){
            ajaxError('请选择操作数据');
        }
        $result = $this->AdminModel->delVouchert($ids);
        if(!$result){
            ajaxError('请选择操作数据');
        }
        ajaxSuccess('删除成功！',array('url'=>'/admin/voucher'));
    }
}
