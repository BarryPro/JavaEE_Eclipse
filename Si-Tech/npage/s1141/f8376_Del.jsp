<%
/********************
 version v1.0
开发商: si-tech
update: sunaj@2010-03-01
********************/
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%
	String opCode="8376";
	String opName="赠送预存款方案删除";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password"); 

	String paraAray[] = new String[10];
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = "01";
    paraAray[2] = opCode;
	paraAray[3] = work_no;
    paraAray[4] = password;
    paraAray[5] = "";
	paraAray[6] = "";
    paraAray[7] = request.getParameter("projectcode");
    paraAray[8] = regionCode;  
    paraAray[9] = request.getParameter("projecttype");

%>
	<wtc:service name="s8376Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg  = retMsg;
	if (errCode.equals("000000") )
	{
		String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	
%>
	<jsp:include page="<%=url%>" flush="true" />
<script language="JavaScript">	
	rdShowMessageDialog("确认成功! ",2);
	window.location="/npage/s1141/f8375_login.jsp?opCode=8375&opName=赠送预存款方案配置";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("赠送预存款方案配置失败!(<%=errMsg%>",0);
	window.location="/npage/s1141/f8375_login.jsp?opCode=8375&opName=赠送预存款方案配置";
</script>
<%}%>
