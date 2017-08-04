<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%
String regionCode = (String)session.getAttribute("regCode");
String phoneNo = Pub_lxd.repNull(request.getParameter("phoneNo"));
String sq="select to_char(cust_id) from dCustMsg where phone_no=:phoneNo and substr(run_code,2,1) < 'a'";
String sqp = "phoneNo="+phoneNo;
String   cussidStr="";
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sq%>" />
		<wtc:param value="<%=sqp%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"  />
		
<%
if(result_t.length>0){
		cussidStr = result_t[0][0];
}

System.out.println("-------hejwa---------------------cussidStr---->"+cussidStr);
%>		
var response = new AJAXPacket();
response.data.add("cussid","<%=cussidStr%>"); 
core.ajax.receivePacket(response);