<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String orderArrayID = request.getParameter("orderArrayID");
	String retType = request.getParameter("retType");
%>
<wtc:utype name="sBindQuery" id="retVal" scope="end" >
          <wtc:uparam value="<%= orderArrayID %>" type="String"/>      
 </wtc:utype>
 var orderArrayIDs = new Array();
 //orderArrayIDs.push("A0109061500000031");
 orderArrayIDs.push("<%=orderArrayID%>");
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode========================="+retCode);
	System.out.println("retMsg========================="+retMsg);
	System.out.println("retSize========================="+retVal.getSize(2));
if(retCode.equals("0")){
	int idNum = retVal.getSize(2);
	for(int i=0;i<idNum;i++){
		System.out.println("retdata========================="+retVal.getValue("2."+i+".0"));
		String bindId = retVal.getValue("2."+i+".0");
%>
	orderArrayIDs.push("<%=bindId%>");
<%
	}

}	
%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("orderArrayIDs",orderArrayIDs);
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");

core.ajax.receivePacket(response);