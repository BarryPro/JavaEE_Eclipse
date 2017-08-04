<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

String nodeId = request.getParameter("nodeId");
 String sqlStr="select t.object_id,t.parent_object_id,t.object_name,t.is_leaf from dqcobject t where t.parent_object_id='"+nodeId+"' order by t.object_id";
%>
<wtc:service name="s151Select" outnum="4">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="4" >
//<%
//System.out.println("$$$$$$$$$$$$$2222222$$$$$$$$$$$$$$$$$");
//for(int i = 0; i < resultList.length; i++){
//	for(int j = 0; j < resultList[i].length; j++){
//	System.out.println(resultList[i][j]);
//	}
//}
//System.out.println("$$$$$$$$$$$$$$2222222$$$$$$$$$$$$$$$$");
//%>
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
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);

</wtc:array>
