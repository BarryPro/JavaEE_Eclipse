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
	//�ʷѱ��ʱ��ˮ��
	String acceptNo = request.getParameter("acceptNo");
	//��������
	String opCode = request.getParameter("opcode");
	//��������
	String opName = request.getParameter("opName");
	System.out.println("============= fb098_quey.jsp  acceptNo : " + acceptNo);

	String loginAccept = "";
	String phoneNo = "";
	String memberName = "";
	String smName = "";
	String offerIdA = "";
	String offerNameA = "";
	String offerIdB = "";
	String offerNameB = "";
	String loginName = "";
	String loginTime = "";
	String smCode = "";
	String idNo = "";

	//��ʼ�����
	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = password;
	paraArr[2] = opCode;
	paraArr[3] = opName;
	paraArr[4] = acceptNo;
%>
	<wtc:service name="sb098Init" retcode="errCode" retmsg="errMsg"  outnum="12" routerKey="region" routerValue="<%=regionCode%>" >
		<wtc:param value="<%= paraArr[0]%>"/>
		<wtc:param value="<%= paraArr[1]%>"/>
		<wtc:param value="<%= paraArr[2]%>"/>
		<wtc:param value="<%= paraArr[3]%>"/>
		<wtc:param value="<%= paraArr[4]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
	if("000000".equals(errCode)){
		if(result != null && result.length > 0){
			loginAccept = result[0][0];
			phoneNo 	= result[0][1];
			memberName 	= result[0][2];
			smName 		= result[0][3];
			offerIdA 	= result[0][4];
			offerNameA 	= result[0][5];
			offerIdB 	= result[0][6];
			offerNameB 	= result[0][7];
			loginName 	= result[0][8];
			loginTime 	= result[0][9];
			idNo 		= result[0][10];
			smCode	 	= result[0][11];
		}
	}

%>
var response = new AJAXPacket();
response.data.add("errorCode"	,"<%=errCode%>");
response.data.add("errorMsg"	,"<%=errMsg%>");
response.data.add("loginAccept"	,"<%=loginAccept%>");
response.data.add("phoneNo"		,"<%=phoneNo%>");
response.data.add("memberName"	,"<%=memberName%>");
response.data.add("smName"		,"<%=smName%>");
response.data.add("offerIdA"	,"<%=offerIdA%>");
response.data.add("offerNameA"	,"<%=offerNameA%>");
response.data.add("offerIdB"	,"<%=offerIdB%>");
response.data.add("offerNameB"	,"<%=offerNameB%>");
response.data.add("loginName"	,"<%=loginName%>");
response.data.add("loginTime"	,"<%=loginTime%>");
response.data.add("smCode"		,"<%=smCode%>");
response.data.add("idNo"		,"<%=idNo%>");
core.ajax.receivePacket(response);
