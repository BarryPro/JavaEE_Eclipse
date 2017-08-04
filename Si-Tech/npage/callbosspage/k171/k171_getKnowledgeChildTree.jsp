<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%
	String superCode = request.getParameter("superCode");
	Map pMap = new HashMap();
	pMap.put("superCode", superCode);
	List resultList = KFEjbClient.queryForList("query_k171_knowledge_tree", pMap);
%>

var resultDataArr = new Array();
<%
	if (resultList != null) {
		for(int i = 0; i < resultList.size(); i++){
			Map map = (Map)resultList.get(i);
%>
			var tmpArr = new Array();
			tmpArr[0] = '<%=map.get("COLUKNGID")%>';
			tmpArr[1] = '<%=map.get("COLUKNGNAME")%>';
			tmpArr[2] = '<%=map.get("CODE")%>';
			tmpArr[3] = '<%=map.get("SUPERCODE")%>';
			tmpArr[4] = '<%=map.get("COLUKNGTYPE")%>';
			resultDataArr[<%=i%>] = tmpArr;
<%
		}
	}
%>
var response = new AJAXPacket();
response.data.add("resultDataArr",resultDataArr);
core.ajax.receivePacket(response);

