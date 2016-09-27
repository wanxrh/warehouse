<?php

/*
首页控制器
 */

class Cate extends App_Controller
{
    const PER_NUMS = 20;
    public function __construct()
    {
        parent::__construct();
        $this->load->model('cate_model');
    }

    /**
     *
     * @author小莫
     */
    public function index()
    {
        $arr = array();
        //app专题图片
        $flash= $this->cate_model->get_img(array(10,11,12,13));
        if($flash) {
            foreach ($flash as &$v) {
                $v['img'] = img_url($v['img']);
                //专 题
                if ($v['cid'] == 10) $arr['subject'][] = $v;
                //上衣
                if ($v['cid'] == 11) $arr['jacket'][] = $v;
                //时尚
                if ($v['cid'] == 12) $arr['fashion'][] = $v;
                //男身新款
                if ($v['cid'] == 13) $arr['new'][] = $v;
            }
        }else{
            $arr['subject']=[];
            $arr['jacket']=[];
            $arr['fashion']=[];
            $arr['new']=[];
        }
        //全部分类
        $gcategorys = $this->cate_model->get_cate();
        if($gcategorys) {
            foreach ($gcategorys as &$v) {
                $v['cate_images'] = img_url($v['cate_images']);
                //轮播
                $arr['gcategory'][] = $v;
                //限时特购
            }
        }else{
            $arr['gcategory'] ='';
        }
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }
    
    //专题
    public function subject(){

        $arr['list'] = $this->cate_model->get_img(10);
        if(!$arr['list']) $this->success(1, '暂无数据', $arr['list']);
        foreach ($arr['list'] as &$v) {
            $v['img'] = img_url($v['img']);
        }
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    //上衣
    public function jacket(){
        $arr['list'] = $this->cate_model->get_img(11);
        if(!$arr['list']) $this->success(1, '暂无数据', $arr['list']);
        foreach ($arr['list'] as &$v) {
            $v['img'] = img_url($v['img']);
        }
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    //时尚
    public function fashion(){
        $arr['list'] = $this->cate_model->get_img(12);
        if(!$arr['list']) $this->success(1, '暂无数据', $arr['list']);
        foreach ($arr['list'] as &$v) {
            $v['img'] = img_url($v['img']);
        }
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    //新款
    public function style(){
        $arr['list'] = $this->cate_model->get_img(13);
        if(!$arr['list']) $this->success(1, '暂无数据', $arr['list']);
        foreach ($arr['list'] as &$v) {
            $v['img'] = img_url($v['img']);
        }
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }



    //全部分类
    public function category(){
        $arr['list'] = $this->cate_model->get_cate();
        if(!$arr['list']) $this->success(1, '暂无数据', $arr['list']);
        foreach ($arr['list'] as &$v) {
            $v['cate_images'] = img_url($v['cate_images']);
        }
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }

    //分类商品
    public function goods(){
        $type = intval($this->input->post('type'));//排序类型
        $max_sort = intval($this->input->post('max_sort'));//最大价格
        $min_sort = intval($this->input->post('min_sort'));//最小价格
        $keyword = filter_sql($this->input->post('keyword'));//关键字
        $page = intval($this->input->post('page'));//分页
        $cid = intval($this->input->post('cid'));//分类id

        if(empty($page)) $page = 1;
        $offset = ($page - 1) * self::PER_NUMS;
        $ret = $this->cate_model->get_goods($cid,$type,$max_sort,$min_sort,$keyword,self::PER_NUMS,$offset);
        $arr['list']=$ret['list'];
        $arr['total']=$ret['total'];
        if(!$arr['list']) $this->success(1, '暂无数据',$arr);
        foreach ($arr['list'] as &$v) {
            $v['default_image'] = img_url($v['default_image']);
        }
        $arr['page_size'] = self::PER_NUMS;
        if ($arr) {
            $this->success(1, '数据返回成功', $arr);
        } else {
            $this->failure(0, '系统繁忙');
        }
    }
    //商品搜索页面
    public function search(){
        $ret['list']=$this->cate_model->search();
        if ($ret['list']) {
            $this->success(1, '数据返回成功', $ret['list']);
        } else {
            $this->failure(0, '暂无数据');
        }

    }

    //购物车
    public function cart_num(){
        $this->check_user();
        $uid = $this->uid;

        $ret['cart_num']=$this->cate_model->get_cart($uid);
        if (isset($ret['cart_num'])) {
            $this->success(1, '数据返回成功', $ret);
        } else {
            $this->failure(0, '系统繁忙');
        }

    }
}