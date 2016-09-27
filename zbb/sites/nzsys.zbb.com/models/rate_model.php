<?php

/**
 * 服务费资费标准
 */
class Rate_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 根据ID获取一条资费信息
     */
    public function get_one_rate($cate_id)
    {
        return $this->db->get_where('service_rate', array('cate_id' => $cate_id))->row_array();
    }

    /**
     * 获取所有分类和资费信息
     */
    public function get_cate_rate()
    {
        $this->db->select('service_rate.*,gcategory.cate_id,gcategory.parent_id,gcategory.cate_name,gcategory.parent_id');
        $this->db->where('parent_id', 0);
        $this->db->where('store_id', 0);
        $this->db->order_by('gcategory.cate_id', 'asc');
        $this->db->join('service_rate', 'gcategory.cate_id=service_rate.cate_id', 'left');
        $temp = $this->db->get('gcategory')->result_array();
        $res['list'] = $this->_getTree($temp);
        return $res;
    }

    /**
     * 获取所有资费信息
     */
    public function get_rate()
    {
        return $this->db->get('service_rate')->result_array();
    }

    /**
     * 无限极树形列表
     */
    private function _getTree($data, $parent_id = 0, $level = 0)
    {
        static $_ret = array();
        foreach ($data as $k => $v) {
            if ($v['parent_id'] == $parent_id) {
                $v['level'] = $level;  // 用来标记这个分类是第几级的
                $_ret[] = $v;
                // 找子分类
                $this->_getTree($data, $v['cate_id'], $level + 1);
            }
        }
        return $_ret;
    }

    /**
     * 获取未添加资费的分类
     */
    public function get_cate()
    {
        $res['rate'] = $this->db->get('service_rate')->result_array();
        $this->db->select('gcategory.cate_id,gcategory.cate_name');
        $this->db->where(array(
            'parent_id !=' => 0,
            'store_id' => 0,
        ));
        $res['cate'] = $this->db->get('gcategory')->result_array();
        return $res;
    }

    /**
     * 添加新资费
     */
    public function rate_add($cate_id, $rate)
    {
        $arr = array(
            'cate_id' => $cate_id,
            'rate' => $rate,
        );
        $this->db->insert('service_rate', $arr);
        $res = $this->db->insert_id();
        return $res;
    }

    /**
     * 删除资费
     */
    public function rate_del($cate_id)
    {
        $this->db->where('cate_id', $cate_id);
        $res = $this->db->delete('service_rate');
        return $res;
    }

    /**
     * 根据cateId获取一条分类信息
     */
    public function get_one_cate($cate_id)
    {
        return $this->db->select('cate_name')->get_where('gcategory', array('cate_id' => $cate_id))->row_array();
    }

    /**
     * 修改资费
     */
    public function rate_save($cate_id, $rate)
    {
        return $this->db->where('cate_id', $cate_id)->update('service_rate', array('rate' => $rate));
    }

}