<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  String g629_CT_HOMECUST_INFO_flag = "0";
  String regionCode  = (String)session.getAttribute("regCode");
  String g_CustId    = WtcUtil.repNull(request.getParameter("g_CustId")); 
  System.out.println("hejwa---------------g_CustId-------------->"+g_CustId);
  String paramsql    = "	select count(1) from CT_HOMECUST_INFO where master_id_no in   "+
											 "	(select master_id_no   "+
											 "	from CT_HOMECUST_INFO  "+
											 "	where cust_id = :g_CustId )";

											 
  String paramIn     = "g_CustId="+g_CustId;
%>

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramsql%>" />
		<wtc:param value="<%=paramIn%>" />	
	</wtc:service>
	<wtc:array id="result_t"   scope="end"/>
		
<%
System.out.println("hejwa----------------result_t.length---------------->"+result_t.length);
if(result_t.length>0){
	g629_CT_HOMECUST_INFO_flag = result_t[0][0];
}

System.out.println("hejwa---------------g629_CT_HOMECUST_INFO_flag-------------->"+g629_CT_HOMECUST_INFO_flag);
%>
var response = new AJAXPacket();
response.data.add("g629_CT_HOMECUST_INFO_flag","<%=g629_CT_HOMECUST_INFO_flag%>");
core.ajax.receivePacket(response);