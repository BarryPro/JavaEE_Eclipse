<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:УѶͨapn���ܿ�ͨ
   * �汾: 1.0
   * ����: 2012/09/25
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	0 iLoginAccept ��ˮ
		1 iChnSource  ��������
		2 iOpCode    ��������
		3 iLoginNo    ����
		4 iLoginPwd   ��������
		5 iPhoneNo   �û��ֻ�����
		6 iUserPwd   �û��ֻ�����
		7 sOfferId    �ʷѴ���
		8 sSchool     ѧУ����
		9 sClass      �༶����
*/

	/*===========��ȡ����============*/
  String  iLoginAccept = (String)request.getParameter("loginAccept");  
  String  iChnSource = "01";
  String  iOpCode = (String)request.getParameter("iopCode");
  String  iLoginNo = (String)request.getParameter("workNo");
  String  iLoginPwd = (String)request.getParameter("noPass");
  String  iPhoneNo = (String)request.getParameter("phoneNo");
  String  iUserPwd = "";
  String  sOfferId = (String)request.getParameter("opTariff").split("\\|")[0];
  String  sSchool = (String)request.getParameter("belongSchool");
  String  sClass = (String)request.getParameter("belongClass");
  String regionCode = (String)session.getAttribute("regCode");			
  String iopName = 	(String)request.getParameter("iopName");           
%>
<wtc:service name="sG147Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=sOfferId%>" />
		<wtc:param value="<%=sSchool%>" />
		<wtc:param value="<%=sClass%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sTeacherAPNOn in fg147Main.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("УѶͨapn���ܿ�ͨ�ɹ���");
		window.location = 'fg147Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("���÷���sTeacherAPNOn in fg147Main.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		window.location = 'fg147Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		
%>	
