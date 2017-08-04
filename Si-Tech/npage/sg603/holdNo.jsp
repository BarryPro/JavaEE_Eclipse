<%
  /* *********************
   * 预占用
   * 版本: 1.0
   * 日期: 2013/03/11
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
		String opCode = (String)request.getParameter("opCode");
		
		String iOpNote = (String)request.getParameter("iOpNote");
		String iGroupId = (String)request.getParameter("iGroupId");
		String iCardNo = (String)request.getParameter("iCardNo");
		String iSIMNo = (String)request.getParameter("iSIMNo");
		
		String iDispatchType = (String)request.getParameter("iDispatchType");
		String iStreamNo = (String)request.getParameter("iStreamNo");
		String iCompanyName = (String)request.getParameter("iCompanyName");
		
		String isDispatch = (String)request.getParameter("isDispatch");
		String iDescInfo = (String)request.getParameter("iDescInfo");
		String iFlag = (String)request.getParameter("iFlag");
		String iMailAddress = (String)request.getParameter("iMailAddress");
		
		/**
		 *@ 输入参数：
		 *@        iLoginAccept              	流水
		 *@        iChnSource              	 渠道标识
		 *@        iOpCode                 		操作代码
		 *@        iLoginNo              	   	工号
		 *@        iLoginPwd                  工号密码
		 *@        iPhoneNo              	   	手机号码
		 *@        iUserPwd              	   	服务密码
		 
		 *@        iOpNote              	   	备注 	（可以不写）
		 
		 *@        iGroupId						办理营业厅     写卡的时候传 groupid
		 *@        iCardNo						卡号  写卡的时候传
		 *@        iSIMNo 						SIM卡号码   写卡的时候传
		 
		 *@        iDispatchType 				配送类型    邮寄的时候传
		 *@        iStreamNo					物流单号	邮寄的时候传
		 *@        iCompanyName					物流公司名称  邮寄的时候传
		 
		 *@        isDispatch					标识0配送成功1配送失败2外呼成功3外呼失败4修改配送地址5用户拒收6预占
		 *@        iDescInfo					失败原因      人工填的配送失败原因
		 *@        iFlag					    0写卡1填写物流单号2配送录入3外呼
		 *@        iMailAddress				配送地址
		 
			System.out.println("zhouby opCode " + opCode);
		*/

		if ("".equals(accept)){
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sloginAccept"/>

<%		
			accept = sloginAccept;
		}
%>
		<wtc:service name="sg530Cfm" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
				<wtc:param value="<%=accept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				
				<wtc:param value="<%=iOpNote%>"/>	
				<wtc:param value="<%=iGroupId%>"/>	
				<wtc:param value="<%=iCardNo%>"/>	
				<wtc:param value="<%=iSIMNo%>"/>	
				
				<wtc:param value="<%=iDispatchType%>"/>	
				<wtc:param value="<%=iStreamNo%>"/>	
				<wtc:param value="<%=iCompanyName%>"/>
				
				<wtc:param value="<%=isDispatch%>"/>	
				<wtc:param value="<%=iDescInfo%>"/>	
				<wtc:param value="<%=iFlag%>"/>
				<wtc:param value="<%=iMailAddress%>"/>
		</wtc:service>
		
		<wtc:array id="result" scope="end"/>

		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode %>");
		response.data.add("retMsg", "<%=retMsg %>");
		core.ajax.receivePacket(response);