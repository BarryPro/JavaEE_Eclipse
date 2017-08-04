<%@ page contentType= "text/html;charset=gb2312" %>

<% String retCode = "0";
   String retMsg = "";

%>

var response = new AJAXPacket();
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%= retMsg %>");
core.ajax.receivePacket(response);