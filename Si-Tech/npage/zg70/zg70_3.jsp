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
		String opCode = "zg70";
		String opName = "ʡ�����Ź�ϵ����";
		String sjgh = request.getParameter("login_no");
		String flag = request.getParameter("flag");
		String s_ret="";
		String workno = (String)session.getAttribute("workNo");
%>
<wtc:service name="zg70Cfm" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=sjgh%>"/>
	<wtc:param value="<%=flag%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	if(retCode1=="000000" ||retCode1.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("�����ɹ�!");
				window.location.href="zg70_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("����ʧ��!�������:"+"<%=retCode1%>"+",����ԭ��:"+"<%=retMsg1%>");
				window.location.href="zg70_1.jsp";
			</script>
		<%
	}
%>
 