<?php

//查询多条语句的封装函数
function selectMore($field = '*', $table, $where = 1, $order = 'order by id asc', $offset = 0, $perpage = 1000) {
	$sql = "select $field from `$table` where $where $order limit $offset,$perpage"; //查询news表里面的12条内容
	$query = mysql_query($sql); //执行上面的语句
	$list = array(); //新建一个数组
	while ($row = mysql_fetch_assoc($query)) {//循环news表里面的那12条内容
		$list[] = $row; //把执行出来的每一条内容赋值给list这个数组
	}
	return $list;
}


//查询一条语句的封装函数
function selectOne($field, $table, $where) {
	$sql = "select $field from `$table` where $where"; //用提交上来账号密码去数据库找到相对应的账号密码	
	$query = mysql_query($sql); //执行上面的sql语句
	$row = mysql_fetch_assoc($query); //如果数据库里面找到了跟提交上来的账号密码相同，这里才会有内容
	//print_r($row);
	return $row;
}



//增加一条语句的封装函数
function add($table, $data) {
	$str_key = '';
	$str_val = '';
	foreach ($data as $key => $val) {
		$str_key.='`' . $key . '`,';
		$str_val.="'" . $val . "',";
	}
	$str_key = substr($str_key, 0, -1);
	$str_val = substr($str_val, 0, -1);
	$sql = "insert into `$table` ($str_key) values($str_val)";
	$query = mysql_query($sql);
	return $query;
}



//修改一条语句的封装函数
function update($table, $where, $date) {
	$str_set = '';
	foreach ($date as $key => $val) {
		$str_set.="`" . $key . "`='" . $val . "',";
	}
	$str_set = substr($str_set, 0, -1);
	$sql = "update `$table` set $str_set where $where";
	$query = mysql_query($sql);
	return $query;
}



//删除一条语句的封装函数
function delete($table, $where) {
	$sql = "delete from `$table` where $where";
	$query = mysql_query($sql);
	return $query;
}


?>