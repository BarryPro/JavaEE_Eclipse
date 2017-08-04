<!-- 通用配置. -->
<script src="<%=request.getContextPath()%>/njs/extend/jquery/main_window_show_div.js" type="text/javascript"></script>
<!-- 通用样式配置. -->
<style type="text/css"> 
.show_window_dialog {background-color: white; border:  #A6C9E2 2px solid; position: absolute; }
.dialog_title {height: 23px; cursor: move; background:#2191C0 url(<%=request.getContextPath()%>/nresources/default/images/callimage/images_div_window/bg_title.png) repeat-x scroll 50% 50%; }
.title_left{ float: left; text-align: left; font: bold ; color: white;}
.title_right{ float: right; text-align: right;}
.close_img{ background: url(<%=request.getContextPath()%>/nresources/default/images/callimage/images_div_window/close.gif) 120% 120% ;}
</style>
<!-- .*************测试弹出窗口开始.***************** -->
<script type="text/javascript">
//-- //初始化拖拽.对应窗口ID.
$(function() {
    $("#show_window_dialog_test_id").draggable();
});
</script>
<!-- 测试窗口开始. style下面配置弹出窗口大小.-->
<div id="show_window_dialog_test_id" class="show_window_dialog" style="top: 25px; left: 314px; width: 800px;height: 650px;">
	<div id="title"  class="dialog_title">
		<div class="title_left"> title</div>
		<div class="title_right"> 
			<a href="#" onclick="window.show_window_dialog_test_iframe.location.reload();">
			<img height="18px" width="18px" 
			src="<%=request.getContextPath()%>/nresources/default/images/callimage/images_div_window/reload.gif"
			 border="0"/></a>
			<a href="#" onclick="document.getElementById('show_window_dialog_test_id').style.display='none';">
			<img height="18px" width="18px" 
			src="<%=request.getContextPath()%>/nresources/default/images/callimage/images_div_window/close.gif"
			 border="0"/></a>
		</div>
	</div>
  <div><!-- 下面是内容开始显示. -->
  <iframe width="100%" height="100%" name="show_window_dialog_test_iframe" src="<%=request.getContextPath()%>/test/test_reason/callreson2.jsp">
  </iframe>
  </div>
</div>
<!-- .*************测试弹出窗口结束.***************** -->