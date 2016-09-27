<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 系统配置模型
 *
 */
class app_sys_model extends CI_Model
{
    const TYPE_ANDROID = 1;
    const TYPE_IOS = 2;

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 获取app当前最低版本
     * @param int $type 客户端类型
     * @return array 版本数组
     */
    public function get_app_min_version($type)
    {
        $key = '';
        switch ($type) {
            case self::TYPE_ANDROID:
                $key = 'android_min_version';
                break;
            case self::TYPE_IOS:
                $key = 'ios_min_version';
                break;
        }
        $version = config_item($key);
        $version_url = config_item($type . '_url');
        return array(
            'nversion' => isset($version) ? $version : 0,
            'version_url' => isset($version_url) ? $version_url : '',
        );
    }

    /**
     * 获取app当前最高版本
     * @param int $type 客户端类型
     * @return array 版本数组
     */
    public function get_app_max_version($type)
    {
        $key = '';
        switch ($type) {
            case self::TYPE_ANDROID:
                $key = 'android_max_version';
                break;
            case self::TYPE_IOS:
                $key = 'ios_max_version';
                break;
        }
        $version = config_item($key);
        $version_url = config_item($type . '_url');
        return array(
            'version' => isset($version) ? $version : 0,
            'version_url' => isset($version_url) ? $version_url : '',
        );
    }

}