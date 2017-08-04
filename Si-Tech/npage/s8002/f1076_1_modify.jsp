<%
  /* *********************

   * *********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String op_code = "1076";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String loginAccept = getMaxAccept();
	String chnSource = "01";

	String op_type = (String)request.getParameter("optypeHid");
	String timeFlag = (String)request.getParameter("timeFlagHid");
	String inputWorkNo = (String)request.getParameter("loginNoHid");
	String inputOpcode = (String)request.getParameter("opCodeHid");
	String limitValue = (String)request.getParameter("limitValueHid");
	System.out.println(" ~~~~~~~~~ || " + timeFlag + " || " + inputWorkNo + " || " + inputOpcode + " || " + limitValue);
	int successFlag = 0;
	
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
	if(!(errCode.equals("0") || errCode.equals("000000"))){
		System.out.println("======f1076_1_modify.jsp调用s1076Cfm失败！======");
		successFlag = 0;
	}else{
		System.out.println("======f1076_1_modify.jsp调用s1076Cfm成功！======");
		successFlag = 1;
	}
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= errCode %>");
	response.data.add("retmsg","<%= errMsg %>");
	response.data.add("result","<%=successFlag%>");
	core.ajax.receivePacket(response);