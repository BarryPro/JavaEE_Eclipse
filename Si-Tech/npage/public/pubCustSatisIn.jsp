<%
/*
 * 功能: 营业前台参加客户满意度调查接口
 * 版本: 1.0
 * 日期: 2012/5/2 15:22:26
 * 作者: zhangyan
 * 版权: si-tech
 * update:
 */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String iLoginAccept = request.getParameter("statisLoginAccept"); /*流水*/
String iChnSource="01";
String iOpCode=request.getParameter("statisOpCode");
String iLoginNo=(String)session.getAttribute("workNo");
String iLoginPwd=(String)session.getAttribute("password");
String iPhoneNo=request.getParameter("statisPhoneNo");
String iUserPwd="";
String iIdNo=request.getParameter("statisIdNo");
String iCustId=request.getParameter("statisCustId");
%>

<wtc:service name="sCustSatisIn" 
	retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iIdNo%>"/>
	<wtc:param value="<%=iCustId%>"/>
</wtc:service>

<%
if (retCode.equals("000000"))
{
	System.out.println("@pubCustSatisIn~~~~retCode"+retCode);
	System.out.println("@pubCustSatisIn~~~~retMsg"+retMsg);
}
else
{
	System.out.println("@pubCustSatisIn~~~~retCode"+retCode);
	System.out.println("@pubCustSatisIn~~~~retMsg"+retMsg);
}
%>