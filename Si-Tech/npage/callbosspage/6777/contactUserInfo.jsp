<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.net.InetAddress"%>
<%
   String callPhone = WtcUtil.repNull(request.getParameter("accept_phone"));
   String cust_name="";
   String ms_code="";
   String userInfo="";
   String user_region_code="";
	  
%>

<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String mystrSql ="select a.cust_name,b.sm_code,a.region_code from dcustdoc a,dCustMsg b where a.cust_id=b.cust_id and b.phone_no=:phone_no";
	String myparams="phone_no="+callPhone; 
	System.out.println(mystrSql);
	System.out.println(myparams);
	  
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		<wtc:param value="<%=mystrSql%>"/>
		<wtc:param value="<%=myparams%>"/>
	</wtc:service>
	<wtc:array id="infoList" scope="end"/>		
<%
if(infoList.length>0)
{
	cust_name  = infoList[0][0];
	ms_code = infoList[0][1];
	user_region_code = infoList[0][2];
	
	userInfo=cust_name+"|"+ms_code+"|"+user_region_code+"|"+regionCode;
}
%>

var response = new AJAXPacket();
response.data.add("userInfo","<%=userInfo%>");
core.ajax.receivePacket(response);

