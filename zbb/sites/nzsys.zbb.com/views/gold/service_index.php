<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>技术服务费列表</title>
        <link href="<?php echo $this->config->item('domain_static'); ?>common/css/global.css" rel="stylesheet"/>
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/common.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $this->config->item('domain_static'); ?>system/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>system/js/jquery.js"></script>
        <script type="text/javascript" src="<?php echo $this->config->item('domain_static'); ?>common/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
        <script type="text/javascript">
            $(document).ready(function() {
            	var log_id ;
                $(".btn_service").click(function() {
                	log_id = $(this).attr('locat');//logId
                    $("#logId").val(log_id);
                    $(".tip").fadeIn(200);
                });

                $(".tiptop a").click(function() {
                    $(".tip").fadeOut(200);
                });

                $(".cancel").click(function() {
                    $(".tip").fadeOut(100);
                });


            });
        </script>
    </head>

    <body>

        <div class="u-bd-tt">
            <span>位置：</span>
            <ul >
                <li>资金管理</li>
                <li><a href="/service">服务费列表</a></li>
            </ul>
        </div>

        <div class="g-mnr">

            <div class="tools">
                <form method="get" id="form" action="/service/index">
					时间从:
						<input id="add_time_from" class="dfinput" style="width:90px;" type="text" name="add_time_from" value="<?php echo $this->input->get('add_time_from', TRUE); ?>">
					至:
						<input id="add_time_to" class="dfinput" style="width:90px;" type="text" name="add_time_to" value="<?php echo $this->input->get('add_time_to', TRUE); ?>">
						<input type="submit" class="u-btn" value="查询" /> 
					　服务费总金额　:　<?php echo $amount; ?>
				</form>
			</div>

			<table class="tablelist">
				<thead>
					<tr>
						<th>编号</th>
                        <th>订单编号</th>
                        <th>互联支付交易编号</th>
                        <th>服务费金额</th>
                        <th>记录添加时间</th>
					</tr>
				</thead>
				<tbody>
				<?php foreach ($list as $item): ?>
					<tr>
						<td><?php echo $item['id'] ?></td>
                        <td><?php echo $item['order_id'] ?></td>
                        <td><?php echo $item['service_charges_sn'] ?></td>
                        <td><?php echo $item['money'] ?></td>
                        <td><?php echo $item['add_time'] ?></td>
					</tr>
				<?php endforeach; ?>  
                </tbody>
			</table>

			<div class="pagin">  	
				<ul class="paginList">
					<?php echo $page ?>
				</ul>
			</div>
		</div>
                                    
                                    <div class="tip">
                                    <form action="/service/service_pay" method="post" name="service_from">
                                        <div class="tiptop"><span>提示信息</span><a></a></div>

                                        <div class="tipinfo">

                                            <div class="tipright">
                                                <p>是否对技术服务费状态修改（格式：2016-3-7 14:18:07）</p>
                                                <cite>时间<input type="text" name="trading_time" class="dfinput" value="">
                                                <input type="hidden" name="log_id" id="logId" value="">
                                                </cite>
                                            </div>
                                        </div>

                                        <div class="tipbtn">
                                            <input name="" type="button" onclick="document.service_from.submit()"  class="sure" value="确定" />&nbsp;
                                            <input name="" type="button"  class="cancel" value="取消" />
                                        </div>
                                     </form>
                                    </div>


                                    <script type="text/javascript">
                                        $('.tablelist tbody tr:odd').addClass('odd');
                                    </script>

                                    </body>

                                    </html>
                                    
                                    <script type="text/javascript">


                                        $(function() {

                                            $('#add_time_from').focus(function() {
                                                WdatePicker({
                                                    skin: 'whyGreen',
                                                    dateFmt: 'yyyy-MM-dd',
                                                    maxDate: '#F{$dp.$D(\'add_time_to\');}'
                                                });
                                            });
                                            $('#add_time_to').focus(function() {
                                                WdatePicker({
                                                    skin: 'whyGreen',
                                                    dateFmt: 'yyyy-MM-dd',
                                                    minDate: '#F{$dp.$D(\'add_time_from\');}'
                                                });
                                            });
                                        });
                                        $("#click_xls").click(function() {
                                            $("#form").attr("action", "/service/export_xls");
                                            $("#form").submit();
                                            $("#form").attr("action", "/service/index");
                                        });


                                    </script>