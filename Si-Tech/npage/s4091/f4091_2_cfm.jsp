<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
String loginNo = request.getParameter("loginNo");
String expireTime = request.getParameter("expireTime");


String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String workNo = (String)session.getAttribute("workNo");
String loginPwd  = (String)session.getAttribute("password");
String ipAddr = request.getRemoteAddr();
String in_ChanceId = WtcUtil.repNull((String)request.getParameter("in_ChanceId"));
String batch_no = WtcUtil.repNull((String)request.getParameter("batch_no"));
String WaNo = WtcUtil.repNull((String)request.getParameter("wa_no1"));
String sm_code = WtcUtil.repNull((String)request.getParameter("sm_code"));
String op_code = WtcUtil.repNull((String)request.getParameter("op_code"));
%>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<wtc:service name="s4091ChgBatch" routerKey="region" routerValue="<%=regionCode%>" outnum="0"  retcode="Code" retmsg="Msg">
   <wtc:param value="<%=workNo%>" />
   <wtc:param value="<%=sm_code%>" />
   <wtc:param value="<%=in_ChanceId%>" />
   <wtc:param value="<%=WaNo%>" />
   <wtc:param value="<%=batch_no%>" />
</wtc:service>
<%
System.out.println("Code-------------|"+Code);
if(!Code.equals("000000")){
%>
<script language="JavaScript">
		rdShowMessageDialog("<%=Msg%>!",0);
		removeCurrentTab();
</script>
<%
}else{
%>
<script language="JavaScript">
		rdShowMessageDialog("²Ù×÷³É¹¦!",2);
		removeCurrentTab();
</script>
<%
}
%>
