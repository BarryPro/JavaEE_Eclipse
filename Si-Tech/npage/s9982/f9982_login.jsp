<%
/********************
 version v2.0
 ������: si-tech
 update wangjya at 2009.6.23
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	    response.setHeader("Pragma","No-cache");
	    response.setHeader("Cache-Control","no-cache");
	    response.setDateHeader("Expires", 0);
%>
<%

		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
%>

 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="retListString1"/>	
<HEAD>

<script language="JavaScript">
<!--
	
  onload=function()
 {
 	
  	if("<%=opCode%>" == "9982")
  	{
  		document.all.busyType[0].checked = true;
  		selectInput(document.all.busyType[0]);
  	}
  	else if("<%=opCode%>" == "9983")
  	{
  		document.all.busyType[1].checked = true;
  		selectInput(document.all.busyType[1]);
  	}
  	
 }
function selectInput(choose)
{
	document.frm.op_code.value = choose.value;
	document.frm.op_name.value = choose.text;
}
function commitjsp()
{
	//getAfterPrompt();
	if(document.frm.phone_no.value.trim().length != 11)
	{
		rdShowMessageDialog("�ֻ����������11λ!",0);
 	    document.frm.phone_no.focus();
 	    return false;
	}
   	if(document.frm.op_code.value == 9982)
   	{
   		document.frm.op_name.value = "sim��У԰Ӫ��������";
   		document.frm.action = "f9982_1.jsp";
   	}
   	else if(document.frm.op_code.value == 9983)
   	{
   		document.frm.op_name.value = "sim��У԰Ӫ��������";
   		document.frm.action = "f9982_1.jsp";
   	}
   
  	document.all.query.disabled = true;
	document.frm.submit();
}

-->
 </script>

<title>������BOSS-sim��У԰Ӫ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<BODY>
<form action="f9982_1.jsp" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	<input type="hidden" name="opCode" id="op_code" value="<%=opCode%>">
	<input type="hidden" name="opName" id="op_name" value="<%=opName%>">
	<input type="hidden" name="loginAccept" value="<%=retListString1%>">
	<table cellspacing="0">
		<tr>
			<td class="blue">��������</td>
			<td>
				<input  id="busyType" name="busyType" type="radio"  value="9982" checked  onclick="selectInput(this)">
				����
				<input id="busyType" name="busyType" type="radio"  value="9983" onclick="selectInput(this)">
				����
			</td>
		</tr>
		<tr>
			<TD  class="blue" width="20%">�ֻ�����</TD>
             <td> 
        		<input class="button"type="text" name="phone_no" id="phone_no" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) commitjsp();"><font class="orange">*</font>  
      		</td>
        </tr>
		<TR>
			<TD id="footer" align="center" colspan="2">
				<input type="button" name="query"  id = "query" class="b_foot" value="ȷ��" onclick="commitjsp()" >
				&nbsp;
				<input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
			</TD>
		</TR>
	</TABLE>
       <%@ include file="/npage/include/footer.jsp" %>   
</form>
 </BODY>
</HTML>
