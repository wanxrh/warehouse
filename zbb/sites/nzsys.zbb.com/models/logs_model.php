<?php

class Logs_model extends CI_Model
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
     * 日志列表列表查询  
     * @param unknown $op_uid  编号
     * @param unknown $add_time_from  开始时间
     * @param unknown $add_time_to  结束时间
     * @param unknown $per_page  每页显示的记录数
     * @param unknown $offset 偏移量
     */
    public function get_search_log($op_uid,$add_time_from,$add_time_to,$per_page, $offset)
    {
        if($op_uid){
            $this->db->where('op_uid', $op_uid);
        }
        if (!empty($add_time_from)) {
            $this->db->where('action_log.dateline >=', $add_time_from);
        }
        if (!empty($add_time_to)) {
            $this->db->where('action_log.dateline <=', $add_time_to);
        }

        $this->db->from('action_log');
        $temp = clone($this->db);
        $this->db->limit($per_page, $offset);
        $arr['list'] = $this->db->order_by('action_log.log_id', 'desc')->get()->result_array();
        //总数
        $this->db = $temp;
        $arr['total'] = $this->db->count_all_results();
        return $arr;
    }



}


