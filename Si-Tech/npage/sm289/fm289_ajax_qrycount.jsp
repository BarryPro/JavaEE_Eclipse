<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*create liangyl 2016-03-23
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		
		String regCode = (String)session.getAttribute("regCode");
		String y_year_month=request.getParameter("y_year_month");
		String sql = "select count(*) from wWebGoodPhoneopr where order_ym=:order_ym and order_flag='1'";
		String[] inParams = new String[2];
		inParams[0] = sql;
		inParams[1] = "order_ym="+y_year_month;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
	var results="";
	<%
		String results="";
		if(retCode.equals("000000")){
			results+=result[0][0];
		}
	%>
	var response = new AJAXPacket();
	response.data.add("results","<%=results%>");
	core.ajax.receivePacket(response);