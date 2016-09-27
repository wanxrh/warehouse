<?php

/*
首页控制器
 */

class Profile extends App_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('profile_model');
    }

    /**
     *修改资料页面
     * @author
     */
    public function index()
    {
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;
        $ret = $this->profile_model->user_info($user_id);
        $user_info['user_id'] = $user_id;
        $user_info['gender'] = $ret['gender'];//性别
        $user_info['portrait'] = $ret['portrait'] ? img_url($ret['portrait']) : '';//头像
        $user_info['background_img'] = $ret['background_img'] ? img_url($ret['background_img']) : '';//背景图
        $user_info['location'] = $ret['location'];

        $result = $this->profile_model->ship_address($user_id);
        //判断是否存在收货地址
        if ($result > 0) {
            $user_info['ship_address'] = 1;
        } else {
            $user_info['ship_address'] = 0;
        }
        //链接uc中心获取手机
        $temp = $this->profile_model->get_mobile($user_id);
        $user_info['mobile'] = $temp['mobile'];

        if ($user_info) {
            $this->success(1, '数据返回成功', $user_info);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     *修改头像
     * @author
     */
    public function portrait()
    {
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;
        $img = $this->upload_image('portrait');
        $ret = $this->profile_model->save_portrait($user_id, $img);
        if ($ret) {
            $this->success(1, '上传成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     *修改背景
     * @author
     */
    public function background()
    {
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;
        $img = $this->upload_image('background');
        $ret = $this->profile_model->save_background($user_id, $img);
        if ($ret) {
            $this->success(1, '上传成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     *性别
     * @author
     */
    public function gender()
    {
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;
        $sex = intval($this->input->post('gender'));

        $ret = $this->profile_model->save_gender($user_id, $sex);
        if ($ret) {
            $this->success(1, '修改成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     *获取地区
     * @author
     */
    public function region()
    {
        $region_id = intval($this->input->post('region_id'));
        //获取会员地址
        $ret = $this->profile_model->get_region($region_id);

        if ($ret) {
            $this->success(1, '数据返回成功', $ret);
        } else {
            $this->failure(0, '获取失败');
        }
    }

    /**
     *保存地址
     * @author
     */
    public function location()
    {
        //获取会员信息
        $this->check_user();
        $user_id = $this->uid;
        $province_id = intval($this->input->post('province_id'));
        $location = filter_sql($this->input->post('location'));

        //获取会员地址
        $data = array(
            'province_id' => $province_id,
            'location' => $location,
        );
        $ret = $this->profile_model->save_address($user_id, $data);
        if ($ret) {
            $this->success(1, '数据返回成功');
        } else {
            $this->failure(0, '获取失败');
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
        $Y = date("Y", time());
        $m = date("m", time());
        $d = date("d", time());
        if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
            $this->uploader->allowed_size(6096000);
            $this->uploader->addFile($file);
            if ($this->uploader->file_info() === false) {
                show_error($this->uploader->get_error());
                return false;
            }
            $ret = $this->uploader->save(''.$img.'/' . $Y . '/' . $m . '/' . $d);
        }
        return ''.$img.'/' . $Y . '/' . $m . '/' . $d . '/' . basename($ret);
    }
}