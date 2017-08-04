<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	
	String opCode = "zgb9";
	String opName = "欠费专票回收";
	MoneyUtil mon = new MoneyUtil();
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	String work_no = (String)session.getAttribute("workNo");
	String s_sum1 = request.getParameter("s_sum1"); 
	String unit_id = request.getParameter("unit_id");
	String unit_name = request.getParameter("unit_name");
	String year_month = request.getParameter("year_month");
%>
<wtc:service name="szg46cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sCodes" retmsg="sMsgs" outnum="3" >
    <wtc:param value="<%=unit_id%>"/>
    <wtc:param value="<%=unit_name%>"/> 
	<wtc:param value="<%=work_no%>"/> 
	<wtc:param value="<%=s_sum1%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=year_month%>"/>
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode1= sCodes;
	String retMsg1 = sMsgs;
    if ( sCodes.equals("000000"))
	{
 
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
    rdShowMessageDialog("办理成功",2);
	window.location="zgb9_1.jsp?opCode=zg27&opName=增值税红字发票开具申请";
</SCRIPT>

<body >
 
 
</body>     
</html>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg1%>,<%=retCode1%>",0);
	window.location="zgb9_1.jsp?opCode=zg27&opName=增值税红字发票开具申请";
	</script>
<%}
%>

