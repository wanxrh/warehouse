<?php

/**
 * 后台支付管理控制器
 */
class Payment extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('payment_model');
    }

    public function index()
    {
        $data['list'] = $this->payment_model->get_payments();
        // 格式化是否开启
        foreach ($data['list'] as $k => $v) {
            $data['list'][$k]['enabled'] = $v['enabled'] == 1 ? '是' : '否';
        }
        $this->load->view('payment/payment_index', $data);
    }

    /**
     * 增加
     */
    public function add_payment()
    {
        if (IS_POST) {
            $add = $this->input->post(NULL, TRUE);
            if ($add['payment_code'] == '' || $add['payment_name'] == '' || $add['sort_order'] == '' || $add['sort_order'] < 0 || $add['sort_order'] > 255) {
                echo "<script>alert('必填字段未填或输入了非法字符');history.go(-1);</script>";
                return;
            }
            $data = array(
                'payment_code' => filter_sql($add['payment_code']),
                'payment_name' => filter_sql($add['payment_name']),
                'payment_desc' => filter_sql($add['payment_desc']),
                'enabled' => intval($add['enabled']),
                'sort_order' => intval($add['sort_order']),
            );
            // 如果有图片上传
            if ($_FILES['icon']['error'] == 0) {
                $icon = $this->_upload_image('icon');
                $data['icon'] = $icon;
            }
            $id = $this->payment_model->add_payment($data);
            if ($id) {
                get_redirect('新增成功', '/payment');
            } else {
                get_redirect('新增失败', '/payment');
            }
        }
        $this->load->view('payment/payment_add');
    }

    /**
     * 删除
     */
    public function del_payment()
    {
        $payment_id = intval($this->input->get('payment_id', TRUE));
        $this->payment_model->del_payment($payment_id);
        get_redirect('删除成功', '/payment');
    }

    /**
     * 修改
     */
    public function edit_payment()
    {
        $payment_id = intval($this->input->get('payment_id', TRUE));
        $info = $this->payment_model->get_one_payment($payment_id);
        if (IS_POST) {
            $edit = $this->input->post(NULL, TRUE);
            if ($edit['payment_code'] == '' || $edit['payment_name'] == '' || $edit['sort_order'] == '' || $edit['sort_order'] < 0 || $edit['sort_order'] > 255) {
                echo "<script>alert('必填字段未填或输入了非法字符');history.go(-1);</script>";
                return;
            }
            $payment_id = intval($edit['payment_id']);
            $data = array(
                'payment_code' => filter_sql($edit['payment_code']),
                'payment_name' => filter_sql($edit['payment_name']),
                'payment_desc' => filter_sql($edit['payment_desc']),
                'enabled' => intval($edit['enabled']),
                'sort_order' => intval($edit['sort_order']),
            );
            // 如果有图片上传
            if ($_FILES['icon']['error'] == UPLOAD_ERR_OK) {
                $icon = $this->_upload_image('icon');
                $data['icon'] = $icon;
            }
            $result = $this->payment_model->edit_payment($payment_id, $data);
            if ($result) {
                get_redirect('修改成功', '/payment');
            } else {
                get_redirect('修改失败', '/payment');
            }
        }
        $this->load->view('payment/payment_edit', $info);
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
            $info = $this->uploader->file_info();
            $type = $info['extension'];
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            $dir_name = 'payment/' . $Y . '/' . $m . '/' . $d;
            $filename = time() . rand(1000, 9999);
            $this->uploader->save($dir_name, $filename);
        }
        return 'payment/' . $Y . '/' . $m . '/' . $d . '/' . $filename . '.' . $type;
    }
}