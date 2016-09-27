<?php

/**
 * 服务费资费标准
 */
class Rate extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('rate_model');
    }

    /**
     * 资费标准列表
     */
    public function index()
    {
        $res = $this->rate_model->get_cate_rate();

        if ($res) {
            $data['list'] = $res['list'];
            $this->load->view('rate/rate_index', $data);
        } else {
            show_error('获取信息失败!');
        }
    }

    /**
     * 添加资费标准
     */
    public function rate_add()
    {
        if (IS_POST) {
            $cate_id = intval($this->input->post('cate_id', true));
            $rate = doubleval($this->input->post('rate', true));
            if ($cate_id <= 0 || $rate <= 0) {
                echo "<script>alert('必填项未填或输入不合法!');history.go(-1);</script>";
            }
            $add = $this->rate_model->rate_add($cate_id, $rate);
            if ($add) {
                get_redirect('添加资费成功!', '/rate');
                // 写入service_charges文件
                $this->_service_charges($cate_id, $rate);
            } else {
                get_redirect('添加资费失败!', '/rate');
            }
        }
        $temp = $this->rate_model->get_cate();
        $rate_cate_id = array_column($temp['rate'], 'cate_id');
        foreach ($temp['cate'] as $value) {
            if (!in_array($value['cate_id'], $rate_cate_id)) {
                $data['cate'][] = $value;
            }
        }
        $this->load->view('rate/rate_add', $data);
    }

    /**
     * 删除资费标准
     */
    public function rate_del()
    {
        $cate_id = intval($this->uri->segment(4));
        $res = $this->rate_model->rate_del($cate_id);
        if (!$res) {
            get_redirect('删除失败!', '/rate');
        }
        // 写入service_charges文件
        $this->_service_charges($cate_id);
        header("location:" . '/rate');
    }

    /**
     * 添加或修改资费
     */
    public function rate_save()
    {
        $rate_info = $this->rate_model->get_rate();
        $rate_cate_id = array_column($rate_info, 'cate_id');

        if (IS_POST) {
            $cate_id = intval($this->input->post('cate_id', true));
            $rate = doubleval($this->input->post('rate', true));
            if ($cate_id <= 0 || $rate <= 0) {
                echo "<script>alert('必填项未填或输入不合法!');history.go(-1);</script>";
            }
            // 如果表中原来存有,则修改
            if (in_array($cate_id, $rate_cate_id)) {
                $res = $this->rate_model->rate_save($cate_id, $rate);
            } else {
                // 没有,则添加
                $res = $this->rate_model->rate_add($cate_id, $rate);
            }
            // 输入资费为0.05,则删除数据库中的条目
            if ($rate == 0.05) {
                $res = $this->rate_model->rate_del($cate_id);
            }
            if ($res) {
                get_redirect('修改资费成功!', '/rate');
                $this->_service_charges($cate_id, $rate);
            }
            get_redirect('修改资费失败!', '/rate');
        }

        $data['cate_id'] = intval($this->uri->segment(4));
        $rate = $this->rate_model->get_one_rate($data['cate_id']);
        if ($rate) {
            $data['rate'] = $rate['rate'];
        } else {
            $data['rate'] = null;
        }
        $temp = $this->rate_model->get_one_cate($data['cate_id']);
        $data['cate_name'] = $temp['cate_name'];
        $this->load->view('rate/rate_save', $data);
    }

    /**
     * 写入service_charges文件
     */
    private function _service_charges($cate_id, $rate = 0.05)
    {
        $arr = array(0 => '0.05');
        $res = $this->rate_model->get_rate();
        foreach ($res as $v) {
            if ($v['rate'] != 0.05) {
                $arr[$v['cate_id']] = $v['rate'];
            }
        }
        if ($rate != 0.05) {
            $arr["$cate_id"] = "$rate";
        }

        $filename = COMPATH . 'config/' . ENVIRONMENT . '/service_charges.php'; // 文件路径
        $myfile = fopen($filename, "w");
        $info = '<?php' . PHP_EOL . '$config[\'service_charges\']=' . var_export($arr, true) . ';';
        fwrite($myfile, $info);
        fclose($myfile);
    }
}