<?php

if (!function_exists('cache_user')) {
    /**
     * 获取用户信息
     * @param $uid 想获取的用户编号
     * @param bool $if_cache 是否读取缓存，默认读取
     * @return array|bool
     * @author 王立
     */
    function cache_user($uid, $if_cache = true)
    {
        $CI = &get_instance();
        // 从缓存读取用户信息
        $key = 'app_user_info_' . $uid;
        if ($if_cache) {
            $user = cache($key);
            if ($user) {
                return $user;
            }
        }
        // 数据库读取并更新到缓存
        $uc_db = $CI->load->database('uc', TRUE);
        $uc_user = $uc_db->select('uid,username,uTypeId,isLock,email,mobile')->where('uid', $uid)->get('members')->row_array();
        if (!$uc_user)
            return false;
        $zbb_db = $CI->load->database('zbb', TRUE);
        $zbb_user = $zbb_db->select('lock,login_sign')->where('user_id', $uid)->get('member')->row_array();
        if (!$zbb_user) {
            //用户不存在本地用户库，进行同步
            $login_sign = md5($uid,$uc_user['username'].time());
            $syn_info['user_id'] = $uid;
            $syn_info['user_name'] = $uc_user['username'];
            $syn_info['login_sign'] = $login_sign;
            $zbb_db->insert('member', $syn_info);
            $zbb_db->insert('user_stat', array('uid' => $uid));

            $zbb_user['lock'] = 0;
            $zbb_user['login_sign'] = $login_sign;
        }
        // 组装用户信息
        $user = array(
            'id' => $uid,
            'name' => $uc_user ['username'],
            'uc_lock'=>$uc_user['isLock'],
            'zbb_lock'=>$zbb_user['lock'],
            'login_sign'=>$zbb_user['login_sign']
        );
        cache($key, $user, 3 * 60 * 60);
        return $user;
    }

    if (!function_exists('rand_code')) {
        /**
         * 随机验证码
         * @param int $length 默认6位
         * @return string
         * @author 王立
         */
        function rand_code($length = 6)
        {
            $chars = '1234567890';
            $len = strlen($chars);
            $code = '';
            for ($i = 0; $i < $length; $i++) {
                $code .= $chars [mt_rand(0, $len - 1)];
            }
            return $code;
        }
    }
}