<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%
 
    String opCode = "";
	String opName = "";
	String return_code="";
	String ret_msg="";

	String s_Invoice_number = request.getParameter("s_Invoice_number");
	String e_Invoice_number = request.getParameter("e_Invoice_number");
	String Invoice_code = request.getParameter("Invoice_code");
	String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
	String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode");
	String yingyt = request.getParameter("yingyt");
		
	if(s_in_ModeTypeCode == null) s_in_ModeTypeCode = "";
	if(s_in_CaseTypeCode == null) s_in_CaseTypeCode = "";
	String workno = (String)session.getAttribute("workNo");
	String return_page = "g485_5.jsp";
  

	String [] inParas = new String[7];
	inParas[0]  = s_Invoice_number;
	inParas[1]  = e_Invoice_number;
	inParas[2]  = Invoice_code;	
	inParas[3]  = s_in_ModeTypeCode.substring(0,2);
	inParas[4]  = s_in_CaseTypeCode.substring(2,4);
	inParas[5]  = workno;
	inParas[6]  = yingyt;
	
System.out.println("s_in_ModeTypeCode:"+inParas[3]);

%>
	<wtc:service name="sInvoiceInsert" routerKey="region" routerValue="<%=inParas[3]%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="N"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<body >
  <%	
	if (return_code.equals("000000"))
	{	
%>	
 <script language="javascript">
	  rdShowMessageDialog("��Ʊ��Ϣ¼��ɹ���");
	  window.location.href="<%=return_page%>";
 </script>


<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("��Ʊ��Ϣ¼��ʧ��!<br>������룺'<%=return_code%>'��������Ϣ��'<%=ret_msg%>'��");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%}
%>
</body></html>