<?php

/*
 * apk控制器
 */

class Apk extends Admin_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('apk_model');
    }

    /*
     * 默认
     */

    public function index() {
        $ret['apk_info']= $this->apk_model->get_info();
        $this->load->view('apk/index',$ret);
    }

   /*
     * 更新页面
     */

    public function renew() {
    	if(!IS_POST){
    	   $ret['apk_info']= $this->apk_model->get_info();
           $this->load->view('apk/renew',$ret);
    	}else{
    		$version=$this->input->post('version');
    		$content=$this->input->post('content');
            $is_open=$this->input->post('is_open');
    		//处理上传apk
            $ret = $this->upload_image('apk');
			$arr=array('version' =>$version ,'content' => $content,'url' => $ret,'is_open'=>$is_open);
			$temp= $this->apk_model->update_info($arr);
			if($temp){
					get_redirect('更新成功', '/apk/index');
				}else{
					get_redirect('更新失败', '/apk/index');
				}	
    	}
    }

    /**
     * 图片上传
     */
    protected function upload_image($img)
    {
        $this->load->library('uploader');
        $file = $_FILES[$img];
        //上传文件不能为空
        if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
            $this->uploader->allowed_size(6096000);
            $this->uploader->addFile($file);
            $this->uploader->allowed_type('apk');//定义上传文件类型
            if ($this->uploader->file_info() === false) {
                show_error($this->uploader->get_error());
                return false;
            }
            return $this->config->item('domain_download').$this->uploader->save($img,basename($file['name'],".apk"));
        }
    }
       
}
