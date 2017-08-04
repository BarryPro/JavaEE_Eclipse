



<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>他机验证</title>
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
	<div class="groupItem" id="div1_show">
		<!--<div class="itemHeader"><div id="get_rest_title">二次拨号</div>-->
	</div>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
						<td class="blue">
							本机验证<input type="radio" name="checkType" value="0" checked onclick="checkMode(this.value);">
							它机验证<input type="radio" name="checkType" value="1" onclick="checkMode(this.value);">
						</td>
					</tr>
					<tr>
						<td class="blue">
							电话号码：<input type="text" name="secondDial" value="13623654821" readOnly>
						</td>
					</tr>

				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="footer" align=center>
							<input class="b_foot" name="submit1" type="button" value="确认"
								onclick="submitConfig()">
							&nbsp;&nbsp;&nbsp;<input class="b_foot" name="cancel" type="button"
								onclick="goaway();" value="取消">
						</td>
					</tr>
				</table>
</body>
</html>
<script language="javascript">
function submitConfig()
{
var returnvalue="";
if(document.getElementById("secondDial").value=="")
{
   alert("请输入电话号码");
   document.getElementById("secondDial").focus();
   return;
}
if(document.getElementById("secondDialnow").checked)
returnvalue="1";
window.returnValue=document.getElementById("secondDial").value+"isnowsend"+returnvalue;   
window.close();
}
function goaway()
{
window.returnValue="cancel";   

window.close();
}

function checkMode(checkValue)
{
if(checkValue==0)
{
document.getElementById("secondDial").readOnly = true; 

}	
if(checkValue==1)
{
document.getElementById("secondDial").readOnly = false; 
}
}
</script>