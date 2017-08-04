<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>

<%
 
  String smCode = WtcUtil.repNull(request.getParameter("smCode")); 
  String offerId = WtcUtil.repNull(request.getParameter("offerId")); 
  String opCode = WtcUtil.repNull(request.getParameter("opCode")); 
  System.out.println("------------------smCode-----------------"+smCode);
  System.out.println("------------------offerId-----------------"+offerId);
  System.out.println("------------------opCode-----------------"+opCode);
  String regionCode = (String)session.getAttribute("regCode");
  String strArray="var retResult; ";  //must
  String arrStr = "var retResult; ";
  //218
  
%>
			<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
    		  <wtc:param value="215"/>
    		  <wtc:param value="<%=smCode%>"/>
    		  <wtc:param value="<%=offerId%>"/>
    		  <wtc:param value="<%=opCode%>"/>
    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>
			
<%
	System.out.println("---liujian---retCode=" + retCode);
	 strArray = WtcUtil.createArray("retResult",result_t.length);	
%>
<%=strArray%>
<%
	  System.out.println("zhangyan  result_t.length = " +result_t.length);

	for(int i=0;i<result_t.length;i++){
	  System.out.println("zhangyan  value = " + result_t[i][0]);
	%>
		retResult[<%=i%>][0] = "<%=result_t[i][0]%>";
		retResult[<%=i%>][1] = "<%=result_t[i][1]%>";
	<%
	}
%>
var response = new AJAXPacket();
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);