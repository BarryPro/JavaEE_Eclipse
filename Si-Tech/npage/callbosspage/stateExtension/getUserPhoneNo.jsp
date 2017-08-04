<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<HTML>
  <head>
	<title>输入受理号码</title>
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

  </head>
	<BODY>

			<div class="groupItem" id="div1_show">
		<div class="itemHeader"><div id="get_rest_title">输入受理号码</div>
	</div>
			<div class="layer_content">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					
					<tr>
						<td class="blue">
							受理号码：
						</td>
						<td>
							 <input type="text" name="phoneNo" size="20" maxlength="11" onkeyDown="if(event.keyCode==13)sub1ExtendTime()"><font class="orange">*</font>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="footer" align=center>
							<input class="b_foot" name="submit1" type="button" value="确认"
								onclick="sub1ExtendTime()">
							<input class="b_foot" name="cancel" type="button"
								onclick="window.close();" value="取消">
						</td>
					</tr>
				</table>
			</div>

	</BODY>
</HTML>

	<script type="text/javascript">
	//document.getElementById("usedTime").value=window.opener.getExtendTime();
 function sub1ExtendTime()
 {
 var phoneNo=document.getElementById("phoneNo").value;
 		if(phoneNo=="")
		{
			rdShowMessageDialog("服务号码不能为空,请重新输入!",1);
			document.getElementById("phoneNo").focus();
			return false;
		}else if(!(/[1]{1}\d{10}/.test(phoneNo))){	
			rdShowMessageDialog("服务号码不正确,请重新输入!",1);
			document.getElementById("phoneNo").value="";
			document.getElementById("phoneNo").focus();
			return false;	
			
		}else if(phoneNo.length!=11)
		{
			rdShowMessageDialog("服务号码长度不正确,请重新输入!",1);
			document.getElementById("phoneNo").value="";
			document.getElementById("phoneNo").focus();
			return false;
		}
 //window.opener.inputPhoneNo=phoneNo;
 window.returnValue = phoneNo;
 window.close();
 }	
	</script>