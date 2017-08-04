<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String searchCaption = request.getParameter("searchCaption")==null?"":request.getParameter("searchCaption");
	
	Map pMap = new HashMap();
	pMap.put("searchCaption",searchCaption);
	List list = KFEjbClient.queryForList("query_k171_knowledge_search", pMap);
	String knowledgeId = "";
	String knowledgeCaption = "";
	for (int i = 0; i < list.size(); i++) {
		Map map = (Map)list.get(i);
		String id = (String)map.get("ID");
		String caption = (String)map.get("CAPTION");
		knowledgeId += id + ",";
		knowledgeCaption += caption + ",";
	}
	if (knowledgeId.endsWith(",")) {
		knowledgeId = knowledgeId.substring(0,knowledgeId.length()-1);
	}
	if (knowledgeCaption.endsWith(",")) {
		knowledgeCaption = knowledgeCaption.substring(0,knowledgeCaption.length()-1);
	}
	
%>
	var response = new AJAXPacket();
	response.data.add("knowledgeId","<%=knowledgeId%>");
	response.data.add("knowledgeCaption","<%=knowledgeCaption%>");
	core.ajax.receivePacket(response);;