<%
/********************
 version v2.0
 开发商: si-tech
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

		String opCode = request.getParameter("op_code");
		String opName = request.getParameter("op_name");
		String phoneNo = request.getParameter("phone_no");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String ipAdd = (String)session.getAttribute("ipAddr");
		String workNo = (String)session.getAttribute("workNo");
		String opNote = request.getParameter("opNote");
		String  inputParsm [] = new String[6];
		inputParsm[0] = "0";
		inputParsm[1] = phoneNo;
		inputParsm[2] = workNo;
		inputParsm[3] = opCode;
		inputParsm[4] = opNote;
		inputParsm[5] = ipAdd;
		
%>	
    <wtc:service name="s9983Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="2">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	<wtc:param value="<%=inputParsm[5]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="2"  scope="end"/>
<% 		
String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+workNo+"&loginAccept=0&contactId="+phoneNo+"&contactType=user&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime+"&pageActivePhone="+phoneNo;
	%>
	<jsp:include page="<%=url%>" flush="true" />
	<%
	if(!(errCode.equals("000000")))
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("冲正失败！" + "<%=errMsg%>",0);	
	 	window.location="f9982_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%		
		return;				 			
	}

%>
		<script language="javascript">
	 	rdShowMessageDialog("冲正成功",2);	
	 	window.location="f9982_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>