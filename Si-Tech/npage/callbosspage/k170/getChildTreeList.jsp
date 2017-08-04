<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);
String nodeId = request.getParameter("nodeId");

 String sqlStr="select t.callcause_id,t.super_id,t.caption,t.is_leaf from DCALLCAUSECFG t where t.super_id=:nodeId order by t.callcause_id";
 myParams = "nodeId="+nodeId ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="4">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="3">
<%
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
for(int i = 0; i < resultList.length; i++){
	for(int j = 0; j < resultList[i].length; j++){
		System.out.println(resultList[i][j]);
	}
}
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
%>
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
