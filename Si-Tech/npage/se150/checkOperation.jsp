<%
/********************
 version v2.0
开发商: si-tech
*
*create:hejwa 2013-6-24 9:32:09
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String servBuisiId  = (String)request.getParameter("servBuisiId");
		String orderArrayId = (String)request.getParameter("orderArrayId");
		String regionCode   = (String)session.getAttribute("regCode");
 		String sqlStrOpAll  = "select function_code from service_offer where function_code in ('g794','g796') and action_id in (5011,5018) and service_offer_id = :serv_busi_id";
 		String sqlG796Str   = "SELECT count(*) FROM dorderarraymsg where order_array_id = :order_array_id and array_status > 11" ;
 		String paramInopAll = "serv_busi_id="+servBuisiId;
 		String paramInG796  = "order_array_id="+orderArrayId;
		String allOpCode    = "";
		String g796Count    = "";
		String limitFlag    = "";
%>		
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStrOpAll%>" />
		<wtc:param value="<%=paramInopAll%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
		
	<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlG796Str%>" />
		<wtc:param value="<%=paramInG796%>" />	
	</wtc:service>
	<wtc:array id="result_g" scope="end"/>	
		
<%
	if(result_t.length>0){
		allOpCode = result_t[0][0];
	}
	if(result_g.length>0){
		g796Count = result_g[0][0];
	}
	System.out.println("---------------mylog----------allOpCode------"+allOpCode);
	System.out.println("---------------mylog----------g796Count------"+g796Count);
	if("g794".equals(allOpCode)){//g794查到opcode就算通过，g796需要再次查询
			limitFlag = "1";
	}else if("g796".equals(allOpCode)){
		if("0".equals(g796Count)){
			limitFlag = "1";
		}else{
			limitFlag = "0";
		}
	}else{
		limitFlag = "2";
	}
	System.out.println("---------------mylog----------limitFlag------"+limitFlag);
%>

var response = new AJAXPacket();
response.data.add("markCount","<%=limitFlag%>");
core.ajax.receivePacket(response);
