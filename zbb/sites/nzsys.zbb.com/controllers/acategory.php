<?php

/*
 * 后台文章分类管理控制器
 */

class Acategory extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('acategory_model');
    }

    /*
     * 默认首页
     */

    public function index()
    {
        $data['list'] = $this->category();
        $this->load->view('acategory/acategory_index', $data);
    }

    /*
     * 编辑
     */

    public function edit()
    {
        $cate_id = intval($this->uri->segment(4));
        $data['acategory'] = $this->category();
        $data['row'] = $this->acategory_model->get_one('acategory', array('cate_id' => $cate_id));
        if (IS_POST) {
            $edit = $this->input->post(NULL, TRUE);
            $result = $this->acategory_model->get_edit('acategory', $edit, array('cate_id' => $cate_id));
            if ($result) {
                get_redirect('更新成功', '/acategory');
            } else {
                get_redirect('更新失败', '/acategory');
            }
        }
        $this->load->view('acategory/acategory_edit', $data);
    }

    /*
     * 删除
     */

    public function delete()
    {
        $cate_id = intval($this->uri->segment(4));
        $this->del_category($cate_id);
        get_redirect('删除成功', '/acategory');
    }

    /*
     * 新增
     */

    public function add()
    {
        $data['acategory'] = $this->category();
        if (IS_POST) {
            $add = $this->input->post(NULL, TRUE);
            if ($add['cate_name'] == '') {
                echo '<script>alert("请输入分类名");window.history.go(-1);</script>';
                exit;
            }
            if ($add['parent_id'] == '') {
                echo '<script>alert("请选择分类");window.history.go(-1);</script>';
                exit;
            }
            $id = $this->acategory_model->get_add('acategory', $add);
            if ($id) {
                get_redirect('新增成功', '/acategory');
            } else {
                get_redirect('新增失败', '/acategory');
            }
        }
        $this->load->view('acategory/acategory_add', $data);
    }

    /**
     * 无极分类方法
     * @param $id 默认为0
     * @param $list 空数组
     * @param $status 标识
     * @return $list 返回无极分类数组，父类下面接子类
     */
    private function category($id = 0, $list = array(), $status = 0)
    {
        $result = $this->acategory_model->get_more('acategory', array('parent_id' => $id));
        foreach ($result as $val) {
            for ($i = 0; $i < $status; $i++) {
                $val['cate_name'] = '<font color="#FF0000">|-</font>' . $val['cate_name'];
            }
            $list[] = $val;
            $id = $val['cate_id'];
            $list = $this->category($id, $list, $status + 1);
        }
        return $list;
    }

    /**
     * 删除分类的方法
     * @param $cate_id 分类ID
     * @return $delete 返回删除结果
     */
    private function del_category($cate_id)
    {
        $result = $this->acategory_model->get_more('acategory', array('parent_id' => $cate_id));
        foreach ($result as $key => $val) {
            $child_id = $val['cate_id'];
            $this->acategory_model->delete(array('cate_id' => $child_id));
            $this->del_category($child_id);
        }
        $delete = $this->acategory_model->delete(array('cate_id' => $cate_id));
        return $delete;
    }

}
