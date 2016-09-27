<?php

class Client extends Admin_Controller {

	public function __construct() {
		parent::__construct();
		$this->load->model('apk_model');
	}

	public function index() {
		/* 创建文件读取资源句柄 */
		$dir_source = opendir($this->config->item('_download_dir') . '/client');
		$file_list = array(); //用于接收符合要求的文件名
		$preg = '/^\w+/';
		/* 两个感叹号，转换为布尔值 */
		while (!!$file = readdir($dir_source)) {
			if (preg_match($preg, $file)) {
				$file_list[] = $file;
			}
		}
		closedir($dir_source); //关闭资源
		$data['files'] = $file_list;
		$this->load->view('client/index', $data);
	}

	public function delete() {
		$client_name = $this->input->get('name', TRUE);
		$res = unlink($this->config->item('_download_dir') . '/client/' . $client_name);
		if ($res) {
			get_redirect('删除成功', '/client');
			exit;
		}
		get_redirect('操作失败', '/client');
	}

	public function upload() {
		if (IS_POST) {
			$version = $this->input->post('version', true);
			if($version == ''){
				get_redirect('版本号不能为空', '/client/upload');
				exit;
			}
			$content = $this->input->post('content', true);
			$this->load->library('uploader');
			$res = '';
			if (!empty($_FILES['client_name'])) {
				$file = $_FILES['client_name'];
				if ($file['error'] == UPLOAD_ERR_OK) {
					$this->uploader->allowed_type('rar|zip'); //定义上传文件类型
					$this->uploader->allowed_size(20971520); //定义上传文件的大小，最大20M
					$this->uploader->addFile($file);
					$this->uploader->root_dir($this->config->item('_download_dir'));
					if ($this->uploader->file_info() === false) {
						show_error($this->uploader->get_error());
						return false;
					}
					/* 得到需要保存的文件名 */
					$file_name = substr($file['name'], 0, strrpos($file['name'], '.'));
					$res = $this->uploader->save('/client', $file_name);
				}
			}
			if ($res) {
				$arr = array('version' => $version, 'content' => $content, 'img' => '');
				$temp = $this->apk_model->update_client_info($arr);
				if ($temp) {
					get_redirect('上传成功', '/client');
				} else {
					get_redirect('上传失败', '/client');
				}
			}
		} else {
			$this->load->view('client/add');
		}
	}

}
