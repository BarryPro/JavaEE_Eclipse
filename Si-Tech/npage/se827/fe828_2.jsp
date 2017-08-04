<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String op_strong_pwd  = (String)session.getAttribute("password");//登陆密码
		String opCode = request.getParameter("opCode");
		String phoneNo = request.getParameter("phoneNo");
		String busiType = request.getParameter("busiType");
	    String oprType = request.getParameter("oprType");
	    String infoStr   = request.getParameter("infoStr");
		String provCode = request.getParameter("provCode");
		String dateStr =  new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String jsonstr   = request.getParameter("jsonstr");
		
		String[] inputParams = new String[15];
		inputParams[0] = "";
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = workNo;
		inputParams[4] = op_strong_pwd;
		inputParams[5] = phoneNo;
		inputParams[6] = "";
		inputParams[7] = dateStr;
		inputParams[8] = busiType;
		inputParams[9] = "02"+oprType;
		inputParams[10] = infoStr;
		if(busiType != null) {
			if(busiType.equals("42")) {      //手机阅读42
				inputParams[12] = "01030303";
			}else if(busiType.equals("57")) {//手机游戏57
				inputParams[12] = "01030302";
			}else if(busiType.equals("64")) {//手机支付64
				inputParams[12] = "01030301";
			}else if(busiType.equals("72")) {//无线音乐72
				inputParams[12] = "01030305";
			}else if(busiType.equals("82")) {//手机视频82
				inputParams[12] = "01030304";
			}
		}
		
		inputParams[13] = provCode;
		inputParams[14] = jsonstr;


for(int i=0;i<inputParams.length;i++)		{
	System.out.println("------liujian-------inputParams["+i+"]------------------->"+inputParams[i]);
}
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		<%
		System.out.println("---liujian--------------loginAccept=" + loginAccept);
		inputParams[0] = loginAccept;
		String tempAccept = loginAccept.substring(5);
		inputParams[11] = dateStr2 + "CSVC" + provCode + tempAccept;
		System.out.println("---liujian--------------inputParams[11]=" + inputParams[11]);
%>	
		<wtc:service name="sE828Cfm" routerKey="region" routerValue="<%=regionCode%>"
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
				<wtc:param value="<%=inputParams[14]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />	
<%
		System.out.println("e828===sE828Cfm===liujian=======retCode="+retCode);
		System.out.println("e828===sE828Cfm===liujian=======retMsg="+retMsg);
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		core.ajax.receivePacket(response); 