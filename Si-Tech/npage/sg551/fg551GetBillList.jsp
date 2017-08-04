<%
  /* *********************
   * 功能: 获取用户账单信息
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
		
		String phoneNo = (String)request.getParameter("phoneNo");
%>
		
		<wtc:service name="sPayMoreQry" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
				<wtc:param value="<%=phoneNo%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
		var array = [];
<%
		/**
		 * 输入参数：
		 
		 *        iPhoneNo              	   	手机号码
		 * 返回参数：
		 *				GPARM32_0	交费时间	单行	字符串			格式为“YYYYMM“
							GPARM32_1	交费信息	单行	字符串	60		
							GPARM32_2	上月账单额度	单行	字符串	10		

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
		System.out.println("zhouby ===+++" + retCode);
		System.out.println("zhouby ===+++" + retMsg);
%>
		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		response.data.add("result", array);
		core.ajax.receivePacket(response);