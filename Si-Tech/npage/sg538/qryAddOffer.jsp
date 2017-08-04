<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
  String iQryType = WtcUtil.repNull(request.getParameter("iQryType")); 
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo")); 
  String offerType = WtcUtil.repNull(request.getParameter("offerType")); 
  String offerId = WtcUtil.repNull(request.getParameter("offerId")); 
  String offerName = WtcUtil.repNull(request.getParameter("offerName")); 
  String opCode ="g538";
  String groupId = (String)session.getAttribute("groupId");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
		/* liujian add workNo and password 2012-4-5 15:59:15 end */
		String strArray="var retAry;";  
		
	 
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
			<wtc:service name="sQryOfferType" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
    		  <wtc:param value="<%=loginAccept%>"/>
    		  <wtc:param value="01"/>
    		  <wtc:param value="<%=opCode%>"/>
    		  <wtc:param value="<%=workNo%>"/>
    		  <wtc:param value="<%=password%>"/>
    		  <wtc:param value="<%=phoneNo%>"/>
    		  <wtc:param value=""/>
    		  <wtc:param value="<%=iQryType%>"/>
    		  <wtc:param value="<%=offerId%>"/>
    		  <wtc:param value="<%=offerType%>"/>
    		  <wtc:param value="<%=offerName%>"/>
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
	%>
		retResult[<%=i%>][0] = "<%=result_t[i][0]%>";
		retResult[<%=i%>][1] = "<%=result_t[i][1]%>";
		retResult[<%=i%>][2] = "<%=result_t[i][2]%>";
	<%
	}
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("retAry",retResult);
core.ajax.receivePacket(response);