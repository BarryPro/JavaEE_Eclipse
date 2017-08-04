<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String kuandai = request.getParameter("kuandai")== null? "" : request.getParameter("kuandai");
	
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  
  String  inParams [] = new String[2];
	inParams[0] = "SELECT a.phone_no FROM dbroadbandmsg a WHERE a.cfm_login =:cfmlogin";
	inParams[1] = "cfmlogin="+kuandai;
	
	String phoneNo = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret"  scope="end"/>
	<%
		if("000000".equals(retCode1)){
			if(ret.length > 0 ){
				phoneNo = ret[0][0];
			}
		}
	%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%= retCode1 %>");
	response.data.add("retMsg","<%= retMsg1 %>");
	response.data.add("phoneNo","<%=phoneNo%>");
	core.ajax.receivePacket(response);