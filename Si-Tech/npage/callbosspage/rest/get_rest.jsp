
<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>请假</title>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="<%=request.getContextPath() %>/nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
	
	<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>
	<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/sitechcallcenter.js"></script>
	<style type="text/css">
	#get_rest_title{
	text-align: left;
	height: 25px;
	width: 100%;
	float: left;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #FFFFFF;
    }
	</style>	
	<script type="text/javascript">
	function rest(){
		   
		   //判断当前是否在通话状态 by libin 20090601
		   if(window.opener.parPhone.GetCallSuccess == 1){
		     window.opener.similarMSNPop("正在通话,稍后操作");
		     return;		
		  }
	    /*
	     *需要对手机号码进行js前端的校验
	     */
	     var rest_time = '';
	     var radios = document.getElementsByName('rest_time');
	     for(var i = 0; i < radios.length; i++){
	        if(radios[i].checked){
	        	rest_time = radios[i].value;
	        }
	     }
		//window.opener.cCcommonTool.getRest(rest_time);
		window.opener.exeRest(rest_time);
		//window.close();
	}
	</script>
  </head>
  
  <body>
	<div class="groupItem" id="div1_show">
		<div class="itemHeader"><div id="get_rest_title">请假</div>
	</div>
	<table width="100%" cellspacing="0" cellpadding="0" border="0">
    	<tr>
			<td align="center" class="grey" width="100%">
			<input type="radio" name="rest_time" value="180">小休3分钟
			</td>
		</tr>
		<tr>
			<td align="center" class="grey" width="100%">
			<input type="radio" name="rest_time" value="300">中休5分钟
			</td>
		</tr>
		<tr>
			<td align="center" class="grey" width="100%">
			<input type="radio" name="rest_time" value="600">大休10分钟
			</td>
		</tr>
		<tr>
			<td align="center" class="grey" width="100%">
			<input type="button" name="btn_submit" value="确认" onClick="rest()">
			<input type="button" name="btn_submit" value="取消" onclick="window.close()">
			</td>
		</tr>																
	</table>
</body>
</html>
