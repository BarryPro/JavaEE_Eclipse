<%
/********************
 version v1.0
开发商: si-tech
*
*create:gaopeng@2013/07/11 15:09:25
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String) session.getAttribute("workNo");
	String nopass = (String) session.getAttribute("password");
	String loginAccept = request.getParameter("loginAccept");
	String orderId = request.getParameter("orderId");
	String offerId = request.getParameter("offerId");
	String opCode = request.getParameter("opCode");
	System.out.println("loginAccept==================:"+loginAccept);
	System.out.println("orderId==================:"+orderId);
	System.out.println("offerId==================:"+offerId);
	System.out.println("opCode==================:"+opCode);
	String outPhoneNo = "";
	
	/***
		hejwa add 先判断sql，如果有值则不变原逻辑，否则调用新的校验服务，并修改服务的入参
	**/
	
	String retCode = "";
	String retMsg  = "";
	String tmonthLimitSql = " select count(*) "+
													" from wphonesaleopr a  "+
													" where  a.login_accept = to_number(:iSaleAccept) and a.op_code = '1145' "+
     											" and a.back_flag = '0' and a.op_time+90 > sysdate ";
	String iSaleAcceptParam = "iSaleAccept="+orderId;   
	System.out.println("-----hejwa---------tmonthLimitSql----------"+tmonthLimitSql);  											
	System.out.println("-----hejwa---------iSaleAcceptParam--------"+orderId);  											
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=tmonthLimitSql%>" />
		<wtc:param value="<%=iSaleAcceptParam%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"   />
<%
	String tmonthLimitResult = result_t[0][0];
	System.out.println("-----hejwa------tmonthLimitResult---------"+tmonthLimitResult);
	if(!"0".equals(tmonthLimitResult)){
		System.out.println("-----hejwa------原逻辑---------");
		//找到逻辑不变
%>

		<wtc:service name="sBandSaleChk" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode1" retmsg="retMsg1" outnum="3">
			  <wtc:param value="<%=loginAccept%>"/>
			  <wtc:param value="01"/>
			  <wtc:param value="<%=opCode%>"/>
			  <wtc:param value="<%=workNo%>"/>
			  <wtc:param value="<%=nopass%>"/>
			  <wtc:param value=""/>
			  <wtc:param value=""/>
			  <wtc:param value="sBandSaleChk校验"/>
			  <wtc:param value="<%=orderId%>"/>
			  <wtc:param value="<%=offerId%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	retCode = retCode1;
	retMsg  = retMsg1;
	if(retCode1.equals("000000") || retCode1.equals("0")){
		if(result!=null && result.length > 0){
			outPhoneNo = result[0][0];
		}
	}
%>

<%		
	}else{
		//没找到调用新逻辑
		System.out.println("-----hejwa------新逻辑---------");
%>
			<wtc:service name="sCheckAccept" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode2" retmsg="retMsg2" outnum="5">
			  <wtc:param value=""/>
			  <wtc:param value="01"/>
			  <wtc:param value="<%=opCode%>"/>
			  <wtc:param value="<%=workNo%>"/>
			  <wtc:param value="<%=nopass%>"/>
			  <wtc:param value=""/>
			  <wtc:param value=""/>
			  <wtc:param value="<%=orderId%>"/>
			  <wtc:param value="<%=offerId%>"/>	
			  <wtc:param value="1"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	retCode = retCode2;
	retMsg  = retMsg2;
	if(retCode2.equals("000000") || retCode2.equals("0")){
		if(result!=null && result.length > 0){
			outPhoneNo = result[0][4];
		}
	}
%>

<%		
	}
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("outPhoneNo","<%= outPhoneNo%>");
	core.ajax.receivePacket(response);