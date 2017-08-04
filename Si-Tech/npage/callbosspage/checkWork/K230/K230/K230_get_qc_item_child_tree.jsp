<%@ page contentType="text/html;charset=gb2312"%>
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

 String sqlStr="select t.item_id, t.parent_item_id, t.item_name, t.is_leaf, t.is_scored " +
               "from dqccheckitem t "+
               "where trim(t.parent_item_id)='" + parent_item_id.trim() + "' and object_id = '" + object_id + "' and contect_id = '" + content_id + "' and bak1='Y' " +
               "order by t.item_id";
%>

<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >

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
