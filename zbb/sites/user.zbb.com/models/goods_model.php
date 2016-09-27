<?php

/**
 * 商品模型
 */
class Goods_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }


    /*
     * 获取商品
     */

    public function get_goods($store_id, $per_page, $offset, $cate_id = '', $if_show = '', $keyword = '', $closed = '')
    {
        if ($cate_id != '') {
            $temp = $this->db->where('cate_id', $cate_id)->get('goods_cate')->result_array();
            $cate_ids = array_column($temp, 'goods_id');
            if ($cate_ids) {
                $this->db->where_in('goods_id', $cate_ids);
            } else {
                $ret['list'] = array();
                $ret['total'] = 0;
                $ret['cate'] = $this->category($store_id);
                return $ret;
            }

        }
        if (!empty($if_show)) $this->db->where('if_show', $if_show - 1);
        if (!empty($closed)) $this->db->where('closed', $closed - 1);

        if ($keyword != '') {
            $this->db->like('goods_name', $keyword);
        }
        $this->db->from('goods');
        $this->db->select('goods.goods_id,store_id,goods_name,if_show,price,default_image');
        $this->db->where('store_id', $store_id)->where('is_del', 0);
        $db = clone($this->db);
        $ret['list'] = $this->db->order_by('add_time', 'desc')->limit($per_page, $offset)->get()->result_array();
        $this->db = $db;
        $ret['total'] = $this->db->count_all_results();
        $ret['cate'] = $this->category($store_id);
        return $ret;
    }

    public function get_goods_cate($goods_ids)
    {
        $this->db->select('goods_cate.goods_id,gcategory.cate_name');
        $this->db->where_in('goods_id', $goods_ids);
        $this->db->where('inside', 1)->where('level', 1);
        $this->db->from('goods_cate');
        $this->db->join('gcategory', 'goods_cate.cate_id=gcategory.cate_id');
        return $this->db->get()->result_array();
    }

    /*
     * 树形分类
     */

    protected function category($store_id, $id = 0, $list = array(), $status = 0)
    {
        $result = $this->db->where(array('store_id' => $store_id, 'parent_id' => $id))->order_by('sort_order', 'asc')->get('gcategory')->result_array();
        foreach ($result as $key => $val) {
            for ($i = 0; $i < $status; $i++) {
                $val['cate_name'] = '<font color="#FF0000">|-</font>' . $val['cate_name'];
            }
            $list[] = $val;
            $id = $val['cate_id'];
            $list = $this->category($store_id, $id, $list, $status + 1);
        }
        return $list;
    }

    public function goods_category($cate_id)
    {
        return $this->db->where_in('cate_id', $cate_id)->get('gcategory')->result_array();
    }

    /**
     * 获取商品分类
     */
    public function get_cate($parent_id = 0, $store_id = 0)
    {
        $this->db->select('cate_id,cate_name');
        $this->db->where(array('parent_id' => $parent_id, 'store_id' => $store_id));
        $ret = $this->db->get('gcategory')->result_array();
        return $ret;
    }

    public function add_attr_name($data)
    {
        $this->db->insert_batch('attr_name', $data);
        return $this->db->insert_id();
    }

    public function add_attr_value($data)
    {
        $this->db->insert_batch('attr_value', $data);
        return $this->db->insert_id();
    }

    public function get_attr_value($attr_value_ids)
    {
        return $this->db->select('attr_value_id,attr_value')->where_in('attr_value_id', $attr_value_ids)->get('attr_value')->result_array();
    }

    public function add_goods_sku($data)
    {
        $this->db->insert_batch('goods_sku', $data);
        return $this->db->insert_id();
    }

    public function get_goods_sku($sku_ids)
    {
        return $this->db->where_in('sku_id', $sku_ids)->get('goods_sku')->result_array();
    }

    public function add_goods_attr($data)
    {
        $this->db->insert_batch('goods_attr', $data);
    }

    public function add_goods($data)
    {
        $this->db->insert('goods', $data);
        return $this->db->insert_id();
    }

    public function add_goods_img($goods_img)
    {
        $this->db->insert_batch('goods_image', $goods_img);
    }

    public function add_goods_cate($cate)
    {
        $this->db->insert_batch('goods_cate', $cate);
    }

    public function get_min_sku($goods_id)
    {
        return $this->db->where('goods_id', $goods_id)->order_by('price', 'ASC')->get('goods_sku')->row_array();
    }

    public function up_goods($goods_id, $data)
    {
        if (is_array($goods_id)) {
            return $this->db->where_in('goods_id', $goods_id)->update('goods', $data);
        } else {
            return $this->db->where('goods_id', $goods_id)->update('goods', $data);
        }

    }

    public function add_goods_extm($goods_extm)
    {
        $this->db->insert('goods_extm', $goods_extm);
        return $this->db->insert_id();
    }

    public function del_goods($goods_ids)
    {
        if (is_array($goods_ids)) {
            $this->db->where_in('goods_id', $goods_ids)->where('store_id', get_user()['id']);
        } else {
            $this->db->where('goods_id', $goods_ids)->where('store_id', get_user()['id']);
        }
        $ret = $this->db->update('goods', array('is_del' => 1));
        return $ret;
    }

    /*
     * 商品信息
     */
    public function goods_info($goods_id)
    {
        return $this->db->get_where('goods', array('goods_id' => $goods_id, 'store_id' => get_user()['id']))->row_array();
    }

    /*
     * 商品图片
     */
    public function goods_img($goods_id)
    {
        return $this->db->get_where('goods_image', array('goods_id' => $goods_id))->result_array();
    }

    /*
    * 商品扩展信息
    */
    public function goods_extm($goods_id)
    {
        return $this->db->get_where('goods_extm', array('goods_id' => $goods_id))->row_array();
    }

    /*
    * 商品规格名
    */
    public function goods_attr_name($goods_id)
    {
        return $this->db->get_where('attr_name', array('goods_id' => $goods_id))->result_array();
    }

    /*
    * 商品规格值
    */
    public function goods_attr_value($goods_id)
    {
        return $this->db->get_where('attr_value', array('goods_id' => $goods_id))->result_array();
    }

    /*
    * 商品规格名
    */
    public function goods_sku($goods_id)
    {
        return $this->db->get_where('goods_sku', array('goods_id' => $goods_id))->result_array();
    }
    /*
    * 商品所属分类
    */
    public function goods_cate($goods_id){
        $this->db->select('cate_id');
        $this->db->where('goods_id',$goods_id);
        return $this->db->get('goods_cate')->result_array();
    }
    /*
    * 更新商品表
    */
    public function update_goods($table,$goods_id,$data)
    {
        $ret=$this->db->where(array('goods_id'=>$goods_id))->update($table, $data);
        return $ret;
    }

    /*
    * 检测商品表
    */
    public function check_goods($goods_id,$user_id)
    {
        $ret=$this->db->get_where('goods',array('store_id'=>$user_id,'goods_id'=>$goods_id))->row_array();
        return $ret;
    }

    /*
    * 删除图片表
    */
    public function del_img($goods_id)
    {
        $ret=$this->db->where('goods_id',$goods_id)->delete('goods_image');
        return $ret;
    }

    /*
   * 删除分类关系
   */
    public function del_cate($goods_id)
    {
        $ret=$this->db->where('goods_id',$goods_id)->delete('goods_cate');
        return $ret;
    }

    /*
    * 批量修改sku
    */
    public function update_batch_sku($arr)
    {
        $ret=$this->db->update_batch('goods_sku', $arr, 'sku_id');
        return $ret;
    }
    /*
    * 批量修改sku
    */
    public function del_sku($sku_ids){
      return $this->db->where_in('sku_id',$sku_ids)->delete('goods_sku');
    }

    public function new_add_attr_value($data)
    {
        $this->db->insert('attr_value', $data);
        return $this->db->insert_id();
    }

    public function new_add_goods_sku($data)
    {
        $this->db->insert('goods_sku', $data);
        return $this->db->insert_id();
    }

    /*
   * 单条sku
   */
    public function goods_one_sku($goods_id)
    {
        return $this->db->get_where('goods_sku', array('goods_id' => $goods_id))->row_array();
    }

    /*
    * 商品库存
    */
    public function goods_stock($goods_id)
    {
        $this->db->select('sum(stock) as stock,goods_id');
        $this->db->where_in('goods_id',$goods_id);
        $this->db->group_by('goods_id');
        $ret=$this->db->get('goods_sku')->result_array();
        return $ret;
    }

    /*
     * 商品大类
     */
    public function get_store_cate($store_id){
        return $this->db->select('cate_id')->where('store_id',$store_id)->get('store')->row_array();
    }
}
