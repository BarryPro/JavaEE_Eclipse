<%
  /* *********************
   * ����: ��ȡ�û��˵���Ϣ
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
%>
		
		<wtc:service name="sPayMoreQry" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
				<wtc:param value="<%=phoneNo%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
		var array = [];
<%
		/**
		 * ���������
		 
		 *        iPhoneNo              	   	�ֻ�����
		 * ���ز�����
		 *				GPARM32_0	����ʱ��	����	�ַ���			��ʽΪ��YYYYMM��
							GPARM32_1	������Ϣ	����	�ַ���	60		
							GPARM32_2	�����˵����	����	�ַ���	10		

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