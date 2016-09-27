<?php

/**
 * 用户中心控制器
 */
class Myinfo extends User_Controller {

    private $user_id;
	public function __construct() {
		parent::__construct();
        $this->user_id = get_user()['id'];
        $this->load->model('myinfo_model');
	}

	public function index() {
	    $data['myinfo'] = $this->myinfo_model->get_member($this->user_id);
        $ret = $this->myinfo_model->get_mobile($this->user_id);
        $data['mobile']=isset($ret['mobile'])?hide_star($ret['mobile']):'';
        $data['un_ship']=$this->myinfo_model->un_ship($this->user_id);
        $data['un_refund']=$this->myinfo_model->un_refund($this->user_id);
        $temp=$this->myinfo_model->un_read($this->user_id);
        $data['un_read']=isset($temp['msg_unread'])?$temp['msg_unread']:0;
        $data['finished']=$this->myinfo_model->finished($this->user_id);
		$this->load->view('index',$data);
	}
    /*
     * 头像上传
     */
	public function portrait(){
        if(IS_POST){
            $file = $this->_upload_image('store_logo');
            $data = array(
                'portrait'=>$file,
            );
        $this->myinfo_model->edit_portrait($this->user_id,$data);
            get_redirect('上传成功','/myinfo/index');
        }
    }

    public function member_ajax(){
        $this->load->library('Hulianpay');
        $output['balance'] = $this->hulianpay->get_user_amount($this->user_id);
        if ($this->hulianpay->hlpay_error) {
            ajax_error('获取失败');
        }
        ajax_success($output['balance']);
    }
    /**
     * 图片上传
     */
    protected function _upload_image($img)
    {
        $this->load->library('uploader');
        $this->uploader->allowed_size(6000000); // 400KB
        $file = $_FILES[$img];

        if ($file['error'] == UPLOAD_ERR_OK) {
            if (empty($file)) {
                return false;
            }
            $this->uploader->addFile($file);
            if (!$this->uploader->file_info()) {
                show_error($this->uploader->get_error());
            }
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            $dir_name = 'portrait/' . $Y . '/' . $m . '/' . $d;
            $filename = time() . rand(1000, 9999);
           return  $this->uploader->save($dir_name, $filename);
        }
    }
}