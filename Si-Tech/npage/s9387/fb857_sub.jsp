<%
/********************
 version v1.0
开发商: si-tech
create by haoyy 2010-11-04
********************/
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%
	    String opCode = "b857";
        String opName = "WLAN静态密码修改";

		String work_no = (String)session.getAttribute("workNo");
		String ipAddr = (String)session.getAttribute("ipAddr");
		String group_id = (String)session.getAttribute("group_id");
		String password = (String)session.getAttribute("password");
		String regionCode=(String)session.getAttribute("regCode");

		String phone  = request.getParameter("phone"); 	   // 用户号码
	    String BizType  = request.getParameter("BizType"); // 业务类型
	    String oldPass  = request.getParameter("oldPass"); // 原密码
	    String newPass  = request.getParameter("newPass"); // 新密码

%>
	<wtc:service name="sb857Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=BizType%>"/>
		<wtc:param value="<%=oldPass%>"/>
		<wtc:param value="<%=newPass%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg  = retMsg;
	if (errCode.equals("000000") )
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("密码修改成功！",2);
	window.location="/npage/s9387/fb857.jsp?opCode=b857&opName=WLAN静态密码修改";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=errCode%>    <%=errMsg%>",0);
	window.location="/npage/s9387/fb857.jsp?opCode=b857&opName=WLAN静态密码修改";
</script>
<%}%>


