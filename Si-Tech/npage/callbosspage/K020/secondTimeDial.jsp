<%
  /*
   * 功能: 二次拨号
　 * 版本: 1.1.0
　 * 日期: 
　 * 作者: 
　 * 版权: 
   * update: libin 二次拨号修改
   *         chengh 二次拨号修改 20090318
　 */
%>



<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>二次拨号</title>
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
 <!-- <div class="groupItem" id="div1_show"><div id="get_rest_title">二次拨号</div>
	</div> -->
	<form name="sitechform" method="post">
	<div class="layer_content">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="blue" height="25px" align="right">
						电话号码：
						</td>
						<td>
							<input type="text" name="secondDial" value="" onKeyup="timeCall(this.value);">
						</td>
					</tr>
					<tr>
						<td class="blue" height="25px" align="right">
							<input type="checkbox" name="secondDialnow" value="1" onclick="checkedbox()" checked >
						</td>
						<td>即拨即送</td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="footer" align=center>
							<input class="b_foot" name="submit1" type="button" value="确认" onclick="submitConfig()">
							<input class="b_foot" name="cancel" type="button" onclick="goaway();" value="取消" >
						</td>
					</tr>
				</table>
   </div>
	</form>
</body>
</html>
<script language="javascript">
document.sitechform.secondDial.focus();
//选中复选框后聚焦到输入框  by chengh 2009-03-18
function submitConfig()
{
	/**
var returnvalue="";
//alert(document.getElementById("secondDialnow").checked);
if(document.getElementById("secondDialnow").checked)
returnvalue="1";
//alert(document.getElementById("secondDial").value+"isnowsend"+returnvalue); 
window.returnValue=document.getElementById("secondDial").value+"isnowsend"+returnvalue; 
 **/
//声明二次拨号对象
  var tf = document.sitechform.secondDialnow;
	//声明电话号码文本对象
  var tv = document.sitechform.secondDial.value;
  if(tv==""){
  	window.opener.similarMSNPop("请输入电话！");
  	return false;
  }else{
  	if(tf.checked){
     window.opener.cCcommonTool.AgentSendDTMF(tv);//触发二次拨号事件  
     window.close();	
    }else{
    	window.opener.cCcommonTool.AgentSendDTMF(tv);//触发二次拨号事件
    	document.sitechform.secondDial.value = "";
    	return false;
    }
  } 
}

function goaway()
{
window.returnValue="cancel";   
window.close();
}

//实现在用户选择即拨即送时，触发的文本框实时事件  by libin 2009-03-16
//实现在用户选择即拨即送时，触发的文本框实时事件  by chengh 2009-03-18
//选中复选框后聚焦到输入框  by chengh 2009-03-18
function timeCall(value){
	//声明即拨即送checkbox对象
	var tf = document.sitechform.secondDialnow;
	//声明电话号码文本对象
	var tv = document.sitechform.secondDial.value;
	var rs = tv.replace(new RegExp('#', 'g'), '');
	var ts = rs.split("*");
	var flag = true;
	for(var i = 0; i < ts.length; i++){
		if(isNaN(ts[i])){
			flag = false;
			break;
		}
	}
	if(tf.checked){
		//document.sitechform.secondDial.focus();
		if(flag){//判断是否数字或是*
			var num = tv.substring(tv.length-1);
		  window.opener.cCcommonTool.AgentSendDTMF(num);
	  }else{
	  	//window.opener.rdShowMessageDialog("必须是数字",1);
			window.opener.similarMSNPop("必须是数字或*、#字符");
      document.sitechform.secondDial.value=tv.substring(0,tv.length-1);
      //return false;
	    
	  }
  }
	
}
//选中复选框后聚焦到输入框  by chengh 2009-03-18
function checkedbox (){
	document.sitechform.secondDial.focus();
		var tf = document.sitechform.secondDialnow;
		if(!tf.checked){
	     document.sitechform.secondDial.value="";
	  }
}
</script>