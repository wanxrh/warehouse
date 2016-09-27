<?php

/**
 * 首页推送管理模型
 */
class Linke_model extends CI_Model {

    public function __construct() {

        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
    }

    /**
     * 分类
     */
    public function cate($params) {
        
        if (isset($params['type'])) {
            $this->db->where('type', $params['type']);
        }
        if (isset($params['pid'])) {
            $this->db->where('pid', $params['pid']);
        }
        $data = $this->db->get('common_link_category')->result_array();
        return $data;
    }
    
    /**
     * 获取分类信息用于显示
     */
    public function get_cate($type, $id, $arr = array()) {
        
        $result = $this->db->where(array('type' => $type, 'id' => $id))->get('common_link_category')->row_array();
        array_push($arr, $result);
        krsort($arr);
        return $arr;
    }

    /**
     * 列表
     */
    public function linke_list($cid, $id) {

        $data['arr'] = $this->db->where('cid', $cid)->order_by("dateline", " desc")->get('common_link')->result_array();
        $data['linke'] = $this->db->where('id', $id)->get('common_link')->row_array();

        return $data;
    }
	
	    /**
     * 分类信息
     */
    public function cate_info($id) {
        $ret= $this->db->select('*')->where('id', $id)->get('common_link_category')->row_array();
        return $ret;
    }
	
	/**
     * 修改名称
     */
    public function update_cate($id,$name) {
        $ret= $this->db->where('id',$id)->update('common_link_category',array('name'=>$name));
        return $ret;
    }

    /**
     * 推荐添加
     */
    public function linke_add($post,$cid) {

        //判断是否达到最大条数
        $max = $this->db->where('id', $cid)->get('common_link_category')->row_array();
        $numb = $this->db->where('cid', $cid)->count_all_results('common_link');

        $this->db->set('title', $post['title']);
        $this->db->set('dateline', time());

        if ($post['type'] == 2) {
            $file = $_FILES['logo'];
            if ($file['name'] != '') {
                $img = $this->_upload_image();
                $this->db->set('img', $img);
            }
        }
        //类别和是否编辑
        if (!empty($post['id'])) {
            $this->db->set('url', $post['url']);
			$this->db->set('content', $post['content']);
            $this->db->where('id', $post['id']);
            $this->db->update('common_link');
        } else {
            if ($numb >= $max['max_num']) {
                echo "<script>alert('已到最大条数');history.go(-1)</script>";exit;
            }
            $this->db->set('url', $post['url']);
			$this->db->set('content', $post['content']);
            $this->db->set('cid', $post['cid']);
            $this->db->insert('common_link');
        }
    }

    /**
     * 推荐删除
     */
    public function linke_delete($id) {

        $this->db->where('id', $id)->delete('common_link');
    }

    /* 上传图片 */
	function _upload_image() {
		$this->load->library('uploader');
		$this->uploader->allowed_size(600000); // 400KB
		$file = $_FILES['logo'];

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
    
       /* 最大数量更改 */

    function linke_num($post) {
             $this->db->where('id',$post['id']);
             $this->db->set('max_num',$post['num']);
              $this->db->update('common_link_category');
        
    }

}
