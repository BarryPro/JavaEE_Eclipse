<%
/********************
 version v2.0
������: si-tech
ningtn 2011-6-7 10:54:09
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String phoneNo = request.getParameter("phoneNo");
		String iOldMode = WtcUtil.repStr(request.getParameter("iOldMode")," ");
		String iProjectType = WtcUtil.repStr(request.getParameter("iProjectType")," ");
		String vProjectCode = WtcUtil.repStr(request.getParameter("vProjectCode")," ");
		String iReturnFee = WtcUtil.repStr(request.getParameter("iReturnFee")," ");
		String iAccountMark = WtcUtil.repStr(request.getParameter("iAccountMark")," ");
		String retCode = "000000";
		String retMsg = "�����ɹ�";
		//add by diling for ��ȫ�ӹ��޸ķ����б�
	  String password = (String)session.getAttribute("password");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
		System.out.println(" ==== start f8379_check.jsp ==== " + loginAccept);
		
		String  inputParsm [] = new String[12];
		inputParsm[0] = loginAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		/* "�û���ǰ���ʷ�(iOldMode)" */
		inputParsm[7] = iOldMode;
		/* "�������ͣ�iProjectType��" */
		inputParsm[8] = iProjectType;
		/* "��������(vProjectCode)" */
		inputParsm[9] = vProjectCode;
		/* "ÿ������Ԥ���(iReturnFee)" */
		inputParsm[10] = iReturnFee;
		/* "�û���ǰ����(iAccountMark)" */
		inputParsm[11] = iAccountMark;
%>
		<wtc:service name="s8379Init" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
		</wtc:service>
			
		<wtc:service name="bs_8379VasgCfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode2" retmsg="retMsg2" outnum="2">
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
		</wtc:service>
<%
		System.out.println("  ===s8379Init=== " + retCode1 + " | " + retMsg1);
		System.out.println("  ===bs_8379VasgCfm=== " + retCode2 + " | " + retMsg2);
		if(!"000000".equals(retCode1)){
			retCode = retCode1;
			retMsg = retMsg1;
		}else if(!"000000".equals(retCode2)){
			retCode = retCode2;
			retMsg = retMsg2;
		}
		System.out.println("  ===s8379_check=== " + retCode + " | " + retMsg);
%>
var response = new AJAXPacket();
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);