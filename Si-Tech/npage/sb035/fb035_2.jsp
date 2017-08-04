<%
  /* *********************

   * *********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password"); 
	String phone_no = request.getParameter("phone_no");
	String paraAray[] = new String[12];
	paraAray[0] = "0";
	paraAray[1] = "01";
	paraAray[2] = "6892";
	paraAray[3] = workNo;
	paraAray[4] = password;
	paraAray[5] = phone_no;
	paraAray[6] = " ";
	
%>
	<wtc:service name="sQrCodeAgain" routerKey="regionCode" routerValue="<%=regionCode%>" 
					retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
	</wtc:service>
<%
	int successFlag = 0;
	if(!(errCode.equals("0") || errCode.equals("000000"))){
		System.out.println("======fb035_2.jsp调用sQrCodeAgain失败！======" + errCode);
		successFlag = 0;
	}else{
		System.out.println("======fb035_2.jsp调用sQrCodeAgain成功！======" + errCode);
		successFlag = 1;
	}
%>
	var response = new AJAXPacket();
	response.data.add("retcode","<%= errCode %>");
	response.data.add("retmsg","<%= errMsg %>");
	response.data.add("result","<%=successFlag%>");
	core.ajax.receivePacket(response);