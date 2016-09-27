<?php

class Goods_model extends CI_Model
{

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /*
     * 商品列表查询
     * @param unknown $per_page  每页显示的记录数
     * @param unknown $offset 偏移量
     * @param unknown $good_name 商品名
     * @param unknown $store_name 店铺名
     * @param unknown $brand 品牌名
     */

    public function goods_list($per_page, $offset, $goods_name = '', $store_name = '', $cate_id = '')
    {
        //判断店铺是否为空
        if (!empty($store_name)){
            $this->db->like('store_name',$store_name );
        }
        //判断商品名是否为空
        if ($goods_name != '') {
            $this->db->like('goods_name', $goods_name);
        }
        //判断商品名是否为空
        if ($cate_id!='') {
            $this->db->where('goods_cate.cate_id', $cate_id);
        }

        $this->db->select('shop_goods.*,shop_store.store_name,shop_goods_cate.cate_id');
        $this->db->from('goods');
        $this->db->join('shop_store', 'goods.store_id = store.store_id', 'left');
        $this->db->join('goods_cate', 'goods.goods_id = goods_cate.goods_id', 'left');
        $this->db->where(array('is_del' => 0));
        $this->db->where(array('inside' => 0, 'level' => 1));
        $temp = clone($this->db);
        $res['list'] = $this->db->limit($per_page, $offset)->get()->result_array();
        $this->db = $temp;
        $res['total'] = $this->db->count_all_results();
        $res['cate'] = $this->category();
        return $res;
    }

    /*
     * 树形分类
     */
    function category($id = 0, $list = array(), $status = 0)
    {
        $result = $this->db->where(array('store_id' => 0, 'parent_id' => $id))->order_by('sort_order', 'asc')->get('gcategory')->result_array();
        foreach ($result as $key => $val) {
            for ($i = 0; $i < $status; $i++) {
                $val['cate_name'] = '<font color="#FF0000">|-</font>' . $val['cate_name'];
            }
            $list[] = $val;
            $id = $val['cate_id'];
            $list = $this->category($id, $list, $status + 1);
        }
        return $list;
    }

    /*
     * 查询是否上架字段
     */

    public function goods_shelves($goods_id)
    {
        $res = $this->db->select('if_show')->where('goods_id', $goods_id)->get('goods')->row_array();
        return $res;


        /*
         * 把判断是否上架if_show字段的值改成1
         */
    }

    public function show_shelves($goods_id)
    {
        $array = array('if_show' => 1);
        $this->db->where('goods_id', $goods_id)->update('goods', $array);
    }

    /*
     * 把判断是否上架if_show字段的值改成0
     */

    public function un_shelves($goods_id)
    {
        $array = array('if_show' => 0);
        $this->db->where('goods_id', $goods_id)->update('goods', $array);
    }


    /*
     * 批量下架
     */

    public function goods_down($days)
    {
        return $this->db->query("CALL proc_goods_down(" . $days . ")")->row_array();
    }

    /*
     * 查询是否禁售字段
     */

    public function goods_lock($goods_id)
    {
        $res = $this->db->select('closed')->where('goods_id', $goods_id)->get('goods')->row_array();
        return $res;
    }

    /*
     * 把判断是否禁售closed字段的值改成1
     */

    public function close_goods($goods_id)
    {
        $array = array('closed' => 1);
        $this->db->where('goods_id', $goods_id)->update('goods', $array);
    }

    /*
     * 把判断是否禁售closed字段的值改成0
     */

    public function open_goods($goods_id)
    {
        $array = array('closed' => 0);
        $this->db->where('goods_id', $goods_id)->update('goods', $array);
    }

    /*
     * 商品信息
     */
    public function goods_now($goods_id)
    {
        $this->db->join('store', 'store.store_id = goods.store_id');
        $ret = $this->db->where('goods_id', $goods_id)->get('goods')->row_array();
        return $ret;
    }

    /*
     * 商品编辑
     */
    public function goods_edit($post_data)
    {
        if ($post_data['if_show'] == GOODS_NOTSHOW || $post_data['if_show'] == GOODS_SHOW) {
            $post_data['closed'] = GOODS_NOTCLOSED;
        }
        if ($post_data['if_show'] == 2) {
            unset($post_data['if_show']);
            $post_data['closed'] = GOODS_CLOSED;
        }
        return $this->db->where('goods_id', $post_data['goods_id'])->update('goods', $post_data);
    }

    public function goods_category($cate_id)
    {
        return $this->db->where_in('cate_id', $cate_id)->get('gcategory')->result_array();
    }

}


