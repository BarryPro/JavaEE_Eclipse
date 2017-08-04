<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String backAccept = request.getParameter("backAccept");
	String famCode = request.getParameter("famCode");
	
	String memRoleId = request.getParameter("memRoleId");
	System.out.println("getBusi.jsp-----[" + phoneNo + "|" + backAccept + "|" + "|" + memRoleId + "]");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String prepayFee = "0";
  String machineFee = "0"; //购机款
  //记录是否成功标志   1 = 成功    0 = 失败
	int successFlag = 0;
%>

		<wtc:service name="sFamSelCheck" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
				<wtc:param value="<%=backAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="4"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=memRoleId%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	<%
	System.out.println("~~~~~~~~~" + retCode1 + " , " + result.length);
		if(!(retCode1.equals("0") || retCode1.equals("000000"))){
			successFlag = 0;
		}else{
			successFlag = 1;
			if(result != null && result.length > 0){
				prepayFee = result[0][0];
				machineFee = result[0][1];
			}
		}
	%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("prepayFee","<%=prepayFee%>");
	response.data.add("machineFee","<%=machineFee%>");
	core.ajax.receivePacket(response);