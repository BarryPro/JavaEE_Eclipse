<%
  /* *********************
   * Ԥռ��
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
		 *@ ���������
		 *@        iLoginAccept              	��ˮ
		 *@        iChnSource              	 ������ʶ
		 *@        iOpCode                 		��������
		 *@        iLoginNo              	   	����
		 *@        iLoginPwd                  ��������
		 *@        iPhoneNo              	   	�ֻ�����
		 *@        iUserPwd              	   	��������
		 
		 *@        iOpNote              	   	��ע 	�����Բ�д��
		 
		 *@        iGroupId						����Ӫҵ��     д����ʱ�� groupid
		 *@        iCardNo						����  д����ʱ��
		 *@        iSIMNo 						SIM������   д����ʱ��
		 
		 *@        iDispatchType 				��������    �ʼĵ�ʱ��
		 *@        iStreamNo					��������	�ʼĵ�ʱ��
		 *@        iCompanyName					������˾����  �ʼĵ�ʱ��
		 
		 *@        isDispatch					��ʶ0���ͳɹ�1����ʧ��2����ɹ�3���ʧ��4�޸����͵�ַ5�û�����6Ԥռ
		 *@        iDescInfo					ʧ��ԭ��      �˹��������ʧ��ԭ��
		 *@        iFlag					    0д��1��д��������2����¼��3���
		 *@        iMailAddress				���͵�ַ
		 
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