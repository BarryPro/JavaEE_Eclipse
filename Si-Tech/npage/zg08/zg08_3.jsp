<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
    String opCode = "zg08";
    String opName = "�ܶ����˷�";
 

	String login_accept = request.getParameter("login_accept");
 
	String totaldate = request.getParameter("totaldate");
	String workno = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String phone_no = request.getParameter("phone_no");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dateStr is "+dateStr);
	String s_sys = request.getParameter("s_sys");
	String s_reason="�����ܶ����˷�";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�ܶ����˷�</TITLE>
	
</HEAD>
<body>


<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 
 
		
		<wtc:service name="sTSNPubSnd" retcode="retCode2" retmsg="retMsg2" outnum="9">
			<wtc:param value="BIP1A167"/>
			<wtc:param value="T1000159"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="4511"/>
			<wtc:param value="<%=totaldate%>"/>
			<wtc:param value="<%=login_accept%>"/>
			<wtc:param value="<%=s_reason%>"/>
			<wtc:param value="<%=s_sys%>"/>
			<wtc:param value="<%=dateStr%>"/>
			<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="ret_val2" scope="end"   />	
		
		<%
			String return_code2="";
			String return_msg2="";

			return_code2=retCode2;
			return_msg2=retMsg2;
			if(!return_code2.equals("000000"))
			{
				%>
					<script language="javascript">
						rdShowMessageDialog("�˷�ʧ��!�������"+"<%=return_code2%>������ԭ��"+"<%=return_msg2%>");
						//history.go(-1);
						window.location.href="zg08_1.jsp?activePhone=<%=phone_no%>";
					</script>
				<%
			}
			else
			{
				%>
					<script language="javascript">
							rdShowMessageDialog("�ܶ����˷ѳɹ�!");
							window.location.href="zg08_1.jsp?activePhone=<%=phone_no%>";
					</script>	
				<%
			}
		 
 
%>


