<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:MIS-POSͳһ����-�Ʒѳ���
   * �汾: 1.0
   * ����: 
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	
   ���� org_code �ֻ����� in_Rrn(������ˮ)
  *@		 iLoginNo      ����
	*@     org_code  		 ��֯��������
	*@		 iPhoneNo,     �ֻ�����
  *@     iOldAccept    ԭҵ����ˮ

*/

	/*===========��ȡ����============*/
  String 	regionCode = (String)session.getAttribute("regCode");  
  String  iOpCode = (String)request.getParameter("iOpCode");
  String  iLoginNo = (String)request.getParameter("iLoginNo");
  String  iPhoneNo = (String)request.getParameter("iPhoneNo");
  String  iOldAccept = (String)request.getParameter("iOldAccept");
  String 	iopName = 	(String)request.getParameter("iOpName"); 
  String 	iOrgCode = 	(String)request.getParameter("iOrgCode");             
      
%>
<wtc:service name="updPosInf" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iOrgCode%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iOldAccept%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���updPosInf in fg175Cfm2.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("MIS-POSͳһ�����ɹ���");
		window.location = 'fg175Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("���÷���updPosInf in fg175Cfm2.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location = 'fg175Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		
%>	

