<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会门票退定
   * 版本: 1.0
   * 日期: 2009/5/13
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
 
	String opCode = "6918";
	String opName = "世博会门票退定";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	String  opr_numb = request.getParameter("oprnumb");
	String  tktType = request.getParameter("tkt_type");
	String  tktSum = request.getParameter("tkt_sum");
	String  tktDate = request.getParameter("tkt_Date");
	String  tktTag = request.getParameter("tkt_tag");
	String  inputParsm [] = new String[8];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = "1";
	inputParsm[3] = opr_numb;
	inputParsm[4] = tktType;
	inputParsm[5] = tktSum;
	inputParsm[6] = tktDate;
	inputParsm[7] = tktTag;
%>	
    <wtc:service name="s6917Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="8">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	<wtc:param value="<%=inputParsm[5]%>"/>	
	<wtc:param value="<%=inputParsm[6]%>"/>	
	<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="8"  scope="end"/>
<% 		
	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("退定失败！" + "<%=errMsg%>",0);	
	 	window.location="f6917_1.jsp?opCode=6917&opName=世博会门票预定";
		</script>
<%		
		return;				 			
	}
	else if(!(tempArr[0][0].equals("0000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("退定失败！" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6917_1.jsp?opCode=6917&opName=世博会门票预定";	
		</script>
<%		
		return;				 			
	}
	else
	{
	%>
		<script language="javascript">
	 	rdShowMessageDialog("退定成功！",2);	
	 	window.location="f6917_1.jsp?opCode=6917&opName=世博会门票预定";	
		</script>
	<%	
	}
%>
		
