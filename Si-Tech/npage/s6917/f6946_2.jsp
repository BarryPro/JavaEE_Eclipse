<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会手机票支付
   * 版本: 1.0
   * 日期: 2009/8/19
   * 作者: dujl
   * 版权: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6946";
	String opName = "世博会手机票支付";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	
	String printAccept = request.getParameter("printAccept");

	String inputParsm[] = new String[1];
	inputParsm[0] = printAccept;	
%>

   <wtc:service name="s692aCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="2">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="0" length="2"  scope="end"/>
<%
	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("打印成功！" + "<%=errMsg%>",0);	
	 	window.location="f6946_1.jsp?";
		</script>
<%
		return;
	}
	else
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("打印成功！",2);	
		window.location="f6946_1.jsp?";
		</script>
	<%
	}
%>
