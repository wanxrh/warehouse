<?php

class Message extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('send_model');
        $this->load->model('message_model');
    }

    /*
     * 默认管理员首页
     */

    public function index()
    {
        $this->load->view('message');
    }

    public function send()
    {
        $temp_post = $this->input->post(NULL);
        $from_id = get_admin();
        $title = $temp_post['title'];
        $to_type = $temp_post['to_type'];
        $content = $temp_post['content'];
        $username = $temp_post['username'];
        $arr = explode(",", $username);
        if ($temp_post['username'] != '') {
            $user = $this->send_model->user_info($arr);
            if ($user) {
                foreach ($user as $key => $val) {
                    $user_id = $val['user_id'];
                    $temp = array('from_id' => $from_id, 'to_id' => $user_id, 'title' => $title, 'content' => $content, 'add_time' => time(), 'new' => 1, 'is_sys' => 1);
                    $this->message_model->send_msgs($temp, $user_id);  //指定会员发送
                }
                get_redirect("发送成功", '/message');
            } else {
                echo "<script>alert('会员名不正确');history.go(-1);</script>";
            }
        } else {
            //群发
            $end_time = $temp_post['days'] * 86400 + time();
            $this->send_model->send_mass($from_id, $to_type, $title, $content, $end_time);
            get_redirect("发送成功", '/message');
        }
    }

    /*
     * kindedit插件的图片上传处理
     */

    public function upload()
    {
        if (!get_admin()) {
            show_error("未登录不能上传");
        } else {
            $this->load->library('uploader');
            $file = $_FILES['imgFile'];
            //上传文件不能为空
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
                $this->uploader->allowed_size(400000);
                $this->uploader->addFile($file);
                if ($this->uploader->file_info() === false) {
                    show_error($this->uploader->get_error());
                    return false;
                }
                $ret = $this->config->item('domain_img') . $this->uploader->save('system/' . $Y . '/' . $m . '/' . $d);
            }
            echo json_encode(array('error' => 0, 'url' => $ret));
            exit;
        }
    }

}
