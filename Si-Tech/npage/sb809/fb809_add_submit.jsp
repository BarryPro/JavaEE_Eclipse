<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%

String start_year   = request.getParameter("start_year");
String end_year     = request.getParameter("end_year");
String start_month  = request.getParameter("start_month");
String end_month    = request.getParameter("end_month");
String start_day    = request.getParameter("start_day");
String end_day      = request.getParameter("end_day");
String start_hours  = request.getParameter("start_hours");
String end_hours    = request.getParameter("end_hours");
String start_minute    = request.getParameter("start_minute"); //diling add 开始分，结束分
String end_minute    = request.getParameter("end_minute");
String region_code  = request.getParameter("region_code");
String feeIndex_code    = request.getParameter("feeIndex_code");
String login_accept="";
login_accept = getMaxAccept();
String orgCode = (String)session.getAttribute("orgCode");
String loginregionCode = orgCode.substring(0,2);
String work_no   = (String)session.getAttribute("workNo");
String pass = (String)session.getAttribute("password");
String op_code= "b809";
String inputParam[] = new String[17];
if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
inputParam[0] = login_accept;
inputParam[1]= op_code;
inputParam[2]= work_no;
inputParam[3]= pass;
inputParam[4]= loginregionCode;
inputParam[5] = feeIndex_code;
inputParam[6] = region_code;
inputParam[7] = start_year;
inputParam[8] = end_year;
inputParam[9] = start_month;
inputParam[10] = end_month;
inputParam[11] = start_day;
inputParam[12] = end_day;
inputParam[13] = start_hours;
inputParam[14] = end_hours;
inputParam[15] = start_minute; //diling add 增加开发分，结束分参数
inputParam[16] = end_minute;

String errCode ="";
String errMsg = "";


%>


<wtc:service name="sb809AddCfg"  routerKey="region" routerValue="<%=region_code%>" retcode="code" retmsg="msg" outnum="0">
    <wtc:param value="<%=inputParam[0]%>"/>
    <wtc:param value="<%=inputParam[1]%>"/>
    <wtc:param value="<%=inputParam[2]%>"/>
    <wtc:param value="<%=inputParam[3]%>"/>
    <wtc:param value="<%=inputParam[4]%>"/>
    <wtc:param value="<%=inputParam[5]%>"/>
    <wtc:param value="<%=inputParam[6]%>"/> 
    <wtc:param value="<%=inputParam[7]%>"/>
    <wtc:param value="<%=inputParam[8]%>"/>
    <wtc:param value="<%=inputParam[9]%>"/>
    <wtc:param value="<%=inputParam[10]%>"/>
    <wtc:param value="<%=inputParam[11]%>"/>  	
    <wtc:param value="<%=inputParam[12]%>"/>
    <wtc:param value="<%=inputParam[13]%>"/>
    <wtc:param value="<%=inputParam[14]%>"/> 
    <wtc:param value="<%=inputParam[15]%>"/> 
    <wtc:param value="<%=inputParam[16]%>"/> 
</wtc:service>
<%
	errCode = code;
	System.out.println("errMsg#######################################33"+msg);
	errMsg =msg;
	%>

<%


response.setContentType("text/xml;charset=gb2312");
out.println("<?xml version=\"1.0\" encoding=\"GB2312\"?>");

out.println("<rows>");

		
out.println("<f1>"+errCode+"</f1>");
out.println("<f2>"+errMsg+"</f2>");
out.println("</rows>");
%>



  
	

