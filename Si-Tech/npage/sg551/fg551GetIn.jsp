<%
  /* *********************
   * ����: ����û�����ʱ��
   * �汾: 1.0
   * ����: 2013/03/11
   * ����: zhouby
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String phoneNo = (String)request.getParameter("phoneNo");
		
		/**
		System.out.println("zhouby opCode " + opCode);
		*/
%>
		
		<wtc:service name="sIndexCustMsg" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
				<wtc:param value="<%=phoneNo%>"/>
		</wtc:service>
		
		<wtc:array id="result" scope="end" start="0" length="10"/>
			
		var array = [];
<%
		/**
		 �������;
			input_parms[0] in_phone_no    �������    
			 
			
			 ���ز�����
			GPARM32_0    �ײ�      product_name
			GPARM32_1    ����      group_name
			GPARM32_2    ����      current_point  
			GPARM32_3    Ʒ��      sm_name
			  GPARM32_4    ����ʱ��  open_time  
			GPARM32_5    ״̬      run_name        
			    GPARM32_6    �û���    cust_id
			GPARM32_7    ����
			GPARM32_8    �ʺ���� 
			GPARM32_9    �ͻ�����  attr_code
		 */
		 //"000000".equals(retCode) 
		if (true && result.length > 0){
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