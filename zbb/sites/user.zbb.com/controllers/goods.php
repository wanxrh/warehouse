<?php

/**
 * 用户中心控制器
 */
class Goods extends User_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('goods_model');
        $this->per_page = 10;
        $this->cur_page = intval($this->uri->segment(3));
        if ($this->cur_page < 1) {
            $this->cur_page = 1;
        }
        $this->offset = ($this->cur_page - 1) * $this->per_page;
    }

    //商品列表页
    public function index()
    {
        $user_id = get_user()['id'];

        $data['cate_id'] = $cate_id = intval($this->input->get('cate_id'));
        $data['if_show'] = $if_show = intval($this->input->get('if_show'));
        $data['closed'] = $closed = intval($this->input->get('closed'));
        $data['keyword'] = $keyword = filter_sql($this->input->get('keyword'));

        $result = $this->goods_model->get_goods($user_id, $this->per_page, $this->offset, $cate_id, $if_show, $keyword, $closed);

        $data['list'] = $result['list'];

        //分类名称
        if ($result['list']) {
            $goods_ids = array_column($data['list'], 'goods_id');
            $ret = $this->goods_model->get_goods_cate($goods_ids);
            $data['cate_name'] = array_column($ret, 'cate_name', 'goods_id');

            $temp_stock=$this->goods_model->goods_stock($goods_ids);
            $temp_stock=array_column($temp_stock,'stock','goods_id');

            foreach ($data['list'] as &$v){
                $v['stock']=$temp_stock[$v['goods_id']];
            }
        }

        // 分页
        $data['rows'] = $result['total'];
        $url_format = "/goods/index/%d?" . str_replace('%', '%%', urldecode($_SERVER['QUERY_STRING']));
        $data['page'] = page($this->cur_page, ceil($data['rows'] / $this->per_page), $url_format, 5, TRUE, TRUE);
        $data['cate'] = $result['cate'];
        $this->load->view('goods/index', $data);
    }

    public function add()
    {
        $data['site_cate'] = $this->goods_model->get_cate();
        $data['shop_cate'] = $this->goods_model->get_cate(0, get_user()['id']);
        $data['store_info']=$this->goods_model->get_store_cate(get_user()['id']);
        if (IS_POST) {
            //TODO 先插入商品表,返回goods_id

            $params = $this->input->post(null, true);
            $goods = array(
                'store_id' => get_user()['id'],
                'goods_name' => $params['goods_name'],
                'add_time' => time(),
                'is_recom' => $params['recommended']
            );
            $goods_id = $this->goods_model->add_goods($goods);
            //写入详细表
            $goods_extm = array(
                'goods_id' => $goods_id,
                'attributes' => filter_sql($params['attributes']),
                'detail' => filter_sql($params['detail'])
            );
            $this->goods_model->add_goods_extm($goods_extm);
            //默认图片
            $temp_imgs = explode(',', $params['uploadimg']);
            $default_image = $temp_imgs[0];
            if ($params['uploadimg']) {
                $goods_img = [];
                foreach ($temp_imgs as $v) {
                    $goods_img[] = array(
                        'goods_id' => $goods_id,
                        'image_url' => $v
                    );
                }
                $this->goods_model->add_goods_img($goods_img);
            }
            //平台分类
            $cate = [];
            foreach ($params['cate_id'] as $k => $v) {
                $cate[] = array(
                    'cate_id' => $v,
                    'goods_id' => $goods_id,
                    'level' => $k + 1
                );
            }
            $this->goods_model->add_goods_cate($cate);
            //本店分类
            foreach ($params['store_cate_id'] as $k => $v) {
                $store_cate[] = array(
                    'cate_id' => $v,
                    'goods_id' => $goods_id,
                    'inside' => 1,
                    'level' => $k + 1
                );
            }
            $this->goods_model->add_goods_cate($store_cate);
            if (isset($params['spec_n']) && isset($params['spec_v_0'])) {
                $attr_nums = count($params['spec_n']);
                $attr_name_arr = [];
                for ($i = 0; $i < $attr_nums; $i++) {
                    $attr_name_arr[] = array(
                        'goods_id' => $goods_id,
                        'attr_name' => $params['spec_n'][$i]
                    );
                }
                $attr_name_fisrt_id = $this->goods_model->add_attr_name($attr_name_arr);
                $attr_name = [];
                for ($i = 0; $i < $attr_nums; $i++) {
                    $attr_name[] = array(
                        'attr_name_id' => $attr_name_fisrt_id + $i,
                        'attr_name' => $params['spec_n'][$i]
                    );
                }
                $attr_value_arr = [];
                for ($i = 0; $i < $attr_nums; $i++) {
                    foreach (array_flip(array_flip($params["spec_v_$i"])) as $v) {
                        $attr_value_arr[] = array(
                            'goods_id' => $goods_id,
                            'attr_name_id' => $attr_name[$i]['attr_name_id'],
                            'attr_value' => $v,
                        );
                    }
                }
                $attr_value_fisrt_id = $this->goods_model->add_attr_value($attr_value_arr);
                $attr_value_ids = [];
                for ($i = 0; $i < count($attr_value_arr); $i++) {
                    $attr_value_ids[] = $attr_value_fisrt_id + $i;
                }
                $attr_values = $this->goods_model->get_attr_value($attr_value_ids);
                $attr_values = array_column($attr_values, 'attr_value_id', 'attr_value');
                $goods_sku = [];
                for ($i = 0; $i < count($params['spec_v_0']); $i++) {
                    $properties = '';
                    for ($m = 0; $m < $attr_nums; $m++) {
                        $properties .= $attr_name[$m]['attr_name_id'] . ':' . $attr_values[$params['spec_v_' . $m][$i]] . ';';
                    }
                    $goods_sku[] = array(
                        'store_id' => get_user()['id'],
                        'goods_id' => $goods_id,
                        'properties' => trim($properties, ';'),
                        'price' => $params['price'][$i],
                        'stock' => $params['stock'][$i],
                        'cost_price' => $params['cost_price'][$i],
                        'out_sku' => $params['sku'][$i]
                    );
                }
                $goods_sku_first_id = $this->goods_model->add_goods_sku($goods_sku);
                $goods_sku_ids = [];
                for ($i = 0; $i < count($goods_sku); $i++) {
                    $goods_sku_ids[] = $goods_sku_first_id + $i;
                }
                $goodsSku = $this->goods_model->get_goods_sku($goods_sku_ids);
                $goods_attr_arr = [];
                foreach (array_column($goodsSku, 'properties', 'sku_id') as $sku_id => $properties) {
                    foreach (explode(';', $properties) as $v) {
                        $goods_attr_arr[] = array(
                            'goods_id' => $goods_id,
                            'attr_name_id' => explode(':', $v)[0],
                            'attr_value_id' => explode(':', $v)[1],
                            'sku_id' => $sku_id
                        );
                    }
                }
                $this->goods_model->add_goods_attr($goods_attr_arr);
                //修改商品默认数据
                $min_sku = $this->goods_model->get_min_sku($goods_id);
                $update_goods = array(
                    'sku_id' => $min_sku['sku_id'],
                    'price' => $min_sku['price'],
                    'cost_price' => $min_sku['cost_price'],
                    'default_image' => $default_image
                );
                $this->goods_model->update_goods('goods', $goods_id, $update_goods);
            } else {
                //写入SKU
                $goods_sku = array(
                    'store_id' => get_user()['uid'],
                    'goods_id' => $goods_id,
                    'price' => $params['price'][0],
                    'stock' => $params['stock'][0],
                    'cost_price' => $params['cost_price'][0],
                    'out_sku' => $params['sku'][0],
                );
                $goods_sku_id = $this->goods_model->add_goods_sku($goods_sku);
                $update_goods = array(
                    'sku_id' => $goods_sku_id,
                    'price' => $params['price'][0],
                    'cost_price' => $params['cost_price'][0],
                    'default_image' => $default_image,
                    'enable_sku' => 0
                );
                $this->goods_model->update_goods('goods', $goods_id, $update_goods);
            }
            get_redirect('添加成功','/goods/index');
        }
        $this->load->view('goods/add', $data);
    }

    public function edit()
    {
        $user_id = get_user()['id'];
        $data['store_info']=$this->goods_model->get_store_cate($user_id );
        $goods_id = intval($this->input->get('goods_id'));
        if (IS_POST) {
            $params = $this->input->post(null);
            $goods_id = intval($params['goods_id']);
            //检测是否自己的商品
            $ret = $this->goods_model->check_goods($goods_id, get_user()['id']);
            if (!$ret) {
                show_error('商品编号错误');
            }
            $goods_id = $ret['goods_id'];

            //商品主表
            $goods = array(
                'goods_name' => $params['goods_name'],
                'is_recom' => intval($params['recommended'])
            );
            $this->goods_model->update_goods('goods', $goods_id, $goods);
            //商品附加表
            $goods_extm = array(
                'attributes' => $params['attributes'],
                'detail' => $params['detail']
            );
            $this->goods_model->update_goods('goods_extm', $goods_id, $goods_extm);
            //删除旧的图片
            $this->goods_model->del_img($goods_id);
            //添加默认图片
            $temp_imgs = explode(',', $params['uploadimg']);
            $default_image = $temp_imgs[0];
            if ($params['uploadimg']) {
                $goods_img = [];
                foreach ($temp_imgs as $v) {
                    $goods_img[] = array(
                        'goods_id' => $goods_id,
                        'image_url' => $v
                    );
                }
                $this->goods_model->add_goods_img($goods_img);
            }
            //删除旧分类关系
            $this->goods_model->del_cate($goods_id);
            //平台分类
            $cate = [];
            foreach ($params['cate_id'] as $k => $v) {
                $cate[] = array(
                    'cate_id' => $v,
                    'goods_id' => $goods_id,
                    'level' => $k + 1
                );
            }
            $this->goods_model->add_goods_cate($cate);
            //本店分类
            foreach ($params['store_cate_id'] as $k => $v) {
                $store_cate[] = array(
                    'cate_id' => $v,
                    'goods_id' => $goods_id,
                    'inside' => 1,
                    'level' => $k + 1
                );
            }
            $this->goods_model->add_goods_cate($store_cate);

            $this->db->trans_begin();
            if ($ret['enable_sku']) {
                //获取原来的sku数组，来判断是否有删除的sku
                $old_sku = $this->goods_model->goods_sku($goods_id);
                $new_sku = $params['sku_id'];
                $i = 0;
                foreach ($old_sku as $key => $v) {
                    if (in_array($v['sku_id'], $new_sku)) {
                        //批量修改数组
                        $sku_arr[] = array(
                            'sku_id' => $v['sku_id'],
                            'price' => $params['price'][$key],
                            'cost_price' => $params['cost_price'][$key],
                            'stock' => $params['stock'][$key],
                            'out_sku' => $params['sku'][$key]
                        );
                    } else {
                        //执行删除数组
                        $sku_ids[] = $v['sku_id'];
                    }
                    $i = $i + 1;
                }
                $this->goods_model->update_batch_sku($sku_arr);
                if (!empty($sku_ids)) {
                    $this->goods_model->del_sku($sku_ids);
                }
                //新增的规格对
                if (!empty($params['new_sku'])) {
                    $goods_new_sku = $params['new_sku'];
                    $temp_attr = $this->goods_model->goods_attr_name($goods_id);
                    $temp_attr = array_column($temp_attr, 'attr_name_id');
                    foreach ($goods_new_sku as $m) {
                        foreach ($temp_attr as $key => $v) {
                            $attr_info = array(
                                'goods_id' => $goods_id,
                                'attr_name_id' => $v,
                                'attr_value' => $params['spec_v_' . $key . ''][$i]
                            );
                            $new_attr_id = $this->goods_model->new_add_attr_value($attr_info);
                            $temp_pro[] = $v . ':' . $new_attr_id;

                            $goods_attr_arr[] = array(
                                'goods_id' => $goods_id,
                                'attr_name_id' => $v,
                                'attr_value_id' => $new_attr_id,
                            );
                        }
                        $properties = implode(';', $temp_pro);
                        $temp_sku = array(
                            'store_id' => $user_id,
                            'goods_id' => $goods_id,
                            'properties' => $properties,
                            'price' => $m['price'],
                            'stock' => $m['stock'],
                            'cost_price' => $m['cost_price'],
                            'out_sku' => $m['sku']
                        );
                        //写入sku表
                        $temp_sku_id = $this->goods_model->new_add_goods_sku($temp_sku);
                        //写入goods_attr
                        foreach ($goods_attr_arr as &$g) {
                            $g['sku_id'] = $temp_sku_id;
                        }
                        $this->goods_model->add_goods_attr($goods_attr_arr);
                    }
                }

                //修改商品默认数据
                $min_sku = $this->goods_model->get_min_sku($goods_id);
                $update_goods = array(
                    'sku_id' => $min_sku['sku_id'],
                    'price' => $min_sku['price'],
                    'cost_price' => $min_sku['cost_price'],
                    'default_image' => $default_image,
                    'enable_sku' => 1
                );
                $this->goods_model->update_goods('goods', $goods_id, $update_goods);

            } else {
                //没有sku的情况
                $temp_sku = array(
                    'store_id' => $user_id,
                    'goods_id' => $goods_id,
                    'price' => $params['price'],
                    'stock' => $params['stock'],
                    'cost_price' => $params['cost_price'],
                    'out_sku' => $params['sku']
                );
                //写入sku表
                $temp_sku_id = $this->goods_model->new_add_goods_sku($temp_sku);
                $update_goods = array(
                    'sku_id' => $temp_sku_id,
                    'price' => $params['price'],
                    'cost_price' => $params['cost_price'],
                    'default_image' => $default_image,
                    'enable_sku' => 0
                );
                $this->goods_model->update_goods('goods', $goods_id, $update_goods);

            }

            if ($this->db->trans_status() === FALSE) {
                $this->db->trans_rollback();
            } else {
                $this->db->trans_commit();
                get_redirect('修改成功','/goods/index');
            }

        } else {
            //获取商品对应的分类编号
            $goods_cate = $this->goods_model->goods_cate($goods_id);
            $goods_cate = array_column($goods_cate, 'cate_id');
            //网站分类1
            $data['site_cate'] = $this->goods_model->get_cate();
            foreach ($data['site_cate'] as &$v) {
                $v['is_checked'] = 0;
                if (in_array($v['cate_id'], $goods_cate)) {
                    $v['is_checked'] = 1;
                    $site_checked_cate = $v['cate_id'];
                }
            }
            //网站分类2
            $data['site_cate_2'] = $this->goods_model->get_cate($site_checked_cate);
            foreach ($data['site_cate_2'] as &$v) {
                $v['is_checked'] = 0;
                if (in_array($v['cate_id'], $goods_cate)) {
                    $v['is_checked'] = 1;
                }
            }
            //店铺分类1
            $data['shop_cate'] = $this->goods_model->get_cate(0, get_user()['id']);
            foreach ($data['shop_cate'] as &$v) {
                $v['is_checked'] = 0;
                if (in_array($v['cate_id'], $goods_cate)) {
                    $v['is_checked'] = 1;
                    $shop_checked_cate = $v['cate_id'];
                }
            }
            //店铺分类2
            $data['shop_cate_2'] = $this->goods_model->get_cate($shop_checked_cate, get_user()['id']);
            foreach ($data['shop_cate_2'] as &$v) {
                $v['is_checked'] = 0;
                if (in_array($v['cate_id'], $goods_cate)) {
                    $v['is_checked'] = 1;
                }
            }

            $data['goods_info'] = $this->goods_model->goods_info($goods_id);
            $data['goods_img'] = $this->goods_model->goods_img($goods_id);
            $data['goods_extm'] = $this->goods_model->goods_extm($goods_id);
            $data['attr_name'] = $this->goods_model->goods_attr_name($goods_id);
            $temp_attr = $this->goods_model->goods_attr_value($goods_id);
            $attr_value = array_column($temp_attr, 'attr_value', 'attr_value_id');

            //没有sku的时候
            if (!$data['goods_info']['enable_sku']) {
                $temp_info = $this->goods_model->goods_one_sku($goods_id);
                $data['price'] = $temp_info['price'];
                $data['cost_price'] = $temp_info['cost_price'];
                $data['stock'] = $temp_info['stock'];
                $data['sku'] = $temp_info['out_sku'];
            }else{


                $data['goods_sku'] = $this->goods_model->goods_sku($goods_id);
                foreach ($data['goods_sku'] as &$v) {
                    //规格数
                    $split = explode(';', $v['properties']);
                    foreach ($split as $m) {
                        $temp = explode(':', $m);
                        $v['list'][] = $attr_value[$temp[1]];
                    }
                }


            }

            $this->load->view('goods/edit', $data);
        }

    }

    public function site_cate()
    {

        $parent_id = intval($this->input->post('parent_id'));
        $ret = $this->goods_model->get_cate($parent_id);
        if ($ret) {
            ajax_success($ret);
        } else {
            ajax_error('无分类信息');
        }
    }

    public function shop_cate()
    {
        //ajax调用
        $parent_id = intval($this->input->post('parent_id'));
        $ret = $this->goods_model->get_cate($parent_id, get_user()['id']);
        if ($ret) {
            ajax_success($ret);
        } else {
            ajax_error('无分类信息');
        }
    }

    /*
     * 宝贝上下架
     */
    public function up_goods()
    {
        //ajax调用
        $if_show = intval($this->input->post('if_show'));
        $goods_id = $this->input->post('goods_id');
        $ret = $this->goods_model->up_goods($goods_id, array('if_show' => $if_show));
        $mark = $if_show == 1 ? '上架成功' : '下架成功';
        if ($ret) {
            ajax_success($mark);
        } else {
            ajax_error('操作失败');
        }
    }

    /**
     * 商品上传
     */
    public function upload_more()
    {
        if (!get_user()) {
            show_error("未登录不能上传");
        } else {
            $this->load->library('uploader');
            $file = $_FILES['file'];
            //上传文件不能为空
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
                $this->uploader->allowed_size(4096000);
                $this->uploader->addFile($file);
                if ($this->uploader->file_info() === false) {
                    show_error($this->uploader->get_error());
                    return false;
                }
                $ret = $this->uploader->save('goods/' . $Y . '/' . $m . '/' . $d);
            }
            ajax_success('goods/' . $Y . '/' . $m . '/' . $d . '/' . basename($ret));
        }
    }

    /**
     * 商品上传
     */
    public function upload()
    {
        if (!get_user()) {
            show_error("未登录不能上传");
        } else {
            $this->load->library('uploader');
            $file = $_FILES['imgFile'];
            //上传文件不能为空
            $Y = date("Y", time());
            $m = date("m", time());
            $d = date("d", time());
            if ($file['error'] == UPLOAD_ERR_OK && $file != '') {
                $this->uploader->allowed_size(4096000);
                $this->uploader->addFile($file);
                if ($this->uploader->file_info() === false) {
                    show_error($this->uploader->get_error());
                    return false;
                }
                $ret = $this->config->item('domain_img') . $this->uploader->save('goods/' . $Y . '/' . $m . '/' . $d);
            }
            echo json_encode(array('error' => 0, 'url' => $ret));
            exit;
        }
    }

    /*
    * 删除宝贝商品
    */
    public function del_goods()
    {
        $goods_ids = $this->input->post('goods_id');
        $ret = $this->goods_model->del_goods($goods_ids);
        if ($ret) {
            ajax_success('删除操作');
        } else {
            ajax_error('失败操作');
        }
    }
}