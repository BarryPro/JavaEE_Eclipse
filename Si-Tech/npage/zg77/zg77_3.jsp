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
		String opCode = "zg77";
		String opName = "集团发票打印取消";
		String invoice_number = request.getParameter("invoice_number");
		String invoice_code = request.getParameter("invoice_code");
	 
		String op_code = request.getParameter("op_code");
		String workno = (String)session.getAttribute("workNo");
		String org_code = (String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		String s_ret="";
		//xl add 为插入dinvoice_left表
		String groupId = (String)session.getAttribute("groupId");
		//
		String begin_ym = request.getParameter("begin_ym");
		String end_ym = request.getParameter("end_ym");
%>
 
<wtc:service name="sgrp_cancel" retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:param value="<%=invoice_number%>"/>
	<wtc:param value="<%=invoice_code%>"/>
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=op_code%>"/>
	<wtc:param value="<%=groupId%>"/>
	<wtc:param value="<%=begin_ym%>"/>
	<wtc:param value="<%=end_ym%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
	 if(retCode1=="000000" ||retCode1.equals("000000"))
	 {
		 %>
			<script language="javascript">
				rdShowMessageDialog("取消成功!");
				window.location.href="zg77_1.jsp";
			</script> 
		 <%
	 }
	 else
	 {
		 %>
			<script language="javascript">
				rdShowMessageDialog("取消失败!");
				window.location.href="zg77_1.jsp";
			</script>
		 <%
	 }
%>
