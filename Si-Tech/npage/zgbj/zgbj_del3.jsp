<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zgbj";
    String opName = "���յ��ӷ�Ʊ��������";
	String hth=request.getParameter("hth");
	String gmf =  request.getParameter("gfhm");
	String stype =  request.getParameter("stype");
	String gmfmc =request.getParameter("gfhmmc"); 
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String s_op_note="���յ��ӷ�Ʊ��������";
%>
   
<wtc:service name="bs_zgbjCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:param value="<%=hth%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=gmf%>"/>
			<wtc:param value="<%=gmfmc%>"/>
			<wtc:param value="<%=s_op_note%>"/>
			<wtc:param value="<%=stype%>"/>
		 
 
		 	
</wtc:service>
  
<wtc:array id="result1" scope="end" />
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>���յ��ӷ�Ʊ��������</TITLE>
</HEAD>
<body>
<%
	if(retCode2=="000000" ||retCode2.equals("000000") )
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("ɾ���ɹ���");
				window.location.href="zgbj_del.jsp";
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("ɾ��ʧ�ܣ��������:"+"<%=retCode2%>,����ԭ��:"+"<%=retMsg2%>");
				window.location.href="zgbj_del.jsp";
			</script>
		<%
	}
%>

 
</BODY></HTML>

