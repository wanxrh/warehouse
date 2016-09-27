<?php

/*
 * 管理员基础类
 */

class Admin_Controller extends CI_Controller {

    function __construct() {
        parent::__construct();
        header("Content-type: text/html; charset=utf-8");
        if (!isset($_COOKIE['nzsys_c'])) {
            header('Location: ' . $this->config->item('domain_nzsys'));
        }
    }

}