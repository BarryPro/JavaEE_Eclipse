<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	 String opName= "APN名称配置";
	 String regionCode = (String)session.getAttribute("regCode");
	 String queryAPNsql = "select apnname ,apncode from dg3op_apnconfig";
%>
  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=queryAPNsql%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end"  />
<%
String apnName = "";
String apnCode = "";
if(result_t.length>0){
	apnName =result_t[0][0]; 
	apnCode =result_t[0][1]; 
}
		System.out.println("-----------g3op--apnName---------"+apnName);
		System.out.println("-----------g3op--apnCode---------"+apnCode);
%>		
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>APN名称配置</title>
<script type="text/javascript" >
	
function doCfm(){
	if($("#apnName").val().trim()==""){
		rdShowMessageDialog("请输入APN名称");
		retrun;
	}
	if($("#apnCode").val().trim()==""){
		rdShowMessageDialog("请输入APN代码");
		retrun;
	}
	var opflag = "";
	if("<%=apnCode%>"==""||"<%=apnName%>"==""){//第一次绑定没有查到就新增
		opflag = "0"
	}else{
		opflag = "1"
	}
	var apcConfigPacket = new AJAXPacket("ajaxConfigApn.jsp","正在执行,请稍后...");	
		apcConfigPacket.data.add("apnName",$("#apnName").val().trim());
		apcConfigPacket.data.add("apnCode",$("#apnCode").val().trim());
		apcConfigPacket.data.add("opflag",opflag);
		core.ajax.sendPacket(apcConfigPacket,doDoCfm);
		apcConfigPacket = null; 
}
function doDoCfm(packet){
	var success = packet.data.findValueByName("code"); 
	if(success=="000000"){
		rdShowMessageDialog("APN配置成功",2);
		window.close();
	}else{
		rdShowMessageDialog("APN配置失败",0);
		return;
	}
}
 
</script>
</head>
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">APN名称配置</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							
			<td class="blue" >APN名称</td>
		<td class="blue"><input type="text" id="apnName" name="apnName" value="<%=apnName%>" />
			<font class="orange">*</font>
		</td>
			<td class="blue" >APN代码</td>
		<td class="blue"><input type="text" id="apnCode" name="apnCode"  value="<%=apnCode%>" />
			<font class="orange">*</font>
		</td>
						</tr>
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add"   type=button value="确定" onclick="doCfm()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="取消" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>
				</div>
			</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<script type="text/javascript">
 
</script> 
</body>
</html>