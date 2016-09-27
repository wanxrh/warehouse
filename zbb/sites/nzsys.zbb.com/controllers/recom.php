<?php

/*
 * 推荐商品
 */

class Recom extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('recom_model');
        $this->per_page = 10;     //每页显示条数;
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;
    }

    /*
     * 默认首页
     */

    public function index()
    {
        $data['cate'] = $this->recom_model->get_list();
        $this->load->view('recom/recom', $data);
    }

    /*
     * 添加推荐
     */

    public function add()
    {
        //商品名
        $goods_name = $this->input->get('good_name', TRUE);

        $data['cid'] = $cid = intval($this->input->get('cid', true));
        $data['glist'] = $this->recom_model->get_recom_goods($cid);
        $ret = $this->recom_model->get_all_goods($this->per_page, $this->offset, $goods_name);
        foreach ($ret['list'] as $item) {
            $cate_id[] = $item['cate_id'];
        }
        $category = $this->recom_model->goods_category($cate_id);
        $data['cate_name'] = array_column($category, 'cate_name', 'cate_id');
        $nums = $ret['total'];   //总记录
        $data['alist'] = $ret['list'];
        $url_format = "/recom/add/%d?" . urldecode($_SERVER ['QUERY_STRING']);
        $data['page'] = page($this->cur_page, ceil($nums / $this->per_page), $url_format, 5, TRUE, FALSE, $nums);
        $data['cur_page'] = $this->cur_page ? $this->cur_page : '1';
        $this->load->view('recom/recom_add', $data);
    }

    /*
     * 推荐动作
     */

    public function recom_act()
    {
        $cid = intval($this->input->get('cid', true));
        $page = intval($this->input->get('page', true));
        $goods_id = intval($this->input->get('goods_id', true));
        $result = $this->recom_model->get_one('common_link', array('cid' => $cid, 'target_id' => $goods_id));
        //echo $result;exit;
        if ($result) {
            get_redirect("该商品已被推荐", '/recom/add/' . $page . '?cid=' . $cid);
            die();
        }
        $row = $this->recom_model->get_goods('goods', array('goods_id' => $goods_id));
        if ($row['cost_price'] != 0) {
            $ret = $this->recom_model->recom_act($cid, $goods_id, $row['goods_name'], $row['default_image'], $row['price'], $row['cost_price']);
        } else {
            get_redirect("该商品原价为0", '/recom/add/' . $page . '?cid=' . $cid);
            die();
        }
        if ($ret) {
            get_redirect("推荐成功", '/recom/add/' . $page . '?cid=' . $cid);
        }
    }

    /*
     * 修改
     */

    public function edit()
    {
        $data['cid'] = $cid = intval($this->input->get('cid', true));
        $id = intval($this->input->get('id', true));
        $data['row'] = $this->recom_model->get_one('common_link', array('id' => $id));
        $cid = $data['row']['cid'];
        if (IS_POST) {
            $edit = $this->input->post(NULL, TRUE);
            if (!empty($_FILES['img']['name'])) {
                $edit['img'] = $this->recom_model->_upload_image();
            }
            $this->recom_model->get_edit('common_link', $edit, array('id' => $id));
            get_redirect("修改成功", '/recom/add?cid=' . $cid);
        }
        $this->load->view('recom/recom_edit', $data);
    }

    /**
     * 推送数据上移
     */
    function up()
    {
        //表单处理
        $cid = intval($this->input->get("cid", TRUE));
        $did = intval($this->input->get("id", TRUE));
        $sort = intval($this->input->get("sort", TRUE));
        // 判断是否到了顶部
        $nums = $this->recom_model->get_num("sort < $sort and cid = $cid");
        // 更新当前的sort
        if ($nums > 0) {
            $info = $this->recom_model->get_limit('common_link', "sort < $sort and cid = $cid", 1, 'sort desc');
            $nid = $info ['id'];
            $nsort = $info ['sort'];
            // 交换sort
            $this->recom_model->get_edit('common_link', array('sort' => $nsort), array('id' => $did));
            $this->recom_model->get_edit('common_link', array('sort' => $sort), array('id' => $nid));
        } else {
            get_redirect("已经到顶部了", '/recom/add?cid=' . $cid);
        }
        get_redirect("上移成功", '/recom/add?cid=' . $cid);
    }

    /**
     * 推送数据下移
     */
    function down()
    {
        //表单处理
        $cid = intval($this->input->get("cid", TRUE));
        $did = intval($this->input->get("id", TRUE));
        $sort = intval($this->input->get("sort", TRUE));
        // 判断是否到了底部
        $nums = $this->recom_model->get_num("sort > $sort and cid = $cid");
        // 更新当前的sort
        if ($nums > 0) {
            $info = $this->recom_model->get_limit('common_link', "sort > $sort and cid = $cid", 1, 'sort asc');
            $nid = $info ['id'];
            $nsort = $info ['sort'];
            // 交换sort
            $this->recom_model->get_edit('common_link', array('sort' => $nsort), array('id' => $did));
            $this->recom_model->get_edit('common_link', array('sort' => $sort), array('id' => $nid));
        } else {
            get_redirect("已经到底部了", '/recom/add?cid=' . $cid);
        }
        get_redirect("下移成功", '/recom/add?cid=' . $cid);
    }

    /*
     * 取消推荐
     */

    public function delete()
    {
        $id = intval($this->input->get("id", TRUE));
        $cid = intval($this->input->get("cid", TRUE));
        $this->recom_model->get_delete('common_link', array('id' => $id));
        get_redirect("取消成功", '/recom/add?cid=' . $cid);
    }

}
