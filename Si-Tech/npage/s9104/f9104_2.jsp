<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String op_name = "";
	String regionCode = (String)session.getAttribute("regCode");
	//String checkId = request.getParameter("checkId");
	String op_type = request.getParameter("op_type");
	String sqlStr = "select max(check_id)+1 from sdsmprulecode";
	//String sqlStr = "select to_char(count(check_id)) from sdsmprulecode where  check_id=:checkId";
	//String var1 = "checkId="+checkId;
	String countNum = "";
	String sqlStr2 = "select check_id from sdsmprulecode";
	%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:sql><%=sqlStr2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
		
	<wtc:pubselect name="sPubSelect" retCode="errCode" retMsg="errMsg" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%
if(result1.length > 0){
countNum = result[0][0];
}
else if(result1.length == 0){
	countNum = "100001";
	}
%>


var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("countNum","<%=countNum%>");
response.data.add("op_type","<%=op_type%>");
core.ajax.receivePacket(response);
