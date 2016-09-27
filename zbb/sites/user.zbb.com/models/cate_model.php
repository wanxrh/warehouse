<?php

/*
 * 店铺商品分类模型
 */
class Cate_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }
    
    /*
     * 商品分类
     */
    public function cate_seller($page, $offset)
    {
        $user_id = get_user();
        // 全部分类
        $arr['all'] = $this->db->where('store_id', $user_id['id'])
            ->order_by('sort_order', 'asc')
            ->get('gcategory')
            ->result_array();
        // 一级分类
        $arr['cate'] = $this->db->where('store_id', $user_id['id'])
            ->where('parent_id', 0)
            ->order_by('parent_id', 'asc')
            ->limit($page, $offset)
            ->order_by('sort_order', 'asc')
            ->get('gcategory')
            ->result_array();
        
        // 一级分类总数
        $arr['count'] = $this->db->where('store_id', $user_id['id'])
            ->where('parent_id', 0)
            ->count_all_results('gcategory');
        
        return $arr;
    }
    
    /*
     * 商品分类添加
     */
    public function add_cate($data)
    {
        return $this->db->insert('gcategory', $data);
    }
    
    /*
     * 商品分类更改
     */
    public function edit_cate($id, $data)
    {
        return $this->db->where(array(
            'cate_id' => $id
        ))->update('gcategory', $data);
    }

    /**
     * 根据分类id得到一条分类详情
     * 
     * @param unknown $cate_id            
     * @return unknown
     */
    public function get_one_cate($cate_id)
    {
        $res = $this->db->get_where('gcategory', array(
            'cate_id' => $cate_id
        ))->row_array();
        return $res;
    }
    /*
     * 商品分类
     */
   /*  public function cate_one($store_id)
    {
        $data = $this->db->where('store_id', $store_id)
            ->order_by('sort_order', 'asc')
            ->get('gcategory')
            ->result_array();
        return $data;
    } */
    
    /*
     * 商品分类删除
     */
    public function select_cate($id)
    {
        $this->db->where('cate_id', $id);
        $this->db->or_where('parent_id', $id);
        return $this->db->delete('gcategory');
    }

    /**
     * 获取卖家货物的分类列表
     *
     * @param            
     *
     * @return 返回货物分类列表的二维数组
     */
    public function seller_category($condition)
    {
        $arr = $this->db->where($condition)
            ->order_by('sort_order', 'asc')
            ->get('gcategory')
            ->result_array();
        return $arr;
    }

    /**
     * 取得所有商品分类
     *
     * @param int $store_id
     *            店铺编号
     * @return array
     */
    
    function get_all_cate(){
        $gcategorie = $this->db->where(array(
            'store_id' => 0
        ))
        ->order_by('sort_order', 'asc')
        ->get('gcategory')
        ->result_array();
        $this->load->library('tree');
        $this->tree->set_tree($gcategorie);
        return $this->tree->get_tree_spc();
        
    }
    /**
     * 得到包含标识符的树形分类二位数组，本店分类
     * @param unknown $user_id
     */
    function get_sgcategory_options($user_id){
        $gcategories = $this->seller_category(array(
            'store_id' => $user_id,
            'if_show' => 1
        ));
        $this->load->library('tree');
        $this->tree->set_tree($gcategories);
        return $this->tree->get_tree();
    }
    /**
     * 得到包含标识符的树形分类一维数组，本店分类
     * @param unknown $user_id
     */
    function get_sgcategory_simple($user_id){
        $gcategories = $this->seller_category(array(
            'store_id' => $user_id,
            'if_show' => 1
        ));
        $this->load->library('tree');
        $this->tree->set_tree($gcategories);
        return $this->tree->get_tree_simple();
    }
    /**
     * 返回包含图标['│','├','└']，不包含'select'字段的树形分类二位数组，本店分类
     */
    function get_scategory_list($user_id){
        $gcategories = $this->seller_category(array(
            'store_id' => $user_id,
            'if_show' => 1
        ));
        $this->load->library('tree');
        $this->tree->set_tree($gcategories);
        return $this->tree->get_tree_list();
    }




public function get_more($parent_id){

        $result = $this->db->where('parent_id',$parent_id)->where('store_id',0)->get('gcategory')->result_array();
        return $result;
    }


public function store_cate($store_id,$parent_id){
       $result = $this->db->where('parent_id',$parent_id)->where('store_id',$store_id)->get('gcategory')->result_array();
        return $result;
      
    }
	/*
	 * 获取单条分类的信息
	 */
	public  function get_parent($cate_id){
		$result = $this->db->select('cate_id,parent_id,cate_name,sort_order,if_show')->where('cate_id',$cate_id)->get('gcategory')->row_array();
		return $result;
		
		
		}
	//本店分类
	public  function sgcate_parent($goods_id){
		$result = $this->db->where('goods_id',$goods_id)->get('category_goods')->row_array();
		return $result;
		}
    /*
     * 删除分类
     */
    public function category_del($id){
        $this->db->where('cate_id', $id);
        return $this->db->delete('gcategory');
    }
    /*
    查询该分类是否有子级
    */
    public function sel_cate_parent($id){
        $this->db->from('gcategory');
        $this->db->where('parent_id',$id);
        $result = $this->db->count_all_results();
        return $result;
    }
    /*
     * 新增分类
     */
    public function category_add($data){
        return $this->db->insert('gcategory', $data);
    }
    /*
     * 获取所有一级分类
     */
    public function cate_children($uid)
    {
        // 获取一级分类
        $ret=$this->db->select('cate_id,cate_name')->where(array('store_id' => $uid,'parent_id' => 0))->get('gcategory')->result_array();
        return $ret;
    }
    /*
    *编辑分类
    */
    public function cate_save($cate_id,$arr){
        $ret=$this->db->where('cate_id',$cate_id)->update('gcategory',$arr);
        return $ret;
    }

}
