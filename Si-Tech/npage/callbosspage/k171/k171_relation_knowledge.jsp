<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>

<%
   	String retCode="000000";
   	String causeId = request.getParameter("causeId")==null?"":request.getParameter("causeId");
   	String causeCaption = request.getParameter("causeCaption")==null?"":request.getParameter("causeCaption");
   	String add_knowledgeId = request.getParameter("add_knowledgeId")==null?"":request.getParameter("add_knowledgeId");
   	String del_knowledgeId = request.getParameter("del_knowledgeId")==null?"":request.getParameter("del_knowledgeId");
   	
   	StringBuffer deleteSql = new StringBuffer();
   	StringBuffer insertSql = new StringBuffer();
   	Map pMap = null;
   	try {
   		if (!del_knowledgeId.equals("")) {
   			pMap = new HashMap();
   			pMap.put("causeId",causeId);
   			pMap.put("knowledgeId",del_knowledgeId);
				KFEjbClient.delete("delete_k171_knowledge", pMap);
   		}
   		
   		if (!add_knowledgeId.equals("")) {
   			pMap = new HashMap();
   			pMap.put("causeId",causeId);
   			pMap.put("causeCaption",causeCaption);
   			pMap.put("knowledgeId",add_knowledgeId);
		   	KFEjbClient.insert("insert_k171_knowledge", pMap);
   		}
		} catch(Exception e) {
			retCode = "999999";
		}
%>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);;