<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%


	/*===========��ȡ����============*/
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
		System.out.println("���÷���sG294Cfm in fg293Login.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("��ɢ���ڱ���ɹ���");
		window.location = 'fg293Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("���÷���sG294Cfm in fg293Login.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location = 'fg293Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		

%>