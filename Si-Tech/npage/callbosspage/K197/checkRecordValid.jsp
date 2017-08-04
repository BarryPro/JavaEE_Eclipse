<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient, java.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String phone_no = request.getParameter("phone_no");
	boolean isExist = false;

	String selectSql = "select count(*) num from dcallspeciallist t where t.accept_phone = '"
	                   + phone_no + "'";
	List list = KFEjbClient.queryForList("selectPublic", selectSql);
	if (list != null && list.size() > 0) {
		Map map = (Map)list.get(0);
		String num = map.get("NUM").toString();
		if (!"0".equals(num)) {
			isExist = true;
		}
	}
%>

	var response = new AJAXPacket();
	response.data.add("isExist",<%=isExist%>);
	core.ajax.receivePacket(response);