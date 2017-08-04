<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	String srv_no = WtcUtil.repNull(request.getParameter("selNum"));
	String region_code = WtcUtil.repNull(request.getParameter("regionCode"));
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$srv_no==="+srv_no);
	System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$region_code==="+region_code);
	
	String sqlStr = "SELECT a.hlr_code||'--'||b.hlr_name FROM shlrcode a,shlrcodename b where a.phoneno_head=substr('"+srv_no+"',1,7) and a.region_code='"+region_code+"' AND a.hlr_code=b.hlr_code " ;
	//lj. °ó¶¨²ÎÊı
	String sql_select1 = "SELECT a.hlr_code||'--'||b.hlr_name FROM shlrcode a,shlrcodename b where a.phoneno_head=substr(:srv_no,1,7) and a.region_code=:region_code AND a.hlr_code=b.hlr_code";
	String srv_params1 = "srv_no=" + srv_no + ",region_code=" + region_code;
%>
<wtc:service name="TlsPubSelCrm" outnum="1">
	<wtc:param value="<%=sql_select1%>"/>
	<wtc:param value="<%=srv_params1%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
String strArray = CreatePlanerArray.createArray("result",result.length);
System.out.println("--------diling ----------1104----------result.length="+result.length);
%>

var result;

result="<%=result[0][0]%>";

var response = new AJAXPacket();

response.data.add("retType","1");
response.data.add("result","<%=result[0][0]%>");
core.ajax.receivePacket(response);

<%
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$result==="+result[0][0]);
%>
