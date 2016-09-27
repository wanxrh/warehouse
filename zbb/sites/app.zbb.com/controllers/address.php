<?php

/**
 * 我的地址
 */
class Address extends App_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('address_model');

    }

    /**
     * 用户地址列表
     */
    public function index()
    {
        $this->check_user();
        $uid = $this->uid;
        $ret['list'] = $this->address_model->get_address($uid);
        if ($ret['list']) {
            $this->success(1, '数据返回成功', $ret);
        } else {
            $this->failure(0, '暂无数据');
        }
    }

    /**
     * 增加地址
     */
    public function add()
    {
        $this->check_user();
        $uid = $this->uid;

        $arr['user_id'] = $uid;
        $arr['consignee'] = filter_sql($this->input->post('consignee'));
        $arr['province_id'] = intval($this->input->post('province_id'));
        $arr['city_id'] = intval($this->input->post('city_id'));
        $arr['country_id'] = intval($this->input->post('country_id'));
        $arr['region_name'] = filter_sql($this->input->post('region_name'));
        $arr['address'] = filter_sql($this->input->post('address'));
        $arr['zipcode'] = filter_sql($this->input->post('zipcode'));
        $arr['tel'] = filter_sql($this->input->post('tel'));
        $arr['mobile'] = intval($this->input->post('mobile'));

        //先判断有地址
        $temp = $this->address_model->get_address($uid);
        if ($temp) {
            $arr['is_default'] = 0;
        }else{
            $arr['is_default'] = 1;
        }
        $ret['addr_id'] = $this->address_model->add_addr($arr);
        if ($ret) {
            $this->success(1, '添加成功', $ret);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /**
     * 修改地址
     */
    public function edit()
    {
        $this->check_user();
        $uid = $this->uid;

        $arr['consignee'] = filter_sql($this->input->post('consignee'));
        $arr['province_id'] = intval($this->input->post('province_id'));
        $arr['city_id'] = intval($this->input->post('city_id'));
        $arr['country_id'] = intval($this->input->post('country_id'));
        $arr['region_name'] = filter_sql($this->input->post('region_name'));
        $arr['address'] = filter_sql($this->input->post('address'));
        $arr['zipcode'] = filter_sql($this->input->post('zipcode'));
        $arr['tel'] = filter_sql($this->input->post('tel'));
        $arr['mobile'] = intval($this->input->post('mobile'));

        $addr_id = intval($this->input->post('addr_id'));

        $ret = $this->address_model->edit_addr($addr_id, $uid, $arr);
        if ($ret) {
            $this->success(1, '修改成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }


    /**
     * 删除地址
     */
    public function del()
    {
        $this->check_user();
        $uid = $this->uid;
        $addr_id = intval($this->input->post('addr_id'));

        $ret = $this->address_model->delete_addr($addr_id, $uid);
        if ($ret) {
            $this->success(1, '删除成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    /*
     * 联动地址
     */
    public function get_region()
    {
        $parent_id = intval($this->input->post('parent_id'));
        $ret['list'] = $this->address_model->get_region($parent_id);
        if ($ret['list']) {
            $this->success(1,'返回成功',$ret);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }


    /*
     * 设置默认地址
     */
    public function set_default()
    {
        $this->check_user();
        $uid = $this->uid;

        $addr_id = intval($this->input->post('addr_id'));
        $data=array('is_default'=>1);
        $this->address_model->edit_addr(0,$uid,array('is_default'=>0));
        $ret = $this->address_model->edit_addr($addr_id,$uid,$data);
        if ($ret) {
            $this->success(1, '设置成功');
        } else {
            $this->failure(0, '系统繁忙');
        }
    }
}