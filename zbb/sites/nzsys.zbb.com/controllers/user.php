<?php

/*
 * 后台会员管理控制器
 */

class User extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('sys_user_model');
        $this->load->model('user_model');
        //每页显示的条数
        $this->per_page = 10;
        //当前页
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        //当前页从第几条数据开始
        $this->offset = ($this->cur_page - 1) * $this->per_page;
    }

    /*
     * 默认首页
     */

    public function index()
    {
        //获取关键字
        $field_name = $this->input->get('field_name', TRUE);
        $field_value = $this->input->get('field_value', TRUE);
        //获取排序
        $sort = $this->input->get('sort', TRUE);
        //显示页码数
        $show_page = 5;
        //根据用户输入的条件进行订单查询，结合分页类使用
        $data = $this->sys_user_model->get_search($field_name, $field_value, $sort);
        $url = '/user/index/%d?' . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['count'] / $this->per_page), $url, $show_page, TRUE, FALSE, $data['count']);
        $data['list'] = $this->check_admin($data['list']);
        $data['list'] = $this->check_lock($data['list']);
        $this->load->view('user/user_index', $data);
    }

    /*
     * 新增
     */

    public function add()
    {
        if (IS_POST) {
            $data = $this->input->post(NULL, TRUE);
            if ($data['user_name'] == '') {
                echo '<script>alert("请输入用户名");window.history.go(-1);</script>';
                exit;
            }
            $is_registrable = $this->sys_user_model->is_registrable($data['user_name']);
            if (!$is_registrable) {
                echo '<script>alert("用户名格式不正确或用户名已存在");window.history.go(-1);</script>';
                exit;
            }
            if ($data['password'] == '') {
                echo '<script>alert("请输入密码");window.history.go(-1);</script>';
                exit;
            }
            $check_password = $this->user_model->check_password($data['password']);
            if (!$check_password) {
                echo '<script>alert("密码格式不正确");window.history.go(-1);</script>';
                exit;
            }
            if (!empty($_FILES['portrait']['name'])) {
                $data['portrait'] = $this->_upload_image();
            }
            $data['reg_time'] = time();
            $result = $this->sys_user_model->reg_to_admin($data['user_name'], $data['password'], $data['email']);
            if ($result) {
                get_redirect('新增成功', '/user');
            } else {
                get_redirect('新增失败', '/user');
            }
        }
        $this->load->view('user/user_add');
    }

    /*
     * 冻结帐号
     * lock == 1  冻结帐号
     */

    public function lock()
    {
        if (IS_POST) {
            $user_id = intval($this->input->get('id', true));
            $data['lock_msg'] = $this->input->post('content', TRUE);
            $data['lock_time'] = strtotime($this->input->post('lock_time', TRUE));
            if (empty($data['lock_time'])) {
                get_redirect('请输入正确的时间格式', '/user/lock/id/' . $user_id);
                exit;
            }
            if ($data['lock_time'] < time()) {
                get_redirect('输入的截至日期小于当前日期，请重新输入', '/user/lock/id/' . $user_id);
                exit;
            }
            if (empty($data['lock_msg']) || empty($data['lock_time'])) {
                get_redirect('原因或时间不能为空', '/user/lock/id/' . $user_id);
                exit;
            }
            $this->sys_user_model->user_lock($user_id, $data);
            //添加进自动解锁的定时器表
            $result = $this->sys_user_model->tasktimer_lock($user_id, $data);
            if ($result) {
                get_redirect('冻结成功', '/user');
            }
        }
        $this->load->view('user/user_lock');
    }

    /*
     * 解除冻结帐号
     * lock == 0  冻结帐号
     */

    public function unlock()
    {
        $user_id = intval($this->input->get('id', true));
        if ($user_id) {
            $this->sys_user_model->user_unlock($user_id);
            get_redirect('解除成功', '/user');
        }
    }

    /**
     * 判断是否为管理员 type == 0 时为普通会员 type == 1时为管理员
     * @param $data user表的全部数据
     * @return $data 返回重组后的全部数据
     */
    private function check_admin($data)
    {
        foreach ($data as $key => $val) {
            if ($val['type'] == 0) {
                $data[$key]['type'] = '<a href="' . $this->config->item('domain_nzsys') . 'admin/add?id=' . $val['user_id'] . '">设为管理员</a>';
            } elseif ($val['type'] == 1) {
                $data[$key]['type'] = '是';
            }
        }
        return $data;
    }

    /**
     * 判断是否冻结 lock == 0时未冻结 lock == 1时已冻结
     * @param $data user表的全部数据
     * @return $data 返回重组后的全部数据
     */
    private function check_lock($data)
    {
        foreach ($data as $key => $val) {
            if ($val['lock'] == 0) {
                $data[$key]['lock'] = '<a href="' . $this->config->item('domain_nzsys') . 'user/lock?id=' . $val['user_id'] . '">点击冻结</a>';
            } elseif ($val['lock'] == 1) {
                $data[$key]['lock'] = '已冻结 | <a href="' . $this->config->item('domain_nzsys') . 'user/unlock?id=' . $val['user_id'] . '">点击解除</a>';
            }
        }
        return $data;
    }

    //AJAX 点击查看UC库的手机号码和邮箱
    public function select_uc_mob()
    {
        $user_id = intval($this->input->post('user_id', true));
        $row = $this->sys_user_model->select_uc_mob($user_id);
        echo json_encode($row);
    }

}