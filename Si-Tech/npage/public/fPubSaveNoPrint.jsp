<%
/********************
 version v2.0
������: si-tech
*
*update:yanpx@2008-11-12 
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>

<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 

<%	
			/***�û��ֻ���	phone_no**��������	login_no**Ʊ������	bill_type*/
 
		  String opCode=request.getParameter("opCode");
			String login_accept=request.getParameter("login_accept");
			String retType=request.getParameter("retType");
	    String billType=request.getParameter("billType");
	    String phoneNo=request.getParameter("phoneNo");

	    String errCode="";
	    String errMsg="";
	    
	    System.out.println("opCode="+opCode);
	    System.out.println("login_accept="+login_accept);
	    System.out.println("retType="+retType);
	    System.out.println("billType="+billType);
%>
	<wtc:service name="sPrt_Del" routerKey="phone" routerValue="<%=phoneNo%>" outnum="13" >
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=billType%>"/>
	</wtc:service>
<%
if(retCode.equals("000000")){   
		 errCode="000000";
     errMsg="ȡ����ӡ�ɹ���";
}else{ 
		 errCode="000001";
     errMsg="����ӡ��ʾʧ�ܣ�";
}
%>
var response = new AJAXPacket();
var retType = "";
var errCode = ""
var errMsg = "";
retType = "<%=retType%>";
errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";

response.data.add("retType",retType);
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
core.ajax.receivePacket(response);

