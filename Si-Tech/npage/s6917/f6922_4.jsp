<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会取票二维码补发
   * 版本: 1.0
   * 日期: 2009/5/15
   * 作者: wangjya
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
 
	String opCode = "6922";
	String opName = "世博会取票二维码补发";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	

	
	String orderCode = request.getParameter("order_code");	
	String phoneNo = request.getParameter("phone_no");
		
	String  id_type = request.getParameter("id_type");
	String  id_card = request.getParameter("id_card");
	String  codeType = request.getParameter("code_type");
	String inputParsm[] = new String[5];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = orderCode;
	inputParsm[3] = phoneNo;
	inputParsm[4] = codeType;	
%>

   <wtc:service name="s6922Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="4">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="4"  scope="end"/>
<% 		
	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("重发失败！" + "<%=errMsg%>",0);	
	 	window.location="f6922_1.jsp?opCode=6922&opName=世博会取票二维码补发";
	 	</script>
<%		
		return;				 			
	}
	else if(!(tempArr[0][0].equals("0000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("重发失败！" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6922_1.jsp?opCode=6922&opName=世博会取票二维码补发";
	 	</script>
<%		
		return;				 			
	}
	else if((tempArr[0][2].equals("0")))
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("重发成功！",2);	
		window.location="f6922_1.jsp?opCode=6922&opName=世博会取票二维码补发";
		</script>
	<%	
	}
	else
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("重发失败！定单号错误!",0);	
	 	window.location="f6922_1.jsp?opCode=6922&opName=世博会取票二维码补发";
	 	</script>
	<%	
	}
%>
