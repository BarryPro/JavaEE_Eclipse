<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2011-11-23 手机与CA卡
     *
     ********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String loginNo = (String)session.getAttribute("workNo");
		String loginPwd  = (String)session.getAttribute("password");//登陆密码
		String regionCode= (String)session.getAttribute("regCode");
		//绑定CA卡前，查询用户信息，需传递的参数
		String opCode = request.getParameter("opCode");
		String phone = request.getParameter("phone");	
		String note = request.getParameter("note");
		String user_id = request.getParameter("user_id");
		String card_id = request.getParameter("card_id");
		String method = request.getParameter("method");
		//绑定CA时，除查询用户传递的参数外，需传递的参数
		String addr = request.getParameter("addr");
		String id_type = request.getParameter("id_type");
		String iccid = request.getParameter("id_iccid");
		String userName = request.getParameter("user_name");
		System.out.println("===================liujian=============================");
		System.out.println("opCode = " + opCode + ",phone = " + phone + ",note = " + note);
		System.out.println("user_id = " + user_id + ",card_id = " + card_id + ",method = " + method);
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
	//绑定CA卡前，查询用户信息
	if("searchUserInfo".equals(method)) {
		if(note == null || "".equals(note)){
			note =  phone + "--" + card_id + "绑前查询";
		}
		String  inputParams [] = new String[10];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = loginNo;
		inputParams[4] = loginPwd;
		inputParams[5] = phone;
		inputParams[6] = "";
		inputParams[7] = note;
		inputParams[8] = card_id;
		inputParams[9] = user_id;
	
		for(int i=0;i<inputParams.length;i++){
			System.out.println("test : inputParams[" + i + "]=" + inputParams[i]);
		}
	/*
		String[] ret = new String[6];
		for(int i=0;i<ret.length;i++){
				ret[i] = i + "";
			}
		String retCode = "000000";
		String retMsg = "成功";
		*/
	%>
	<wtc:service name="sE434Init" routerKey="region" routerValue="<%=regionCode%>"
				 retcode="retCode" retmsg="retMsg" outnum="6">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
			<wtc:param value="<%=inputParams[8]%>"/>
			<wtc:param value="<%=inputParams[9]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
	<%
		System.out.println("retcode=" + retCode);
		System.out.println("retmsg=" + retMsg);
	%>	
	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode %>");
	response.data.add("retmsg","<%=retMsg %>");
	<% 
	if("000000".equals(retCode)) {
	%>
		response.data.add("user_id","<%=ret[0][0] %>");
		response.data.add("card_id","<%=ret[0][1] %>");
		response.data.add("name","<%=ret[0][2] %>");
		response.data.add("addr","<%=ret[0][3] %>");
		response.data.add("id_type","<%=ret[0][4] %>");
		response.data.add("id_iccid","<%=ret[0][5] %>");
	<%
	}
	%>
	core.ajax.receivePacket(response);
	<%	
	}
	//绑定CA卡
	else if("bindCA".equals(method)) {
		if(note == null || "".equals(note)){
			note =phone + "--" + card_id + "绑定";
		}
		String  inputParams [] = new String[14];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = loginNo;
		inputParams[4] = loginPwd;
		inputParams[5] = phone;
		inputParams[6] = "";
		inputParams[7] = note;
		inputParams[8] = card_id;
		inputParams[9] = user_id;
		inputParams[10] = addr;
		inputParams[11] = id_type;
		inputParams[12] = iccid;
		inputParams[13] = userName;
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("test : inputParams[" + i + "]=" + inputParams[i]);
		}
		/*
		String retCode = "000000";
		String retMsg = "成功";
		*/
	%>
	<wtc:service name="sE434Cfm" routerKey="region" routerValue="<%=regionCode%>"
				 retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
			<wtc:param value="<%=inputParams[8]%>"/>
			<wtc:param value="<%=inputParams[9]%>"/>
			<wtc:param value="<%=inputParams[10]%>"/>
			<wtc:param value="<%=inputParams[11]%>"/>
			<wtc:param value="<%=inputParams[12]%>"/>
			<wtc:param value="<%=inputParams[13]%>"/>
	</wtc:service>
	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
	<%
	}
	//解除绑定前查询绑定信息(sE435Init)
	else if("searchBindInfo".equals(method)) {
		if(note == null || "".equals(note)){
			note = phone + "--" + card_id + "解绑前查询";
		}
		String  inputParams [] = new String[8];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = loginNo;
		inputParams[4] = loginPwd;
		inputParams[5] = phone;
		inputParams[6] = "";
		inputParams[7] = note;
	%>
	<wtc:service name="sE435Init" routerKey="region" routerValue="<%=regionCode%>"
				 retcode="retCode" retmsg="retMsg" outnum="6">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
		<%
		System.out.println("sE435Init -- retcode=" + retCode);
		System.out.println("sE435Init -- retmsg=" + retMsg);
	%>
	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode %>");
	response.data.add("retmsg","<%=retMsg %>");
	<% 
	if("000000".equals(retCode)) {
	%>
		response.data.add("user_id","<%=ret[0][0] %>");
		response.data.add("card_id","<%=ret[0][1] %>");
		response.data.add("userName","<%=ret[0][2] %>");
		response.data.add("addr","<%=ret[0][3] %>");
		response.data.add("id_type","<%=ret[0][4] %>");
		response.data.add("id_iccid","<%=ret[0][5] %>");
	<%
	}
	%>
	core.ajax.receivePacket(response);
	<%
	}else if("unbindCA".equals(method)) {
		if(note == null || "".equals(note)){
			note = phone + "--" + card_id + "解绑定";
		}
		String  inputParams [] = new String[9];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = loginNo;
		inputParams[4] = loginPwd;
		inputParams[5] = phone;
		inputParams[6] = "";
		inputParams[7] = note;
		inputParams[8] = user_id;
%>
<wtc:service name="sE435Cfm" routerKey="region" routerValue="<%=regionCode%>"
				 retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParams[0]%>"/>
			<wtc:param value="<%=inputParams[1]%>"/>
			<wtc:param value="<%=inputParams[2]%>"/>
			<wtc:param value="<%=inputParams[3]%>"/>
			<wtc:param value="<%=inputParams[4]%>"/>
			<wtc:param value="<%=inputParams[5]%>"/>
			<wtc:param value="<%=inputParams[6]%>"/>
			<wtc:param value="<%=inputParams[7]%>"/>
			<wtc:param value="<%=inputParams[8]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode %>");
	response.data.add("retmsg","<%=retMsg %>");
	core.ajax.receivePacket(response);
<%
}
%>