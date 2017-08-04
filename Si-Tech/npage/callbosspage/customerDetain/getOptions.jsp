<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient, java.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
	String selectSql = request.getParameter("selectSql");
	String option_value = request.getParameter("option_value");
	String option_description = request.getParameter("option_description");
	
	List list = KFEjbClient.queryForList("selectPublic", selectSql);
	String optionsHtml = "";
	for (int i = 0; i < list.size(); i++) {
		Map map = (Map)list.get(i);
		String value = (String)map.get(option_value);
		String description = (String)map.get(option_description);
		optionsHtml += "<option value='" + value + "'>" + description + "</option>";
	}
%>
	var response = new AJAXPacket();
	response.data.add("optionsHtml","<%=optionsHtml%>");
	core.ajax.receivePacket(response);
