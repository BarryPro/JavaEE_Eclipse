
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  
  String activeIdArr = request.getParameter("activeIdArr");
  String belongGroupArr = request.getParameter("belongGroupArr");
  String activeArr = request.getParameter("activeArr");
  String phoneNo = request.getParameter("phoneNo");
  
  String[] activeIdArrs = new String[]{""};
  String[] belongGroupArrs = new String[]{""};
  String[] activeArrs = new String[]{""};
  
  activeIdArrs = activeIdArr.split(",");
  belongGroupArrs = belongGroupArr.split(",");
  activeArrs = activeArr.split(",");
  
  if(activeIdArrs.length == 0){
		activeIdArrs = new String[]{""};
	}
	if(belongGroupArrs.length == 0){
		belongGroupArrs = new String[]{""};
	}
	if(activeArrs.length == 0){
		activeArrs = new String[]{""};
	}
	
	for(int i = 0; i < activeIdArrs.length; i++){
		System.out.println("===" + i + "===" + activeIdArrs[i] + " | " + activeArrs[i]);
	}
%>

		<wtc:service name="sCollCfm" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value=""/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:params value="<%=activeIdArrs%>"/>
			<wtc:params value="<%=belongGroupArrs%>"/>
			<wtc:params value="<%=activeArrs%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>



	var response = new AJAXPacket();

	response.data.add("retcode","<%=retCode1%>");
	response.data.add("retmsg","<%=retMsg1%>");
	core.ajax.receivePacket(response);