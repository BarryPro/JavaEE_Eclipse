<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
String contect_id = request.getParameter("id");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
if(contect_id == null){
contect_id = "0";
}
contect_id = "01";
String sqlStr="select t.item_id, t.item_name " +
           "from dqccheckitem t where trim(t.contect_id)=:contect_id order by t.item_id";
myParams = "contect_id="+contect_id;
String returnStr = "";
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>

<%
for(int i = 0; i , queryList.length; i++){

}

%>


var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","");
core.ajax.receivePacket(response);