<?php
defined('BASEPATH') OR exit('No direct script access allowed');

if ( ! function_exists('ajaxError'))
{
    function ajaxError($info = '',$merge = NULL) {
    	$array = array(
            'status' => 0,
            'info'=>$info
        );
    	if(is_array($merge)){
    		$array = array_merge($array,$merge);
    	}
        exit(json_encode($array,TRUE));
    }
}

if ( ! function_exists('ajaxSuccess'))
{
    function ajaxSuccess($info = '',$merge = NULL) {
        $array = array(
            'status' => 1,
            'info'=>$info
        );
    	if(is_array($merge)){
    		$array = array_merge($array,$merge);
    	}
        exit(json_encode($array,TRUE));
    }
}

if( ! function_exists('goodsUrl'))
{
	function goodsUrl($goods_id){
		$CI = &get_instance();
		return $CI->config->base_url().'mall/detail/'.$goods_id;
	}
}

if( ! function_exists('imgUrl'))
{
	function imgUrl($url){
		$CI = &get_instance();
		return $CI->config->base_url().'imgs/'.$url;
	}
}

