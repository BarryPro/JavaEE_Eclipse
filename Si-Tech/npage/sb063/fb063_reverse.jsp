<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
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
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String iChnSource = "01";
	String[] inParams = new String[5];
	String opName = "��˧���±�����";
	String loginAcceptNew = request.getParameter("reverse_accept");
	inParams[0] = workNo;
	inParams[1] = opCode;
	inParams[2] = oldPhone;
	inParams[3] = loginAcceptNew;
	inParams[4] = iChnSource;
%>
<wtc:service name="sB063Cancle" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
	<wtc:param value="<%=inParams[3]%>" />
	<wtc:param value="<%=inParams[1]%>" />
	<wtc:param value="<%=inParams[0]%>" />
	<wtc:param value="<%=inParams[2]%>" />
	<wtc:param value="<%=inParams[4]%>" />
</wtc:service>
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sB063Cancle in fb063_reverse.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������˧���±�����ҵ��ɹ���");
		history.go(-1);
	</script>
<%
	}else{
		System.out.println("���÷���sB063Cancle in fb063_reverse.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		history.go(-1);
	</script>
<%
	}
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+ opCode +"&retCodeForCntt="+errCode+
			"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAcceptNew+
			"&pageActivePhone="+oldPhone+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />


