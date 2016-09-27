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
 * @author 温守力
 *
 */
function page($page, $pages, $url_format = '%d.html', $show_page = 5, $show_pages = TRUE, $show_goto = TRUE, $total = NULL) {
    if ($page > $pages) {
        $page = $pages;
    }

    if ($pages < 2)
        return '';
    $html = array();
    $html [] = '<div class="u-pageMain">';

    if ($page > 1) {
        $html [] = '<a title="查看第' . ($page - 1) . '页" class="u-prev" href="' . sprintf($url_format, $page - 1) . '">&lt;&nbsp;上一页</a>';
    }

    $page_start = $page - intval($show_page / 2);
    if ($page_start < 1)
        $page_start = 1;

    if ($page_start > 1) {
        $html [] = '<a title="查看第' . 1 . '页" href="' . sprintf($url_format, 1) . '">' . 1 . '</a>';
        if ($page_start > 2) {
            $html [] = '<span class="u-mid">...</span>';
        }
    }


    for ($i = 0; $i < $show_page; $i ++) {
        $cur = $page_start + $i;
        if ($cur > $pages)
            break;

        if ($cur == $page) {
            $html [] = '<a href="javascript:;" class="u-sel">' . $cur . '</a>';
        } else {
            $html [] = '<a title="查看第' . $cur . '页" href="' . sprintf($url_format, $cur) . '">' . $cur . '</a>';
        }
    }
    if ($cur < $pages) {
        if ($cur + 1 < $pages) {
            $html [] = '<span class="u-etc">...</span>';
        }
        $html [] = '<a title="查看第' . $pages . '页" href="' . sprintf($url_format, $pages) . '">' . $pages . '</a>';
    }

    if ($page < $pages) {
        $html [] = '<a title="查看第' . ($page + 1) . '页" class="u-next" href="' . sprintf($url_format, $page + 1) . '"><span>下一页&nbsp;&gt;</span><b class="trigon"></b></a>';
    }

    if ($show_pages) {
        $html [] = '<span class="u-go-page"><em>共 ' . $pages . ' 页</em></span>';
    }

    if ($total !== NULL) {
        $html [] = '<span class="u-go-page"><em>共 ' . $total . ' 条</em></span>';
    }

    if ($show_goto) {
        $next_page = $pages < 2 ? $page : ($page >= $pages ? $page - 1 : $page + 1);

        $str = explode('%d', $url_format);
        $html [] = '<form class="u-page-form" onsubmit="var p;location.href=\'' . $str [0] . '\'+((p=parseInt(this.getElementsByTagName(\'input\')[0].value))>0?p:1)+\'' . $str [1] . '\';return false;">到第 
                       <span><input class="u-ipt-txt" type="text" size="1" name="page" value="' . $next_page . '"></span> 页
                       <input type="submit" class="u-page-submit" value="确定">
                    </form>';
    }
    $html [] = '</div>';

    return implode($html);
}
function app_page($page, $pages, $url_format = '%d.html', $show_page = 5, $show_pages = TRUE, $show_goto = TRUE, $total = NULL) {
	if ($page > $pages) {
		$page = $pages;
	}

	if ($pages < 2)
		return '';
	$html = array();
	$html [] = '<div class="u-pageMain">';

	if ($page > 1) {
		$html [] = '<a title="查看第' . ($page - 1) . '页" class="u-prev" href="' . sprintf($url_format, $page - 1) . '">&lt;</a>';
	}

	$page_start = $page - intval($show_page / 2);
	if ($page_start < 1)
		$page_start = 1;

	if ($page_start > 1) {
		$html [] = '<a title="查看第' . 1 . '页" href="' . sprintf($url_format, 1) . '">' . 1 . '</a>';
		if ($page_start > 2) {
			$html [] = '<span class="u-mid">...</span>';
		}
	}


	for ($i = 0; $i < $show_page; $i ++) {
		$cur = $page_start + $i;
		if ($cur > $pages)
			break;

		if ($cur == $page) {
			$html [] = '<a href="javascript:;" class="u-sel">' . $cur . '</a>';
		} else {
			$html [] = '<a title="查看第' . $cur . '页" href="' . sprintf($url_format, $cur) . '">' . $cur . '</a>';
		}
	}
	if ($cur < $pages) {
		if ($cur + 1 < $pages) {
			$html [] = '<span class="u-etc">...</span>';
		}
		$html [] = '<a title="查看第' . $pages . '页" href="' . sprintf($url_format, $pages) . '">' . $pages . '</a>';
	}

	if ($page < $pages) {
		$html [] = '<a title="查看第' . ($page + 1) . '页" class="u-next" href="' . sprintf($url_format, $page + 1) . '"><span>&gt;</span><b class="trigon"></b></a>';
	}

	if ($show_pages) {
		$html [] = '<span class="u-go-page"><em>共 ' . $pages . ' 页</em></span>';
	}

	if ($total !== NULL) {
		$html [] = '<span class="u-go-page"><em>共 ' . $total . ' 条</em></span>';
	}

	if ($show_goto) {
		$next_page = $pages < 2 ? $page : ($page >= $pages ? $page - 1 : $page + 1);

		$str = explode('%d', $url_format);
		$html [] = '<form class="u-page-form" onsubmit="var p;location.href=\'' . $str [0] . '\'+((p=parseInt(this.getElementsByTagName(\'input\')[0].value))>0?p:1)+\'' . $str [1] . '\';return false;">到第
                       <span><input class="u-ipt-txt" type="text" size="1" name="page" value="' . $next_page . '"></span> 页
                       <input type="submit" class="u-page-submit" value="确定">
                    </form>';
	}
	$html [] = '</div>';

	return implode($html);
}
function simple_page($page, $pages, $url_format = '%d.html', $show_page = 5) {
	if ($page > $pages) {
		$page = $pages;
	}

	if ($pages < 2)
		return '';
	$html = array();
	$html [] = '<div class="u-pageMain">';

	if ($page > 1) {
		$html [] = '<a title="查看第' . ($page - 1) . '页" class="u-prev" href="' . sprintf($url_format, $page - 1) . '">&lt;&nbsp;上一页</a>';
	}

	$page_start = $page - intval($show_page / 2);
	if ($page_start < 1)
		$page_start = 1;


	if ($page < $pages) {
		$html [] = '<a title="查看第' . ($page + 1) . '页" class="u-next" href="' . sprintf($url_format, $page + 1) . '"><span>下一页&nbsp;&gt;</span><b class="trigon"></b></a>';
	}


	$html [] = '</div>';

	return implode($html);
}

