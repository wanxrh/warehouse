<?php $this->load->view('admin/header'); ?>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/city.min.js"></script>
<script type="text/javascript" src="<?php echo $this->config->base_url(); ?>static/js/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>
<style>
   #city_4 select{width: 100px;}
   img {
	   max-width: 	none;
   }
</style>
<div class="main_body">

	<div class="span9 page_message">
		<section id="contents">
			<ul class="tab-nav nav">

			</ul>
			<div class="tab-content">
				<!-- 表单 -->
				<form id="form" action="" method="post" class="form-horizontal form-center">
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							地区
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
                           <div id="city_4">
                            <select class="prov" name="provinces"></select>
                            <select class="city" disabled="disabled" name="city"></select>
                            <select class="dist" disabled="disabled" name="county"></select>
                        </div>

						</div>
					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							详细地址：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<input type="text" name="address"></input>
							</label>
						</div>
					</div>
					<div class="form-item cf toggle-title">
							<label >查找地点：</label>
							<input id="where" name="where" type="text" >
							<input type="button" value="地图上找" onClick="sear(document.getElementById('where').value);" />



							<div style="width:520px;height:340px;border:1px solid gray" id="container"></div>


							经纬度：
							<input id="lonlat" name="latitude" type="text" ><a href="javascript:void(0);" id="dianji">获取经纬度</a>

					</div>
					<div class="form-item cf toggle-title">
						<label class="item-label">
							<span class="need_flag">*</span>
							代理人微信ID：
							<span class="check-tips"> </span>
						</label>
						<div class="controls">
							<label class="textarea">
								<select name="open_id" style="width: 350px;">
									<?php foreach($qrcode as $item):?>
									<option value="<?php echo $item['openid'];?>"><?php echo $item['remark'].'：'.$item['openid'];?></option>
									<?php endforeach;?>
								</select>
							</label>
						</div>
					</div>
					<div class="form-item cf toggle-title copy-node">
						<label class="item-label">
							<span class="need_flag">*</span>
							商品名：
							<span class="check-tips"> </span>
						</label>
						<div class="per">
							<div class="controls">
								<label class="textarea">
									<select name="goods_id[]" style="width: 400px;">
										<?php foreach($goods as $val):?>
										<option value="<?php echo $val['id'];?>"><?php echo $val['title'];?></option>
										<?php endforeach;?>
									</select>
								数量：<input type="text" name="number[]">  <a href="javascript:void(0);" class="clone">添加</a>
								</label>
							</div>
						</div>
					</div>
			
			</div>
			<div class="form-item form_bh">
				<button class="btn submit-btn ajax-post" id="submit" type="submit" target-form="form-horizontal">确 定</button>
			</div>
			</form>

		</section>
	</div>


</div>

</div>
</div>
<script type="text/javascript">
            $(function() {
               $("#city_4").citySelect({
                    prov: "广西",
                    city: "南宁",
                    dist: "西乡塘区",
                    nodata: "none"
                });
				$(".clone").click(function(){
					var html = '';
						html+='<div class="controls  del-clone">';
						html+='<label class="textarea">';
						html+='<select name="goods_id[]" style="width: 400px;">';
						html+="<?php foreach($goods as $val):?>";
						html+='<option value="<?php echo $val['id'];?>"><?php echo $val['title'];?></option>';
						html+="<?php endforeach;?>";
						html+="</select>";
						html+=' 数量：<input type="text" name="number[]">&nbsp;<a href="javascript:void(0);" class="clone2">删除</a>';
						html+= '</label> </div>';
					$(".per").append(html);
					//$(".copy-node").eq(0).clone().insertAfter(".per");

				});
				$(document).on('click',".clone2",function (e) {
					$(this).parent().parent(".del-clone").remove();
				});


			});
        </script>
	<script type="text/javascript">
		//在指定的容器内创建地图实例
		var map = new BMap.Map("container");

		map.setDefaultCursor("crosshair");//设置地图默认的鼠标指针样式
		map.enableScrollWheelZoom();//启用滚轮放大缩小，默认禁用。
		//创建点坐标
		var point = new BMap.Point(108.3280880000,22.8250290000);
		//初始化地图，设置中心点坐标和地图级别
		map.centerAndZoom(point, 13);
        //panTo()方法 等待两秒钟后-让地图平滑移动至新中心点
//        window.setTimeout(function(){
//            map.panTo(new BMap.Point(108.384838, 22.892839)); }, 1000);
//***********************地址解析类
		var gc = new BMap.Geocoder();
		//向map中添加--------------------------------------控件
//NavigationControl 地图平移缩放控件，默认位于地图左上方 它包含控制地图的平移和缩放的功能。
		map.addControl(new BMap.NavigationControl());
		//OverviewMapControl 缩略地图控件，默认位于地图右下方，是一个可折叠的缩略地图
		map.addControl(new BMap.OverviewMapControl());
		//ScaleControl：比例尺控件，默认位于地图左下方，显示地图的比例关系。
		map.addControl(new BMap.ScaleControl());
		//MapTypeControl：地图类型控件，默认位于地图右上方。
		map.addControl(new BMap.MapTypeControl());
		//CopyrightControl：版权控件，默认位于地图左下方
		map.addControl(new BMap.CopyrightControl());

		//----------------------------------------------地图覆盖物
		/**地图API提供了如下几种覆盖物：
		 Overlay：覆盖物的抽象基类，所有的覆盖物均继承此类的方法。
		 Marker：标注表示地图上的点，可自定义标注的图标。
		 Label：表示地图上的文本标注，您可以自定义标注的文本内容。
		 Polyline：表示地图上的折线。
		 Polygon：表示地图上的多边形。多边形类似于闭合的折线，另外您也可以为其添加填充颜色。
		 Circle: 表示地图上的圆。
		 InfoWindow：信息窗口也是一种特殊的覆盖物，它可以展示更为丰富的文字和多媒体信息。注意：同一时刻只能有一个信息窗口在地图上打开。
		 可以使用map.addOverlay方法向地图添加覆盖物，使用map.removeOverlay方法移除覆盖物，注意此方法不适用于InfoWindow。
		 **/
// 创建标注
		var marker = new BMap.Marker(point);
		// 将标注添加到地图中
		map.addOverlay(marker);
		//********************************************监听标注事件
		//点击事件
		marker.addEventListener("click", function(e){
			document.getElementById("lonlat").value = e.point.lng + "," + e.point.lat;
		});


		//*******************************************可托拽的标注
		//marker的enableDragging和disableDragging方法可用来开启和关闭标注的拖拽功能。
		marker.enableDragging();
		//监听标注的dragend事件来捕获拖拽后标注的最新位置
		marker.addEventListener("dragend",function(e){
			gc.getLocation(e.point, function(rs){
				showLocationInfo(e.point, rs);
			});
		});

		//*****************************信息窗口
		//显示地址信息窗口
		function showLocationInfo(pt, rs){
			var opts = {
				width : 250,     //信息窗口宽度
				height: 150,     //信息窗口高度
				title : "当前位置"  //信息窗口标题
			}

			var addComp = rs.addressComponents;
			var addr = "当前位置：" + addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber + "<br/>";
			addr += "纬度: " + pt.lat + ", " + "经度：" + pt.lng;

			var infoWindow = new BMap.InfoWindow(addr, opts);  //创建信息窗口对象
			marker.openInfoWindow(infoWindow);
		}
		document.getElementById("dianji").addEventListener("click", function(e){
			document.getElementById("lonlat").value = marker.point.lng + "," + marker.point.lat;
		});

		map.addEventListener("click", function(e){//地图单击事件
			document.getElementById("lonlat").value = e.point.lng + "," + e.point.lat;
		});

		//**************************** 目前百度地图提供的图层包括：
		//TrafficLayer：交通流量图层
		// 创建交通流量图层实例
		var traffic = new BMap.TrafficLayer();
		// 将图层添加到地图上
		map.addTileLayer(traffic);

//		function iploac(result){//根据IP设置地图中心
//			var cityName = result.name;
//			map.setCenter(cityName);
//		}
		var myCity = new BMap.LocalCity();
		myCity.get(iploac);
		function sear(result){//地图搜索
			var local = new BMap.LocalSearch(map, {
				renderOptions:{map: map}
			});
			local.search(result);
		}
	</script>

	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-12599330-14']);
		_gaq.push(['_trackPageview']);

		(function() {
			var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		})();
	</script>
<?php $this->load->view('admin/footer'); ?>