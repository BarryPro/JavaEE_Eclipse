<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:MIS-POSͳһ����-CRM����
   * �汾: 1.0
   * ����: 
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
/**	
	*@     iLoginAccept  ��ˮ
  *@		 iChnSource    ������ʶ(��������01-BOSS��02-����Ӫҵ����
                       03-����Ӫҵ����04-����Ӫҵ����05-��ý���ѯ����06-10086)
  *@		 iOpCode       ��������	
  *@		 iLoginNo      ����
  *@		 iLoginPwd     ��������
  *@		 iPhoneNo,     �����˺���
  *@		 iUserPwd,     ��������
  *@		 iOpNote,      ������ע
  *@     iOldAccept    ԭҵ����ˮ
  *@     iRrn          ԭ����ϵͳ������
  *@     inIpAddr      IP��ַ

*/

	/*===========��ȡ����============*/
  String  iLoginAccept = getMaxAccept();
  String 	regionCode = (String)session.getAttribute("regCode");  
  String  iChnSource = "01";
  String  iOpCode = (String)request.getParameter("iOpCode");
  String  iLoginNo = (String)request.getParameter("iLoginNo");
  String  iLoginPwd = (String)request.getParameter("iLoginPwd");
  String  iPhoneNo = (String)request.getParameter("iPhoneNo");
  String  iUserPwd = (String)request.getParameter("iUserPwd");
  String  iOpNote = (String)request.getParameter("iOpNote");
  String  iOldAccept = (String)request.getParameter("iOldAccept");
  String  inIpAddr = (String)request.getParameter("inIpAddr");
  String  iRrn = (String)request.getParameter("iRrn");
  String 	iopName = 	(String)request.getParameter("iOpName");           
%>
<wtc:service name="sg175Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iOpNote%>" />
		<wtc:param value="<%=iOldAccept%>" />
		<wtc:param value="<%=iRrn%>" />
		<wtc:param value="<%=inIpAddr%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sg175Cfm in fg175Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("MIS-POSͳһ�����ɹ���");
		window.location = 'fg175Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("���÷���sg175Cfm in fg175Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location = 'fg175Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		
%>	

