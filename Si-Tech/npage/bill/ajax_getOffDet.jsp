<%
/********************
 version v2.0
 开发商: si-tech
 *	author:hejwa 
 *	2013年3月4日13:38:31
 *	取亲情资费描述
 *
 ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

var response = new AJAXPacket();
<%
	String regionCode = (String)session.getAttribute("regCode");
	String retCode = "";
	String retMsg  = "";
	String offerComment = "";
try{
	String offId    = request.getParameter("offId");
	String offDetSql = "select offer_name,offer_comments from  product_offer where offer_id =:offID";
	String paramIn   = "offID="+offId;
%>
  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=offDetSql%>" />
		<wtc:param value="<%=paramIn%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
<%
if(result_t.length>0){
	offerComment = result_t[0][1];
}
%>		
	response.data.add("offerComment","<%=offerComment%>");
	response.data.add("retCode","<%=code%>");
	response.data.add("retMsg","<%=msg%>");		
<%
}catch(Exception e){
	e.printStackTrace();
%>
	response.data.add("retCode","444444");
	response.data.add("retMsg","系统错误，请联系管理员");
<%
}	 
%>		
	
core.ajax.receivePacket(response);


 
