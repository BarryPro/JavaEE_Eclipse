<%
  /* *********************
   * ����: ���õ绰�Ƿ��й�ͨ����¼
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
		 * ���������
		 *        ��֤�ֻ���	�ַ���	80
							�û��ֻ���	�ַ���	15
							����	�ַ���	6
							opcode	�ַ���	4
		 * ���ز�����
		  GPARM32_0	���ش���	����
			GPARM32_1	������ʾ��Ϣ	����
			GPARM32_2	��Ϣ��֤��ʶ	����
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