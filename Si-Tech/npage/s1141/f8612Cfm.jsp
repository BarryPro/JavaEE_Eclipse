<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gb2312"%>

<%	
	String work_no = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");	
  String paraAray[] = new String[6];

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
  paraAray[3] = work_no;
  paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");

	%>
	<wtc:service name="s8612Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />			
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
		</wtc:service>
	<wtc:array id="result_t" scope="end"  />	
	
	<%
	String errCode = code;
	String errMsg = msg;
	if (errCode.equals("000000"))
	{

%>
<script language="JavaScript">
    rdShowMessageDialog("提交成功! ");
window.location="f8609_login.jsp?phone_no=<%=paraAray[1]%>";
   </script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("冲正失败!(<%=errMsg%>");
	window.location="f8609_login.jsp?phone_no=<%=paraAray[1]%>";
</script>
<%}%>
