<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String sqlStr="";
String nodeId = request.getParameter("nodeId");
String inFlag = request.getParameter("inFlag");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
if(!nodeId.equals("")){
	if(inFlag.equals("0")){
		sqlStr="select a.id,a.superid,a.typeid,a.servicename,a.ttansfercode ,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a  "
		+"where a.superid=:vsuperid and a.typeid<>0 order by a.id";
		myParams = "vsuperid="+ nodeId;
	}else{
		sqlStr="select a.id,a.superid,a.typeid,a.servicename,a.transfercode ,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a "
		+" where a.visiable = '1' and  a.superid=:vsuperid order by a.id";
		myParams = "vsuperid="+ nodeId;
		//yanghy 华为添加是否可见的字段. 1 是可见.20090910
	}
}
System.out.println("aaaaaaaaaaaaaaaaaaaaaa"+sqlStr);
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="8" >
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
