<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by wanglma @ 20110419
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	String serviceName = request.getParameter("serviceName");
	
	String regionCode= (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String sql_select = "select detail_code, detail_name from sbbossListCode where list_code = 'CompanyID' order by detail_order";
%>
	function Province(code,name) {
		this.code = code;
		this.name = name;
	}	
	var provArr = new Array(); 
<wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=sql_select%>"/>
	</wtc:service>
	<wtc:array id="provResult" scope="end" />
<%
	if(retCode.equals("000000") || retCode.equals("0")) {
		for(int i=0;i<provResult.length;i++) {
%>
			provArr.push(new Province('<%=provResult[i][0]%>','<%=provResult[i][1]%>'));
<%
		}
	}
%>

var response = new AJAXPacket();
response.data.add("retcode","<%= retCode %>");
response.data.add("retmsg","<%= retMsg %>");
response.data.add("provArr",provArr);
core.ajax.receivePacket(response);