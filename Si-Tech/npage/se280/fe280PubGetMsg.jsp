<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	String loginAccept = request.getParameter("loginAccept");
	
	String outNum = request.getParameter("outNum") == null? "1" : request.getParameter("outNum");
	String queryType = request.getParameter("queryType")== null? "" : request.getParameter("queryType");
	String famCode = request.getParameter("famCode")== null? "" : request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode")== null? "" : request.getParameter("prodCode");
	String famRole = request.getParameter("famRole")== null? "" : request.getParameter("famRole");
	String memRoleId = request.getParameter("memRoleId")== null? "" : request.getParameter("memRoleId");
	String busyType = request.getParameter("busyType")== null? "" : request.getParameter("busyType");
	System.out.println(" ----- fe280PubGetMsg.jsp  ---  " + queryType + " , " + prodCode);
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String prepayFee = "0";
  //记录是否成功标志   1 = 成功    0 = 失败
	int successFlag = 0;
	String strArray = "var arrMsg; ";
	
	String vOrderFlag = request.getParameter("vOrderFlag")== null? "" : request.getParameter("vOrderFlag");
%>

		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode1" retmsg="retMsg1" outnum="<%=outNum%>">
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=queryType%>"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=prodCode%>"/>
				<wtc:param value="<%=famRole%>"/>
				<wtc:param value="<%=memRoleId%>"/>
				<wtc:param value="<%=busyType%>"/>
					<%
						if("e855".equals(opCode))
						{
					%>
				<wtc:param value="<%=vOrderFlag%>"/>
					<%
					}
					%>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	<%
	System.out.println("~~~~~ fe280PubGetMsg.jsp ~~~~" + retCode1 + " , " + result.length);
		if(!(retCode1.equals("0") || retCode1.equals("000000"))){
			successFlag = 0;
		}else{
			successFlag = 1;
			strArray = WtcUtil.createArray("arrMsg",result.length);
		}
	%>
	<%=strArray%>
	<%
	if(successFlag == 1){
		for(int i = 0 ; i < result.length ; i ++){
      for(int j = 0 ; j < result[i].length ; j ++){
      	if(result[i][j].trim().equals("") || result[i][j] == null){
				   result[i][j] = "";
				}
				System.out.println("$$$$$$ fe280PubGetMsg.jsp $$$ " + result[i][j]);
	%>
				arrMsg[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
	<%
			}
		}
	}
	%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("result",arrMsg);
	core.ajax.receivePacket(response);