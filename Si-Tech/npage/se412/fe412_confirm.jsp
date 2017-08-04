<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		
		String opCode = request.getParameter("opCode");
		String phoneNo = request.getParameter("phoneNo");
		String bp_name = request.getParameter("bp_name");
		String renzhengtype = request.getParameter("renzhengtype");
		String idcard="";
		if(renzhengtype.equals("0")) {//如果是身份证
		  idcard = request.getParameter("idcard");
		}
	  else {//不是身份证
	  	idcard = request.getParameter("idcardqt");
		}
		String lxrphoneNo = request.getParameter("lxrphoneNo");
		String lianxiren_name = request.getParameter("lianxiren_name");
		String yucunmoney = request.getParameter("yucunmoney");
		String ykh_workNo = request.getParameter("ykh_workNo");
		String khdays = request.getParameter("khdays");
		String spr_workNo = request.getParameter("spr_workNo");
		String do_note = request.getParameter("do_note");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
		
		String  inputParsm [] = new String[18];
		inputParsm[0] = loginAccept;
		inputParsm[1] = "";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = "";
		inputParsm[6] = "";
		inputParsm[7] = do_note;
		inputParsm[8] = phoneNo;
		inputParsm[9] = bp_name;
		inputParsm[10] = renzhengtype;
		inputParsm[11] = idcard;
		inputParsm[12] = lianxiren_name;
		inputParsm[13] = lxrphoneNo;
		inputParsm[14] = ykh_workNo;
		inputParsm[15] = yucunmoney;
		inputParsm[16] = spr_workNo;
		inputParsm[17] = khdays;
%>
		<wtc:service name="sE412Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
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
				<wtc:param value="<%=inputParsm[12]%>"/>
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
				<wtc:param value="<%=inputParsm[15]%>"/>
				<wtc:param value="<%=inputParsm[16]%>"/>
				<wtc:param value="<%=inputParsm[17]%>"/>

		</wtc:service>
		<wtc:array id="ret" scope="end"/>

	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);