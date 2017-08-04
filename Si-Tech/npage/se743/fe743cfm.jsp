<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String jsonText = request.getParameter("json1");
	String pageHref = request.getParameter("pageHref");
	String[] jsons = new String[30];
	int start = 0;
	System.out.println("====liujian====fe743_cfm.jsp========= " + jsonText);
	for (int i = 0; i < (jsonText.length() / 400) + 1; i ++) {
		if (i == (jsonText.length() / 400)) {
			jsons[i] = jsonText.substring(start, jsonText.length());
		} else {
			jsons[i] = jsonText.substring(start, start + 400);
			start += 400;
		}
	}
	String loginAccept = "";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
	loginAccept = seq;
	System.out.println("----liujian----loginAccept=" + loginAccept);
%>
<wtc:service name="se743Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="e743"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:params value="<%=jsons%>"/>
</wtc:service>
<%
	if("000000".equals(retCode1)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交成功！", 2);
			removeCurrentTab();
		</script>
<%
	} else {
%>
		<script language="JavaScript">
			rdShowMessageDialog('提交失败！se743Cfm，<%=retCode1%>，<%=retMsg1%>', 0);
			location="<%=pageHref%>";
		</script>
<%
	}
%>
