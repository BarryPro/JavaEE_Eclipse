<%
  /* *********************
   * ����:���ų�Ա�ʷѱ������
   * �汾: 1.0
   * ����: 2010/07/29
   * ����: ningtn
   * ��Ȩ: si-tech
   * *********************/
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	//��ȡ�û�session��Ϣ
	String workNo   = (String)session.getAttribute("workNo");              //����
	String workName = (String)session.getAttribute("workName");            //��������
	String password = (String)session.getAttribute("password");			//��������
	String regionCode= (String)session.getAttribute("regCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	//��������
	String opCode = request.getParameter("opcode");
	//��������
	String opName = request.getParameter("opName");
	String opNote = request.getParameter("opNote");
	String acceptNo = request.getParameter("acceptNo");
	String sysaccept = request.getParameter("sysaccept");
	String idNo = request.getParameter("idNo");
	String smCode = request.getParameter("smCode");
	System.out.println("============= fb098_submit.jsp  acceptNo : " + acceptNo);

	//��ʼ�����
	String paraArr[] = new String[10];
	paraArr[0] = workNo;
	paraArr[1] = password;
	paraArr[2] = opCode;
	paraArr[3] = opName;
	paraArr[4] = sysaccept;
	paraArr[5] = opNote;
	paraArr[6] = acceptNo;
	paraArr[7] = ip_Addr;
	paraArr[8] = idNo;
	paraArr[9] = smCode;
%>
	<wtc:service name="sb098Cfm" retcode="errCode" retmsg="errMsg"  outnum="2" routerKey="region" routerValue="<%=regionCode%>" >
		<wtc:param value="<%= paraArr[0]%>"/>
		<wtc:param value="<%= paraArr[1]%>"/>
		<wtc:param value="<%= paraArr[2]%>"/>
		<wtc:param value="<%= paraArr[3]%>"/>
		<wtc:param value="<%= paraArr[4]%>"/>
		<wtc:param value="<%= paraArr[5]%>"/>
		<wtc:param value="<%= paraArr[6]%>"/>
		<wtc:param value="<%= paraArr[7]%>"/>
		<wtc:param value="<%= paraArr[8]%>"/>
		<wtc:param value="<%= paraArr[9]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />

var response = new AJAXPacket();
response.data.add("errorCode","<%=errCode%>");
response.data.add("errorMsg","<%=errMsg%>");
core.ajax.receivePacket(response);
