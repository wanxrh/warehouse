<?php

class person
{

    private $nzw_hostname = NULL;
    private $nzw_username = NULL;
    private $nzw_password = NULL;
    private $nzw_database = NULL;
    private $uc_hostname = NULL;
    private $uc_username = NULL;
    private $uc_password = NULL;
    private $uc_database = NULL;
    private $_root_dir = NULL;
    private $_allowed_file_type = NULL;

    function __construct()
    {
        $dir = dirname(dirname(dirname(__FILE__)));
        //include $dir . '/common/config/yibanmall.com/database.php';
        //include $dir . '/common/config/yibanmall.com/nzw.php';
        include $dir . '/common/config/development/database.php';
        include $dir . '/common/config/development/zbb.php';
        include $dir . '/common/helpers/core_helper.php';
        $this->_root_dir = $config['_root_dir'];
        $this->_allowed_file_type = $config['_allowed_file_type'];
        $this->nzw_hostname = $db['zbb']['hostname'];
        $this->nzw_username = $db['zbb']['username'];
        $this->nzw_password = $db['zbb']['password'];
        $this->nzw_database = $db['zbb']['database'];
        $this->uc_hostname = $db['uc']['hostname'];
        $this->uc_username = $db['uc']['username'];
        $this->uc_password = $db['uc']['password'];
        $this->uc_database = $db['uc']['database'];
        $this->connect_db();
    }

    //连接nzw数据库
    private function connect_db()
    {
        //mysql_connect($this->nzw_hostname . ":1039", $this->nzw_username, $this->nzw_password);
        mysql_connect($this->nzw_hostname, $this->nzw_username, $this->nzw_password);
        mysql_select_db($this->nzw_database);
        mysql_query('set names utf8');
    }

    //根据帐号密码判断用户是否存在
    public function check_password($user_name, $password)
    {
        //连接UC数据库
        //mysql_connect($this->uc_hostname . ":1049", $this->uc_username, $this->uc_password);
        $ret = mysql_connect($this->uc_hostname, $this->uc_username, $this->uc_password);
        mysql_select_db($this->uc_database);
        mysql_query('set names utf8');

        // 判断登录类型
        if (preg_match('/^[^_][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/', $user_name)) {
            $column_uc = 'email';
        } else if (preg_match('/^([1][3|4|5|8][0-9]{9}){1}$/', $user_name)) {
            $column_uc = 'mobile';
        } else {
            $column_uc = 'username';
        }

        $sql = 'select * from `yz_members` where `' . $column_uc . '`=' . "'$user_name'";
        $result = mysql_query($sql);
        $user_uc = mysql_fetch_assoc($result);

        if ($user_uc) {
            $password_login = strtolower(md5(strtolower(md5($password) . $user_uc['salt'])));
            if ($user_uc['password'] != $password_login) {
                return 0;
            } else {
                return $user_uc['uid'];
            }
        } else {
            return -1;
        }
    }

    //根据卖家ID  查询订单信息
    public function get_order($seller_id)
    {
        $s_id = intval($seller_id);
        $sql = "SELECT Count(`shop_order_goods`.`goods_id`) as goods_num,`shop_order`.`order_id`,`shop_order`.`buyer_name`,`shop_order`.`postscript`,`shop_order`.`pay_time`,`shop_order`.`order_sn`,`shop_order_extm`.`region_id` as buyer_region_id, `shop_order_extm`.`shipping_remark`,`shop_store`.`region_id` as store_region_id, `shop_order`.`seller_name`, `shop_order_extm`.`consignee`, `shop_order_extm`.`mobile`,`shop_order_extm`.`tel`,`shop_order_extm`.`address` as buyer_address, `shop_order_extm`.`region_name` as buyer_region_name, `shop_store`.`region_name`, `shop_store`.`address`,`shop_store`.`tel`,`shop_store`.`store_name`,`shop_order_goods`.`goods_name`,`shop_order_goods`.`specification` FROM (`shop_order`) LEFT JOIN `shop_order_goods` ON `shop_order`.`order_id` = `shop_order_goods`.`order_id`  LEFT JOIN `shop_goods` ON `shop_goods`.`goods_id`=`shop_order_goods`.`goods_id` LEFT JOIN `shop_order_extm` ON `shop_order`.`order_id` = `shop_order_extm`.`order_id` LEFT JOIN `shop_store` ON `shop_store`.`store_id` = `shop_order`.`seller_id` WHERE `shop_order`.`seller_id` = $s_id AND `shop_order_goods`.`status` = 20 GROUP BY `shop_order_goods`.`order_id`";
        $query = mysql_query($sql);
        $list = array();
        while ($row = mysql_fetch_assoc($query)) {
            $list['data'][] = $row;
        }
        if (count($list) > 0) {
            foreach ($list['data'] as $key => $val) {
                $list['data'][$key] = str_replace(" ", "", $val);
                $list['data'][$key]['store_reg_name'] = $this->get_region($val['store_region_id']);
                $list['data'][$key]['buyer_reg_name'] = $this->get_region($val['buyer_region_id']);
                if (!empty($val['phone_mob']) && !empty($val['phone_tel'])) {
                    $list['data'][$key]['phone_mob'] = $val['phone_mob'] . '/' . $val['phone_tel'];
                }
                if (!empty($val['phone_mob']) && empty($val['phone_tel'])) {
                    $list['data'][$key]['phone_mob'] = $val['phone_mob'];
                }
                if (empty($val['phone_mob']) && !empty($val['phone_tel'])) {
                    $list['data'][$key]['phone_mob'] = $val['phone_tel'];
                }
            }
            $json = json_encode($list);
            return $json;
        } else {
            return json_encode("no");
        }
    }

    //根据地区ID查出上级名称
    private function get_region($region_id)
    {
        $reg_id = intval($region_id);
        $sql = "SELECT `parent_id`,`region_name` FROM(`shop_region`) WHERE `region_id` = $reg_id";
        $query = mysql_query($sql);
        $row = mysql_fetch_assoc($query);
        $parent_id = $row['parent_id']; //3948
        $sql01 = "SELECT `region_name`,`region_id`,`parent_id` FROM(`shop_region`) WHERE `region_id` = $parent_id";
        $query01 = mysql_query($sql01);
        $row01 = mysql_fetch_assoc($query01);
        $pid = $row01['parent_id']; //3947
        if ($pid == 0) {
            return $row01['region_name'] . $row['region_name'];
        } else {
            $sql02 = "SELECT `region_name`,`region_id` FROM(`shop_region`) WHERE `region_id` = $pid";
            $query02 = mysql_query($sql02);
            $row02 = mysql_fetch_assoc($query02);
            return $row02['region_name'] . $row01['region_name'];
        }
    }


    //根据会员名称 查询会员ID
    public function get_id($user_name)
    {
        if ($user_name == '') {
            return;
        }
        $user_name = "'" . $user_name . "'";
        $sql = 'SELECT `shop_member`.`user_id` FROM(`shop_member`) WHERE `shop_member`.`user_name`=' . $user_name;
        $query = mysql_query($sql);
        $list = array();
        while ($row = mysql_fetch_assoc($query)) {
            $list[] = $row;
        }
        $json = json_encode($list);
        return $json;
    }

    //判断
    public function is_has_addr($store_id)
    {
        if ($store_id == '') {
            return;
        }
        $sql = 'SELECT count(1) as tj FROM shop_depot_address WHERE user_id=' . $store_id . ' and is_default=1';
        $query = mysql_query($sql);
        $list = array();
        while ($row = mysql_fetch_assoc($query)) {
            $list[] = $row;
        }
        return $list[0]['tj'] >= 1 ? 1 : 0;
    }

    //批量发货
    public function delivery($order_id, $shipping_name, $invoice_no, $reason, $operator)
    {
        $result = mysql_query("CALL proc_new_seller_order_shipped(" . $order_id . ",'" . $shipping_name . "','" . $invoice_no . "','" . $reason . "','" . $operator . "')");
        $one = mysql_fetch_assoc($result);
        if ($one['code'] != 200) {
            return json_encode('no');
        } else {
            return json_encode('yes');
        }
    }

    public function import_unsku($arr, $detail, $intro)
    {
        $data = explode('@@', $arr);
        $good_data['store_id'] = intval($data[0]);
        $good_data['goods_name'] = $data[1];
        $good_data['add_time'] = time();
        $good_data['default_image'] = $this->GrabImage(str_replace('60x60', '430x430', $data[2]));
        $good_data['enable_sku'] = 0;
        mysql_query("BEGIN");
        //插入goods表
        $goods_id = $this->insert('shop_goods', $good_data);
        if (!$goods_id) {
            mysql_query("ROLLBACK");
            return '2';
        }

        //处理其他图片 循环插入
        $other_image = explode('*', $data[3]);
        foreach ($other_image as $li) {
            $image_url = $this->GrabImage(str_replace('60x60', '430x430', $li));
            $ret_img = $this->insert('shop_goods_image', array('goods_id' => $goods_id, 'image_url' => $image_url));
        }
        if (!$ret_img) {
            mysql_query("ROLLBACK");
            return '3';
        }
        //参数和详情
        $temp_arr = array('goods_id' => $goods_id, 'attributes' => $detail, 'detail' => $intro);
        $ret_extm = $this->insert('shop_goods_extm', $temp_arr);
        if (!$ret_extm) {
            mysql_query("ROLLBACK");
            return '4';
        }

        //商品类目关联(网站)
        $cate_site_arr = explode('*', $data[5]);
        $i = 1;
        foreach ($cate_site_arr as $cate_site) {
            $cate_site_data = array('cate_id' => $cate_site, 'goods_id' => $goods_id, 'level' => $i);
            $ret_site_cate = $this->insert('shop_goods_cate', $cate_site_data);
            $i = $i + 1;
        }
        if (!$ret_site_cate) {
            mysql_query("ROLLBACK");
            return '5';
        }
        //商品类目关联(店铺)
        $cate_shop_arr = explode('*', $data[6]);
        $j = 1;
        foreach ($cate_shop_arr as $cate_shop) {
            $cate_shop_data = array('cate_id' => $cate_shop, 'goods_id' => $goods_id, 'inside' => 1, 'level' => $j);
            $ret_shop_cate = $this->insert('shop_goods_cate', $cate_shop_data);
            $j = $j + 1;
        }
        if (!$ret_shop_cate) {
            mysql_query("ROLLBACK");
            return '51';
        }

        //插入sku表
        $sku_arr = array(
            'goods_id' => $goods_id,
            'price' => $data[9],
            'stock' => $data[10],
            'cost_price' => $data[8]
        );
        $sku_id = $this->insert('shop_goods_sku', $sku_arr);
        if (!$sku_id) {
            mysql_query("ROLLBACK");
            return '6';
        }

        //更新goods表
        $ret_goods = $this->update('shop_goods', "goods_id=$goods_id", array('sku_id' => $sku_id, 'price' => $data[9], 'cost_price' => $data[8]));

        if (!$ret_goods) {
            mysql_query("ROLLBACK");
            return '7';
        }

        $ret_goods_stat = $this->insert('shop_goods_stat', array('goods_id' => $goods_id));

        if (!$ret_goods_stat) {
            mysql_query("ROLLBACK");
            return '8';
        }

        mysql_query("COMMIT");

        return 1;
    }

    //天猫采集
    public function import_taobao($arr, $detail, $intro, $json_total, $json_relate)
    {
        //处理插进goods表的数据
        $data = explode('@@', $arr);
        $good_data['store_id'] = intval($data[0]);
        $good_data['goods_name'] = $data[1];
        $good_data['add_time'] = time();
        $good_data['default_image'] = $this->GrabImage(str_replace('60x60', '430x430', $data[2]));

        mysql_query("BEGIN");
        //插入goods表
        $goods_id = $this->insert('shop_goods', $good_data);

        if (!$goods_id) {
            mysql_query("ROLLBACK");
            return '2';
        }
        //处理其他图片 循环插入
        $other_image = explode('*', $data[3]);
        foreach ($other_image as $li) {
            $image_url = $this->GrabImage(str_replace('60x60', '430x430', $li));
            $ret_img = $this->insert('shop_goods_image', array('goods_id' => $goods_id, 'image_url' => $image_url));
        }

        if (!$ret_img) {
            mysql_query("ROLLBACK");
            return '3';
        }
        //参数和详情
        $temp_arr = array('goods_id' => $goods_id, 'attributes' => $detail, 'detail' => $intro);
        $ret_extm = $this->insert('shop_goods_extm', $temp_arr);

        if (!$ret_extm) {
            mysql_query("ROLLBACK");
            return '4';
        }

        //商品类目关联(网站)
        $cate_site_arr = explode('*', $data[5]);
        $i = 1;
        foreach ($cate_site_arr as $cate_site) {
            $cate_site_data = array('cate_id' => $cate_site, 'goods_id' => $goods_id, 'level' => $i);
            $ret_site_cate = $this->insert('shop_goods_cate', $cate_site_data);
            $i = $i + 1;
        }
        if (!$ret_site_cate) {
            mysql_query("ROLLBACK");
            return '5';
        }

        //商品类目关联(店铺)
        $cate_shop_arr = explode('*', $data[6]);
        $j = 1;
        foreach ($cate_shop_arr as $cate_shop) {
            $cate_shop_data = array('cate_id' => $cate_shop, 'goods_id' => $goods_id, 'inside' => 1, 'level' => $j);
            $ret_shop_cate = $this->insert('shop_goods_cate', $cate_shop_data);
            $j = $j + 1;
        }
        if (!$ret_shop_cate) {
            mysql_query("ROLLBACK");
            return '51';
        }

        //规格名称
        //通过库存数组获取规格名称对应ID
        $attr_name = array_keys(json_decode($json_total, true));
        preg_match_all("/\;(.+?)\:/", $attr_name[0], $match);
        $attr_name = $match[1];
        $spec_arr = explode('|', $data[4]);
        $s = 0;
        $attr_relat = [];
        foreach ($spec_arr as $spec_li) {
            $ret_cate = $this->insert('shop_attr_name', array('goods_id' => $goods_id, 'attr_name' => $spec_li));
            $attr_relat[$attr_name[$s]] = $ret_cate;
            $s++;
        }

        if (!$ret_cate) {
            mysql_query("ROLLBACK");
            return '6';
        }
        //规格值
        $relate = json_decode($json_relate, true);
        $attr_value = [];
        foreach ($relate as $k => $v) {
            $a_name = explode(':', $k);
            $relate_id = $this->insert('shop_attr_value', array('goods_id' => $goods_id, 'attr_name_id' => $attr_relat[$a_name[0]], 'attr_value' => $v));
            $attr_value[$k] = $attr_relat[$a_name[0]] . ':' . $relate_id;
        }

        if (!$relate_id) {
            mysql_query("ROLLBACK");
            return '7';
        }

        //处理sku表
        $sku = json_decode($json_total, true);
        $price_arr = [];
        foreach ($sku as $k => $v) {
            $params = [];
            $nk = trim($k, ';');
            $properties_arr = explode(';', $nk);
            $properties = '';
            foreach ($properties_arr as $kk => $vv) {
                $properties .= $attr_value[$vv] . ';';
            }
            $params = array(
                'goods_id' => $goods_id,
                'properties' => trim($properties, ';'),
                'price' => $v['price'],
                'store_id' => intval($data[0]),
                'stock' => $v['stock'],
                'cost_price' => $v['cost_price'],
                'out_sku' => $v['skuid']
            );

            $skuid = $this->insert('shop_goods_sku', $params);

            if (!$skuid) {
                mysql_query("ROLLBACK");
                return '8';
            }

            //goods_ttr表
            $gattr = explode(';', trim($properties, ';'));
            foreach ($gattr as $v) {
                $single = explode(':', $v);
                $in_attr = array(
                    'goods_id' => $goods_id,
                    'attr_name_id' => $single[0],
                    'attr_value_id' => $single[1],
                    'sku_id' => $skuid,
                );
                $ret_gattr = $this->insert('shop_goods_attr', $in_attr);
            }

            if (!$ret_gattr) {
                mysql_query("ROLLBACK");
                return '9';
            }

        }
        $sql = "SELECT `price`,`cost_price`,`sku_id` FROM(`shop_goods_sku`) WHERE `goods_id`=$goods_id order by `price` desc";
        $query = mysql_query($sql);
        $min_price = mysql_fetch_array($query);
        $temp_sql_arr = array('price' => $min_price[0], 'cost_price' => $min_price[1], 'sku_id' => $min_price[2]);
        $ret_goods = $this->update('shop_goods', "goods_id=$goods_id", $temp_sql_arr);

        if (!$ret_goods) {
            mysql_query("ROLLBACK");
            return '10';
        }

        $ret_goods_stat = $this->insert('shop_goods_stat', array('goods_id' => $goods_id));

        if (!$ret_goods_stat) {
            mysql_query("ROLLBACK");
            return '11';
        }

        mysql_query("COMMIT");

        return 1;
    }


    private function GrabImage($url, $filename = "")
    {
        if (!$url) {
            return false;
        }
        if (!$filename) { // 如果没有指定新的文件名
            $ext = strrchr($url, "."); // 得到$url的图片格式
            $type = substr($ext, 1);
            if (!in_array($type, $this->_allowed_file_type)) {
                return false;
            }
            $filename = date("YmdHis", time()) . rand(1111, 9999) . $ext; // 用天月面时分秒来命名新的文件名
        }

        ob_start(); // 打开输出
        readfile($url); // 输出图片文件
        $img = ob_get_contents(); // 得到浏览器输出
        ob_end_clean(); // 清除输出并关闭
        $Y = date("Y", time());
        $m = date("m", time());
        $d = date("d", time());
        $path = $this->_root_dir . '/goods/' . $Y . '/' . $m . '/' . $d . '/';
        if (!file_exists($path)) {
            mkdir($path, 0755, true);
        }
        $fp2 = @fopen($path . $filename, "a");
        fwrite($fp2, $img); // 向当前目录写入图片文件，并重新命名
        fclose($fp2);
        return 'goods/' . $Y . '/' . $m . '/' . $d . '/' . $filename;
    }

    /**
     * 采集商品分类以及店铺分类
     * @param int $goods_parent_id 商品父类 默认顶级为0
     * @param int $store_parent_id 店铺父类 默认顶级为0
     * @param int $store_id 店铺ID
     * @return $list 二维数组
     */
    public function get_all_cate($goods_parent_id = 0, $store_parent_id = 0, $store_id = 0)
    {
        $g_p_id = intval($goods_parent_id);
        $s_p_id = intval($store_parent_id);
        $s_id = intval($store_id);
        if ($s_id == 0) {
            $sql = "SELECT * FROM(`shop_gcategory`) WHERE `store_id`=0 AND `parent_id`=$g_p_id ORDER BY `sort_order` ASC";
            $query = mysql_query($sql);
            $list = array();
            while ($row = mysql_fetch_assoc($query)) {
                $list[] = $row;
            }
            $json = json_encode($list);
            return $json;
        } else {
            $sql = "SELECT * FROM(`shop_gcategory`) WHERE `store_id`=$s_id AND `if_show`=1 AND `parent_id`=$s_p_id ORDER BY `sort_order` ASC";
            $query = mysql_query($sql);
            $list = array();
            while ($row = mysql_fetch_assoc($query)) {
                $list[] = $row;
            }
            $json = json_encode($list);
            return $json;
        }
    }


    //根据store_id查询商家的商品
    public function store_goods($store_id)
    {
        $s_id = intval($store_id);
        $is_del = 0;
        $sql = "SELECT `goods_id`,`goods_name`,`price`,`cost_price` FROM(`shop_goods`) WHERE `store_id`=$s_id AND `is_del`=" . $is_del . " order by goods_id desc";
        $query = mysql_query($sql);
        $list = array();
        while ($row = mysql_fetch_assoc($query)) {
            $list[] = $row;
        }
        if (count($list) > 0) {
            $json = json_encode($list);
            return $json;
        } else {
            return json_encode("no");
        }
    }

    //根据store_id查询商家的商品
    public function store_cate($store_id)
    {
        $store_id = intval($store_id);
        $sql = 'SELECT b.cate_id,b.cate_name FROM shop_store a,shop_gcategory b WHERE a.cate_id=b.cate_id AND a.store_id='.$store_id;
        $query = mysql_query($sql);
        $list = array();
        while ($row = mysql_fetch_assoc($query)) {
            $list[] = $row;
        }
        if (count($list) > 0) {
            $json = json_encode($list);
            return $json;
        } else {
            return json_encode("no");
        }
    }


    //批量修改商品价格
    public function update_spec($goods_id, $price)
    {
        $g_id = intval($goods_id);
        $res = $this->update('shop_goods_sku', "goods_id=$g_id", array('price' => $price));
        if ($res) {
            $result = $this->update('shop_goods', "goods_id=$g_id", array('price' => $price));
            if ($result) {
                return 1;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    //查询已上架/下架的商品
    public function goods_show($user_id, $status)
    {
        $u_id = intval($user_id);
        $if_show = intval($status);
        $sql = 'SELECT DISTINCT `goods_name`,goods_id,`if_show`,`add_time` FROM `shop_goods` WHERE store_id=' . $u_id . ' AND if_show=' . $if_show . ' AND is_del=0 ORDER BY add_time DESC';
        $query = mysql_query($sql);
        $list = array();
        while ($row = mysql_fetch_assoc($query)) {
            $list[] = $row;
        }
        if (count($list) > 0) {
            $json = json_encode($list);
            return $json;
        } else {
            return json_encode("no");
        }
    }

    //修改上架/下架状态
    public function update_show($user_id, $goods_id, $if_show)
    {
        $u_id = intval($user_id);
        $g_id = intval($goods_id);
        $sql = 'UPDATE `shop_goods` SET `if_show`=' . $if_show . ' WHERE `store_id`=' . $u_id . ' AND `goods_id`=' . $g_id;
        $query = mysql_query($sql);
        if ($query) {
            return 1;
        } else {
            return 0;
        }
    }

    //根据ID查询会员是否存在
    public function get_user($user_id)
    {
        $u_id = intval($user_id);
        $sql = "SELECT `user_id`,`user_name` FROM(`shop_member`) WHERE `user_id`=$u_id";
        $query = mysql_query($sql);
        $row = mysql_fetch_assoc($query);
        if ($row != '') {
            $data = array('0' => array('user_id' => $row['user_id'], 'user_name' => $row['user_name']));
            return json_encode($data);
        } else {
            return 0;
        }
    }

    //查询店铺是否关闭,是否审核通过
    public function select_store($user_id)
    {
        $sql = "SELECT `store_id` FROM(`shop_store`) WHERE `store_id`=$user_id and status=1";
        $query = mysql_query($sql);
        $row = mysql_fetch_array($query);
        return $row['store_id'];
    }

    //增加一条语句的封装函数
    private function insert($table, $data)
    {
        $str_key = '';
        $str_val = '';
        foreach ($data as $key => $val) {
            $str_key .= '`' . $key . '`,';
            $str_val .= "'" . $val . "',";
        }
        $str_k = substr($str_key, 0, -1);
        $str_v = substr($str_val, 0, -1);
        $sql = "insert into `$table` ($str_k) values($str_v)";
        mysql_query($sql);
        return mysql_insert_id();
    }

    //修改一条语句的封装函数
    private function update($table, $where, $data)
    {
        $str_set = '';
        foreach ($data as $key => $val) {
            $str_set .= "`" . $key . "`='" . $val . "',";
        }
        $str = substr($str_set, 0, -1);
        $sql = "update `$table` set $str where $where";
        $query = mysql_query($sql);
        return $query;
    }


    //修改一条语句的封装函数
    private function update_trys($table, $where, $data)
    {
        $str_set = '';
        foreach ($data as $key => $val) {
            $str_set .= "`" . $key . "`='" . $val . "',";
        }
        $str = substr($str_set, 0, -1);
        $sql = "update `$table` set $str where $where";
        mysql_query($sql);
        return mysql_affected_rows();
    }

    /*
      $length  int 生成字符传的长度
      $numeric  int  ,$numeric = 0 随机数则是 大小写字符+ 数字... $numeric = 1 则为纯数字
     */

    private function random($length, $numeric = 0)
    {
        PHP_VERSION < '4.2.0' ? mt_srand((double)microtime() * 1000000) : mt_srand();
        $seed = base_convert(md5(print_r($_SERVER, 1) . microtime()), 16, $numeric ? 10 : 35);
        $seed = $numeric ? (str_replace('0', '', $seed) . '012340567890') : ($seed . 'zZ' . strtoupper($seed));
        $hash = '';
        $max = strlen($seed) - 1;
        for ($i = 0; $i < $length; $i++) {
            $hash .= $seed [mt_rand(0, $max)];
        }
        return $hash;
    }

    //查询版本号，自动更新用到
    public function version($version)
    {
        $sql = "SELECT `version` FROM(`shop_common_content`) WHERE `key`=3";
        $query = mysql_query($sql);
        $row = mysql_fetch_row($query);
        if (empty($row[0])) {
            return 2;
        }
        if ($row[0] != $version) {
            return $row[0];
        } else {
            return 0;
        }

    }
}
