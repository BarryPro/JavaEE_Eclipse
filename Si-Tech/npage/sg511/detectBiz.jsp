<%
  /* *********************
   * ����: ����û��Ƿ��Ѿ����������ҵ��
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
		 * ���������
		 *        iLoginAccept               ��ˮ
		 *        iChnSource              	  ������ʶ
		 *        iOpCode                 		��������
		 *        iLoginNo              	   	����
		 *        iLoginPwd                  ��������
		 *        iPhoneNo              	   	�ֻ�����
		 *        iUserPwd                 	��������
		 * ���ز�����
		 *				oPhoneNo										�ֻ�����
		 *				oId_No                    	�û���ʶ
		 *				oSpId                    		��ҵ����
		 *				oSpName                 		��ҵ����
		 *				oBizCode                   	ҵ�����
		 *				oBizName                   	ҵ������
		 *				oEffTime                   	��Чʱ��
		 *				oExpTime                   	ʧЧʱ��
		 *				oOldLoginAccept             ԭ��ˮ
		 *				oLoginNo                	 	��������
		 *				oOpTime                   	����ʱ��
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