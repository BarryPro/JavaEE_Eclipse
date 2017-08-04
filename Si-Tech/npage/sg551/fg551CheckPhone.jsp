<%
  /* *********************
   * 功能: 检测该电话是否有过通话记录
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
		String originalPhoneNo = (String)request.getParameter("originalPhoneNo");
		String targetPhoneNo = (String)request.getParameter("targetPhoneNo");
		
		/**
		System.out.println("zhouby opCode " + opCode);
		System.out.println("zhouby inLoginNo " + inLoginNo);
		System.out.println("zhouby password " + password);
		System.out.println("zhouby phoneNo " + phoneNo);
		*/
%>
		<wtc:service name="sRightQryRecord" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4">
				<wtc:param value="<%=targetPhoneNo%>"/>
				<wtc:param value="<%=originalPhoneNo%>"/>
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="g551"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
		var array = [];
<%
		/**
		 * 输入参数：
		 *        验证手机号	字符串	80
							用户手机号	字符串	15
							工号	字符串	6
							opcode	字符串	4
		 * 返回参数：
		  GPARM32_0	返回代码	单行
			GPARM32_1	返回提示信息	单行
			GPARM32_2	信息验证标识	单行
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