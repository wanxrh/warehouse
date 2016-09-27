<?php

/*
 * 用户基础类
 */

class App_Controller extends CI_Controller
{
    /**
     * @var android客户端类型
     */
    const CLIENT_TYPE_ANDROID = 1;
    /**
     * @var ios客户端类型
     */
    const CLIENT_TYPE_IOS = 2;
    /**
     * 用户id
     * @var int
     */
    protected $uid;

    /**
     * 用户名
     * @var string
     */
    protected $uname;

    /**
     * 用户信息
     * @var array
     */
    protected $user;

    function __construct()
    {
        parent::__construct();
        SIGN_DEBUG && $this->check_version();
    }

    /**
     * APP接口失败返回
     * @param int $code 错误编码
     * @param string $msg 描述
     * @param null $data 数据
     * @param bool $output 终端程序，默认中断
     * @return string
     */
    protected function failure($code = 0, $msg = '', $data = null, $output = true)
    {
        $ret = array(
            'code' => 300 + intval($code),
            'msg' => $msg
        );
        $data !== NULL && ($ret ['data'] = $data);
        $json_str = json_encode($ret);

        if ($output) {
            die ($json_str);
        } else {
            return $json_str;
        }
    }

    /**
     * APP接口成功返回
     * @param int $code 成功编码
     * @param string $msg 描述
     * @param null $data 数据
     * @param bool $output 终端程序，默认中断
     * @return string
     */
    protected function success($code = 0, $msg = '', $data = null, $output = true)
    {
        $ret = array(
            'code' => 200 + intval($code),
            'msg' => $msg
        );
        $data !== NULL && ($ret ['data'] = $data);
        $json_str = json_encode($ret);

        if ($output) {
            die ($json_str);
        } else {
            return $json_str;
        }
    }

    /**
     * 检验用户ID
     * @param null $uid 用户编号
     * @param null $sign 登陆加密标示
     * @param bool $if_cache 是否先查询缓存，默认查询
     * @param bool $check_status 是否验证账号状态，默认验证
     * @return array|bool|null
     * @author 王立
     */
    protected function check_user($uid = null, $sign = null, $if_cache = true, $check_status = true)
    {
        if (!$uid) {
            $uid = $this->get_uint('uid');
        }
        $user = NULL;
        if ($if_cache) {
            $user = cache_user($uid);
        } else {
            $user = cache_user($uid, false);
        }
        $user || $this->failure(USER_UNDEFINE, '用户不存在');
        $this->user = $user;
        $this->uid = $user['id'];
        $this->uname = $user['name'];
        if ($check_status) {
            //众宝贝用户状态 zbb_lock 0：正常 1：封号
            $this->user['zbb_lock'] == 1 and $this->failure(USER_BANED, '账号已被封号');
            //UC库 0.正常;1.已锁定;2.未激活;3.未激活(作废);4.已屏蔽;5.屏蔽待处理
            $this->user['uc_lock'] == 1 and $this->failure(USER_BANED, '账号已被封号!');
            $this->user['uc_lock'] == 2 and $this->failure(USER_UNACTIVATE, '账号未激活!');
            $this->user['uc_lock'] == 3 and $this->failure(USER_UNACTIVATE, '账号未激活');
            $this->user['uc_lock'] == 4 and $this->failure(USER_SHIELD, '账号已屏蔽!');
            $this->user['uc_lock'] == 5 and $this->failure(USER_SHIELDING, '账号已屏蔽待处理!');
        }
        if (SIGN_DEBUG) {
            if ($sign == NULL) {
                $sign = $this->get_string('sign');
            }
            if (!$user['login_sign']) {
                $this->failure(UNDEFINED_LOGIN_SIGN, '账号签名不匹配');
            }
            if ($sign != $user['login_sign']) {
                $this->failure(ERROR_LOGIN_SIGN, '账号签名不匹配');
            }
        }
        return $user;
    }

    /**
     * 检测版请求版本号
     */
    protected function check_version()
    {
        // 获取客户端类型
        $client_type = $this->get_uint('client_type');

        if (!in_array($client_type, array(self::CLIENT_TYPE_ANDROID, self::CLIENT_TYPE_IOS))) {
            $this->failure(57, '不支持客户端类型：' . $client_type);
        }

        $this->load->model('app_sys_model');
        //获取系统设置的最高最低版本
        $min_version = $this->app_sys_model->get_app_min_version($client_type);
        $max_version = $this->app_sys_model->get_app_max_version($client_type);
        //获取版本号
        $version = $this->get_string('version');
        //检测旧的版本号存不存在
        if (!empty($version)) {
            $this->failure(58, '客户端版本号过低', array('version' => $min_version['version'], 'version_url' => $min_version['version_url']));
        }
        //客户端版本数组
        $version_arr = explode('.', $version);
        if (count($version_arr) != 3) {
            $this->failure(58, '客户端版本号过低', array('version' => $min_version['version'], 'version_url' => $min_version['version_url']));
        }

        //对应的是 大版本号 小版本号 修改号
        $version_arr_1 = $version_arr[0];
        $version_arr_2 = $version_arr[1];
        $version_arr_3 = $version_arr[2];

        $min_version_arr = $this->check_version_rules($min_version);
        $max_version_arr = $this->check_version_rules($max_version);
        //对比最低版本
        if (($min_version_arr[0] > $version_arr_1)) {
            $this->failure(58, '客户端版本号过低', array('version' => $min_version['version'], 'version_url' => $min_version['version_url']));
        }
        if (($version_arr_1 == $min_version_arr[0]) && ($min_version_arr[1] > $version_arr_2)) {
            $this->failure(58, '客户端版本号过低', array('version' => $min_version['version'], 'version_url' => $min_version['version_url']));
        }
        if (($version_arr_1 == $min_version_arr[0]) && ($min_version_arr[1] == $version_arr_2) && ($min_version_arr[2] > $version_arr_3)) {
            $this->failure(58, '客户端版本号过低', array('version' => $min_version['version'], 'version_url' => $min_version['version_url']));
        }
        //比对最高版本
        if (($max_version_arr[0] < $version_arr_1)) {
            $this->failure(59, '客户端版本号大于最大版本号', array('version' => $max_version['version'], 'version_url' => $max_version['version_url']));
        }
        if (($version_arr_1 == $max_version_arr[0]) && ($max_version_arr[1] < $version_arr_2)) {
            $this->failure(59, '客户端版本号大于最大版本号', array('version' => $max_version['version'], 'version_url' => $max_version['version_url']));
        }
        if (($version_arr_1 == $max_version_arr[0]) && ($max_version_arr[1] == $version_arr_2) && ($max_version_arr[2] < $version_arr_3)) {
            $this->failure(59, '客户端版本号大于最大版本号', array('version' => $max_version['version'], 'version_url' => $max_version['version_url']));
        }
    }

    /**
     * 改进的Input类get_post方法
     *
     * @param string $key :索引键值
     * @param boolean $xss_clean :XSS清除（默认FALSE）
     * @return string
     * @author 王立
     */
    protected function get_post($key, $xss_clean = false)
    {
        $val = $this->input->get_post($key, $xss_clean);
        if (false === $val) {
            $this->failure(0, '请求缺少参数:' . $key);
        }
        return $val;
    }

    /**
     * 获取请求参数为string的值
     * @param string $key :索引键值
     * @param boolean $xss_clean :XSS清除（默认FALSE）
     * @return string
     * @author 王立
     */
    protected function get_string($key, $xss_clean = false)
    {
        $val = $this->get_post($key, $xss_clean);
        if (!$val) {
            $this->failure(0, '参数未传值:' . $key);
        }
        $val = trim($val);
        return $val;
    }

    /**
     * 获取请求参数为int的值
     * @param string $key :索引键值
     * @param boolean $xss_clean :XSS清除（默认FALSE）
     * @return int
     * @author 王立
     */
    protected function get_int($key, $xss_clean = false)
    {
        $val = $this->get_post($key, $xss_clean);
        if ($val === false || !is_numeric($val)) {
            if (empty($val)) {
                $this->failure(0, '参数值不能为空:' . $key);
            }
            if (is_string($val)) {
                $this->failure(0, '参数传入了字符串:' . $key . '=' . $val);
            }
            $this->failure(0, '参数未传值:' . $key);
        }

        $val = intval($val);
        return $val;
    }

    /**
     * 获取请求参数为uint的值
     * @param string $key :索引键值
     * @param boolean $xss_clean :XSS清除（默认FALSE）
     * @return uint
     * @author 王立
     */
    protected function get_uint($key, $xss_clean = false)
    {
        $val = $this->get_int($key, $xss_clean);
        if ($val <= 0) {
            $this->failure(0, '参数不允许为非正整数:' . $key);
        }
        return $val;
    }

    /**
     *  获取请求参数为有符号浮点数的值
     * @param string $key :索引键值
     * @param boolean $xss_clean :XSS清除（默认FALSE）
     * @return float
     * @author 王立
     */
    protected function get_floatvalt($key, $xss_clean = false)
    {
        $val = $this->get_post($key, $xss_clean);
        if ($val === FALSE || !is_numeric($val)) {
            if (empty($val)) {
                $this->failure(0, '参数值不能为空:' . $key);
            }
            if (is_string($val)) {
                $this->failure(0, '参数传入了字符串:' . $key . '=' . $val);
            }
            $this->failure(0, '参数未传值:' . $key);
        }

        $val = floatval($val);
        return $val;
    }

    /**
     * 获取请求参数为无符号浮点数的值
     * @param string $key :索引键值
     * @param boolean $xss_clean :XSS清除（默认FALSE）
     * @return float
     * @author 王立
     */
    protected function get_ufloat($key, $xss_clean = false)
    {
        $val = $this->get_floatvalt($key, $xss_clean);
        if ($val < 0) {
            $this->failure(0, '参数不允许为负数:' . $key);
        }
        return $val;
    }

    /**
     * 检测版本号是否填写正确
     * @param $version
     * @return array
     * @author 王立
     */
    private function check_version_rules($version)
    {
        $version_arr = explode('.', $version);
        if (!is_numeric($version_arr[0])) {
            $this->failure(54, '大版本号必须填写数字');
        }
        if (!is_numeric($version_arr[1])) {
            $this->failure(55, '小版本号必须填写数字');
        }
        if (!is_numeric($version_arr[2])) {
            $this->failure(56, '修改版本号必须填写数字');
        }
        if (count($version_arr) != 3) {
            $this->failure(50, '系统设置最低版本号长度不对');
        }
        if (0 > $version_arr[0] || $version_arr[0] > 9999) {
            $this->failure(51, '大版本号范围在0~9999之间');
        }
        if (0 > $version_arr[1] || $version_arr[1] > 9999) {
            $this->failure(52, '小版本号范围在0~9999之间');
        }
        if (0 > $version_arr[2] || $version_arr[2] > 9999) {
            $this->failure(53, '修改版本号范围在0~9999之间');
        }
        return $version_arr;
    }

    /**
     * 单文件上传方法
     * @param $img 上传文件
     * @param string $size 大小
     * @param string $path 报错路径
     * @return mixed
     * @author 王立
     */
    protected function appUpload($img, $size = '', $path = '')
    {
        $this->load->library('uploader');
        $file = $_FILES[$img];

        if ($file['error'] != UPLOAD_ERR_OK || $file == '') {
            $this->failure(0, '上传文件为空');
        }
        if (!$path) {
            $path = $img . '/' . date('Y', time()) . '/' . date('m', time()) . '/' . date('d', time());
        }
        $this->uploader->allowed_size($size ? $size : config_item('_allowed_file_size'));
        $this->uploader->addFile($file);
        if ($this->uploader->file_info() === false) {
            $this->failure(0, $this->uploader->get_error());
        }
        return $this->uploader->save($path);
    }
}
