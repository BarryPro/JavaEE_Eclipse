<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String nodeId = request.getParameter("nodeId");
	String sqlStr = "SELECT login_group_id,parent_group_id,login_group_name,is_leaf FROM dqclogingroup WHERE IS_DEL='N' AND parent_group_id = '"
			+ nodeId + "' ORDER BY login_group_id";
%>
<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlStr%>" />
</wtc:service>
<wtc:array id="resultList" start="0" length="5">

var nodes = new Array();
<%
	for (int i = 0; i < resultList.length; i++) {
%>
    var tmpArr = new Array();
	<%
		for (int j = 0; j < resultList[i].length; j++) {
	%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%
		}
	%>
	nodes[<%=i%>] = tmpArr;
<%
	}
%>
var response = new AJAXPacket();
response.data.add("nodes",nodes);
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);
</wtc:array>