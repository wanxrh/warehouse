<?php

/**
 * 文件上传辅助类，依赖入口文件设置的常量COMPATH以及公共函数nzw_mkdir
 * $_allowed_file_type、$_allowed_file_size、$_root_dir三个设置项在common/config/nzw.php均设置了初始值
 * $_allowed_file_type 允许的上传文件类型
 * $_allowed_file_size 允许的上传文件大小
 * $_root_dir 上传文件所需的根目录，通常是网站的根目录
 * $_errors 用于收集错误信息的数组
 */
class Uploader {

    public $_file = null;
    public $_allowed_file_type = null;
    public $_allowed_file_size = null;
    public $_root_dir = null;
    public $_errors = array();

    function __construct() {
        $CI = &get_instance();
        $this->_allowed_file_type = $CI->config->item('_allowed_file_type') or trigger_error('缺少配置项：_allowed_file_type');
        $this->_allowed_file_size = $CI->config->item('_allowed_file_size') or trigger_error('缺少配置项：_allowed_file_size');
        $this->_root_dir = $CI->config->item('_root_dir') or trigger_error('缺少配置项：_root_dir');
    }

    /**
     *    添加由POST上来的文件
     *
     *    @param    none
     *    @return    void
     */
    function addFile($file) {
        if (!is_uploaded_file($file['tmp_name'])) {
            return false;
        }
        $this->_file = $this->_get_uploaded_info($file);
    }

    /**
     *    设定允许添加的文件类型
     *
     *    @param     string $type （小写）示例：gif|jpg|jpeg|png
     *    @return    void
     */
    function allowed_type($type) {
        $this->_allowed_file_type = explode('|', $type);
    }

    /**
     *    允许的大小
     *
     *    @param     mixed $size
     *    @return    void
     */
    function allowed_size($size) {
        $this->_allowed_file_size = $size;
    }

    function _get_uploaded_info($file) {

        $pathinfo = pathinfo($file['name']);
        $file['extension'] = $pathinfo['extension'];
        $file['filename'] = $pathinfo['basename'];
        if (!$this->_is_allowd_type($file['extension'])) {
            $this->_error('不允许上传该文件类型', $file['extension']);

            return false;
        }
        if (!$this->_is_allowd_size($file['size'])) {
            $this->_error('你的文件过大', $file['size']);

            return false;
        }

        return $file;
    }

    function _is_allowd_type($type) {
        if (!$this->_allowed_file_type) {
            return true;
        }
        return in_array(strtolower($type), $this->_allowed_file_type);
    }

    function _is_allowd_size($size) {
        if (!$this->_allowed_file_size) {
            return true;
        }

        return is_numeric($this->_allowed_file_size) ?
                ($size <= $this->_allowed_file_size) :
                ($size >= $this->_allowed_file_size[0] && $size <= $this->_allowed_file_size[1]);
    }

    /**
     *    获取上传文件的信息
     *

     *    @param    none
     *    @return    void
     */
    function file_info() {
        return $this->_file;
    }

    /**
     *    若没有指定root，则将会按照所指定的path来保存，但是这样一来，所获得的路径就是一个绝对或者相对当前目录的路径，因此用Web访问时就会有问题，所以大多数情况下需要指定
     *  
     *    @param    none
     *    @return    void
     */
    function root_dir($dir) {
        $this->_root_dir = $dir;
    }

    /**
     * 保存图片将图片从临时的文件目录移动到服务器指定的目录
     * @param  $dir 文件保存的路径
     * @param  $name 保存的文件名
     * @return  返回移动图片的结果，成功则返回TRUE，失败返回FALSE
     */
    function save($dir, $name = false) {
        if (!$this->_file) {
            return false;
        }
        if (!$name) {
            $name = $this->random_filename() .".". $this->_file['extension'];
        } else {
            $name .= '.' . $this->_file['extension'];
        }
        $path = $dir . '/' . $name;
        return $this->move_uploaded_file($this->_file['tmp_name'], $path);
    }

    /**
     *    将上传的文件移动到指定的位置
     *
     *    @param     string $src
     *    @param     string $target
     *    @return    bool
     */
    function move_uploaded_file($src, $target) {
        $abs_path = $this->_root_dir ? $this->_root_dir . '/' . $target : $target;
        $dirname = dirname($abs_path);
        if(!file_exists($dirname)){
            mkdir($dirname,0755,true);
        }
        if (move_uploaded_file($src, $abs_path)) {
            @chmod($abs_path, 0755);
            return $target;
        } else {
            return false;
        }
    }
    /**
     * 生成随机的文件名
     */
    function random_filename() {
        $seedstr = explode(" ", microtime(), 5);
        $seed = $seedstr[0] * 10000;
        srand($seed);
        $random = rand(1000, 10000);

        return date("YmdHis", time()) . $random;
    }

    function _error($msg, $obj = '') {
        if (is_array($msg)) {
            $this->_errors = array_merge($this->_errors, $msg);
        } else {
            $this->_errors[] = compact('msg', 'obj');
        }
    }

    function get_error() {
        $errors = $this->_errors;
        $error_log = '';
        foreach ($errors as $error) {
            $error_log.=$error['msg'] . '&nbsp;';
        }
        return $error_log;
    }

}

?>