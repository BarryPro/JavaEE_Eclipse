<%
/********************
 version v2.0
开发商: si-tech
********************/
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>



<HTML>
<HEAD>
    <TITLE>黑龙江移动BOSS</TITLE>
<%
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
    String op_code="1138";
	String opCode="1138";
	String opName="入网发票补打";
	String regionCode = org_code.substring(0,2);
	String result[][] = new String[][]{};
	String[] inParas = new String[11];
	inParas[0] =request.getParameter("beginPhoneNo");
	inParas[1] = "0";
	inParas[2] = "0";
	inParas[3] = request.getParameter("opAccept");
	inParas[4] = request.getParameter("vLogin_no");
	inParas[5] = request.getParameter("innetTime");
	inParas[6] = op_code;
	inParas[7] = work_no;
	inParas[8] = "0";
	inParas[9] = request.getParameter("pay_money");
	inParas[10] = nopass;
	//xl
%>
<wtc:service name="sbillReprint" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	
	
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>

	
  <%
	result = sVerifyTypeArr;
	String return_code  =  result[0][0];
%>

<SCRIPT LANGUAGE="JavaScript">
<%
	if (return_code.equals("000000") ||return_code.equals("0")){
	%>

			document.location.replace("f1138_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
<%
	}else{%>
	    	
			rdShowMessageDialog("<%=return_code%>工号授权失败！插入表wRePrint 失败",0);
			document.location.replace("f1138_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
<%}%>
</SCRIPT>

