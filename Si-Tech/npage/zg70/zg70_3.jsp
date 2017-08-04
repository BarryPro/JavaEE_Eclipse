<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
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
		String opName = "省级工号关系配置";
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
				rdShowMessageDialog("操作成功!");
				window.location.href="zg70_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("操作失败!错误代码:"+"<%=retCode1%>"+",错误原因:"+"<%=retMsg1%>");
				window.location.href="zg70_1.jsp";
			</script>
		<%
	}
%>
 