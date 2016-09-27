<?php

//header("Content-type:text/html;charset=gb2312");
//$client = new SoapClient("E:/WWW/nzw/sites/web.nzw.com/root/person.wsdl");
//$json = $client->login('123132132');
//print_r(json_decode($json,true));
//$json = $client->test(2091722367);
//print_r(json_decode($json,true));exit;
//$params['cpassword']='rrrr';
//$a = array('cpassword'=>'aaaaa');
//$json = $client->cpassword($a);
//echo $json;
//print_r(json_decode($json,true));exit;
//$json = $client->login('jiushanshan');
//print_r(json_decode($json,true));
//$location = "E:/WWW/nzw/sites/web.nzw.com/root/person.wsdl";
$soap_client = new SoapClient(null, array("location" => 'http://web.nzw.com/server.php', "uri" => 'aa'));
//$aaaaa = $soap_client->__soapCall('import_taobao', array('烟花烫WF2015春新品女装气质婉约宽松印花复古雪纺连衣裙 风掠@@223.44@@228.00@@http://gi1.md.alicdn.com/bao/uploaded/i1/TB1WzaXHpXXXXXaaXXXXXXXXXXX_!!0-item_pic.jpg@@1869@@风衣@@187@@2091722340@@no@@3', 'http://gi1.md.alicdn.com/bao/uploaded/i1/TB1WzaXHpXXXXXaaXXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg@@http://gi2.md.alicdn.com/imgextra/i2/822320219/TB2TsrDbVXXXXXlXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi4.md.alicdn.com/imgextra/i4/822320219/TB2YNzLbVXXXXXdXXXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi4.md.alicdn.com/imgextra/i4/822320219/TB2mf6zbVXXXXaxXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi1.md.alicdn.com/imgextra/i1/822320219/TB2z5HCbVXXXXXhXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg', '', '{";S;珍珠白[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633882,"stock":37},";S;浅水蓝[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633883,"stock":36},";M;珍珠白[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633884,"stock":62},";M;浅水蓝[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633885,"stock":55},";L;珍珠白[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633886,"stock":49},";L;浅水蓝[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633887,"stock":47},";XL;珍珠白[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633888,"stock":30},";XL;浅水蓝[预售4月15日发];":{"price":"179.00","priceCent":17900,"skuId":79192633889,"stock":30}}', '1813'));
//$aaaaa = $soap_client->__soapCall('import_taobao', array('烟花烫WF2015春新品女装气质婉约宽松印花复古雪纺连衣裙 风掠@@223.44@@228.00@@http://gi1.md.alicdn.com/bao/uploaded/i1/TB1WzaXHpXXXXXaaXXXXXXXXXXX_!!0-item_pic.jpg@@1869@@风衣@@187@@2091722340@@no@@1', 'http://gi1.md.alicdn.com/bao/uploaded/i1/TB1WzaXHpXXXXXaaXXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg@@http://gi2.md.alicdn.com/imgextra/i2/822320219/TB2TsrDbVXXXXXlXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi4.md.alicdn.com/imgextra/i4/822320219/TB2YNzLbVXXXXXdXXXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi4.md.alicdn.com/imgextra/i4/822320219/TB2mf6zbVXXXXaxXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi1.md.alicdn.com/imgextra/i1/822320219/TB2z5HCbVXXXXXhXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg', '', '{"stock": 154,"relatedAuctions": [{"current": false,"itemId": 9528612146,"itemNameList": ["三段","400g"]},{"current": false,"itemId": 26633236168,"itemNameList": ["三段","900g"]},{"current": true,"itemId": 41686649369,"itemNameList": ["三段","400g6件组合"]},{"current": false,"itemId": 37789953450,"itemNameList": ["三段","900g 2罐组合"]}]}', '1813'));
//$aaaaa = $soap_client->__soapCall('import_taobao', array('烟花烫WF2015春新品女装气质婉约宽松印花复古雪纺连衣裙 风掠@@223.44@@228.00@@http://gi1.md.alicdn.com/bao/uploaded/i1/TB1WzaXHpXXXXXaaXXXXXXXXXXX_!!0-item_pic.jpg@@1869@@风衣@@187@@2091722340@@no@@2', 'http://gi1.md.alicdn.com/bao/uploaded/i1/TB1WzaXHpXXXXXaaXXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg@@http://gi2.md.alicdn.com/imgextra/i2/822320219/TB2TsrDbVXXXXXlXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi4.md.alicdn.com/imgextra/i4/822320219/TB2YNzLbVXXXXXdXXXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi4.md.alicdn.com/imgextra/i4/822320219/TB2mf6zbVXXXXaxXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg@@http://gi1.md.alicdn.com/imgextra/i1/822320219/TB2z5HCbVXXXXXhXpXXXXXXXXXX_!!822320219.jpg_430x430q90.jpg', '', '', '1813'));
//$aaaaa = $soap_client->__soapCall('import_jd',array('黛萍 2015春季新款长袖休闲衬衫女装 27 XL@@129.00@@129.00@@http://img14.360buyimg.com/n1/jfs/t1213/68/61086018/192226/8ee4d813/54f86277Nb0702055.jpg@@1235@@羽绒服@@187@@2091722340','','http://img14.360buyimg.com/n5/jfs/t1213/68/61086018/192226/8ee4d813/54f86277Nb0702055.jpg@@http://img14.360buyimg.com/n5/jfs/t910/303/62406150/280153/f72fe4b5/54f86288Ne47ef297.jpg@@http://img14.360buyimg.com/n5/jfs/t571/352/1475798387/257305/a451099a/54f86289N11cb6ccd.jpg@@http://img14.360buyimg.com/n5/jfs/t589/323/1500704331/263223/79f6453b/54f8628aNca3b8f70.jpg@@http://img14.360buyimg.com/n5/jfs/t1129/251/68724635/236947/b0a0113/54f8628bNf39facb4.jpg@@http://img14.360buyimg.com/n5/jfs/t541/32/1510010782/201761/20fc0247/54f8628bN1441d9eb.jpg','27|1475203266|S@@27|1475203267|M@@27|1475203268|L@@27|1475203269|XL@@27|1475203270|XXL@@63|1475203271|S@@63|1475203272|M@@63|1475203273|L@@63|1475203274|XL@@63|1475203275|XXL@@66|1475203276|S@@66|1475203277|M@@66|1475203278|L@@66|1475203279|XL@@66|1475203280|XXL@@67|1475203281|S@@67|1475203282|M@@67|1475203283|L@@67|1475203284|XL@@67|1475203285|XXL@@68|1475203286|S@@68|1475203287|M@@68|1475203288|L@@68|1475203289|XL@@68|1475203290|XXL@@69|1475203291|S@@69|1475203292|M@@69|1475203293|L@@69|1475203294|XL@@69|1475203295|XXL@@70|1475203296|S@@70|1475203297|M@@70|1475203298|L@@70|1475203299|XL@@70|1475203300|XXL','1813'));
//$aaaaa = $soap_client->__soapCall('check_password',array('寂静枫叶林','123456a'));
//$aaaaa = $soap_client->__soapCall('get_order',array(2091722312));
//$aaaaa = $soap_client->__soapCall('get_url',array());
//$aaaaa = $soap_client->__soapCall('random',array(8));
//$aaaaa = $soap_client->__soapCall('delivery',array('3141','顺丰速递','32123423423','','星晴'));
//$aaaaa = $soap_client->__soapCall('store_goods',array(2091722313));
//$aaaaa = $soap_client->__soapCall('update_spec',array('9300','100'));
//$aaaaa = $soap_client->__soapCall('goods_show',array('161423','1'));
//$aaaaa = $soap_client->__soapCall('select_store', array('2091722313'));
//$aaaaa = $soap_client->__soapCall('get_user',array('121'));
//$aaaaa = $soap_client->__soapCall('get_id',array('寂静枫叶林'));
//$aaaaa = $soap_client->__soapCall('get_shipping', array('2222'));
$aaaaa = $soap_client->__soapCall('version', array('2.13'));
print_r(json_decode($aaaaa, true));
exit;

//$json = $client->get_friend('2091722309');
//print_r(json_decode($json,true));
?>