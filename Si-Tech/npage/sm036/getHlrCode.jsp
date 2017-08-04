<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	String simNo = WtcUtil.repNull(request.getParameter("simNo"));
	String region_code = WtcUtil.repNull(request.getParameter("regionCode"));


	String sql_select1 = "select b.hlr_code||'--'||c.hlr_name from dsimres a, shlrcode b, shlrcodename c where a.phoneno_head = b.phoneno_head and b.hlr_code = c.hlr_code and a.sim_no =:simnos ";
	String srv_params1 = "simnos="+simNo;
%>
<wtc:service name="TlsPubSelCrm" outnum="1">
	<wtc:param value="<%=sql_select1%>"/>
	<wtc:param value="<%=srv_params1%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%

if (result.length==0)
{
%>
var response = new AJAXPacket();
response.data.add("result","没有查到结果！");
core.ajax.receivePacket(response);
<%
return ;
}
else
{
%>
var result;
result="<%=result[0][0]%>";
var response = new AJAXPacket();
response.data.add("result","<%=result[0][0]%>");
core.ajax.receivePacket(response);
<%
}
%>

