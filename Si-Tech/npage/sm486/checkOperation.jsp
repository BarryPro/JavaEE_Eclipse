<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*
*create:hejwa 2013-6-24 9:32:09
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String servBuisiId = (String)request.getParameter("servBuisiId");
		String regionCode  = (String)session.getAttribute("regCode");
		
 		String sqlStr      = "select count(*) from service_offer where function_code in ('g794','g795','g796','m028','m094') and action_id = 5011 and service_offer_id = :serv_busi_id";
 		String paramIn     = "serv_busi_id="+servBuisiId;
		String markCount   = "";
		System.out.println("liangyl------------------------"+sqlStr);
		System.out.println("liangyl------------------------"+paramIn);
%>		
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>" />
		<wtc:param value="<%=paramIn%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
<%
	if(result_t.length>0){
		markCount = result_t[0][0];
	}
%>

var response = new AJAXPacket();
response.data.add("markCount","<%=markCount%>");
core.ajax.receivePacket(response);