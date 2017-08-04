<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>

<%
 
  String iQryType = WtcUtil.repNull(request.getParameter("iQryType")); 
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo")); 
  String opCode ="g538";
  String groupId = (String)session.getAttribute("groupId");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  String strArray="var retResult; ";  //must
  String arrStr = "var retResult; ";

  
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
			<wtc:service name="sQryOfferType" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retmsg="msg2" retcode="code2">
    		  <wtc:param value="<%=loginAccept%>"/>
    		  <wtc:param value="01"/>
    		  <wtc:param value="<%=opCode%>"/>
    		  <wtc:param value="<%=workNo%>"/>
    		  <wtc:param value="<%=password%>"/>
    		  <wtc:param value="<%=phoneNo%>"/>
    		  <wtc:param value=""/>
    		  <wtc:param value="<%=iQryType%>"/>
    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>
			
<%
	
	 strArray = WtcUtil.createArray("retResult",result_t.length);	
%>
<%=strArray%>
<%
	  System.out.println("zhangyan  result_t.length = " +result_t.length);

	for(int i=0;i<result_t.length;i++){
	  System.out.println("zhangyan  value = " + result_t[i][0]);
	  System.out.println("zhangyan  value = " + result_t[i][1]);
	%>
		retResult[<%=i%>][0] = "<%=result_t[i][0]%>";
		retResult[<%=i%>][1] = "<%=result_t[i][1]%>";
	<%
	}
%>
var response = new AJAXPacket();
response.data.add("retResult",retResult);
response.data.add("errorCode","<%=code2%>");
response.data.add("errorMsg","<%=msg2%>");
core.ajax.receivePacket(response);