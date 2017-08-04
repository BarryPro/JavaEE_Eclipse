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
    String opCode = "zg07";
    String opName = "总对总冲正";
	String unit_id=request.getParameter("unit_id");

	String login_accept = request.getParameter("login_accept");
 
	String totaldate = request.getParameter("totaldate");
	String workno = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String phone_no = request.getParameter("phone_no");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dateStr is "+dateStr);
	String s_sys = request.getParameter("s_sys");
	String s_reason="银行总对总冲正";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>总对总冲正</TITLE>
	
</HEAD>
<body>


<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 

<wtc:service name="sTSNPubSnd" retcode="retCode1" retmsg="retMsg1" outnum="9">
		<wtc:param value="BIP1A166"/>
		<wtc:param value="T1000160"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="4511"/>
		<wtc:param value="<%=totaldate%>"/>
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="T1000157"/>
		<wtc:param value=""/>
</wtc:service>
<wtc:array id="ret_val1" scope="end"   />	 
<%
	String return_code="";
	String return_msg="";

	return_code=retCode1;
	return_msg=retMsg1;
 	if(!return_code.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("冲正调用银行接口失败!错误代码"+"<%=return_code%>，错误原因："+"<%=return_msg%>");
				//history.go(-1);
				window.location.href="zg07_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<%
	}
	else
	{
		//冲正确认
		%>
		
		<wtc:service name="sTSNPubSnd" retcode="retCode2" retmsg="retMsg2" outnum="9">
			<wtc:param value="BIP1A166"/>
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
						rdShowMessageDialog("冲正失败!错误代码"+"<%=return_code2%>，错误原因："+"<%=return_msg2%>");
						//history.go(-1);
						window.location.href="zg07_1.jsp?activePhone=<%=phone_no%>";
					</script>
				<%
			}
			else
			{
				%>
					<script language="javascript">
							rdShowMessageDialog("总对总冲正成功!");
							window.location.href="zg07_1.jsp?activePhone=<%=phone_no%>";
					</script>	
				<%
			}
		 
	}
%>


