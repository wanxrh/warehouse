<?php

/**
 * 生成分页html
 *
 * @param $page          当前页
 * @param $pages         总页数
 * @param $url_format    链接格式，配合sprintf函数
 * @param $show_page     显示页码数，默认为5
 * @param $show_pages    显示总页数，默认true
 * @param $show_goto     显示页面跳转，默认为true
 * @param $total         显示条数，默认为NULL,表示不显示，若为其它则显示。
 *
 * @author LILI
 *
 */
function page($page, $pages, $url_format = '%d.html', $show_page = 5, $show_pages = TRUE, $show_goto = TRUE, $total = NULL) {
    if ($page > $pages) {
        $page = $pages;
    }

    if ($pages < 2)
        return '';
    $html = array();
    $html [] = '<div class="pagin">';
    
    $html [] = '<div>'; 
    
    if ($total !== NULL) {
    	$html [] = '共<i class="blue">'.$total.'</i>条记录，';
    }   
    if ($show_pages) {
    	$html [] = '共&nbsp;<i class="blue">'.$pages.'&nbsp;</i>页';
    }
    $html [] = '</div>';
    $html [] = '<ul class="paginList">';
    
    if ($page > 1) {
    	$html [] = '<li class="paginItem"><a title="查看第' . ($page - 1) . '页" href="'.sprintf($url_format, $page - 1).'">上一页</a></li>';
    }
    $page_start = $page - intval($show_page / 2);
    if ($page_start < 1)
    	$page_start = 1;
    
    if ($page_start > 1) {
    	$html [] = '<li class="paginItem"><a href="'.sprintf($url_format, 1).'">1</a></li>';
    	if ($page_start > 2) {
    		$html [] = '<li class="paginItem more"><a href="javascript:;">...</a></li>';
    	}
    }
    for ($i = 0; $i < $show_page; $i ++) {
    	$cur = $page_start + $i;
    	if ($cur > $pages)
    		break;
    
    	if ($cur == $page) {
    		$html [] = '<li class="paginItem current"><a href="javascript:;" class="current">'.$cur.'</a></li>';
    	} else {
    		$html [] = '<li class="paginItem"><a href="'.sprintf($url_format, $cur).'">'.$cur.'</a></li>';
    	}
    }
    if ($cur < $pages) {
    	if ($cur + 1 < $pages) {
    		$html [] = '<li class="paginItem more"><a href="javascript:;">...</a></li>';
    	}
    	$html [] = '<li class="paginItem"><a href="'.sprintf($url_format, $pages).'">'.$pages.'</a></li>';
    }
    
    if ($page < $pages) {
    	$html [] = '<li class="paginItem"><a title="查看第' . ($page + 1) . '页" href="'.sprintf($url_format, $page + 1).'">下一页</a></li>';
    }
    
    if ($show_goto) {
    	$next_page = $pages < 2 ? $page : ($page >= $pages ? $page - 1 : $page + 1);
    
    	$str = explode('%d', $url_format);
    	$html [] = '<form style="display: inline; float: left; padding: 3px 0 0 5px;" class="u-page-form" onsubmit="var p;location.href=\'' . $str [0] . '\'+((p=parseInt(this.getElementsByTagName(\'input\')[0].value))>0?p:1)+\'' . $str [1] . '\';return false;">到第 <input class="u-ipt-txt" style="border: 1px solid #999; padding: 3px;width:30px;" type="text" size="1" name="page" value="' . $next_page . '">  页 <input type="submit" class="u-page-submit" value="确定" style="background-color: #f6f6f6; border: 1px solid #454545; padding: 2px 5px;"> </form>';
    }
    
    $html [] = '</ul>';
    $html [] = '</div>';

    return implode($html);
}