<?php

function get_user($uid = NULL)
{
    $ci = &get_instance();
    // 读取当前登录用户
    if (!$uid) {
        $cookie = isset($_COOKIE [COOKIE_NAME]) ? $_COOKIE [COOKIE_NAME] : '';
        if (!$cookie) {
            return FALSE;
        }
        $cookie = explode('|', $cookie);
        $ci->load->library('crypt', array(
            'key' => KEY_COOKIE_CRYPT,
            'iv' => KEY_COOKIE_CRYPT_IV
        ));
        $cookie [1] = str_replace(' ', '+', $cookie [1]);
        if ($auth = $ci->crypt->decode($cookie [1])) {
            $auths = explode('|', $auth);
            $uid = $auths [0];
        } else {
            return FALSE;
        }
        //获取cahche值
        $uid = intval($uid);
        $cache_key_uid = 'zbb_user_info_' . $uid;
        $user_id = cache($cache_key_uid);
        if (!$user_id) {
            return FALSE;
        }
        return $user_id;
    }
}


/**
 * 获取管理员id
 */
function get_admin($uname = NULL, $uid = NULL)
{
    $ci = &get_instance();
    // 读取当前登录用户
    if (!$uid) {
        $cookie = isset($_COOKIE ['nzsys_c']) ? $_COOKIE ['nzsys_c'] : '';
        if (!$cookie) {
            return FALSE;
        }
        $cookie = explode('|', $cookie);
        $ci->load->library('crypt', array(
            'key' => KEY_COOKIE_CRYPT,
            'iv' => KEY_COOKIE_CRYPT_IV
        ));
        if ($auth = $ci->crypt->decode($cookie [0])) {
            $auths = explode('|', $auth);
            if (!$uname) {
                return $result = $auths [1];
            } else {
                return $result = $auths [0];
            }
        } else {
            return FALSE;
        }
    }
}

/**
 * 获取couchbase操作类
 *
 * @return object
 */
function get_couchbase()
{
    static $_cb = NULL;
    if ($_cb === NULL) {
        $CI = &get_instance();
        $CI->config->load('memcached', TRUE, TRUE) or show_error("缺少memcached配置文件！");
        $memcache = new Memcache;
        $memcache->connect($CI->config->config ['memcached']['default']['hostname'], $CI->config->config ['memcached']['default'] ['port']) or die ("Could not connect"); //连接Memcached服务器
    }

    return $memcache;
}

/**
 * 全局缓存方法 - 使用couchbase缓存
 *
 * @param $key 缓存key值
 * @param $data 默认为NULL，表示读取；若为FALSE，表示删除；其它表示设置缓存
 * @param $expire 缓存时间。单位：秒，默认1800秒，若为0则表示永久保存。
 */
function cache($key, $data = NULL, $expire = 43200)
{
    static $_cache = NULL;
    if ($_cache === NULL) {
        $_cache = get_couchbase();
    }

    if ($data === NULL) {
        return $_cache->get($key);
    }

    if ($data === FALSE) {
        return $_cache->delete($key);
    }

    return $_cache->set($key, $data, false, $expire);
}

/**
 * 判断是否为ajax请求，常用于判断请求类型，输出不同类型的结果
 *
 * @return boolean
 */
function is_ajax()
{
    static $_ret = NULL;
    if ($_ret === NULL) {
        $_ret = isset($_SERVER ['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER ['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
    }
    return $_ret;
}

/**
 * ajax返回：成功
 *
 * @param $data 成功信息
 * @return void 输出并终止执行
 */
function ajax_success($data = NULL)
{
    $ret = array(
        'success' => TRUE
    );
    if ($data !== NULL)
        $ret ['data'] = $data;
    die(json_encode($ret));
}


/**
 * ajax返回：错误
 *
 * @param $data 错误信息
 * @return void 输出并终止执行
 */
function ajax_error($data = NULL)
{
    $ret = array(
        'success' => FALSE
    );
    if ($data !== NULL)
        $ret ['data'] = $data;
    die(json_encode($ret));
}


/**
 * 获取IP地址
 */
function ip()
{
    $ip = $_SERVER['REMOTE_ADDR'];
    if (isset($_SERVER['HTTP_CLIENT_IP']) && preg_match('/^([0-9]{1,3}\.){3}[0-9]{1,3}$/', $_SERVER['HTTP_CLIENT_IP'])) {
        $ip = $_SERVER['HTTP_CLIENT_IP'];
    } elseif (isset($_SERVER['HTTP_X_FORWARDED_FOR']) AND preg_match_all('#\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}#s', $_SERVER['HTTP_X_FORWARDED_FOR'], $matches)) {
        foreach ($matches[0] AS $xip) {
            if (!preg_match('#^(10|172\.16|192\.168)\.#', $xip)) {
                $ip = $xip;
                break;
            }
        }
    }
    return bindec(decbin(ip2long($ip)));
}

/**
 *  获取COOKIE的值
 *
 * @access public
 * @param  string $key 为空时将返回所有COOKIE
 * @return mixed
 */
function nzw_getcookie($key = '')
{
    return isset($_COOKIE[$key]) ? $_COOKIE[$key] : 0;
}

function goods_url($good_id)
{
    $CI = &get_instance();
    return $CI->config->item('domain_www') . "item-" . $good_id . ".html";
}

function img_url($url)
{
    $CI = &get_instance();
    return $CI->config->item('domain_img') . $url;
}

/**
 * 操作成功或失败辅助函数
 * @param $url 成功或失败之后跳转的路径
 * @param $word 提示文字
 * 返回字符串
 */
function get_redirect($word, $url)
{
    echo '<script>alert("' . $word . '");window.location.href="' . $url . '";</script>';
}

function nzw_mkdir($absolute_path, $mode = 0755)
{
    if (is_dir($absolute_path)) {
        return true;
    }

    $root_path = SRCPATH;
    $relative_path = str_replace($root_path, '', $absolute_path);
    $each_path = explode('/', $relative_path);
    $cur_path = $root_path; // 当前循环处理的路径
    foreach ($each_path as $path) {
        if ($path) {
            $cur_path = $cur_path . '/' . $path;
            if (!is_dir($cur_path)) {
                if (@mkdir($cur_path, $mode)) {
                    fclose(fopen($cur_path . '/index.htm', 'w'));
                } else {
                    return false;
                }
            }
        }
    }

    return true;
}

/* 价格过滤，返回非负浮点数 */

function filter_price($price)
{
    return abs(floatval($price));
}

/**
 * 利用gd库生成缩略图
 *
 * @author  weberliu
 * @param   string $src 原图片路径
 * @param   string $dst 缩略图保存路径
 * @param   int $thumb_width 缩略图高度
 * @param   int $thumb_height 缩略图高度 可选
 * @param   int $quality 缩略图品质 100之内的正整数
 * @return  boolean     成功返回 true 失败返回 false
 */
function make_thumb($src, $dst, $thumb_width, $thumb_height = 0, $quality = 85)
{
    if (function_exists('imagejpeg')) {
        $func_imagecreate = function_exists('imagecreatetruecolor') ? 'imagecreatetruecolor' : 'imagecreate';
        $func_imagecopy = function_exists('imagecopyresampled') ? 'imagecopyresampled' : 'imagecopyresized';
        $dirpath = dirname($dst);
        if (!ecm_mkdir($dirpath, 0777)) {
            return false;
        }

        $data = getimagesize($src);
        $src_width = $data[0];
        $src_height = $data[1];
        if ($thumb_height == 0) {
            if ($src_width > $src_height) {
                $thumb_height = $src_height * $thumb_width / $src_width;
            } else {
                $thumb_height = $thumb_width;
                $thumb_width = $src_width * $thumb_height / $src_height;
            }
            $dst_x = 0;
            $dst_y = 0;
            $dst_w = $thumb_width;
            $dst_h = $thumb_height;
        } else {
            if ($src_width / $src_height > $thumb_width / $thumb_height) {
                $dst_w = $thumb_width;
                $dst_h = ($dst_w * $src_height) / $src_width;
                $dst_x = 0;
                $dst_y = ($thumb_height - $dst_h) / 2;
            } else {
                $dst_h = $thumb_height;
                $dst_w = ($src_width * $dst_h) / $src_height;
                $dst_y = 0;
                $dst_x = ($thumb_width - $dst_w) / 2;
            }
        }

        switch ($data[2]) {
            case 1:
                $im = imagecreatefromgif($src);
                break;
            case 2:
                $im = imagecreatefromjpeg($src);
                break;
            case 3:
                $im = imagecreatefrompng($src);
                break;
            default:
                trigger_error("Cannot process this picture format: " . $data['mime']);
                break;
        }
        $ni = $func_imagecreate($thumb_width, $thumb_height);
        if ($func_imagecreate == 'imagecreatetruecolor') {
            imagefill($ni, 0, 0, imagecolorallocate($ni, 255, 255, 255));
        } else {
            imagecolorallocate($ni, 255, 255, 255);
        }
        $func_imagecopy($ni, $im, $dst_x, $dst_y, 0, 0, $dst_w, $dst_h, $src_width, $src_height);
        imagejpeg($ni, $dst, $quality);
        return is_file($dst) ? $dst : false;
    } else {
        trigger_error("Unable to process picture.", E_USER_ERROR);
    }
}

/**
 * 给图片添加水印
 * @param filepath $src 待处理图片
 * @param filepath $mark_img 水印图片路径
 * @param string $position 水印位置 lt左上  rt右上  rb右下  lb左下 其余取值为中间
 * @param int $quality jpg图片质量，仅对jpg有效 默认85 取值 0-100之间整数
 * @param int $pct 水印图片融合度(透明度)
 *
 * @return void
 */
function water_mark($src, $mark_img, $position = 'rb', $quality = 85, $pct = 80)
{
    if (function_exists('imagecopy') && function_exists('imagecopymerge')) {
        $data = getimagesize($src);
        if ($data[2] > 3) {
            return false;
        }
        $src_width = $data[0];
        $src_height = $data[1];
        $src_type = $data[2];

        $data = getimagesize($mark_img);
        $mark_width = $data[0];
        $mark_height = $data[1];
        $mark_type = $data[2];

        if ($src_width < ($mark_width + 20) || $src_width < ($mark_height + 20)) {
            return false;
        }
        switch ($src_type) {
            case 1:
                $src_im = imagecreatefromgif($src);
                $imagefunc = function_exists('imagejpeg') ? 'imagejpeg' : '';
                break;
            case 2:
                $src_im = imagecreatefromjpeg($src);
                $imagefunc = function_exists('imagegif') ? 'imagejpeg' : '';
                break;
            case 3:
                $src_im = imagecreatefrompng($src);
                $imagefunc = function_exists('imagepng') ? 'imagejpeg' : '';
                break;
        }
        switch ($mark_type) {
            case 1:
                $mark_im = imagecreatefromgif($mark_img);
                break;
            case 2:
                $mark_im = imagecreatefromjpeg($mark_img);
                break;
            case 3:
                $mark_im = imagecreatefrompng($mark_img);
                break;
        }

        switch ($position) {
            case 'lt':
                $x = 10;
                $y = 10;
                break;
            case 'rt':
                $x = $src_width - $mark_width - 10;
                $y = 10;
                break;
            case 'rb':
                $x = $src_width - $mark_width - 10;
                $y = $src_height - $mark_height - 10;
                break;
            case 'lb':
                $x = 10;
                $y = $src_height - $mark_height - 10;
                break;
            default:
                $x = ($src_width - $mark_width - 10) / 2;
                $y = ($src_height - $mark_height - 10) / 2;
                break;
        }

        if (function_exists('imagealphablending'))
            imageAlphaBlending($mark_im, true);
        imageCopyMerge($src_im, $mark_im, $x, $y, 0, 0, $mark_width, $mark_height, $pct);

        if ($src_type == 2) {
            $imagefunc($src_im, $src, $quality);
        } else {
            $imagefunc($dst_photo, $src);
        }
    }
}


//物流列表
function get_ship()
{
    return array(
        '顺丰速递' => 'shunfeng',
        '申通速递' => 'shentong',
        '圆通速递' => 'yuantong',
        '天天快递' => 'tiantian',
        '韵达快递' => 'yunda',
        '百世汇通' => 'huitong',
        '中通快递' => 'zhongtong',
        'EMS速递' => 'ems',
        '宅急送' => 'zjs',
        '全峰快递' => 'quanfeng',
        '城市100' => 'cs',
        '快捷快递' => 'kuaijie',
        '优速快递' => 'yousu',
        '国通快递' => 'guotong',
    );
}

//根据拼音查询快递英文名称
function get_ship_en($key)
{
    $ship_list = get_ship();
    return $ship_list[$key];
}

//幸好替换
function star_replace($str)
{
    $len = mb_strlen($str, 'utf-8');
    $str1 = mb_substr($str, 0, 1, 'utf-8');
    $str2 = mb_substr($str, $len - 1, 1, 'utf-8');
    return $str1 . '***' . $str2;
}

//制作缩略图流程
function get_thumb($src, $width, $height, $size)
{
    $CI = &get_instance();
    $dirname = dirname($src);
    $basename = 'thumb_' . $width . 'x' . $height . '_' . basename($src);
    $path = $dirname . '/' . $basename;

    if (file_exists($CI->config->item('_root_dir') . '/' . $path)) {

        if (filesize($CI->config->item('_root_dir') . '/' . $path) < $size) {
            return re_thumb($CI, $src, $width, $height, $path);
        } else {
            return img_url($path);
        }
    } else {
        if (!file_exists($CI->config->item('_root_dir') . '/' . $src)) {
            return img_url('data/files/goods_image/' . $width . 'x' . $height . '.jpg');
        }
        return re_thumb($CI, $src, $width, $height, $path);
    }
}

//生成缩略图
function re_thumb($CI, $src, $width, $height, $path)
{
    $big_img = $CI->config->item('_root_dir') . '/' . $src;
    $imgage = @getimagesize($big_img); //得到原始大图片

    switch ($imgage[2]) { // 图像类型判断
        case 1:
            $im = imagecreatefromgif($big_img);
            break;
        case 2:
            $im = imagecreatefromjpeg($big_img);
            break;
        case 3:
            $im = imagecreatefrompng($big_img);
            break;
    }
    $src_W = $imgage[0]; //获取大图片宽度
    $src_H = $imgage[1]; //获取大图片高度
    $tn = imagecreatetruecolor($width, $height); //创建缩略图
    imagecopyresampled($tn, $im, 0, 0, 0, 0, $width, $height, $src_W, $src_H); //复制图像并改变大小
    imagejpeg($tn, $CI->config->item('_root_dir') . '/' . $path); //输出图像
    return img_url($path);
}

/**
 * order_id的变一维josn
 */
function encode_order($order_id)
{
    if (!$order_id) {
        return FALSE;
    }
    return base64_encode(json_encode(array($order_id), TRUE));
}

/**
 * 字符串过滤
 * @param str $str
 * @param  $lower FALSE 强制转化小写，TRUE 区分大小写
 * @return str
 */
function filter_sql($str, $lower = FALSE)
{
    if (!$lower) {
        $str = strtolower($str);
    }
    $str = str_replace("and", "", $str);
    $str = str_replace("execute", "", $str);
    $str = str_replace("update", "", $str);
    $str = str_replace("count", "", $str);
    $str = str_replace("chr", "", $str);
    $str = str_replace("mid", "", $str);
    $str = str_replace("master", "", $str);
    $str = str_replace("truncate", "", $str);
    $str = str_replace("char", "", $str);
    $str = str_replace("declare", "", $str);
    $str = str_replace("select", "", $str);
    $str = str_replace("create", "", $str);
    $str = str_replace("delete", "", $str);
    $str = str_replace("insert", "", $str);
    $str = str_replace("or", "", $str);
    $str = str_replace("=", "", $str);
    $str = str_replace(" ", "", $str);
    return $str;
}

//用户名、邮箱、手机账号中间字符串以*隐藏
function hide_star($str)
{
    if (strpos($str, '@')) {
        $email_array = explode("@", $str);
        $prevfix = (strlen($email_array[0]) < 4) ? "" : substr($str, 0, 3); //邮箱前缀
        $count = 0;
        $str = preg_replace('/([\d\w+_-]{0,100})@/', '***@', $str, -1, $count);
        $rs = $prevfix . $str;
    } else {
        $pattern = '/(1[345789]{1}[0-9])[0-9]{4}([0-9]{2})/i';
        if (preg_match($pattern, $str)) {
            $rs = preg_replace($pattern, '$1****$2', $str);
        } else {
            $rs = substr($str, 0, 4) . "***" . substr($str, -1);
        }
    }
    return $rs;
}

function get_cid_info($cid, $arr)
{
    $data = array();
    foreach ($arr as $val) {
        if ($cid == $val['cid']) {
            $data[] = $val;
        }
    }
    return $data;
}

function order_status_name()
{
    $ret = array(
        ORDER_CANCELED => '已取消',
        ORDER_UNPAY => '待付款',
        ORDER_PAID => '待发货',
        ORDER_SHIPPED => '待收货',
        ORDER_FINISHED => '已完成'
    );
    return $ret;
}

function order_goods_status_name()
{
    $ret = array(
        ORDER_GOODS_CANCELED => '已取消',
        ORDER_GOODS_UNPAY => '待付款',
        ORDER_GOODS_PAID => '待发货',
        ORDER_GOODS_SHIPPED => '待收货',
        ORDER_GOODS_FINISHED => '已完成',
        ORDER_GOODS_DRAWBACK => '退款中',
        ORDER_GOODS_DRAWBACKED => '退款成功',
        ORDER_GOODS_RETURNING => '退货中',
        ORDER_GOODS_RETURNED => '退货成功',
    );
    return $ret;
}

/*
 *售后状态对应
 */
function get_aftermarket_status()
{
    $ret = array(
        AFTERMARKET_HANDLE => '等待卖家处理',
        AFTERMARKET_AGREE => '卖家同意',
        AFTERMARKET_REFUSE => '卖家拒绝申请',
        AFTERMARKET_GOODS_RETURNING=>'买家退回商品',
        AFTERMARKET_REFUSE_RETURN => '卖家拒绝退货',
        AFTERMARKET_INTERVENE => '申请客服介入',
        AFTERMARKET_SUCCESS => '退款成功',
        AFTERMARKET_CLOSE => '退款关闭'
    );
    return $ret;
}