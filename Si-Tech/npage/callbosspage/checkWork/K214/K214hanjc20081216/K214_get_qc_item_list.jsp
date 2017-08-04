<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
String contect_id = request.getParameter("id");
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$");
System.out.println(contect_id);
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$");
if(contect_id == null){
contect_id = "0";
}
contect_id = "01";
String sqlStr="select t.item_id, t.item_name " +
           "from dqccheckitem t where trim(t.contect_id)='" + contect_id + "' order by t.item_id";

String returnStr = "";
%>

<wtc:service name="s151Select" outnum="5">
<wtc:param value="<%=sqlStr%>"/>
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