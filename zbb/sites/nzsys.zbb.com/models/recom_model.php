<?php

/**
 * 后台推荐类型模型
 */
class Recom_model extends CI_Model {

	public function __construct() {
		parent::__construct();
		$this->db = $this->load->database('zbb', TRUE);
	}

	/**
	 * 推荐类型
	 */
	public function get_list() {
		$ret = $this->db->get_where('common_link_category', array('type' => 3))->result_array();
		return $ret;
	}

	/**
	 * 获取已推送的商品
	 */
	public function get_recom_goods($cid) {
		$ret = $this->db->order_by('sort ASC')->get_where('common_link', array('cid' => $cid))->result_array();
		return $ret;
	}

	/**
	 * 获取所有商品
	 */
	public function get_all_goods($per_page, $offset, $goods_name='') {
		if($goods_name!=''){
		if (is_numeric($goods_name)) {
			$this->db->where('goods.goods_id', $goods_name);
		} else {
			$this->db->like('goods.goods_name', $goods_name);
		}
	    }
        $this->db->select('goods.*,goods_cate.cate_id');
        $this->db->join('goods_cate','goods_cate.goods_id=goods.goods_id','left');
        $this->db->where('goods.if_show',1)->where('goods.is_del',0);
        $this->db->where('goods_cate.inside',0)->where('goods_cate.level',1);
		$db=clone($this->db);
		$ret['list'] = $this->db->order_by('goods.goods_id', 'desc')->limit($per_page, $offset)->get('goods')->result_array();
		$this->db=$db;
		$ret['total'] = $this->db->count_all_results('goods');
		return $ret;
	}

	/**
	 * 推荐商品
	 */
	public function recom_act($cid, $goods_id, $title, $img, $price,$cost_price) {
		//判断是否达到最大条数
		//echo $cid;exit;
		$max = $this->db->where('id', $cid)->get('common_link_category')->row_array();
		//echo $max['max_num'];exit;
		$numb = $this->db->where('cid', $cid)->count_all_results('common_link');
		//echo $numb;exit;
		if ($numb >= $max['max_num']) {
			echo "<script>alert('已到最大条数');history.go(-1)</script>";
			die();
		}
		$temp = array('cid' => $cid, 'target_id' => $goods_id, 'sort' => $goods_id, 'dateline' => time(), 'title' => $title, 'img' => $img, 'price' => $price, 'cost_price' => $cost_price);
		$this->db->insert('common_link', $temp);
		$ret = $this->db->insert_id();
		return $ret;
	}

	/**
	 * 根据条件查询一条
	 * @param $where 查询条件
	 * @return $row 返回满足条件的数组
	 */
	public function get_one($table, $where) {
		$row = $this->db->get_where($table, $where)->row_array();
		return $row;
	}

	/**
	 * 根据条件查询一条
	 * @param $where 查询条件
	 * @return $row 返回满足条件的数组
	 */
	public function get_goods($table, $where) {
		$row = $this->db->select('goods_name,default_image,price,cost_price')->get_where($table, $where)->row_array();
		return $row;
	}

	/**
	 * 根据条件更新一条数据
	 * @param $where 更新条件
	 * @param $table 表名
	 * @param $data 数据
	 * @return $result 返回更新的结果
	 */
	public function get_edit($table, $data, $where) {
		$result = $this->db->update($table, $data, $where);
		return $result;
	}

	/* 上传图片 */
	function _upload_image() {
		$this->load->library('uploader');
		$this->uploader->allowed_size(600000); // 400KB
		$file = $_FILES['img'];

		if ($file['error'] == UPLOAD_ERR_OK) {
			if (empty($file)) {
				return false;
			}
			$this->uploader->addFile($file);
			if (!$this->uploader->file_info()) {
				show_error($this->uploader->get_error());
			}
			$info = $this->uploader->file_info();
			$type = $info['extension'];
			$Y = date("Y", time());
			$m = date("m", time());
			$d = date("d", time());
			$dirname = 'www/' . $Y . '/' . $m . '/' . $d;
			$filename = 'linke_' . time() . rand(1000, 9999);
			$this->uploader->save($dirname, $filename);
		}
		return 'www/' . $Y . '/' . $m . '/' . $d . '/' . $filename . '.' . $type;
	}

	/**
	 * 根据条件删除数据
	 * @param $table 表名
	 * @param $where 条件
	 * @return $result 返回删除的结果
	 */
	public function get_delete($table, $where) {
		$result = $this->db->delete($table, $where);
		return $result;
	}

	/**
	 * 根据条件查询数据条数
	 * @param $where 查询条件
	 * @return $nums 返回满足条件的条数
	 */
	public function get_num($where) {
		$nums = $this->db->select('id')->get_where('common_link', $where)->num_rows();
		return $nums;
	}

	/**
	 * 根据条件查询一条
	 * @param $where 查询条件
	 * @param $table 表名
	 * @param $limit 第几条数据
	 * @param $order 排序
	 * @return $row 返回满足条件的数组
	 */
	public function get_limit($table, $where, $limit, $order) {
		$row = $this->db->select('id,sort')->order_by($order)->get_where($table, $where, $limit)->row_array();
		return $row;
	}

	/**
	 * 根据用户输入的条件进行商品查询  
	 * @param $goods_name 关键字
	 */
	protected function search_where($goods_name) {
		if (is_numeric($goods_name)) {
			$this->db->where('goods.goods_id', $goods_name);
		} else {
			$this->db->like('goods.goods_name', $goods_name);
		}
		return $this->db;
	}

    public function goods_category($cate_id){
        return $this->db->where_in('cate_id',$cate_id)->get('gcategory')->result_array();
    }

}
