<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%	
	String work_no = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String paraAray[] = new String[9];
	String login_no=request.getParameter("login_no");
	String op_count=request.getParameter("op_count");
	String op_code=request.getParameter("sopcode");
	String grantReason = request.getParameter("grantReason");
	String fileNumber = request.getParameter("fileNumber");
	String fileName = request.getParameter("fileName");
	System.out.println("~~~~==== " + grantReason + " | " + fileNumber + " | " + fileName);
	

	paraAray[0] = login_no;
	paraAray[1] =work_no;
	paraAray[2] = op_code;
	paraAray[3] = op_count;
	paraAray[4] = request.getParameter("nopass");
	paraAray[5] = request.getParameter("oldPass");
	paraAray[6] = grantReason;
	paraAray[7] = fileNumber;
	paraAray[8] = fileName;
 
%>
	<wtc:service name="s8304Cfm" routerKey="region" routerValue="<%=regionCode%>" 
			retcode="errCode" retmsg="errMsg" outnum="2">
			<wtc:param value="<%=paraAray[0]%>"/>
			<wtc:param value="<%=paraAray[1]%>"/>
			<wtc:param value="<%=paraAray[2]%>"/>
			<wtc:param value="<%=paraAray[3]%>"/>
			<wtc:param value="<%=paraAray[4]%>"/>
			<wtc:param value="<%=paraAray[5]%>"/>
			<wtc:param value="<%=paraAray[6]%>"/>
			<wtc:param value="<%=paraAray[7]%>"/>
			<wtc:param value="<%=paraAray[8]%>"/>
	</wtc:service>
<%
	if ("000000".equals(errCode) || "0".equals(errCode))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功！");
   window.location="f8304_1.jsp";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("提交失败!(<%=errMsg%>)");
	window.location="f8304_1.jsp";
</script>
<%}%>
