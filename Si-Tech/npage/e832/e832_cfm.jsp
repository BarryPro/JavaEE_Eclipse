<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �˻�ת��1364
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%	
	String opCode="e832";
	String opName="���Ų�Ʒת��";
	String workno = (String)session.getAttribute("workNo");
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneno  = request.getParameter("grpphoneNo");
	String contractno  = request.getParameter("grpconNo");
	String opcode    = "e832";//������
	String custid = request.getParameter("custid");
	String nopay_money = request.getParameter("return_money");
	String prepay_fee = request.getParameter("prepay_fee");
	String remark = WtcUtil.repNull(request.getParameter("remark"));
	System.out.println("222222222222222"+remark);
	//String busy_type = request.getParameter("busy_type");
	String busy_type ="1";
	String phoneno2 = request.getParameter("zchm"); //ת�����
	String contractno2 = request.getParameter("zczh");
	String printAccept = request.getParameter("printAccept");
	if (remark.equals("")) 
	{
		remark = phoneno+"���Ų�Ʒ�ʻ�ת��:"+nopay_money;
	}
	System.out.println("!@#$%^&*()"+remark);
	//String nopass="111111";
	String nopass = (String)session.getAttribute("password");

	ArrayList arlist = new ArrayList();
	
	String    iErrorNo ="";
	String    sErrorMessage = " ";
	int   	  flag = 0;
	String newloginaccept = "";
	String total_date = "";
	String bigmoney="";

%>
	<wtc:service name="se832Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=orgcode%>"/>
		<wtc:param value="<%=opcode%>"/>
		<wtc:param value="<%=phoneno%>"/>
		<wtc:param value="<%=contractno%>"/>
		<wtc:param value="<%=nopay_money%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=busy_type%>"/>
		<wtc:param value="<%=phoneno2%>"/>
		<wtc:param value="<%=contractno2%>"/>
		<wtc:param value="<%=printAccept%>"/> 
		<wtc:param value="<%=custid%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	System.out.println("1111111111111111111111111111"+result.length);
	iErrorNo = result[0][0];
	sErrorMessage = result[0][1];
	String error_msg = iErrorNo;

			if (iErrorNo.equals("000000")==false)
		{
            flag = -1;
		}

	// �жϴ����Ƿ�ɹ�
	if (flag == 0)
	{
		total_date = result[0][2];
		newloginaccept = result[0][3];
		bigmoney = result[0][4];
	}
	else
	{
		//System.out.println("failed, ���� !");
	}
	/*
	String url = "";
	if(busy_type.equals("1")){
	    url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+newloginaccept+"&pageActivePhone="+phoneno
		+"&opBeginTime="+opBeginTime+"&contactId="+phoneno+"&contactType=user";	
	}else{
	    url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+newloginaccept+"&pageActivePhone="+phoneno
		+"&opBeginTime="+opBeginTime+"&contactId="+contractno+"&contactType=acc";
	}
	System.out.println(url);*/
%>
<SCRIPT type=text/javascript>
function ifprint()
{
	
	if(rdShowConfirmDialog("���Ų�Ʒת�˲����ɹ����Ƿ��ӡ�վ�?")==1)
		frm_print_invoice.submit();
	else 
		document.location.replace("e832_1.jsp?activePhone=<%=phoneno%>");
	
}

function ifprint()
{
     <% if (flag == 0){%>
			rdShowMessageDialog("�ʻ�ת�ʳɹ���",2);
			document.location.replace("e832_1.jsp?activePhone=<%=phoneno%>");
    <%}else{%>
	    rdShowMessageDialog("���Ų�Ʒ�ʻ�ת��ʧ�ܡ�<br>������룺'<%=iErrorNo%>'��<br>������Ϣ��'<%=sErrorMessage%>'��",0);
	    history.go(-1);
    <%}%>
}
</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/header.jsp" %>
<body onload="ifprint()">
<form action="e832_print.jsp" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="print_work_no" value="<%=workno%>">
<INPUT TYPE="hidden" name="print_phoneno" value="<%=phoneno%>">
<INPUT TYPE="hidden" name="print_contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="print_nopay_money" value="<%=nopay_money%>">
<INPUT TYPE="hidden" name="print_prepay_fee" value="<%=prepay_fee%>"> 
<INPUT TYPE="hidden" name="print_total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="print_login_accept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="print_big_money" value="<%=bigmoney%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
 

