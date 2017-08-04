<%
  /* *********************
   * 功能: 检测用户是否满足模糊验证条件
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
		String opCode = (String)request.getParameter("opCode");
		String accept = (String)request.getParameter("accept");
		
		  	/*
  	cl32 sG551Check 7 2 "0" "01" "g551" "aaaaxp" "" "13766945381" "" 
		cl32 sG551Check 7 2 "0" "01" "g552" "aaaaxp" "" "13654558690" "" 
	
		System.out.println("zhouby opCode " + opCode);
		*/
%>
		
		<wtc:service name="sG551Check" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=accept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
		</wtc:service>
		
		<wtc:array id="result" scope="end" start="0" length="2"/>
			
		var array = [];
<%
		/**
		 输入参数;
			input_parms[0] in_phone_no    服务号码    
			 
			
			 返回参数：
			GPARM32_0    套餐      product_name
			GPARM32_1    渠道      group_name
			GPARM32_2    积分      current_point  
			GPARM32_3    品牌      sm_name
			GPARM32_4    入网时间  open_time  
			GPARM32_5    状态      run_name        
			GPARM32_6    用户号    cust_id
			GPARM32_7    级别
			GPARM32_8    帐号余额 
			GPARM32_9    客户属性  attr_code
		 */
		if ("000000".equals(retCode) && result.length > 0){
				for(int i = 0; i < result.length; i++){
%>
						var t = [];
<%
						for(int j = 0; j < result[i].length; j++){
						//System.out.println("zhouby result [" + i +"][" + j + "] = " + result[i][j]);
%>					
								t[<%=j%>] = "<%=result[i][j]%>";
<%
						}
%>
						array[<%=i%>] = t;
<%
				}
		}
/*
		System.out.println("zhouby retCode  " + retCode);
		System.out.println("zhouby retMsg  " + retMsg);
*/
%>
		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		response.data.add("result", array);
		core.ajax.receivePacket(response);