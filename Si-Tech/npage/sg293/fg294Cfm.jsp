<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:
   * 版本: 1.0
   * 日期: 
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%


	/*===========获取参数============*/
  String  iLoginAccept = (String)request.getParameter("loginAccept");  
  String  iChnSource = "01";
  String  iOpCode = (String)request.getParameter("iopCode");
  String  iopCode = "g294";
  String  iLoginNo = (String)request.getParameter("workNo");
  String  iLoginPwd = (String)request.getParameter("noPass");
  String  iPhoneNo = (String)request.getParameter("phoneNo");
  String  iUserPwd = "";
  String regionCode = (String)session.getAttribute("regCode");			
  String iopName = 	(String)request.getParameter("iopName");   
  String iCyclDay =  	(String)request.getParameter("cyclDay");     
  String iOpNote =  	(String)request.getParameter("iOpNote");   
  String iIpAddr =  	(String)request.getParameter("iIpAddr");        
%>
<wtc:service name="sG294Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iopCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iCyclDay%>" />
		<wtc:param value="<%=iOpNote%>" />
		<wtc:param value="<%=iIpAddr%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sG294Cfm in fg293Login.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("分散账期变更成功！");
		window.location = 'fg293Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("调用服务sG294Cfm in fg293Login.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location = 'fg293Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		

%>