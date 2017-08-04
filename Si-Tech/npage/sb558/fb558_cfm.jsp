<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    
    String opCode = "b558";
    String opName = "局数据同步导入";	
    
    
    String workNo = (String)session.getAttribute("workNo");  //工号
    String org_code_note = (String)session.getAttribute("orgCode");
    
    String paraAray[] = new String[8];
    
    paraAray[0] = request.getParameter("sysAccept");
    paraAray[1] = request.getParameter("workNo");
    paraAray[2] = request.getParameter("searchType");
    paraAray[3] = request.getParameter("optType");
    paraAray[4] = request.getParameter("dsmpType");
    paraAray[5] = request.getParameter("sheetno");
    paraAray[6] = request.getParameter("feefile");
    paraAray[7] = "b558";
%>

<wtc:service name="sb558Cfm" routerKey="region" routerValue="<%=org_code_note%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("SP局数据导入成功!",2);
   document.location.replace("fb558_1.jsp");
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("SP局数据导入失败!(<%=errMsg%>",0);
	document.location.replace("fb558_1.jsp");
</script>
<%}%>
