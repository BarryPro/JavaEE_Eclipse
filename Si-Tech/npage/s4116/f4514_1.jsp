<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:一卡多号绑定信息查询
   * 日期: 2009/4/14
   * 作者: dujl
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String workNo=(String)session.getAttribute("workNo");
	StringBuffer  insql = new StringBuffer();


%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	

onload=function()
{		
	self.status="";
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
	
    self.status="";
    
    if(retType == "checkPwd") //密码校验
	{
		if(retCode == "000000")
		{
		    var retResult = packet.data.findValueByName("retResult");
		    if (retResult == "false") {
		    	rdShowMessageDialog("密码校验失败，请重新输入！",0);
		    	frm.user_passwd.value = "";
		    	return false;	        	
		    }
		    else
		    {
				rdShowMessageDialog("密码校验成功！",2);
				document.frm.doConfirm.disabled = false;
		    }
		}
		else
		{
		    rdShowMessageDialog("密码校验出错，请重新校验！",0);
			return false;
		}
	} 
}	


function check_HidPwd()
{
    var Pwd1 = document.all.user_passwd.value;
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("phone_no",document.frm.phoneNo.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function commitJsp()
{
	if(((document.all.phoneNo.value).trim()).length<1)
	{
		rdShowMessageDialog("手机号码不能为空！");
		return;
	}
	if( document.frm.phoneNo.value.length != 11 )
  	{
	     rdShowMessageDialog("号码只能是11位!");
	     document.frm.phoneNo.value = "";
	     return false;
  	}
    
	document.middle.location="f4514info.jsp?phoneNo="+document.frm.phoneNo.value+"&user_passwd="+document.frm.user_passwd.value;
	tabBusi.style.display="";
}
 		
</script> 
 
<title>一卡多号绑定信息查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">一卡多号绑定信息查询</div>
	</div>
<table cellspacing="0">             
	<tr> 
		<td class="blue" nowrap>手机号码</td>
		<td> 
			<input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_phoneNo();">
    	</td>
		<td class="blue">密码</td>
		<td> 
			<jsp:include page="/npage/common/pwd_1.jsp">
		      <jsp:param name="width1" value="16%"  />
		      <jsp:param name="width2" value="34%"  />
		      <jsp:param name="pname" value="user_passwd"  />
		      <jsp:param name="pwd" value="account_passwd"  />
	        </jsp:include>
	        <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass" value=校验>
            <font class="orange">*</font>
    	</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="doConfirm" class="b_foot" value="查询" onclick="commitJsp()" disabled>
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="清除" onclick="window.location='f4514_1.jsp'">
		</td>
	</tr>
</table>
<TABLE id="tabBusi" style="display:none" width="100%"  align="center" id="mainOne" cellspacing="0" border="0" >	
	<TR> 
		<td nowrap>
			<IFRAME frameBorder=0 id=middle name=middle scrolling="yes" 
			style="HEIGHT: 1200%; VISIBILITY: inherit; WIDTH: 99%; Z-INDEX: 1">
			</IFRAME>
		</td>
	</TR>
</TABLE>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>