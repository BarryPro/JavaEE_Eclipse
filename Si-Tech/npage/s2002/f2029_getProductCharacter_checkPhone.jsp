<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String no = request.getParameter("phoneHead");
%>
<%
		String sqlStr = "select count(*) from dbresadm.snotype where trim(no) = '" + no +"'";
%>
		<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
	String phoneHeadFlag = "";
	if("000000".equals(retCode)){
		phoneHeadFlag = result[0][0];
	}
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("phoneHeadFlag","<%= phoneHeadFlag %>");
	core.ajax.receivePacket(response);