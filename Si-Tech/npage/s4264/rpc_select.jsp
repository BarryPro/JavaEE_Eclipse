<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = "01";
	String sql = request.getParameter("sql");
   	String sqlParam = request.getParameter("sqlParam");
   	String rpc_flag = WtcUtil.repStr(request.getParameter("rpc_flag")," ");
   	
   	System.out.println("sunzx:sql="+sql);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retResult" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="<%=sqlParam%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />

var _code = new Array();
var _text = new Array();

<%
for(int outter = 0 ; result1 != null && outter < result1.length; outter ++)
{
%>
	_code[<%=outter%>] = "<%=result1[outter][0]%>";
	_text[<%=outter%>] = "<%=result1[outter][1]%>";
<%
}
%>
var response = new AJAXPacket();
response.data.add("retCode","000000");
response.data.add("retMsg","00001");
response.data.add("code",_code);
response.data.add("text",_text);
response.data.add("rpc_flag","<%=rpc_flag%>");
core.ajax.receivePacket(response);
