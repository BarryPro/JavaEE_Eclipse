<%
  /* *********************
   * ����: ����ҵ�����������Ʋ�������ѯ
   * �汾: 1.0
   * ����: 2010/07/12
   * ����: 
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String op_code = "1076";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String loginAccept = getMaxAccept();
	String chnSource = "01";

	String op_type = "A";
	String timeFlag = (String)request.getParameter("timeFlag");
	String inputWorkNo = (String)request.getParameter("workNoHid");
	String inputOpcode = (String)request.getParameter("inputOpcode");
	String limitValue = (String)request.getParameter("limitValue");
	System.out.println(" ~~~~~~~~~ || " + timeFlag + " || " + inputWorkNo + " || " + inputOpcode + " || " + limitValue);
	
	String paraAray[] = new String[12];
	paraAray[0] = loginAccept;
	paraAray[1] = chnSource;
	paraAray[2] = op_code;
	paraAray[3] = workNo;
	paraAray[4] = password;
	paraAray[5] = " ";
	paraAray[6] = " ";
	paraAray[7] = op_type;
	paraAray[8] = inputWorkNo;
	paraAray[9] = inputOpcode;
	paraAray[10] = limitValue;
	paraAray[11] = timeFlag;
%>
	<wtc:service name="s1076Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" 
					retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
	</wtc:service>
<%
if(errCode.equals("0")||errCode.equals("000000")){
System.out.println("chenggong &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
%>
	<script language="JavaScript" type="text/javascript">
		rdShowMessageDialog("��ӳɹ�");
		var dirtPage = "/npage/s8002/f1076_login.jsp?opCode=<%=op_code%>";
		location = dirtPage;
	</script>
<%
}else{
	System.out.println("shibaile $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
%>
	<script language="JavaScript" type="text/javascript">
		rdShowMessageDialog("���ʧ�ܣ�������룺" + "<%=errCode%>" + "����ԭ��" + "<%=errMsg%>");
		var dirtPage = "/npage/s8002/f1076_login.jsp?opCode=<%=op_code%>";
		location = dirtPage;
	</script>
<%
}
%>

