<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String retQf = request.getParameter("retQf");
		
		
		String opCode = request.getParameter("opCode");
		String phoneNo = request.getParameter("phoneNo");
		
		String kehuphone="";
		String guishuid="";
		String quxianid="";
		String dishiid="";
		String dishi="";
		String quxian="";
		String kehuxm="";
		String kehudw="";
		String kehujlxm="";
		String kehujlhm="";

		String  inputParsm [] = new String[8];
		inputParsm[0] = "0";
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = "工号"+workNo+"执行检索网络优先接入客户功能";

%>

		<wtc:service name="sE468Init" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="10">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>

		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
if(retCode.equals("000000")) {
		 kehuphone=ret[0][0];
		 guishuid=ret[0][1];
		 quxianid=ret[0][2];
		 dishiid=ret[0][3];
		 dishi=ret[0][4];
		 quxian=ret[0][5];
		 kehuxm=ret[0][6];
		 kehudw=ret[0][7];
		 kehujlxm=ret[0][8];
		 kehujlhm=ret[0][9];
		 System.out.println("------------------------------------------------------");
		 System.out.println(ret[0][0]);
		 System.out.println(ret[0][1]);
		 System.out.println(ret[0][2]);
		 System.out.println(ret[0][3]);
		 System.out.println(ret[0][4]);
		 System.out.println(ret[0][5]);
		 System.out.println(ret[0][6]);
		 System.out.println(ret[0][7]);
		 System.out.println(ret[0][8]);
		 System.out.println(ret[0][9]);
}
%>
	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("retQf","<%=retQf%>");
	
	response.data.add("kehuphone","<%=kehuphone%>");
	response.data.add("guishuid","<%=guishuid%>");
	response.data.add("quxianid","<%=quxianid%>");
	response.data.add("dishiid","<%=dishiid%>");
	response.data.add("dishi","<%=dishi%>");
	response.data.add("quxian","<%=quxian%>");
	response.data.add("kehuxingming","<%=kehuxm%>");
	response.data.add("kehudanwei","<%=kehudw%>");
	response.data.add("kehujlxingm","<%=kehujlxm%>");
	response.data.add("kehujlhaom","<%=kehujlhm%>");
	core.ajax.receivePacket(response);