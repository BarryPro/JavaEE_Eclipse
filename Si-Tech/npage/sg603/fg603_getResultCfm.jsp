<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String opCode = (String)request.getParameter("opCode");
		String iOrderId = WtcUtil.repNull(request.getParameter("iOrderId"));
		
		String iItemStatus = WtcUtil.repNull(request.getParameter("iItemStatus"));
		String iMailAddress = WtcUtil.repNull(request.getParameter("iMailAddress"));
		String reason = WtcUtil.repNull(request.getParameter("reason"));
        
		/**
		 *@ 输入参数：
		    服务名称： sA381Cfm
            编码日期：2013/09/08
            服务版本: V1.0
            编码人员：xiahk
            功能描述：更改交易的收货地址（回单、物流单下单）
        	strcpy(iLoginAccept,	input_parms[0]);
        	strcpy(iChnSource,		input_parms[1]);
        	strcpy(iOpCode,			input_parms[2]);
        	strcpy(iLoginNo,		input_parms[3]);
        	strcpy(iLoginPwd,		input_parms[4]);
        	strcpy(iPhoneNo,		input_parms[5]);
        	strcpy(iUserPwd,		input_parms[6]);

        	strcpy(iOrderId,		input_parms[7]);
        	strcpy(iOrderItemId,	input_parms[8]);
        	strcpy(iItemStatus,		input_parms[9]);
        	strcpy(iMailAddress,	input_parms[10]);
        	strcpy(iLogisticsIs,	input_parms[11]);
        	
        	strcpy(iLogisticsNo,	input_parms[12]);
        	strcpy(iStreamNo,		input_parms[13]);
        	strcpy(iBackStatus,		input_parms[14]);
        	strcpy(iBackDescInfo,	input_parms[15]);
        	
			System.out.println("zhouby opCode " + opCode);
		*/
		
		if ("".equals(accept)){
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sloginAccept"/>
<%		
			accept = sloginAccept;
		}
%>
		<wtc:service name="sA381Cfm" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=accept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=inLoginNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			    				
			<wtc:param value="<%=iOrderId%>"/>	
			<wtc:param value=""/>
		    <wtc:param value="<%=iItemStatus%>"/>
		  	<wtc:param value="<%=iMailAddress%>"/>
		    <wtc:param value="0"/>
		    <wtc:param value=""/>
		    <wtc:param value=""/>
		    <wtc:param value=""/>
		    <wtc:param value="<%=reason%>"/>
		</wtc:service>

		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode %>");
		response.data.add("retMsg", "<%=retMsg %>");
		core.ajax.receivePacket(response);