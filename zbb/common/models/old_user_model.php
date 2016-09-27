<?php

/**
 * 首页模型
 * @author feimo
 * @version 2013-10
 */
class User_model extends CI_Model {

    public $error = NULL;

    /**
     * 继承父级构造方法
     * 实例化两个数据库方法
     */
    public function __construct() {
        parent::__construct();
        $this->db = $this->load->database('zbb', TRUE);
        $this->uc_db = $this->load->database('uc', TRUE);
    }

    /**
     * 设置错误代码，并固定返回FALSE
     */
    protected function _error($code, $data) {
        $this->error = array(
            'code' => $code,
            'data' => $data
        );
        return FALSE;
    }

    /**
     * 登录
     *
     * @param $account 账号
     * @param $password 密码
     */
    public function login($account, $password) {
        // 判断登录类型
        if (preg_match('/^[^_][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/', $account)) {
            $column_uc = 'email';
        } else if (preg_match('/^([1][3|4|5|8][0-9]{9}){1}$/', $account)) {
            $column_uc = 'mobile';
        } else {
            $column_uc = 'username';
        }
        //获取uc表数据
        $this->uc_db = $this->load->database('uc', TRUE);
        $user_uc = $this->uc_db->where($column_uc, $account)->get('members')->row_array();
        if ($user_uc) {
            $password_login = strtolower(md5(strtolower(md5($password) . $user_uc['salt'])));
            if ($user_uc['password'] != $password_login) {
                return $this->_error('WRONG_PASSWORD', '密码错误！');
            }
            $user = $this->db->where('user_id', $user_uc['uid'])->get('member')->row_array();
            if($user['lock']==1){
                 return $this->_error('LOCK', '账号被冻结到'.date('Y-m-d',$user['lock_time']).'，原因是:'.$user['lock_msg']);
            }
            if (!$user) {
                //写入衣扮网用户表
                $data = array();
                $data['user_id'] = $user_uc['uid'];
                $data['user_name'] = $user_uc['username'];
                $data['email'] = $user_uc['email'];
                $data['reg_time'] = $user_uc['regdate'];
                $this->db->insert('member', $data);
                //初始化stat
                $this->ini_userstat($user_uc['uid']);
            }
            /******此处为避免测试大爷使用旧数据报错，代码完全多余，上线后清空数据，删除此处*******/
            
            $stat = $this->db->where(array('uid'=>$user_uc['uid']))->get('user_stat')->row_array();
            if(empty($stat)){
            	$this->ini_userstat($user_uc['uid']);
            }
            
            /******像我这种代码精良的人，怎么会加行这代码呢？*******/
        } else {
            return $this->_error('USER_NOT_FOUND', '此账号不存在！');
        }
        
        // 更新 - 最后一次登录信息
        $now = time();
        $ip = ip('int');
        $this->db->where('user_id', $user_uc['uid'])->update('member', array(
            'last_ip' => $ip,
            'last_login' => $now,
        ));
        // 更新 - 在线用户表
        $online_user = array ();
        $online_user ['uid'] = $user_uc ['uid'];
        $online_user ['username'] = $user_uc ['username'];
        $online_user ['password'] = $user_uc ['password'];
        $online_user ['usertype'] = $user_uc ['uTypeid'];
        $online_user ['logintime'] = $now;
        $online_user ['code'] = $this->_random ( 15 );
        if ($this->uc_db->where ( 'uid', $user_uc['uid'] )->count_all_results ( 'onlineusers' ) <= 0) {
            $this->uc_db->insert ( 'onlineusers', $online_user );
        } else {
            $this->uc_db->where ( 'uid', $user_uc['uid'] )->update ( 'onlineusers', $online_user );
        }

        // 更新 - 在线用户表 最后一次登录信息
        $this->uc_db->where ( 'uid', $user_uc['uid'] )->update ( 'members', array (
                'lastloginip' => $ip,
                'lastlogintime' => $now 
        ) );
        // 保存cache
        $user_id = $user_uc['uid'];
        cache('nzw_' . $user_uc['uid'], $user_id);
        // 写入登录cookie
        $this->_save_cookie($user_uc['uid'], $user_uc['username']);
       
        return $user_uc['uid'];
    }
    
    /**
     * 登陆验证
     */
    public function login_check($account, $password){
    	// 判断登录类型
    	if (preg_match('/^[^_][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/', $account)) {
    		$column_uc = 'email';
    	} else if (preg_match('/^([1][3|4|5|8][0-9]{9}){1}$/', $account)) {
    		$column_uc = 'mobile';
    	} else {
    		$column_uc = 'username';
    	}
    	//获取uc表数据
    	$user_uc = $this->uc_db->where($column_uc, $account)->get('members')->row_array();
    	if ($user_uc) {
    		if($user_uc['reg_source'] == 5){
    			return $this->_error('USER_NOT_FOUND', '此账号不存在！');
    		}
    		$password_login = strtolower(md5(strtolower(md5($password) . $user_uc['salt'])));
    		if ($user_uc['password'] != $password_login) {
    			return $this->_error('WRONG_PASSWORD', '密码错误！');
    		}
    		$user = $this->db->where('user_id', $user_uc['uid'])->get('member')->row_array();
    		if(isset($user['lock']) && $user['lock']==1){
    			return $this->_error('LOCK', '账号被冻结到'.date('Y-m-d',$user['lock_time']).'，原因是:'.$user['lock_msg']);
    		}
    	} else {
    		return $this->_error('USER_NOT_FOUND', '此账号不存在！');
    	}
    	return $user_uc['uid'];
    }
    /**
     * 健全账号登陆后置操作
     */
    public function complete_login($user_id){
    	$user_uc = $this->uc_db->where('uid', $user_id)->get('members')->row_array();
    	$user = $this->db->where('user_id', $user_id)->get('member')->row_array();
    	if (!$user) {    		
    		//写入衣扮网用户表
    		$data = array();
    		$data['user_id'] = $user_uc['uid'];
    		$data['user_name'] = $user_uc['username'];
    		$data['email'] = $user_uc['email'];
    		$data['reg_time'] = $user_uc['regdate'];
    		$this->db->insert('member', $data);
    		//初始化stat
    		$this->ini_userstat($user_uc['uid']);
    	}
    	// 更新 - 最后一次登录信息
    	$now = time();
    	$ip = ip('int');
    	$this->db->where('user_id', $user_uc['uid'])->update('member', array(
    			'last_ip' => $ip,
    			'last_login' => $now,
    	));
    	// 更新 - 在线用户表
    	$online_user = array ();
    	$online_user ['uid'] = $user_uc ['uid'];
    	$online_user ['username'] = $user_uc ['username'];
    	$online_user ['password'] = $user_uc ['password'];
    	$online_user ['usertype'] = $user_uc ['uTypeid'];
    	$online_user ['logintime'] = $now;
    	$online_user ['code'] = $this->_random ( 15 );
    	if ($this->uc_db->where ( 'uid', $user_uc['uid'] )->count_all_results ( 'onlineusers' ) <= 0) {
    		$this->uc_db->insert ( 'onlineusers', $online_user );
    	} else {
    		$this->uc_db->where ( 'uid', $user_uc['uid'] )->update ( 'onlineusers', $online_user );
    	}
    	
    	// 更新 - 在线用户表 最后一次登录信息
    	$this->uc_db->where ( 'uid', $user_uc['uid'] )->update ( 'members', array (
    			'lastloginip' => $ip,
    			'lastlogintime' => $now
    	) );
    	// 保存cache
    	$user_id = $user_uc['uid'];
    	cache('nzw_' . $user_uc['uid'], $user_id);
    	// 写入登录cookie
    	$this->_save_cookie($user_uc['uid'], $user_uc['username']);
    	 
    	return $user_uc['uid'];
    }


/**
     * 登录
     *
     * @param $account 账号
     * @param $password 密码
     */
    public function app_login($account, $password) {
        // 判断登录类型
        if (preg_match('/^[^_][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[@][a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,4}$/', $account)) {
            $column_uc = 'email';
        } else if (preg_match('/^([1][3|4|5|8][0-9]{9}){1}$/', $account)) {
            $column_uc = 'mobile';
        } else {
            $column_uc = 'username';
        }
        //获取uc表数据
        $this->uc_db = $this->load->database('uc', TRUE);
        $user_uc = $this->uc_db->where($column_uc, $account)->get('members')->row_array();
        if ($user_uc) {
        	if($user_uc['reg_source'] == 5){
        		return $this->_error('USER_NOT_FOUND', '此账号不存在！');
        	}
            $password_login = strtolower(md5(strtolower(md5($password) . $user_uc['salt'])));
            if ($user_uc['password'] != $password_login) {
                return $this->_error('WRONG_PASSWORD', '密码错误！');
            }
            $user = $this->db->where('user_id', $user_uc['uid'])->get('member')->row_array();
            if($user['lock']==1){
                 return $this->_error('LOCK', '账号被冻结到'.date('Y-m-d',$user['lock_time']).'，原因是:'.$user['lock_msg']);
            }
            if (!$user) {
                //写入衣扮网用户表
                $data = array();
                $data['user_id'] = $user_uc['uid'];
                $data['user_name'] = $user_uc['username'];
                $data['email'] = $user_uc['email'];
                $data['reg_time'] = $user_uc['regdate'];
                $this->db->insert('member', $data);
                //初始化stat
                $this->ini_userstat($user_uc['uid']);
            }
             //$im_res = $this->_get_im( $user_uc['uid'] );
            //if(!$im_res){
                //$this->_syn_im($user_uc['uid'], $user_uc['username'], $password);
            //} 
            /******此处为避免测试大爷使用旧数据报错，代码完全多余，上线后清空数据，删除此处*******/
            
            $stat = $this->db->where(array('uid'=>$user_uc['uid']))->get('user_stat')->row_array();
            if(empty($stat)){
                $this->ini_userstat($user_uc['uid']);
            }
            
            /******像我这种代码精良的人，怎么会加行这代码呢？*******/
        } else {
            return $this->_error('USER_NOT_FOUND', '此账号不存在！');
        }
        
        // 更新 - 最后一次登录信息
        $now = time();
        $ip = ip('int');
        $this->db->where('user_id', $user_uc['uid'])->update('member', array(
            'last_ip' => $ip,
            'last_login' => $now,
        ));
        // 更新 - 在线用户表
        $online_user = array ();
        $online_user ['uid'] = $user_uc ['uid'];
        $online_user ['username'] = $user_uc ['username'];
        $online_user ['password'] = $user_uc ['password'];
        $online_user ['usertype'] = $user_uc ['uTypeid'];
        $online_user ['logintime'] = $now;
        $online_user ['code'] = $this->_random ( 15 );
        if ($this->uc_db->where ( 'uid', $user_uc['uid'] )->count_all_results ( 'onlineusers' ) <= 0) {
            $this->uc_db->insert ( 'onlineusers', $online_user );
        } else {
            $this->uc_db->where ( 'uid', $user_uc['uid'] )->update ( 'onlineusers', $online_user );
        }

        // 更新 - 在线用户表 最后一次登录信息
        $this->uc_db->where ( 'uid', $user_uc['uid'] )->update ( 'members', array (
                'lastloginip' => $ip,
                'lastlogintime' => $now 
        ) );
        // 保存cache
        $user_id = $user_uc['uid'];
        cache('nzw_' . $user_uc['uid'], $user_id);
        // 写入登录cookie
        $temp=$this->_save_cookie($user_uc['uid'], $user_uc['username']);
        return array('user_id' =>$user_uc['uid'] ,'NZW_YZ'=>$temp );
    }


    /**
     * 保存用户cookie信息
     *
     * @param int $uid
     *        	用户编号
     * @param string $uname
     *        	用户名
     * @param int $utype
     *        	用户类型
     * @param string $usalt
     *        	加密字符串
     * @param bool $is_remember
     *        	保存登录账号
     */
    public function _save_cookie($uid, $uname) {
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
        setcookie(COOKIE_NAME, $cookie, time() + 86400, '/', $this->config->item('cookie_domain'), NULL, FALSE);
        return $cookie;
    }

    /**
     * 获取同步登录的令牌
     *
     * @return 失败或者未知均返回空
     */
    public function get_login_token() {
        $uid = get_user ();
        if (! $uid) {
            return 'not_loginff';
        }
        $online_user = $this->uc_db->select ( 'code' )->get_where ( 'onlineusers', array (
                'uid' => $uid 
        ), 1 )->row_array ();
        return $online_user ? md5 ( $_SERVER ['HTTP_USER_AGENT'] . ip() . $online_user ['code'] ) : 'not_online';
    }

    /**
     * 其它系统已登录，需要同步登录站点
     *
     * @param
     *          $uid
     * @param
     *          $token
     */
    public function login_by_token($uid, $token) {
        // 验证是否可进行登录
        $online_user = $this->uc_db->select ( 'code' )->get_where ( 'onlineusers', array (
                'uid' => $uid 
        ), 1 )->row_array ();
        if (! $online_user) {
            return $this->_error ( 'USER_NOT_FOUND', '此账号尚未登录！' );
        }
        if ($token !== md5 ( $_SERVER ['HTTP_USER_AGENT'] . ip() . $online_user ['code'] )) {
            return $this->_error ( 'ERROR_TOKEN', '同步登录令牌错误！' );
        }
        
        // 获取最后登录信息
        $user = $this->uc_db->select ( 'username,uTypeid,password,lastloginip,lastlogintime' )->where ( 'uid', $uid )->get ( 'members' )->row_array ();
        if (! $user) {
            return $this->_error ( 'USER_NOT_FOUND', '此账号信息不存在！' );
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

    public function _random($length, $numeric = 0) {
        $seed = base_convert(md5(microtime() . $_SERVER ['DOCUMENT_ROOT']), 16, $numeric ? 10 : 35 );
        $seed = $numeric ? (str_replace('0', '', $seed) . '012340567890') : ($seed . 'zZ' . strtoupper($seed));
        if ($numeric) {
            $hash = '';
        } else {
            $hash = chr(rand(1, 26) + rand(0, 1) * 32 + 64);
            $length --;
        }
        $max = strlen($seed) - 1;
        for ($i = 0; $i < $length; $i ++) {
            $hash .= $seed {mt_rand(0, $max)};
        }
        return $hash;
    }

    /**
     * 获取邮箱是否被注册
     *
     * @param $email string
     * @return bool
     */
    public function check_email_exists($email) {
        if ($this->uc_db->where('email', $email)->count_all_results('members') > 0) {
            //return $this->_error('EMAIL_EXISTS', '您注册的邮箱已经被注册！');
            return FALSE;
        }

        return TRUE;
    }

    /**
     * 获取手机号是否被注册
     *
     * @param $mobile string
     * @return bool
     */
    public function check_mobile_exists($mobile) {
        if ($this->uc_db->where('mobile', $mobile)->count_all_results('members') > 0) {
            //return $this->_error('MOBILE_EXISTS', '您注册的手机号已经被注册！');
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
    public function check_name_exists($name, $type = 1) {

        if ($type == 1) {
            if ($this->uc_db->where('username', $name)->count_all_results('members') > 0) {
                //return $this->_error('USERNAME_EXISTS', '您注册的用户名已经被注册，请重新更换新的用户名。');
                return FALSE;
            }

            return TRUE;
        }

        if ($type == 2) {
            if ($this->db->where('nickname', $name)->count_all_results('user') > 0) {
                //return $this->_error('NICKNAME_EXISTS', '您注册的昵称已经被注册，请重新更换新的昵称。');
                return FALSE;
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
    public function checkKeyWord($uname) {
        //非法字符串
        $keyword_arr = $this->config->item('key_word');
        if ($keyword_arr) {
            foreach ($keyword_arr as $v) {
                if ($v != '') {
                    $stat = strpos($uname, $v);
                    if ($stat !== FALSE) {
                      
                        return FALSE;
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
     * 判断密码是否符合规范
     *
     * @param $password 密码
     * @return boolean
     */
    public function check_password($password) {
        // 是否全数字
        if (preg_match('/^\d*$/uD', $password)) {
            //return $this->_error('PASSWORD_IS_DIGIS', '密码不能为纯数字。');
            return FALSE;
        }

        // 是否全字母
        if (preg_match('/^\[a-zA-Z]*$/uD', $password)) {
            //return $this->_error('PASSWORD_IS_LETTERS', '密码不能为纯字母。');
            return FALSE;
        }
        
        //不能是邮箱
        if (preg_match('/\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/',$password)){
        	return FALSE;
        }
        $len = strlen($password);
        if ($len < 6 || $len > 20) {
            //return $this->_error('PASSWORD_LENGTH_INCORRECT', '密码只能在6-20位内。');
            return FALSE;
        }

        return TRUE;
    }

    /**
     * 检验邮箱验证码
     * @param  $email 邮箱
     * @param  $captcha 验证码
     * @return boolean
     */
    public function checkCaptcha($email, $captcha) {
        $captcha = strtolower($captcha);
        $code = $this->db->select('dateline,vcode')->where(array('input' => $email, 'vcode' => $captcha))->get('code')->row_array();
        if (!$code) {
            exit(json_encode(array('info' => '验证码无效，请发送邮箱验证码！', 'status' => 'n')));
        }
        if (time() - $code['dateline'] > 1200) {
            $this->db->delete('code', array('input' => $email));
            exit(json_encode(array('info' => '验证码已经失效，请重新发送！', 'status' => 'n')));
        }
        if ($captcha != $code['vcode']) {
            exit(json_encode(array('info' => '验证码错误！', 'status' => 'n')));
        }

        return TRUE;
    }

    /**
     * 检验邮箱验证码  非AJAX
     * @param  $email 邮箱
     * @param  $captcha 验证码
     * @return boolean
     */
    public function check_code($email, $captcha) {
        $captcha = strtolower($captcha);
        $code = $this->db->select('dateline,vcode')->where(array('input' => $email, 'vcode' => $captcha))->get('code')->row_array();
        if (!$code) {
            return FALSE;
        }
        if (time() - $code['dateline'] > 1200) {
            $this->db->delete('code', array('input' => $email));
            return FALSE;
        }
        if ($captcha != $code['vcode']) {
            return FALSE;
        }

        return TRUE;
    }

    /**
     * 注册并登陆
     */
    public function reg_to_log($username, $passowrd ) {
        $now = time();
        $ip = ip('int');
        //写入uc表    	
        $salt = $this->_get_salt();
        $uc_data = array();
        $uc_data['username'] = $username;
        $uc_data['password'] = strtolower(md5(strtolower(md5($passowrd) . $salt)));
        $uc_data['salt'] = $salt;
        $uc_data['VnetPayPswd'] = md5($passowrd);
        $uc_data['regip'] = $ip;
        $uc_data['regdate'] = $now;
        $uc_data['reg_source'] = 7;
        $uc_data['isLock'] = 2;
        $this->uc_db->insert('members', $uc_data);
        $user_id = $this->uc_db->insert_id();
       /*  if ($user_id) {
            //写入女装表
            $data = array();
            $data['user_id'] = $user_id;
            $data['user_name'] = $username;
            //$data['email'] = $email;
            $data['reg_time'] = $uc_data['regdate'];
            $data['last_login'] = $now;
            $data['reg_site'] = 1;
			
            $this->db->insert('member', $data);
        } */
        //初始化stat
        //$this->ini_userstat($user_id);
        // 保存cache
        //cache('nzw_' . $user_id, $user_id);
        // 写入登录cookie
        //$this->_save_cookie($user_id, $username);
        //注册完成第一步写入不存步奏cookie
        $this->load->library('crypt', array(
        		'key' => KEY_COOKIE_CRYPT,
        		'iv' => KEY_COOKIE_CRYPT_IV
        ));
        
        $value = array();
        $value ['userName'] = $username;
        $value ['auth'] = $this->crypt->encode($user_id . '|' . $this->_random(8));
        $cookie = implode('|', $value);
        setcookie( 'NZW_RE', $cookie, time() + 2400, '/', $this->config->item('cookie_domain'), NULL, FALSE);
        return $user_id;
    }


      /**
     * 注册并登陆
     */
    public function app_reg_to_log($username, $passowrd ) {
        $now = time();
        $ip = ip('int');
        //写入uc表     
        $salt = $this->_get_salt();
        $uc_data = array();
        $uc_data['username'] = $username;
        $uc_data['password'] = strtolower(md5(strtolower(md5($passowrd) . $salt)));
        $uc_data['salt'] = $salt;
        $uc_data['VnetPayPswd'] = md5($passowrd);
        $uc_data['regip'] = $ip;
        $uc_data['regdate'] = $now;
        $uc_data['reg_source'] = 7;
        $uc_data['isLock'] = 2;
        $uc_data['mobile_valid'] = 1;
        $this->uc_db->insert('members', $uc_data);
        $user_id = $this->uc_db->insert_id();
       if ($user_id) {
            //写入女装表
            $data = array();
            $data['user_id'] = $user_id;
            $data['user_name'] = $username;
            //$data['email'] = $email;
            $data['reg_time'] = $uc_data['regdate'];
            $data['last_login'] = $now;
            $data['reg_site'] = 1;
            
            $this->db->insert('member', $data);
        } 
        //初始化stat
        $this->ini_userstat($user_id);
        return $user_id;
    }

    /**
     * 注册发送邮箱验证、发送短信验证
     */
    public function set_code($email = NULL, $mobile = NULL) {

        $send_to = $email ? $email : $mobile;
        
        $vcode = $this->_get_salt();
        $code = $this->db->where(array('input' => $send_to))->get('code')->row_array();
        if ($code) {
            if (time() - $code['dateline'] < 1200 && $code['retry_num'] >= 5) {
                $time = intval(($code['dateline'] + 1200 - time()) / 60);
                exit(json_encode(array('info' => '操作过于频繁，请' . $time . '分钟后重试！', 'status' => 'n')));
            }
            if (time() - $code['dateline'] > 1200 && $code['retry_num'] >= 5) {
                $this->db->where(array('input' => $send_to))->update('code', array(
                    'dateline' => time(),
                    'vcode' => $vcode,
                    'retry_num' => 1,
                ));
            }
            if (time() - $code['dateline'] < 60 && $code['retry_num'] < 5) {
                $this->db->where(array('input' => $send_to))->update('code', array(
                    'dateline' => time(),
                    'vcode' => $vcode,
                    'retry_num' => $code['retry_num'] + 1,
                ));
            }
            if (time() - $code['dateline'] > 60 && $code['retry_num'] < 5) {
                $this->db->where(array('input' => $send_to))->update('code', array(
                    'dateline' => time(),
                    'vcode' => $vcode,
                ));
            }
        } else {
            $data = array();
            $data['dateline'] = time();
            $data['type'] = 1;
            $data['input'] = $send_to;
            $data['vcode'] = $vcode;
            $data['retry_num'] = 1;
            $this->db->insert('code', $data);
        }
        
        if ($email) {
            $this->_send_email($send_to, $vcode);
        } else {
            return $this->_send_sms($send_to, $vcode);
        }
    }




/**
     * 注册发送邮箱验证、发送短信验证
     */
    public function set_code_mobile($mobile) {

        $send_to = $mobile;
        
        $vcode = $this->_get_salt();
        $code = $this->db->where(array('input' => $send_to))->get('code')->row_array();
        if ($code) {
            if (time() - $code['dateline'] < 1200 && $code['retry_num'] >= 5) {
                $time = intval(($code['dateline'] + 1200 - time()) / 60);
                exit(json_encode(array('info' => '操作过于频繁，请' . $time . '分钟后重试！', 'status' => 'n')));
            }
            if (time() - $code['dateline'] > 1200 && $code['retry_num'] >= 5) {
                $this->db->where(array('input' => $send_to))->update('code', array(
                    'dateline' => time(),
                    'vcode' => $vcode,
                    'retry_num' => 1,
                ));
            }
            if (time() - $code['dateline'] < 60 && $code['retry_num'] < 5) {
                $this->db->where(array('input' => $send_to))->update('code', array(
                    'dateline' => time(),
                    'vcode' => $vcode,
                    'retry_num' => $code['retry_num'] + 1,
                ));
            }
            if (time() - $code['dateline'] > 60 && $code['retry_num'] < 5) {
                $this->db->where(array('input' => $send_to))->update('code', array(
                    'dateline' => time(),
                    'vcode' => $vcode,
                ));
            }
        } else {
            $data = array();
            $data['dateline'] = time();
            $data['type'] = 1;
            $data['input'] = $send_to;
            $data['vcode'] = $vcode;
            $data['retry_num'] = 1;
            $this->db->insert('code', $data);
        }
            return $this->_send_sms($send_to, $vcode);
    }

    
    /**
     * 生成Salt
     *
     * @param $length 长度（默认为6）
     * @return string
     */
    protected function _get_salt($length = 6) {
        $chars = '123456789abcdefghijklmnopqrstuvwxyz';
        $len = strlen($chars);
        $salt = '';
        for ($i = 0; $i < $length; $i ++) {
            $salt .= $chars [mt_rand(0, $len - 1)];
        }
        return $salt;
    }

    /**
     * 发送邮件验证码
     */
    public function _send_email($email, $code) {
        //发送邮箱
        $this->load->library('Email');
        $this->email->from($this->config->item('smtp_user'), '衣扮网');
        $this->email->to($email);
        $subject = "衣扮网-用户注册邮箱认证(系统邮件，请勿回复)";
        $message = '<p>尊敬的衣扮网用户:</p><p style="padding-left: 30px;">欢迎您加入衣扮网，请您在注册页面中输入验证码:' . $code . '（验证码有效时间为20分钟），即可完成注册 。</p>
	<p style="padding-left: 30px;">如非本人操作，请忽略此邮件，由此给您带来的不便请谅解！（注意：此验证码有效期为20分钟）</p>
	<p style="text-align: right;">衣扮网 ' . date('Y-m-d H:i:s', time()) . '</p>';
        $this->email->subject($subject);
        $this->email->message($message);
        $this->email->send();
    }
    
    /**
     * 发送短信验证码
     */
    private function _send_sms($mobile, $code) {
        $this->load->library('Sms');
        return $this->sms->send($mobile, '您的验证码是'.$code.'，15分钟内有效，请妥善保管。【衣扮网】');
    }
    
    /**
     * 初始化 user_stat表
     */
    public function ini_userstat($user_id){
    	$this->db->insert('user_stat',array('uid'=>$user_id));
    }

	 /**
     * 后台新增会员
     */
    public function reg_to_admin($username, $passowrd, $email) {
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
    /*
     * 同步聊天用户
     */
    public function _syn_im($user_id,$user_name,$password){
    	$soap = new SoapClient(IM_URL . 'openapi/openapi.php?wsdl');
    	try {
    		$params = array();
    		$params['key'] = IM_KEY;
    		$params['userid'] = $user_id;
    		$params['username'] = $user_name;
    		$params['usertype'] = 0;
    		$params['canfindbypublicusers'] = 1;
    		$params['nickname'] = $user_name;
    		$params['actualname'] = $user_name;
    		$params['sex'] = '0';
    		$params['age'] = '-1';
    		$params['birth_year'] = '1900';
    		$params['birth_month'] = '1';
    		$params['birth_day'] = '1';
    		$params['province'] = '0';
    		$params['city'] = '0';
    		$params['address'] = '0';
    		$params['telephone'] = '0';
    		$params['mobile'] = '0';
    		$params['fax'] = '0';
    		$params['qq'] = '0';
    		$params['msn'] = '0';
    		$params['email'] = '0';
    		$params['homepage'] = '0';
    		$params['departid'] = '0';
    		$params['departname'] = '0';
    		$params['jobtitle'] = '0';
    		$params['jobnumber'] = '0';
    		$params['introduction'] = '0';
    		$params['password'] = strtoupper(MD5($password));
    		$syn_res = $soap->__soapCall('AddUser',  $params );
    	} catch (Exception $e) {
    		$syn_res = 'error';
    	}
    	return $syn_res;
    }
    
    /**
     * 获取聊天根据账号信息
     */
    public function _get_im($user_id){
    	$soap = new SoapClient(IM_URL . 'openapi/openapi.php?wsdl');
    	try {
    		$params = array();
    		$params['key'] = IM_KEY;
    		$params['userid'] = $user_id;
    		$ret = $soap->__soapCall('GetUser',  $params );
    		$user_info = json_decode( json_encode( $ret ),true);
    		$uid = $user_info['userid'];
    	} catch (Exception $e) {
    		$uid = 0;
    	}
    	return $uid;
    }
    /**
     * 判断是否需要激活
     */
    public function go_active($user_id = 0){
    	if(intval($user_id)){
    		$user_id = intval($user_id);
    	}else{
    		$user_id = get_user();
    	}
    	$res = $this->uc_db->select('isLock')->where(array('uid'=>$user_id))->get('members')->row_array();
    	if($res['isLock'] == 2){
    		return FALSE;
    	}
    	return TRUE;
    }
    /**
     * 同步uc用户信息
     */
    public function sync($account) {
	    if (preg_match('/^[1-9]\d*$/', $account)) {
	    	$column = 'uid';
	    }else{ 
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
    		if ($this->db->trans_status() === FALSE)
    		{
    			$this->db->trans_rollback();
    			return 0;
    		}
    		else
    		{
    			$this->db->trans_commit();
    			return $ret;
    		}    		
    	} else {
    		return 0;
    	}
    }
}