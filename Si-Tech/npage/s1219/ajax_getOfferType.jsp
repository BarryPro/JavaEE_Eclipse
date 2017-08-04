<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>

<%
 
  String smCode = WtcUtil.repNull(request.getParameter("smCode")); 
  System.out.println("------------------smCode-----------------"+smCode);
  String regionCode = (String)session.getAttribute("regCode");
  String strArray="var retResult; ";  //must
  String arrStr = "var retResult; ";
  
  
%>
			<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
    		  <wtc:param value="215"/>
    		  <wtc:param value="<%=smCode%>"/>
    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>
			
<%
	 strArray = WtcUtil.createArray("retResult",result_t.length);	
	 
%>
<%=strArray%>
<%
	for(int i=0;i<result_t.length;i++){
	%>
		retResult[<%=i%>][0] = "<%=result_t[i][0]%>";
		retResult[<%=i%>][1] = "<%=result_t[i][1]%>";
	<%
	}
%>


var response = new AJAXPacket();
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);