<?php

/**
 * 用户模型
 */
class User_model extends CI_Model
{

    public $error = NULL;

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct()
    {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
        $this->uc_db = $this->load->database('uc', TRUE);
    }

    /**
     * 定义错误返回
     *
     * @param $code 编号
     * @param $data 数据
     * @return bool
     * @author 王立
     */
    protected function _error($code, $data)
    {
        $this->error = array(
            'code' => $code,
            'data' => $data
        );
        return false;
    }

    /**
     * uc库用户密码加密方式
     * @param $clear 明文
     * @param $salt 盐
     * @return string 密文
     * @author 王立
     */
    public function encrypt_password($clear, $salt)
    {
        return strtolower(md5(strtolower(md5($clear) . $salt)));
    }

    /**
     * 通用登陆方法
     * @param $account 账号
     * @param $password 密码明文
     * @param int $uTypeid 允许联盟/划算用户类型登录 0不限制 1允许买家 2允许商家
     * @return array
     * @author 王立
     */
    public function login($account, $password, $uTypeid = 0)
    {
        // 判断登录类型
        if (preg_match('/^[^_][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/', $account)) {
            $column_uc = 'email';
        } else if (preg_match('/^([1][3|4|5|8][0-9]{9}){1}$/', $account)) {
            $column_uc = 'mobile';
        } else {
            $column_uc = 'username';
        }
        $uc_db = $this->load->database('uc', TRUE);
        $uc_user = $uc_db->where($column_uc, $account)->get('members')->row_array();
        if (!$uc_user) {
            return $this->_error(USER_UNDEFINE, '用户不存在');
        }
        if ($uc_user['password'] != $this->encrypt_password($password, $uc_user['salt'])) {
            return $this->_error(PASSWORD_ERROR, '密码错误');
        }
        if ($uTypeid) {
            $uc_user['uTypeid'] != $uTypeid && $this->_error($uTypeid == 1 ? BUYER_USER_UNDEFINE : SELLER_USER_UNDEFINE, $uTypeid == 1 ? '买家账号不存在' : '商家账号不存在');
        }
        if ($uc_user['isLock']) {
            //UC库 0.正常;1.已锁定;2.未激活;3.未激活(作废);4.已屏蔽;5.屏蔽待处理
            $uc_user['isLock'] == 1 and $this->_error(USER_BANED, '账号已被封号!');
            $uc_user['isLock'] == 2 and $this->_error(USER_UNACTIVATE, '账号未激活!');
            $uc_user['isLock'] == 3 and $this->_error(USER_UNACTIVATE, '账号未激活');
            $uc_user['isLock'] == 4 and $this->_error(USER_SHIELD, '账号已屏蔽!');
            $uc_user['isLock'] == 5 and $this->_error(USER_SHIELDING, '账号已屏蔽待处理!');
            return false;
        }
        $db = $this->load->database('zbb', TRUE);
        $user = $db->where('user_id', $uc_user['uid'])->get('member')->row_array();
        if (!$user) {
            //用户不存在本地用户库，进行同步
            $syn_info['user_id'] = $uc_user['uid'];
            $syn_info['user_name'] = $uc_user['username'];
            $db->insert('member', $syn_info);
            $db->insert('user_stat', array('uid' => $uc_user['uid']));
        } elseif ($user['lock'] == 1) {
            return $this->_error(USER_BANED, '账号已被封号');
        }
        $login_sign = md5($uc_user['uid'] . $uc_user['username'] . time());
        $this->db->where('user_id', $uc_user['uid'])->update('member', array('login_sign' => $login_sign));
        return array(
            'uid' => $uc_user['uid'],
            'uname' => $uc_user['username'],
            'login_sign' => $login_sign,
            'zbb_lock' => $uc_user['isLock'],
            'uc_lock' => $user['lock']
        );
    }

    /**
     * 生成用户缓存
     * @param $user 用户
     * @param $cache_name 缓存键值
     * @param int $chache_time 缓存时间
     * @param bool $cookie 是否设置cookie，默认关闭
     * @author 王立
     */
    public function login_post_action($user, $cache_name, $chache_time = 10800, $cookie = false)
    {
        $cache_value = array(
            'id' => $user['uid'],
            'name' => $user['uname'],
            'uc_lock' => $user['uc_lock'],
            'zbb_lock' => $user['zbb_lock'],
            'login_sign' => $user['login_sign']
        );
        cache($cache_name, $cache_value, $chache_time);
        if ($cookie) {
            $this->_save_cookie($user['uid'], $user['uname'], $chache_time);
        }
    }

    /**
     * 用户注册
     * @param $reg_site 注册站点编号
     * @param $uname 用户名
     * @param $password 密码明文
     * @param $mobile 手机
     * @param int $reg_type 注册来源（本站）
     * @param int $uTypeid 注册账号类型1买家 2商家
     * @return mixed 用户ID
     * @author 王立
     */
    public function add_user($reg_site, $uname, $password, $mobile, $reg_type = 1,$uTypeid = 1)
    {
        $uc_db = $this->load->database('uc', TRUE);
        $salt = $this->_get_salt();
        $uc_user = array(
            'username' => $uname,
            'password' => $this->encrypt_password($password, $salt),
            'regip' => ip(),
            'regdate' => time(),
            'salt' => $salt,
            'VnetPayPswd' => md5($password),
            'uTypeid' => $uTypeid,
            'mobile' => $mobile,
            'reg_source' => $reg_site,
            'mobile_valid' => 1 //手机验证，1验证 0未验证
        );
        $uc_db->insert('members', $uc_user);
        $uid = $uc_db->insert_id();
        if (!$uid)
            $this->_error(REG_FAILURE, '注册失败！');
        $zbb_db = $this->load->database('zbb', TRUE);
        $zbb_user = array(
            'user_id' => $uid,
            'user_name' => $uname,
            'reg_site' => $reg_type,
            'login_sign' => md5($uid . $uname . time())
        );
        $zbb_db->insert('member', $zbb_user);
        return array(
            'uid' => $uid,
            'uname' => $uname,
            'login_sign' => $zbb_user['login_sign'],
            'zbb_lock' => 0,
            'uc_lock' => 0
        );
    }

    /**
     * 设置用户信息cooike
     * @param $uid 用户ID
     * @param $uname 账号
     * @param int $chache_time 缓存时间
     * @return string
     * @author 王立
     */
    public function _save_cookie($uid, $uname, $chache_time = 10800)
    {
        // 保存cookie
        $this->load->library('crypt', array(
            'key' => KEY_COOKIE_CRYPT,
            'iv' => KEY_COOKIE_CRYPT_IV
        ));

        $value = array();
        $value ['userName'] = $uname;
        $value ['auth'] = $this->crypt->encode($uid . '|' . $this->_random(8));
        $cookie = implode('|', $value);

        // 登录的加密信息
        setcookie(COOKIE_NAME, $cookie, time() + $chache_time, '/', $this->config->item('cookie_domain'), NULL, FALSE);
        return $cookie;
    }

    /**
     * 获取同步登录的令牌
     *
     * @return 失败或者未知均返回空
     */
    public function get_login_token()
    {
        $uid = get_user();
        if (!$uid) {
            return 'not_loginff';
        }
        $online_user = $this->uc_db->select('code')->get_where('onlineusers', array(
            'uid' => $uid
        ), 1)->row_array();
        return $online_user ? md5($_SERVER ['HTTP_USER_AGENT'] . ip() . $online_user ['code']) : 'not_online';
    }

    /**
     * 其它系统已登录，需要同步登录站点
     *
     * @param
     *          $uid
     * @param
     *          $token
     */
    public function login_by_token($uid, $token)
    {
        // 验证是否可进行登录
        $online_user = $this->uc_db->select('code')->get_where('onlineusers', array(
            'uid' => $uid
        ), 1)->row_array();
        if (!$online_user) {
            return $this->_error('USER_NOT_FOUND', '此账号尚未登录！');
        }
        if ($token !== md5($_SERVER ['HTTP_USER_AGENT'] . ip() . $online_user ['code'])) {
            return $this->_error('ERROR_TOKEN', '同步登录令牌错误！');
        }

        // 获取最后登录信息
        $user = $this->uc_db->select('username,uTypeid,password,lastloginip,lastlogintime')->where('uid', $uid)->get('members')->row_array();
        if (!$user) {
            return $this->_error('USER_NOT_FOUND', '此账号信息不存在！');
        }
        cache('nzw_' . $uid, $uid);
        // 写入登录cookie
        $this->_save_cookie($uid, $user['username']);

        // 登录处理
        return $user;
    }

    /*
     * 生成随机字符函数
     */

    public function _random($length, $numeric = 0)
    {
        $seed = base_convert(md5(microtime() . $_SERVER ['DOCUMENT_ROOT']), 16, $numeric ? 10 : 35);
        $seed = $numeric ? (str_replace('0', '', $seed) . '012340567890') : ($seed . 'zZ' . strtoupper($seed));
        if ($numeric) {
            $hash = '';
        } else {
            $hash = chr(rand(1, 26) + rand(0, 1) * 32 + 64);
            $length--;
        }
        $max = strlen($seed) - 1;
        for ($i = 0; $i < $length; $i++) {
            $hash .= $seed{mt_rand(0, $max)};
        }
        return $hash;
    }

    /**
     * 获取邮箱是否被注册
     *
     * @param $email string
     * @return bool
     */
    public function check_email_exists($email)
    {
        if (!preg_match('/^[^_][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/', $email)) {
            return $this->_error(EMAIL_ERROR, '邮箱格式错误');
        }
        if ($this->uc_db->where('email', $email)->count_all_results('members') > 0) {
            return $this->_error(EMAIL_EXISTS, '您注册的邮箱已经被注册！');
        }

        return TRUE;
    }

    /**
     * 获取手机号是否被注册
     *
     * @param $mobile string
     * @return bool
     */
    public function check_mobile_exists($mobile)
    {
        if (!preg_match('/^([1][3|4|5|8][0-9]{9}){1}$/', $mobile)) {
            return $this->_error(MOBILE_ERROR, '非正确手机号码');
        }
        if ($this->uc_db->where('mobile', $mobile)->count_all_results('members') > 0) {
            return $this->_error(MOBILE_EXISTS, '您注册的手机号已经被注册！');
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
    public function check_name_exists($name, $type = 1)
    {

        if ($type == 1) {
            if ($this->uc_db->where('username', $name)->count_all_results('members') > 0) {
                return $this->_error(USERNAME_EXISTS, '您注册的用户名已经被注册，请重新更换新的用户名。');
            }

            return TRUE;
        }

        if ($type == 2) {
            if ($this->db->where('nickname', $name)->count_all_results('user') > 0) {
                return $this->_error(NICKNAME_EXISTS, '您注册的昵称已经被注册，请重新更换新的昵称。');
            }

            return TRUE;
        }

    }

    /**
     * 检查名字里面是否含有违禁字
     *
     * @param $uname 用户名
     * @return boolean
     */
    public function checkKeyWord($uname)
    {
        //非法字符串
        $keyword_arr = $this->config->item('key_word');
        if ($keyword_arr) {
            foreach ($keyword_arr as $v) {
                if ($v != '') {
                    $stat = strpos($uname, $v);
                    if ($stat !== FALSE) {
                        return $this->_error(ERROR_KEYWORD, '非法关键字');
                    }
                }
            }
        }

        return TRUE;
    }

    /**
     * 检查用户名是否可被注册
     *
     * @return int string
     */
    public function is_registrable($uname)
    {
        $uname = trim($uname);
        // 用户名中连续的数字不能大于等于5个
        if (preg_match('/\d{5}/uD', $uname)) {
            return $this->_error(USERNAME_UNNORM, '用户名中不能包含多个数字，推荐使用中文用户名。');
        }
        // 用户名长度为6-50个字符,一个汉字占3个字符（UTF-8）
        if (strlen($uname) > 50 || strlen($uname) < 6) {
            return $this->_error(USERNAME_UNNORM, '用户名长度必需为6-50个字符。' . $uname);
        }
        // 用户名为汉字、字母、数字和下划线，不含特殊字符
        if (!preg_match('/^[\x{4e00}-\x{9fa5}A-Za-z0-9_]+$/uD', $uname)) {
            return $this->_error(USERNAME_UNNORM, '用户名支持中英文、数字、下划线，不支持除下划线的特殊字符。');
        }
        // 用户名不能全为下划线
        if (preg_match('/^\_+$/uD', $uname)) {
            return $this->_error(USERNAME_UNNORM, '用户名不能全为下划线。');
        }

        // 是否被禁
        if (!$this->checkKeyword($uname)) {
            return false;
        }

        // 查询是否重名
        if (!$this->check_name_exists($uname)) {
            return false;
        }

        return true;
    }

    /**
     * 判断密码是否符合规范
     *
     * @param $password 密码
     * @return boolean
     */
    public function check_password($password)
    {
        // 是否全数字
        if (preg_match('/^\d*$/uD', $password)) {
            return $this->_error(PASSWORD_UNNORM, '密码不能为纯数字。');

        }
        // 是否全字母
        if (preg_match('/^\[a-zA-Z]*$/uD', $password)) {
            return $this->_error(PASSWORD_UNNORM, '密码不能为纯字母。');
        }

        //不能是邮箱
        if (preg_match('/\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/', $password)) {
            return $this->_error(PASSWORD_UNNORM, '密码不能为邮箱。');
        }
        $len = strlen($password);
        if ($len < 6 || $len > 20) {
            return $this->_error(PASSWORD_UNNORM, '密码只能在6-20位内。');
        }

        return TRUE;
    }


    /**
     * 生成Salt
     *
     * @param $length 长度（默认为6）
     * @return string
     */
    protected function _get_salt($length = 6)
    {
        $chars = '123456789abcdefghijklmnopqrstuvwxyz';
        $len = strlen($chars);
        $salt = '';
        for ($i = 0; $i < $length; $i++) {
            $salt .= $chars [mt_rand(0, $len - 1)];
        }
        return $salt;
    }

    /**
     * 初始化 user_stat表
     */
    public function ini_userstat($user_id)
    {
        $this->db->insert('user_stat', array('uid' => $user_id));
    }

    /**
     * 后台新增会员
     */
    public function reg_to_admin($username, $passowrd, $email)
    {
        $now = time();
        $ip = ip('int');
        //写入uc表    	
        $salt = $this->_get_salt();
        $uc_data = array();
        $uc_data['username'] = $username;
        $uc_data['password'] = strtolower(md5(strtolower(md5($passowrd) . $salt)));
        $uc_data['email'] = $email;
        $uc_data['salt'] = $salt;
        $uc_data['VnetPayPswd'] = md5($passowrd);
        $uc_data['regip'] = $ip;
        $uc_data['regdate'] = $now;
        $this->uc_db->insert('members', $uc_data);
        $user_id = $this->uc_db->insert_id();
        if ($user_id) {
            //写入女装表
            $data = array();
            $data['user_id'] = $user_id;
            $data['user_name'] = $username;
            $data['email'] = $email;
            $data['reg_time'] = $uc_data['regdate'];
            $data['last_login'] = $now;
            $this->db->insert('member', $data);
        }
        //初始化stat
        $this->ini_userstat($user_id);
        return TRUE;
    }

    /**
     * 同步uc用户信息
     */
    public function sync($account)
    {
        if (preg_match('/^[1-9]\d*$/', $account)) {
            $column = 'uid';
        } else {
            $column = 'username';
        }
        $user_uc = $this->uc_db->select('uid,username,email,regdate')->where($column, $account)->get('members')->row_array();
        if (count($user_uc) > 0) {
            $this->db->trans_begin();
            $data = array();
            $data['user_id'] = $user_uc['uid'];
            $data['user_name'] = $user_uc['username'];
            $data['email'] = $user_uc['email'];
            $data['reg_time'] = $user_uc['regdate'];
            $this->db->insert('member', $data);
            $ret = $this->db->insert_id();
            $this->ini_userstat($user_uc['uid']);
            if ($this->db->trans_status() === FALSE) {
                $this->db->trans_rollback();
                return 0;
            } else {
                $this->db->trans_commit();
                return $ret;
            }
        } else {
            return 0;
        }
    }
}