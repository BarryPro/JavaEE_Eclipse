<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
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
String pkg_code    = request.getParameter("pkg_code");
String work_no   = (String)session.getAttribute("workNo");
String op_code= "4515";
String inputParam[] = new String[14];
if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}

inputParam[0] = region_code;
inputParam[1] = pkg_code;
inputParam[2] = start_year;
inputParam[3] = end_year;
inputParam[4] = start_month;
inputParam[5] = end_month;
inputParam[6] = start_day;
inputParam[7] = end_day;
inputParam[8] = start_hours;
inputParam[9] = end_hours;
inputParam[10] = start_minute; //diling add 增加开发分，结束分参数
inputParam[11] = end_minute;
inputParam[12]= work_no;
inputParam[13]= op_code;


String errCode ="";
String errMsg = "";


%>


<wtc:service name="s4515AddCfm"  routerKey="region" routerValue="<%=region_code%>" retcode="code" retmsg="msg" outnum="0">
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
</wtc:service>
<%
	errCode = code;
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



  
	
