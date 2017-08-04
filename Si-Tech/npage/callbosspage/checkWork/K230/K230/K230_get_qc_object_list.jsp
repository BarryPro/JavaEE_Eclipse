<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String nodeId = request.getParameter("nodeId");
System.out.println("nodeid_______________:\t"+nodeId);
 //String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf,t.fullname from DCALLCAUSECFG t where t.super_id='"+nodeId+"' order by t.callcause_id";
 
 String sqlStr="select t.object_id, t.parent_object_id, t.object_name, 'Y', t.object_name " + 
               "from dqcobject t where t.parent_object_id='0' order by t.object_id";
%>

<wtc:service name="s151Select" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" >
	
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
