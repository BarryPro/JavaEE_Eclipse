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
	String checkId = request.getParameter("checkId");
	String op_type = request.getParameter("op_type");
	String sqlStr = "select check_rule,localcode,err_code,err_desc from sdsmprulecode where check_id="+checkId;
	String var1 = "checkId="+checkId;
	String check_id = "";
	String check_rule = "";
	String localcode = "";
	String err_code = "";
	String err_desc = "";
	%>
<wtc:pubselect name="sPubSelect" retCode="errCode" retMsg="errMsg" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
	<wtc:array id="result" scope="end" />
	<%
		if(errCode.equals("000000")){	
			check_rule = result[0][0];
			localcode = result[0][1];
			err_code = result[0][2];
			err_desc =result[0][3];
		}
	%>
	
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("check_rule","<%=check_rule%>");
response.data.add("localcode","<%=localcode%>");
response.data.add("err_code","<%=err_code%>");
response.data.add("err_desc","<%=err_desc%>");
response.data.add("op_type","<%=op_type%>");
core.ajax.receivePacket(response);
