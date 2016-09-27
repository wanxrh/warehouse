<?php
class Gcategory_model extends CI_Model{
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
	 *分类
	 */
	public function get_more($cate_id){
		$result = $this->db->where('parent_id',$cate_id)->where('store_id',0)->order_by('sort_order', 'asc')->get('gcategory')->result_array();
		return $result;
	}
	
	/*
	 *无限极分类
	 */
	public function category($id=0,$list=array(),$status=0){
		$result= $this->db->where('parent_id',$id)->where('store_id',0)->order_by('sort_order', 'asc')->get('gcategory')->result_array();		
		foreach($result as $key=>$val){
			for($i=0; $i<$status ; $i++){
				$val['cate_name']='<font color="#FF0000">|-</font>'.$val['cate_name'];
			}
			$list[]=$val;
			$id=$val['cate_id'];
			$list=$this->category($id,$list,$status+1);
		}			
		return $list;
	}
	
   /*
	*新增分类
	*/
	public function cate_add($arr){
		$this->db->insert('gcategory',$arr);	
		$res=$this->db->insert_id();
		return $res;	
	}
	
	
    /*
	 *修改前查询当前分类
	 */
	public function get_cate($cateid){
		$res=$this->db->where('cate_id',$cateid)->order_by('sort_order', 'asc')->get('gcategory')->row_array();	
		return $res;	
	}

	
	/*
	 *编辑分类
	 */
	public function cate_save($cate_id,$arr){

	    $ret=$this->db->where('cate_id',$cate_id)->update('gcategory',$arr);	
		return $ret;
	}
	
	/*
	 * 删除分类的方法
	 * @param $cate_id 分类ID
	 */
	public function del_category($cate_id){
		$result = $this->db->where('parent_id',$cate_id)->order_by('sort_order', 'asc')->get('gcategory')->result_array();
		foreach($result as $key=>$val){
			$child_id = $val['cate_id'];
			$this->db->delete('gcategory',array('cate_id'=>$child_id)); 
			$this->del_category($child_id);
		}
		$delete = $this->db->delete('gcategory',array('cate_id'=>$cate_id));
		return $delete;
	}
	
    /*
	 *显示分类
	 */
	
	 public function show_cate($cate_id){
		$array=array('if_show'=>1);
		$result = $this->db->where('parent_id',$cate_id)->order_by('sort_order', 'asc')->get('gcategory')->result_array();
		foreach($result as $key=>$val){
			$child_id = $val['cate_id'];
			$this->db->where('cate_id',$child_id)->update('gcategory', $array);
			$this->show_cate($child_id);
		}
		$update=$this->db->where('cate_id',$cate_id)->update('gcategory', $array);
		return $update;
		}
		
	/*
     * 隐藏分类
     */		
	public function hidden_cate($cate_id){
		$array=array('if_show'=>0);
		$result = $this->db->where('parent_id',$cate_id)->order_by('sort_order', 'asc')->get('gcategory')->result_array();
		foreach($result as $key=>$val){
			$child_id = $val['cate_id'];
			$this->db->where('cate_id',$child_id)->update('gcategory', $array);
			$this->hidden_cate($child_id);
		}
		$update=$this->db->where('cate_id',$cate_id)->update('gcategory', $array);
		return $update;
	}
 
	/**
	 * 查询频道下的分类
	 * 
	 * @param   $cate_type   频道标志
	 * 1/女装   2/男装  3/妈妈装   4/孕妇装   5/童装
	 */
	public function cate_children()
	{
	   // 获取一级分类
	    $ret['top_cate']=$top_cate=$this->db->where(array('store_id' => 0,'parent_id' => 0))->get('gcategory')->result_array();
	    $parent_ids=array_column($top_cate, 'cate_id');
	    if($parent_ids){
	    // 获取二级分类
	    $ret['second_cate'] = $this->db->where_in('parent_id',$parent_ids)->get('gcategory')->result_array();
	}
	    return $ret;
	}
	
	/**
	 * 获取最大cate_type值
	 */
	public function max_cate_type()
	{
	    $result = $this->db->select_max('cate_type')->order_by('sort_order', 'asc')->get('gcategory')->row_array();
	    return $result['cate_type'];
	}
	
}
?>