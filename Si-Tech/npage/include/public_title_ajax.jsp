<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="/npage/common/errorpage.jsp" %><%/*update by diling for 营业生产主机weblogic报错自查流程@2011/10/27 */%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 

<%
	//String activePhone  = (String)session.getAttribute("activePhone");//当前激活用户号码
	String activePhone = (String)request.getParameter("activePhone");
	String appCnttFlag = (String) application.getAttribute("appCnttFlag");//接触平台状态
%>

<%
	String opBeginTime  = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());//业务开始时间
	//System.out.println("opBeginTime=="+opBeginTime);
%>
