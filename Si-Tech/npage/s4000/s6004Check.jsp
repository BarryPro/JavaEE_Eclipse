<%
	/*
		* 2014/04/15 9:57:20 gaopeng
		* 异地单卡写卡加入校验服务
		*	
	*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode= (String)session.getAttribute("regCode");
		/*smi卡费*/
		String simFee = request.getParameter("simFee");
		System.out.println("======gaopengSeLog==========simFee="+simFee);
%>
	<wtc:service name="s6004Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=simFee%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	if(!(retCode.equals("0") || retCode.equals("000000"))){
	}else if(result != null && result.length > 0){
		
	}
	
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);