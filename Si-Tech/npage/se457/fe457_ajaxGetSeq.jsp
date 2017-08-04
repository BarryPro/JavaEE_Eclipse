<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
String regionCode = (String)session.getAttribute("regCode");
String seq = "";
String sql = "select lpad(to_char(nvl(sMaxTypeCode.nextVal,0)+1),4,'0') from dual";
%>
<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="retMsgSeq" retcode="retCodeSeq" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sql%>"/>
</wtc:service>
<wtc:array id="SeqResult" scope="end" />
<%
if ("000000".equals(retCodeSeq) && SeqResult.length > 0) {
	seq = SeqResult[0][0];
}
%>

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCodeSeq%>");
response.data.add("retMsg", "<%=retMsgSeq%>");
response.data.add("seq", "<%=seq%>");

core.ajax.receivePacket(response);
