<%
  /* *********************
   * 功能: 检测用户是否已经办理了相关业务
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
		
		String opCode = (String)request.getParameter("opCode");
		String phoneNo = (String)request.getParameter("phoneNo");
		
		/**
		System.out.println("zhouby opCode " + opCode);
		System.out.println("zhouby inLoginNo " + inLoginNo);
		System.out.println("zhouby password " + password);
		System.out.println("zhouby phoneNo " + phoneNo);
		*/
%>
		
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
		
		<wtc:service name="sg511Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
				<wtc:param value="<%=accept%>"/>
				<wtc:param value="01"/> 
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
		var array = [];
<%
		/**
		 * 输入参数：
		 *        iLoginAccept               流水
		 *        iChnSource              	  渠道标识
		 *        iOpCode                 		操作代码
		 *        iLoginNo              	   	工号
		 *        iLoginPwd                  工号密码
		 *        iPhoneNo              	   	手机号码
		 *        iUserPwd                 	号码密码
		 * 返回参数：
		 *				oPhoneNo										手机号码
		 *				oId_No                    	用户标识
		 *				oSpId                    		企业代码
		 *				oSpName                 		企业名称
		 *				oBizCode                   	业务代码
		 *				oBizName                   	业务名称
		 *				oEffTime                   	生效时间
		 *				oExpTime                   	失效时间
		 *				oOldLoginAccept             原流水
		 *				oLoginNo                	 	操作工号
		 *				oOpTime                   	操作时间
		 */
		if ("000000".equals(retCode) && result.length > 0){
				for(int i = 0; i < result.length; i++){
%>
						var t = [];
<%
						for(int j = 0; j < result[i].length; j++){
						System.out.println("zhouby result [" + i +"][" + j + "] = " + result[i][j]);
%>					
								t[<%=j%>] = "<%=result[i][j]%>";
<%
						}
%>
						array[<%=i%>] = t;
<%
				}
		}
		System.out.println("zhouby retCode  " +retCode);
%>
		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		response.data.add("result", array);
		core.ajax.receivePacket(response);