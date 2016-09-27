<?php

/*
 * 后台商品管理
 */

class Goods extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('goods_model');
        $this->per_page = 10;     //每页显示条数;
        $this->cur_page = intval($this->uri->segment(3));  //获取地址第四段的参数;
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;  //偏移量;
    }

    /*
     * 商品列表
     */

    public function index()
    {
        //商品名
        $data['good_name'] = $good_name = $this->input->get('good_name', TRUE);
        //店铺名
        $data['store_name'] = $store_name = $this->input->get('store_name', TRUE);
        $data['cate_id'] = $cate_id = $this->input->get('cate_id', TRUE);

        $result = $this->goods_model->goods_list($this->per_page, $this->offset, $good_name, $store_name, $cate_id);
        $num = $result['total'];   //总记录
        if ($result['list']) {
            $cate_ids = array_column($result['list'], 'cate_id');
            $ret = $this->goods_model->goods_category($cate_ids);
            $data['cate_name'] = array_column($ret, 'cate_name', 'cate_id');
        }
        $data['list'] = $result['list'];
        $url_format = "/goods/index/%d?" . str_replace('%', '%%', urldecode($_SERVER ['QUERY_STRING']));
        $data ['page'] = page($this->cur_page, ceil($num / $this->per_page), $url_format, 5, TRUE, FALSE, $num);
        $data['cate'] = $result['cate'];
        $this->load->view('goods_index.php', $data);
    }

    /*
     * 商品上下架
     */

    public function shelves($goods_id)
    {
        $result = $this->goods_model->goods_shelves($goods_id);
        if ($result['if_show'] == 1) {
            $this->goods_model->un_shelves($goods_id);
        } else {
            $this->goods_model->show_shelves($goods_id);
        }
        $result = $this->goods_model->goods_shelves($goods_id);
        echo $result['if_show'];
    }

    /*
     * 商品是否禁售
     */

    public function goods_lock($goods_id)
    {
        $result = $this->goods_model->goods_lock($goods_id);
        if ($result['closed'] == 0) {
            $this->goods_model->close_goods($goods_id);
        } else {
            $this->goods_model->open_goods($goods_id);
        }
        $result = $this->goods_model->goods_lock($goods_id);
        echo $result['closed'];
    }


    /*
     * 商品是否禁售
     */

    public function goods_down()
    {
        $days = $this->input->post('days');
        $ret = $this->goods_model->goods_down($days);
        if ($ret['code'] == 200) {
            get_redirect("操作成功", '/goods');
        } else {
            get_redirect("操作失败", '/goods');
        }
    }

    /*
     * 商品编辑
     */

    public function edit()
    {

        $goods_id = intval($this->input->get('id', TRUE));
        if (empty($goods_id)) {
            show_error("非法操作");
            exit();
        }

        $data['goods'] = $this->goods_model->goods_now($goods_id);
        if (empty($data['goods'])) {
            show_error("商品不存在，或已经被删除");
            exit();
        }

        $data['gcategories'] = $this->goods_model->category(); // 商品分类

        $this->load->view('goods_edit.php', $data);
    }

    /*
    * 商品编辑提交
   */

    public function edit_add()
    {
        $post_data = $this->input->post(NULL, TRUE);

        if ($this->goods_model->goods_edit($post_data)) {
            get_redirect("编辑成功", '/goods');
        }
    }

}