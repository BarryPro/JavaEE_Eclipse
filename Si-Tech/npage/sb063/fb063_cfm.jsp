<%
  /*
   * ����: ��˧���±�
   * �汾: 2.0
   * ����: 2010/07/26
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String opCode = request.getParameter("opCode");
	String oldPhone = request.getParameter("oldPhone");			//��˧�ֻ���
	String newPhone = request.getParameter("newPhone");			//�±��ֻ���
	String orgCode =(String)session.getAttribute("orgCode");
	String loginPwd = (String)session.getAttribute("password");
	String userPwd = request.getParameter("newCustPwd");
	if(null == userPwd ){
		userPwd = "";
	}
	String loginAccept = request.getParameter("login_accept");
	String regionCode = orgCode.substring(0,2);
	String iChnSource = "01";									//��������  01 ��ʾҳ��
	String opName = "��˧���±�";
	System.out.println("loginAccept:"+loginAccept+"	opCode:"+opCode + " workNo:" + workNo + " iChnSource:"+ iChnSource + " oldPhone:" +oldPhone + " newPhone��" + newPhone);

%>
<wtc:service name="sB063Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
	<wtc:param value="<%=loginAccept%>" />
	<wtc:param value="<%=opCode%>" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="<%=iChnSource%>" />
	<wtc:param value="<%=oldPhone%>" />
	<wtc:param value="<%=loginPwd%>" />
	<wtc:param value="<%=userPwd%>" />
	<wtc:param value="<%=newPhone%>" />
</wtc:service>
<%System.out.println("fb063 >>>>>>>>> errCode " + errCode);
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sB063Cfm in fb063_cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������˧���±�ҵ��ɹ���");
		history.go(-1);
	</script>
<%
	}else{
		System.out.println("���÷���sB063Cfm in fb063_cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		history.go(-1);
	</script>
<%
    }
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+
			"&pageActivePhone="+oldPhone+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
