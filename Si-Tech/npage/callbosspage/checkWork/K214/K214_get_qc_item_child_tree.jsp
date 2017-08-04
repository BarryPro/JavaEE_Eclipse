<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
String object_id = request.getParameter("object_id");
if(object_id == null){
	object_id = "01";
}
String content_id = request.getParameter("content_id");
if(content_id == null){
	content_id = "02";
}
String parent_item_id = request.getParameter("parent_item_id");
if(parent_item_id == null){
	parent_item_id = "0";
}
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
 String sqlStr="select t.item_id, t.parent_item_id, t.item_name, t.is_leaf " +
               "from dqccheckitem t where t.parent_item_id=:parent_item_id and object_id = :object_id and contect_id = :content_id " +
               "order by t.item_id";
 myParams = "parent_item_id="+parent_item_id+",object_id="+object_id+",content_id="+content_id;              
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="4" >

var worknos = new Array();
<%for(int i = 0; i < resultList.length; i++){%>
    var tmpArr = new Array();
	<%for(int j = 0; j < resultList[i].length; j++){%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%}%>
	worknos[<%=i%>] = tmpArr;
<%}%>
var response = new AJAXPacket();
response.data.add("worknos",worknos);
response.data.add("nodeId","<%=parent_item_id%>");
core.ajax.receivePacket(response);
</wtc:array>
