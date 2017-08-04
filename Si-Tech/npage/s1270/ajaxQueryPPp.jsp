<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%System.out.println("----------------------------ajaxQueryPPp.jsp---------查询新资费对应品牌-----------------");  %>

<%
	String offerIdv = WtcUtil.repNull(request.getParameter("offerIdVt"));
	String regionCode = (String)session.getAttribute("regCode");
	
	String retResultStr = "";
	String band_id      = "";
		if(!offerIdv.equals("")&&offerIdv!=null){
%>

    <wtc:service name="sDynSqlCfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="219" />
			<wtc:param value="<%=offerIdv%>" />	
		</wtc:service>
		<wtc:array id="result_t33" scope="end"   />

<%
		if(code.equals("000000") && result_t33.length > 0){
	 		retResultStr = result_t33[0][1];
	 		band_id = result_t33[0][0] ;
		}
		System.out.println("---------------retResultStr--################-------------"+result_t33[0][1]);
	}
	
%>

var response = new AJAXPacket();
response.data.add("retResultStr","<%=retResultStr%>");
response.data.add("band_id","<%=band_id%>");
core.ajax.receivePacket(response);

