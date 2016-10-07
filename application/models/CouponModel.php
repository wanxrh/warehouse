<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require "BaseModel.php";
class CouponModel extends BaseModel {
	public function __construct()
	{
		parent::__construct();
	}

	public function daili_store_goods($conditon,$number){
	    $this->db->where($conditon);
        $this->db->where('number >= ',$number);
        $this->db->set('number','number - '.$number,false)->update('shop_daili_store_goods');
    }
}
