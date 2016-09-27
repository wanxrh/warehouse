<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There area two reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router what URI segments to use if those provided
| in the URL cannot be matched to a valid route.
|
*/

$route['default_controller'] = "home";
$route['404_override'] = '';

$route['zs.html'] = "/business/index";
$route['jbzf.html'] = "/coin/pay";
$route['app.html'] = "/app/index";
$route['zs.html'] = "/home/attract";
$route['gyh.html'] = "/home/mobile";
$route['zdm.html'] = "/home/buy";
$route['baoyou-(:num).html'] = "/home/free/$1";
$route['item-(:num).html'] = "/home/details/$1";

//$route['list-(:num).html'] = 'help/index/$1';
//$route['cate-(:num).html'] = 'help/article/$1';
//$route['cate-(:num)-(:num).html'] = ' help/article/$1/$2';
//$route['info-(:num).html'] = 'help/article_info/$1';
/* End of file routes.php */
/* Location: ./application/config/routes.php */