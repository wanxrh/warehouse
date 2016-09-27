<?php

/**
 * @name 后台会员管理模型
 * @author zhangjiwei
 * @version 2014-01
 */
class Sys_user_model extends CI_Model {
	/*
	 * 继承父级构造方法
	 * 实例化两个数据库方法
	 */

	public function __construct() {
		parent::__construct();
		$this->db = $this->load->database('zbb', TRUE);
	}

	/**
	 * 根据用户输入的条件进行订单查询，结合分页类使用
	 * @param $field_name 输入的关键字类型
	 * @param $field_value 关键字
	 * @param $sort 排序
	 * @param $page 当前页
	 * @param $show_page 显示的页码数
	 * @return $data 返回满足条件的订单列表data['list']和订单分页data['page']（二维数组）
	 */
	public function get_search($field_name, $field_value, $sort) {
//查询条件
		$this->db = $this->search_where($field_name, $field_value, $sort);
		$temp = clone($this->db);
		$data['count'] = $this->db->from('member')->count_all_results();
		$this->db = $temp;
		$data['list'] = $this->db->order_by('reg_time desc')->get('member', $this->per_page, $this->offset)->result_array();

		return $data;
	}

	/**
	 * 根据用户输入的条件进行查询 
	 * @param $field_name 查询类型
	 * @param $field_value 查询关键字
	 * @param $sort 排序 
	 */
	protected function search_where($field_name, $field_value, $sort) {
		switch ($field_name) {
			case 'user_name':
				$this->db->like('user_name', $field_value);
				break;
			case 'email':
				$this->db->like('email', $field_value);
				break;
			case 'real_name':
				$this->db->like('real_name', $field_value);
				break;
			case 'user_id':
				$this->db->like('user_id', $field_value);
				break;
		}
		if ($sort) {
			$this->db->order_by($sort);
		}
		return $this->db;
	}

	/**
	 * 根据用户输入的内容来修改
	 * @param $user_id 用户ID
	 * @return $data 返回修改的结果
	 */
	public function user_edit($arr, $user_id) {
		$result = $this->db->update('member', $arr, array('user_id' => $user_id));
		return $result;
	}

	/**
	 * 根据用户输入的内容新增
	 * @return $id 返回新增数据的ID
	 */
	public function user_add($data) {

		$this->db->insert('member', $data);
		$id = $this->db->insert_id();
		return $id;
	}

	/**
	 * 冻结帐号 lock == 1  冻结帐号
	 * @param $user_id 用户ID
	 * @param $data 修改内容的数组
	 * @return $result 返回修改的结果
	 */
	public function user_lock($user_id, $data) {
		$data['lock'] = 1;
		$result = $this->db->update('member', $data, array('user_id' => $user_id));
		return $result;
	}

	/*
	 * 把冻结的信息写进定时器表
	 */

	public function tasktimer_lock($user_id, $data) {
		$arr['target_id'] = $user_id;
		$arr['dateline'] = time();
		$arr['type'] = 10;
		$arr['plan_time'] = $data['lock_time'];
		$arr['remark'] = $data['lock_msg'];
		$this->db->insert('tasktimer', $arr);
		$id = $this->db->insert_id();
		return $id;
	}

	/**
	 * 解除冻结帐号 lock == 0  解除冻结帐号
	 * @param $user_id 用户ID
	 * @return $result 返回修改的结果
	 */
	public function user_unlock($user_id) {
		$this->db->update('member', array('lock' => 0, 'lock_msg' => NULL, 'lock_time' => NULL), array('user_id' => $user_id));
		$result = $this->db->delete('tasktimer', array('target_id' => $user_id));
		return $result;
	}

	/**
	 * 根据条件查询一条数据
	 * @param $where 条件
	 * @return $row 以数组形式返回一条结果
	 */
	public function get_one($where) {
		$row = $this->db->get_where('member', $where)->row_array();
		return $row;
	}

	/**
	 * 根据条件删除一条数据
	 * @param $where 条件
	 * @return $row 以数组形式返回一条结果
	 */
	public function get_delete($where) {
		$row = $this->db->delete('member', $where);
		return $row;
	}

	public function reg_to_admin($username, $passowrd, $email) {
		$data = array();
		$now = time();
		$data['user_name'] = $username;
		$data['password'] = md5($passowrd);
		$data['email'] = $email;
		$data['reg_time'] = $now;
		$data['last_login'] = $now;
		$id = $this->db->insert('member', $data);
		return $id;
	}

	/**
	 * 检查用户名是否可被注册
	 *
	 * @return int string
	 */
	public function is_registrable($uname) {
		$uname = trim($uname);
// 用户名中连续的数字不能大于等于5个
		if (preg_match('/\d{5}/uD', $uname)) {
//return $this->_error('DIGI_SEQ_IN_USERNAME', '用户名中不能包含多个数字，推荐使用中文用户名。');
			return FALSE;
		}
// 用户名长度为6-50个字符,一个汉字占3个字符（UTF-8）
		if (strlen($uname) > 50 || strlen($uname) < 6) {
//return $this->_error('USERNAME_LENGTH_INCORRECT', '用户名长度必需为6-50个字符。' . $uname);
			return FALSE;
		}
// 用户名为汉字、字母、数字和下划线，不含特殊字符
		if (!preg_match('/^[\x{4e00}-\x{9fa5}A-Za-z0-9_]+$/uD', $uname)) {
//return $this->_error('DISALLOWED_CHAR_IN_USERNAME', '用户名支持中英文、数字、下划线，不支持除下划线的特殊字符。');
			return FALSE;
		}
// 用户名不能全为下划线
		if (preg_match('/^\_+$/uD', $uname)) {
//return $this->_error('USERNAME_IS_UNDERSCORES', '用户名不能全为下划线。');
			return FALSE;
		}

// 是否被禁
		/*  if (!$this->check_keyword($uname)) {
		  return FALSE;
		  } */

// 查询是否重名
		if (!$this->check_name_exists($uname)) {
			return FALSE;
		}

		return TRUE;
	}

	/**
	 * 检查名字里面是否含有违禁字
	 *
	 * @param $name 用户名或者昵称
	 * @param $type 1表示用户名；2表示昵称；
	 * @return boolean
	 */
	public function check_name_exists($name) {
		if ($this->db->where('user_name', $name)->count_all_results('member') > 0) {
//return $this->_error('NICKNAME_EXISTS', '您注册的昵称已经被注册，请重新更换新的昵称。');
			return FALSE;
		}
		return TRUE;
	}

	
	public function select_uc_mob($user_id){
		$this->uc_db = $this->load->database('uc', TRUE);
		return $this->uc_db->select('mobile,email')->get_where('members',array('uid'=>$user_id))->row_array();
	}
}

?>
