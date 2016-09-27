<?php

/**
 * 首页推送管理
 */
class Linkecate extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('linke_model');
    }

    /*
     * 默认
     */

    public function index()
    {

        $data['type'] = intval($this->input->get('type', TRUE));
        $data['pid'] = $this->input->get('pid', TRUE);
        $data['pid'] = (isset($data['pid']) && $data['pid']) ? $data['pid'] : 0;

        $params = array('type' => $data['type']);
        $data['category'] = $this->linke_model->cate($params);

        $this->load->view('linke/linke_cate', $data);
    }

    /*
     * 编辑添加页面
     */

    public function linke_add()
    {

        // 状态判断
        $data['cid'] = intval($this->input->get('cid', TRUE));
        $data['id'] = intval($this->input->get('id', TRUE));
        $data['type'] = intval($this->input->get('type', TRUE));

        $cate = $this->linke_model->get_cate($data['type'], $data['cid']);
        $data['p_cate'] = $cate;

        if (!empty($data['category'])) {

            $this->load->view('linke/linke_cate', $data);
            return;
        }
        # end

        $post = $this->input->post(NULL, TRUE);

        //添加
        if (!empty($post)) {
            $this->linke_model->linke_add($post, $data['cid']);
        }
        //类别和是否编辑

        $arr = $this->linke_model->linke_list($data['cid'], $data['id']);
        $data['arr'] = $arr['arr'];
        $data['linke'] = $arr['linke'];

        $params = array('type' => $data['type']);
        $data['category'] = $this->linke_model->cate($params);

        $this->load->view('linke/linke_add', $data);
    }

    /*
       * 删除
       */
    public function linke_delete()
    {
        $id = intval($this->input->get('id', TRUE));

        $this->linke_model->linke_delete($id);
        header("Location:" . $_SERVER['HTTP_REFERER']);
    }

    /*
   * 编辑分类名称
   */
    public function cate_mod()
    {
        $id = intval($this->input->get_post('id', TRUE));
        $type = $this->input->post('type', TRUE);
        $name = $this->input->post('name', TRUE);
        if (!IS_POST) {
            $data['cate_info'] = $this->linke_model->cate_info($id);
            $this->load->view('linke/cate_mod', $data);
        } else {
            $ret = $this->linke_model->update_cate($id, $name);
            if ($type == 1) get_redirect("修改成功", '/linkecate?type=1');
            if ($type == 2) get_redirect("修改成功", '/linkecate?type=2');
            if ($type == 3) get_redirect("修改成功", '/recom');
        }

    }

    /*
   * 最大数量修改
   */
    public function linke_num()
    {
        $post = $this->input->post(NULL, TRUE);
        $post['num'] = intval($post['num']);
        if (!empty($post['num'])) {
            $this->linke_model->linke_num($post);
        }
        header("Location:" . $_SERVER['HTTP_REFERER']);
    }

}
