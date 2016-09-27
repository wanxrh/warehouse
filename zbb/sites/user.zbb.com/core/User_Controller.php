<?php

/*
 * 用户基础类
 */

class User_Controller extends CI_Controller
{

    protected $data;

    function __construct()
    {
        parent::__construct();
        header("Content-type: text/html; charset=utf-8");
        $this->data['user_id'] = $user_id = get_user()['id'];
        if (!$user_id) {
            header('Location: ' . $this->config->item('domain_www'));
            exit;
        }
        //判断是否有店铺
        $this->load->model('store_model');
        $this->load->model('message_model');
        $ret = $this->store_model->store_info($user_id);
        //消息群发消息同步
        $msg_info = $this->message_model->message_mass(2);
        foreach ($msg_info as $key => $val) {
            $mass_id = $val['id'];
            $row = $this->message_model->get_one($user_id, $mass_id);
            if (!$row) {
                if (time()< $val['end_time']) {
                    $temp = array('from_id' => $val['from_uid'], 'to_id' => $user_id, 'title' => $val['title'], 'content' => $val['content'], 'add_time' => time(), 'new' => 1, 'mass_id' => $mass_id, 'is_sys' => 1);
                    $this->message_model->_stat_msg($user_id,'+');
                    $this->message_model->get_message($temp);
                }
            }
        }
        if (!$ret) {
            //跳转到申请页面
            header('Location: ' . $this->config->item('domain_user') . 'store/protocol');
            exit;
        }
    }
}