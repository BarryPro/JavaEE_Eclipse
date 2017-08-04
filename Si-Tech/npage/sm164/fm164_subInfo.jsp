
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	 <%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
    String regCode = (String) session.getAttribute("regCode");
    String workNo = (String) session.getAttribute("workNo");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
    
    String printAccept = request.getParameter("printAccept");
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("phoneNo");
    String oldpassword = request.getParameter("oldpassword");
    String newpassword= request.getParameter("newpassword");
    String opType=request.getParameter("opType");
    String vOpNote = request.getParameter("vOpNote");
    String vSystemNote = request.getParameter("vSystemNote");
%>
<wtc:service name="sm164Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retcode" retmsg="retmsg" outnum="2">
    <wtc:param value="<%=printAccept%>" />
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value="<%=oldpassword%>"/>
    <wtc:param value="<%=newpassword%>"/>
    <wtc:param value="<%=opType%>"/>
    <wtc:param value="<%=vSystemNote%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
	if ("000000".equals(retcode)){
%>
		<script language='jscript'>
	    rdShowMessageDialog("密码变更成功！", 2);
	    window.location.href="fm164_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
  }else{
%>
		<script language='jscript'>
		  rdShowMessageDialog("密码变更失败！<br>错误代码：<%=retcode%><br>错误信息：<%=retmsg%>", 0);
		  window.location.href="fm164_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
  }
%>
