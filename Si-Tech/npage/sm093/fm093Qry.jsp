<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	
	/*2014/04/18 15:33:49 gaopeng ¿í´ø¹ÊÕÏ²éÑ¯(sBroadFaultQry)*/
  String regionCode= (String)session.getAttribute("regCode");
  
  String iLoginAccept = (String)request.getParameter("iLoginAccept");
  String iChnSource = (String)request.getParameter("iChnSource");
  String iOpCode = (String)request.getParameter("iOpCode");
  String iLoginNo = (String)request.getParameter("iLoginNo");
  String iLoginPwd = (String)request.getParameter("iLoginPwd");
  String iPhoneNo = (String)request.getParameter("iPhoneNo");
  String iUserPwd = (String)request.getParameter("iUserPwd");
  String iCfmLogin = (String)request.getParameter("iCfmLogin");
  
  
  String[] param = new String[8];
  param[0] = iLoginAccept;
  param[1] = iChnSource;
  param[2] = iOpCode;
  param[3] = iLoginNo;
  param[4] = iLoginPwd;
  param[5] = iPhoneNo;
  param[6] = iUserPwd;
  param[7] = iCfmLogin;
  
  String retAccept = "";
  String retCodede = "";
  String retMsg = "";  
  String retLogMsg = "";
  
%>

		<wtc:service name="sBroadFaultQry" routerKey="region" routerValue="<%=regionCode%>"
			  retcode="retCode1" retmsg="retMsg1" outnum="4">
				
				<wtc:param value="<%=param[0]%>"/>
				<wtc:param value="<%=param[1]%>"/>
				<wtc:param value="<%=param[2]%>"/>
				<wtc:param value="<%=param[3]%>"/>
				<wtc:param value="<%=param[4]%>"/>
				<wtc:param value="<%=param[5]%>"/>
				<wtc:param value="<%=param[6]%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=param[7]%>"/>
				
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	<%
		if("0".equals(retCode1) || "000000".equals(retCode1)){
			 retAccept = result[0][0];
		   retCodede = result[0][1];
		   retMsg = result[0][2];
		   retLogMsg = result[0][3];
		}
		
	%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode1 %>");
	response.data.add("retmsg","<%= retMsg1 %>");
	response.data.add("vRetAccept","<%= retAccept %>");
	response.data.add("vRetCodede","<%= retCodede %>");
	response.data.add("vRetMsg","<%= retMsg %>");
	response.data.add("vRetLogMsg","<%= retLogMsg %>");
	
	core.ajax.receivePacket(response);