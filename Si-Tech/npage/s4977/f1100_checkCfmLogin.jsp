<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String retType = request.getParameter("retType");
    String cfm_login = request.getParameter("cfm_login");
    String ret_code = "";
    String retMessage = "";
%>

<wtc:service name="sCheckCfmLogin" outnum="2" routerKey="region" routerValue="<%=cfm_login%>">
<wtc:param value="<%=cfm_login%>"/>
</wtc:service>
<wtc:array id="result" start="0" length="2" scope="end" />

<%if (result!=null && result.length > 0 ){
     ret_code = result[0][0];
     retMessage =  result[0][1]; 
     System.out.println("retCode===="+ret_code);
     System.out.println("retMessage====="+retMessage);
     System.out.println("retType==="+retType);
}
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=retMessage%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);