<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String workNo = (String)session.getAttribute("workNo");
	ArrayList podmbutton = new ArrayList();
	try{
%>
<wtc:service name="sGetWDNewkf" outnum="9" >
	<wtc:param value="<%=workNo%>" />
  	<wtc:param value="3" />
  	<wtc:param value="91801" />
  	<wtc:param value="999" />
	</wtc:service>
	<wtc:array id="resultList" scope="end"/>	

var nodes = new Array();
<%
	for (int i = 0; i < resultList.length; i++) {
 

%>
    var tmpArr = new Array();
	
	  nodes['<%=resultList[i][1]%>'] = '<%=resultList[i][1]%>';
	 
	   
<%
    podmbutton.add(resultList[i][1]);
	}
	
	session.setAttribute("podmbutton",podmbutton);
	
%>
var response = new AJAXPacket();
response.data.add("nodes",nodes);
core.ajax.receivePacket(response);

<%
	 }catch(Exception e)
	 {
	 	e.printStackTrace();
	 }
%>