<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:世博会取票二维码补发
   * 版本: 1.0
   * 日期: 2009/5/14
   * 作者: wangjya
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6922";
	String opName = "世博会取票二维码补发";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
onload=function()
{		
	init();
}

// 初始化
function init()
{
}
function commitJsp()
{
		getAfterPrompt();
		if(document.all.phone_no.value.trim().length != 11)
		{
			rdShowMessageDialog("手机号码必须为11位!");
			return false;					
		}
		if(document.all.phone_psw.value.trim().length <=0 && document.all.opFlag[0].checked == true)
		{
			rdShowMessageDialog("请输入用户密码!");
			return false;					
		}
		if(	document.all.opFlag[0].checked == true)
		{
			document.all.cust_type.value = "0";
		}
		else
		{
			document.all.cust_type.value = "1";
		}		
		document.all.phone_password.value = document.all.phone_psw.value.trim();
		frm6922.submit();
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true) 
	{
	  	
	  	document.all.back_password.style.display = "";
	  }else {
	  	document.all.back_password.style.display = "none";
	  	rdShowMessageDialog("异地客户请先通过'异地客户资料查询'验证用户密码!");
	  }

}


function Clear()
{
	document.all.phone_no.value = "";
	document.all.phone_psw.value = "";
}
</script> 
 
<title>世博会取票二维码补发</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f6922_2.jsp" method="post" name="frm6922"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="phone_password" value="">
	<input type="hidden" name="cust_type" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">世博会取票二维码补发</div>
	</div>
<table cellspacing="0" id="sel"  >
	<TR> 
	          <TD class="blue">用户类型</TD>
              <TD colspan=3>
        		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >本省用户&nbsp;&nbsp;
        		<input type="radio" name="opFlag" value="two" onclick="opchange()" >异地用户&nbsp;&nbsp;
	          </TD>
         </TR>                
	<tr> 
		<td class="blue" width="10%" >手机号码:</td>
		<td> 
			<input name="phone_no" type="text" id="phone_no" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)"></td>
    	</td>
    </tr>
	<tr id="back_password" > 
		<td class="blue"  width="10%" >用户密码:</td>
    	<td>
    	  	<jsp:include page="/npage/common/pwd_one_new.jsp">
			<jsp:param name="width1" value="16%"  />
			<jsp:param name="width2" value="34%"  />
			<jsp:param name="pname" value="phone_psw"  />
			<jsp:param name="pwd" value=""  />
			</jsp:include>
    	</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="commitJsp()">	
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="清除" onclick="Clear()">		
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
	 	<%@ include file="/npage/common/pwd_comm.jsp"%>
</form>
</BODY>
</HTML>
