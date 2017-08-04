<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String loginPwd  = (String)session.getAttribute("password");//µÇÂ½ÃÜÂë
%>
		<wtc:sequence name="TlsPubSelCrm" key="sCTGrpIdAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		
		var response = new AJAXPacket();
		response.data.add("loginAccept","<%=loginAccept%>");
		core.ajax.receivePacket(response);