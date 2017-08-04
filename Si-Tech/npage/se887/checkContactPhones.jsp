<%
/********************
 version v1.0
开发商: si-tech
update:lijy@20110510
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String opCode = request.getParameter("opCode");
		String regionCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		String nopass = (String) session.getAttribute("password");/*操作员密码*/
	  String param = request.getParameter("contactPhoness");
	  param= param+"|";
    String [] params = param.split("\\|");
    String retCoderet="000000";
    String retMsgret="校验失败，号码不是本省移动号码0";
%>
	<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		  <wtc:param value="90000114"/>
		 <%
		 		for(int i=0;i<params.length;i++){
		 			System.out.println("yanpx ="+params[i]);
		 %>		
		 		 <wtc:param value="<%=params[i]%>"/>
		 	<%
		 		}
		 %>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
if(result.length>0) {
System.out.println("result.length========"+result.length);
System.out.println("===qian===="+result[0][0]+"============");
if(!"".equals(result[0][0].trim())) {
	retCoderet="000000";
	retMsgret="校验成功";
	}
	
	
		retCoderet="000000";
	retMsgret="校验成功";
}
%>		
	
var response = new AJAXPacket();
var retCode = "";
var retMessage = "";

retCode = "<%=retCoderet%>";
retMessage = "<%=retMsgret%>";
response.data.add("retcode",retCode);
response.data.add("retmsg",retMessage);
core.ajax.receivePacket(response);


