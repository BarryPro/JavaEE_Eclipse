<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ͳһԤ������2289
   * �汾: 1.0
   * ����: 2008/12/31
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="b941";
	String opName="���Ŀͻ���������";

	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");  				//���ݸ�ʽΪString[0][0]---String[n][0]
	String groupId = (String)session.getAttribute("groupId");
	String flag= request.getParameter("flag");
	int recordNum=0;
	int i=0;
	
 
	%>
 
	
<%
 

	

	String iPhoneNo = request.getParameter("srv_no");
	String iOpCode = request.getParameter("opcode");
	String cus_pass = request.getParameter("cus_pass");


 
	String  inputParsm [] = new String[3];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = iOpCode;
	inputParsm[2] = loginNo;
 
  %>
	

	
		 

	<wtc:service name="sb941Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg1">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String errCode = retCode;
  String errMsg = retMsg1;

  System.out.println("111111111111111111111111CZerrCode="+errCode);
  System.out.println("2222222222222222222222222CZerrMsg ="+errMsg);
  if(errCode.equals( "000000"))
  {
	%>
			<script language="JavaScript">
				rdShowMessageDialog("�����ɹ�!",2);
				history.go(-1);
			</script>
      <%

  }
  else{
  %>
			<script language="JavaScript">
				rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
				window.location="/npage/s1141/fb941_login.jsp?activePhone=<%=inputParsm[0]%>&opCode=b941&opName=���Ļ�������";
			</script>
      <%
	}


%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��̨�Ӻ��Ŀͻ����������</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</head>
<body>
<form name="frm" method="post"  onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	 

	 
	 



<div name="licl" id="licl">
			 
		 
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>

</body>
</html>
