 <script type="text/javascript">
	$(function(){
		//搜索功能
		$("#search").click(function(){
			var url = $(this).attr('url');;
	        var query  = $('.search-form').find('input').serialize();
	        query = query.replace(/(&|^)(\w*?\d*?\-*?_*?)*?=?((?=&)|(?=$))/g,'');
	        query = query.replace(/^&/g,'');
	        if( url.indexOf('?')>0 ){
	            url += '&' + query;
	        }else{
	            url += '?' + query;
	        }
	        if(query == '' ){
	        		url= $(this).attr('url');	        			        		
	        }
			window.location.href = url;
		});
	
	    //回车自动提交
	    $('.search-form').find('input').keyup(function(event){
	        if(event.keyCode===13){
	            $("#search").click();
	        }
	    });
	
	})
</script> 
<!-- 底部 -->
<div class="wrap bottom" style="background:#fff; border-top:#ddd;">
<p class="copyright">大官人生态农业开发公司</p>
</div>
     
 <!-- 用于加载js代码 -->
<!-- 页面footer钩子，一般用于加载插件JS文件和JS代码 -->
<div style='display:none'>
    
</div>
<div class="hidden"><!-- 用于加载统计代码等隐藏元素 -->
    
</div>

<!-- /底部 -->
</body>
</html>