<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String opCode =  request.getParameter("opCode");
  String opName =  request.getParameter("opName");
	String famChg =  request.getParameter("myJSONText");
	System.out.println("##############################ningtn fe759Cfm.jsp start [" + famChg + "]");
	String returnUrl = "";
	/*
	if("e759".equals(opCode)){
	*/
		returnUrl = "/npage/se761/fe759Login.jsp?opCode="+opCode+"&opName="+opName;
	/*
	}else if("e760".equals(opCode)){
		returnUrl = "";
	}
	*/
%>
	<wtc:utype name="sProdRevCfm" id="retVal" scope="end" 
		 routerKey="region" routerValue="<%=regionCode%>">
		<wtc:uparam value="<%=famChg%>" type="STRING"/>  
	</wtc:utype>
<%
	String retCode = retVal.getValue(0);
	String retMsg = retVal.getValue(1);
	retMsg = retMsg.replaceAll(System.getProperty("line.separator")," ");
	if("0".equals(retCode) || "000000".equals(retCode)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交成功！");
			location="<%=returnUrl%>";
		</script>
<%
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交失败！" + "<%=retCode%>," + "<%=retMsg%>");
			location="<%=returnUrl%>";
		</script>
<%
	}
%>