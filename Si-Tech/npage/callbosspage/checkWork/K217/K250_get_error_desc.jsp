<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>

<%
	String errorIds = request.getParameter("error_ids"); //ÆÀÓï·¶ÎÄid	
	String selectSql = "select t.note from DQCERRORLEVEL t where t.valid_flag = 'Y' and t.error_level_id in (" + errorIds + ") order by t.error_level_id";
	String descriptions = "";
	List list = KFEjbClient.queryForList("selectPublic", selectSql);
	for (int i = 0; i < list.size(); i++) {
		Map map = (Map)list.get(i);
		descriptions += (String)map.get("NOTE") + "@#";
	}
%>

	var response = new AJAXPacket();
	response.data.add("descriptions","<%=descriptions%>");
	core.ajax.receivePacket(response);