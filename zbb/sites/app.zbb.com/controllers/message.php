<?php

/*
首页控制器
 */

class Message extends App_Controller
{
    const PER_NUM = 20;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('message_model');
    }

    /**
     * 消息首页
     */
    public function index()
    {
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;

        //0为众宝贝消息，1为系统消息
        $zbb_info = $this->message_model->app_get_one($user_id, 0);
        if ($zbb_info) {
            $arr['zbb_info']['content'] = mb_substr($zbb_info['content'], 0, 23, 'utf-8');
            $arr['zbb_info']['is_show'] = $zbb_info['new'] == 1 ? 1 : 0;
            $arr['zbb_info']['add_time'] = date('y/m/d', $zbb_info['add_time']);
        } else {
            $arr['zbb_info']['content'] = '暂无数据';
            $arr['zbb_info']['is_show'] = 0;
            $arr['zbb_info']['add_time'] = '';
        }

        $sys_info = $this->message_model->app_get_one($user_id, 1);
        if ($sys_info) {
            $arr['sys_info']['content'] = mb_substr($sys_info['content'], 0, 23, 'utf-8');
            $arr['sys_info']['is_show'] = $sys_info['new'] == 1 ? 1 : 0;
            $arr['sys_info']['add_time'] = date('y/m/d', $sys_info['add_time']);
        } else {
            $arr['sys_info']['content'] = '暂无数据';
            $arr['sys_info']['is_show'] = 0;
            $arr['sys_info']['add_time'] = '';
        }
        $this->success(1, '数据返回成功', $arr);

    }

    /**
     * 消息列表
     */
    public function msg_list()
    {
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;
        $is_sys = intval($this->input->post('is_sys'));
        $page = intval($this->input->post('page'));//分页
        if (empty($page)) $page = 1;
        $offset = ($page - 1) * self::PER_NUM;
        $ret = $this->message_model->get_all_num($user_id, $is_sys, self::PER_NUM, $offset);
        if ($ret) {
            foreach ($ret['list'] as &$v) {
                $v['add_time'] = date('y/m/d', $v['add_time']);
            }
        } else {
            $arr['list'] = array();
            $arr['total'] = 0;
        }
        $arr['list'] = $ret['list'];

        $arr['total'] = $ret['total'];
        $arr['page_size'] = self::PER_NUM;
        $this->success(1, '数据返回成功', $arr);

    }

    /**
     * 消息查看
     */
    public function msg_view()
    {
        $this->check_user();
        $user_id = $this->uid;
        $msg_id = intval($this->input->post('msg_id'));
        $arr= $this->message_model->view($msg_id, $user_id);
        if ($arr) {
            $ret['title']=$arr['title'];
            $ret['content']=$arr['content'];
            $ret['add_time']=date('y/m/d',$arr['add_time']);
            $ret['new']=$arr['new'];
            $ret['is_sys']=$arr['is_sys'];
            $this->success(1, '数据返回成功',$ret);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     * 消息查看
     */
    public function msg_del()
    {
        $this->check_user();
        $user_id = $this->uid;
        $msg_id = intval($this->input->post('msg_id'));
        $ret= $this->message_model->del_msgs($user_id, $msg_id);
        if ($ret) {
            $this->success(1, '数据返回成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     * 消息未读总数
     */
    public function total()
    {
        $this->check_user();
        $user_id = $this->uid;
        //消息群发消息同步
        $msg_info = $this->message_model->message_mass(1);
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
        //读取未读消息
        $ret= $this->message_model->unread_msg($user_id);
        if ($ret) {
            $this->success(1, '数据返回成功',$ret);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

}