<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String groupId = WtcUtil.repNull(request.getParameter("groupId"));
		String srv_no = WtcUtil.repNull(request.getParameter("srv_no"));
		
		
		System.out.println("----------------------offerId------------------"+offerId);
		System.out.println("----------------------phoneNo------------------"+phoneNo);
		System.out.println("----------------------groupId------------------"+groupId);
		System.out.println("----------------------srv_no-------------------"+srv_no);
		
%>
<wtc:utype name="sCheckGroupMeb" id="retVal" scope="end">
	<wtc:uparams name="oneLevUtype" iMaxOccurs="1">	
		<wtc:uparam value="<%=offerId%>" type="int"/>
	  <wtc:uparam value="<%=phoneNo%>" type="string"/>
	  <wtc:uparam value="<%=groupId%>" type="int"/>
	  <wtc:uparam value="<%=srv_no%>" type="string"/>		
	</wtc:uparams>  	
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");;
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
core.ajax.receivePacket(response);