<?php

/**
 * @name 后台店铺模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Store_model extends CI_Model {
	/*
	 * 继承父级构造方法
	 * 实例化两个数据库方法
	 */

	public function __construct() {
		parent::__construct();
		$this->db = $this->load->database('zbb', TRUE);
		$this->uc_db = $this->load->database('uc', TRUE);
	}

	/*
	 * 顶部广告
	 */

	public function get_info() {
		$data = $this->db->select('*')->limit(20)->get('goods')->result_array();
		return $data;
	}

	/**
	 * 根据用户输入的条件进行订单查询，结合分页类使用
	 * @param $owner_name 输入的店主关键字
	 * @param $store_name 输入的商店关键字
	 * @param $sgrade 所属等级
	 * @param $state 状态
	 * @param $permission 是否有申请认证
	 * @param $page 当前页 
	 * @param $show_page 显示的页码数
	 * @return $data 返回满足条件的订单列表data['list']和订单分页data['page']（二维数组）
	 */
	public function get_search($user_name, $store_name, $sgrade, $state, $store_license, $permission) {
		//查询条件
		$this->db = $this->search_where($user_name, $store_name, $sgrade, $state, $store_license, $permission);
		$temp = clone($this->db);
		//$db = clone($this->db);
		//$db_down = clone($this->db);
		$data['count'] = $this->db->select('store.*,member.user_name')->join('member', 'member.user_id = store.store_id', 'left')->from('store')->count_all_results();
		$this->db = $temp;
		$data['list'] = $this->db->select('store.*,member.user_name')->join('member', 'member.user_id = store.store_id', 'left')->order_by('add_time', 'desc')->get('store', $this->per_page, $this->offset)->result_array();
		//用store_id替换$key,为与上下架商品数量数组作匹配
		$new_data = array();
		foreach ($data['list'] as $val) {
			$new_data[$val['store_id']] = $val;
		}
		$data['list'] = $new_data;

		//算出上架商品的数量
		//$this->db = $db;
		$show_up = $this->db->select('store.store_id,Count(`shop_goods`.`goods_id`) as num_up')->join('goods', 'goods.store_id = store.store_id', 'left')->join('member', 'member.user_id = store.store_id', 'left')->where(array('if_show' => 1, 'is_del' => 0, 'closed' => 0))->group_by('store.store_id')->get('store')->result_array();
		//用store_id替换$k,为与店铺大数组作匹配
		$new_show_up = array();
		foreach ($show_up as $k => $v) {
			$new_show_up[$v['store_id']] = $v;
		}
		$show_up = $new_show_up;
		//print_r($data['list']);exit;
		//算出下架商品的数量
		//$this->db = $db_down;
		$show_down = $this->db->select('store.store_id,Count(`shop_goods`.`goods_id`) as num_down')->join('goods', 'goods.store_id = store.store_id', 'left')->join('member', 'member.user_id = store.store_id', 'left')->where(array('if_show' => 0, 'is_del' => 0, 'closed' => 0))->group_by('store.store_id')->get('store')->result_array();

		//用store_id替换$k,为与店铺大数组作匹配
		$new_show_down = array();
		foreach ($show_down as $k => $v) {
			$new_show_down[$v['store_id']] = $v;
		}
		$show_down = $new_show_down;

		//因为这三个数组的元素个数不一致，所以根据store_id作匹配,因为三个数组的key值都是store_id
		foreach ($data['list'] as $k => $v) {
			if (isset($show_up[$k]['store_id'])) {
				if ($data['list'][$k]['store_id'] == $show_up[$k]['store_id']) {
					$data['list'][$k]['show_up'] = $show_up[$k]['num_up'];
				}
			}
		}
		foreach ($data['list'] as $k => $v) {
			if (isset($show_down[$k]['store_id'])) {
				if ($data['list'][$k]['store_id'] == $show_down[$k]['store_id']) {
					$data['list'][$k]['show_down'] = $show_down[$k]['num_down'];
				}
			}
		}
		return $data;
	}

	/**
	 * 根据用户输入的条件进行订单查询 
	 * @param $type 订单类型
	 * @param $order_sn 订单编号
	 * @param $time_from 起始时间
	 * @param $time_to 终止时间
	 */
	protected function search_where($user_name, $store_name, $sgrade, $state, $store_license, $permission) {
		if ($user_name != '') {
			$this->db->like('member.user_name', $user_name);
		}
		if (($store_name != '') && (!is_numeric($store_name))) {
			$this->db->like('store_name', $store_name);
                }
                if(($store_name != '') && (is_numeric($store_name))){  
                   $this->db->where('store_id', $store_name);
                } 
        
		if ($sgrade != '') {
			$this->db->where('sgrade', $sgrade);
		}
		if ($state != '') {
			$this->db->where('state', $state);
		}
		if ($store_license != '') {
			$this->db->where('store_license', $store_license);

			if ($store_license == '0') {
				$this->db->where("((`image_1` != '' AND `image_1` != '0')
                    OR (`image_2` != '' AND `image_2` != '0')
                    OR (`image_3` != '' AND `image_3` != '0'))");
			}
		}
		if ($permission) {
			$this->db->where("store_license != 1 AND store_license != 2 AND 
                ((`image_1` = '' OR `image_1` = '0') 
                AND (`image_2` = '' OR `image_2` = '0') 
                AND (`image_3` = '' OR `image_3` = '0'))");
		}
		return $this->db;
	}

	/**
	 * 根据条件查询一条数据
	 * @param $where 条件
	 * @return $row 返回满足条件的一条数据
	 */
	public function get_one($where) {
		$row = $this->db->get_where('store', $where)->row_array();
		return $row;
	}

	/**
	 * 同步uc用户信息
	 */
	public function sync($uid) {
		$user_uc = $this->uc_db->select('uid,username,email,regdate')->where('uid', $uid)->get('members')->row_array();
		if (count($user_uc) > 0) {
			$data = array();
			$data['user_id'] = $user_uc['uid'];
			$data['user_name'] = $user_uc['username'];
			$data['email'] = $user_uc['email'];
			$data['reg_time'] = $user_uc['regdate'];
			$this->db->insert('member', $data);
			$ret = $this->db->insert_id();
			return $ret;
		} else {
			return 0;
		}
	}

	/**
	 * 初始化 user_stat表
	 */
	public function ini_userstat($user_id) {
		$this->db->insert('user_stat', array('uid' => $user_id));
	}

	/**
	 * 根据条件删除一条数据
	 * @param $where 条件
	 * @param $table 表名
	 * @return $row 返回删除一条数据的结果
	 */
	public function get_delete($table, $where) {
		$row = $this->db->delete($table, $where);
		return $row;
	}

	/**
	 * 根据用户输入的内容来修改
	 * @param $where 条件
	 * @param $data 数据
	 * @return $result 返回修改的结果
	 */
	public function get_edit($data, $where) {

		$this->db->trans_begin();
		try {
			// 处理店铺关闭时将其商品都处理为下架状态
			if ($data['state'] == 0) {
				$this->db->update('goods', array('if_show' => GOODS_NOTSHOW), $where);
			}
			$this->db->update('store', $data, $where);
		} catch (Exception $e) {
			$this->db->trans_rollback();
			return false;
		}

		$this->db->trans_commit();
		return 1;
	}
	/*
	 * 查询申请店铺列表
	 */
	public function get_apply($status='',$per_page, $offset){
		if($status){
			//审核失败
			if($status==2){
				$this->db->where('status',$status);
			}elseif ($status==3){
				//待审核
				$this->db->where('status',($status-3));
			}
		}
		$this->db->select('*');
		$this->db->from('store_apply');
		$temp = clone($this->db);
		$arr['list'] = $this->db->order_by('dateline','desc')->limit($per_page, $offset)->get()->result_array();
		$this->db = $temp;
		$arr['total'] = $this->db->count_all_results();
		return $arr;
	}
	/*
    申请店铺状态修改
     */
	public function store_update($id, $status)
	{
		$this->db->where(array('apply_id' => $id))->update('store_apply', array('status' => $status));
	}
	/**
	 * 根据条件查询一条数据
	 * @param $where 条件
	 * @return $row 返回满足条件的一条数据
	 */
	public function get_store_info($id) {
		$row = $this->db->where('apply_id', $id)->get('store_apply')->row_array();
		return $row;
	}
	/*
    弹出框备注修改
     */
	public function up_com($id, $comment)
	{
		$arr = $this->db->where(array('apply_id' => $id))->update('store_apply', array('comment' => $comment));
		return $arr;
	}
	/*
	 * 店铺列表信息
	 */
	public function get_store($status,$store_name,$per_page, $offset){
		if($status){
			$this->db->where('status',$status-1);
		}
		if($store_name){
			$this->db->where('store_name',$store_name);
		}
		$this->db->select('store_id,region_name,store_name,address,tel,im_qq,im_ww,status');
		$this->db->from('store');
		$temp = clone($this->db);
		$ret['list'] = $this->db->order_by('store_id','desc')->limit($per_page, $offset)->get()->result_array();
		$this->db = $temp;
		$ret['total'] = $this->db->count_all_results();
		return $ret;
	}
	/*
    审核成功数据写入店铺表
     */
	public function add_store($id,$data)
	{
		$this->db->trans_begin();
		//改变状态
		$this->store_update($id,1);
		$this->db->insert('store', $data);
		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			return false;
		} else {
			$this->db->trans_commit();
			return true;
		}
	}
	public function update_store_status($store_id,$status){
		return $this->db->where('store_id',$store_id)->update('store', array('status' => $status));
	}

}

?>
