<%
  /* *********************
   * 预占用
   * 版本: 1.0
   * 日期: 2013/11/29
   * 作者: zhouby
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String orderId = WtcUtil.repNull(request.getParameter("orderId"));
		String opCode = (String)request.getParameter("opCode");
		String oprType = (String)request.getParameter("oprType");
		
		
		
		/**
    		strcpy(iLoginAccept,input_parms[0]);
            strcpy(iChnSource,  input_parms[1]);
            strcpy(iOpCode,     input_parms[2]);
            strcpy(iLoginNo,    input_parms[3]);
            strcpy(iLoginPwd,   input_parms[4]);
            strcpy(iPhoneNo,    input_parms[5]);
            strcpy(iUserPwd,    input_parms[6]);
            strncpy(inOpNote,	input_parms[7],60);
            strcpy(iOrderId,	input_parms[8]);
            strcpy(iStatus,	 input_parms[9]);
    		System.out.println("zhouby opCode " + opCode);
		*/

		if ("".equals(accept)){
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sloginAccept"/>

<%		
			accept = sloginAccept;
		}
%>
		<wtc:service name="sA381SubCfm" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
				<wtc:param value="<%=accept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				    
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				
				<wtc:param value=""/>
				<wtc:param value="<%=orderId%>"/>
				<wtc:param value="<%=oprType%>"/>
		</wtc:service>

		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode %>");
		response.data.add("retMsg", "<%=retMsg %>");
		core.ajax.receivePacket(response);