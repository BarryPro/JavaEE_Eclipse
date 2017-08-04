<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String loginNo = request.getParameter("loginNo");
String expireTime = request.getParameter("expireTime");
%>
<%
ArrayList arr = (ArrayList)session.getAttribute("allArr");
String[][] baseInfo = (String[][])arr.get(0);
String org_code = baseInfo[0][16];
String regionCode = org_code.substring(0,2);
String workNo = (String)session.getAttribute("workNo");
String ipAddr = request.getRemoteAddr();
String p_ProductOrderNumber = request.getParameter("p_ProductOrderNumber");
String p_ProductStatus = request.getParameter("p_TASK_FLAG");

String parameterNumber = request.getParameter("parameterNumber");
String parameterName = request.getParameter("parameterName");
String parameterValue = request.getParameter("parameterValue");
String characterGroup = request.getParameter("characterGroup");
String[] parameterNumberArr = parameterNumber.split(",");
String[] parameterNameArr = parameterName.split(",");
String[] parameterValueArr = parameterValue.split(",");
String[] characterGroupArr = characterGroup.split(",");

%>
<%
System.out.println("p_ProductStatus="+p_ProductStatus);
if(p_ProductStatus.equals("0"))
{
%>
<script language="JavaScript">
  rdShowMessageDialog("工单未竣工不用提交!",0);
  window.location.replace("f2034_1.jsp");
</script>  
<%
}
else
{
	%>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<%
System.out.println("====wanghfa====f2034_cfm.jsp====0==== workNo = " + workNo);
System.out.println("====wanghfa====f2034_cfm.jsp====1==== p_ProductOrderNumber = " + p_ProductOrderNumber);
System.out.println("====wanghfa====f2034_cfm.jsp====2==== p_ProductStatus = " + p_ProductStatus);
System.out.println("====wanghfa====f2034_cfm.jsp====3==== parameterNumber = " + parameterNumber);
System.out.println("====wanghfa====f2034_cfm.jsp====4==== parameterName = " + parameterName);
System.out.println("====wanghfa====f2034_cfm.jsp====5==== parameterValue = " + parameterValue);
System.out.println("====wanghfa====f2034_cfm.jsp====6==== characterGroup = " + characterGroup);

%>
<wtc:service name="s9105Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2"  retcode="Code" retmsg="Msg">
   <wtc:param value="<%=workNo%>" />
   <wtc:param value="<%=p_ProductOrderNumber%>" />
   <wtc:param value="<%=p_ProductStatus%>" />
   <wtc:params value="<%=parameterNumberArr%>" />
   <wtc:params value="<%=parameterNameArr%>" />
   <wtc:params value="<%=parameterValueArr%>" />
   <wtc:params value="<%=characterGroupArr%>" />
</wtc:service>
<wtc:array id="result" scope="end"/>
<%if(!Code.equals("000000")){
%>
<script language="JavaScript">
		rdShowMessageDialog("<%=Msg%>!",0);
		window.location.replace("f2034_1.jsp");
</script>
<%
}else{
%>
<script language="JavaScript">
		rdShowMessageDialog("操作成功!",1);
		window.location.replace("f2034_1.jsp");
</script>
<%
}
}
%>
