<%
/********************
 version v2.0
开发商: si-tech
作者: jianglei
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String work_no =(String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String pass = (String)session.getAttribute("password");
	String opCode="b464";
	String opName="wlan预付费卡密码补发";
	
	String phone_no=request.getParameter("phone_no");
	String cardtype=request.getParameter("cardtype");
	String cardno=request.getParameter("cardno");
	String efftime=request.getParameter("efftime");
		
	String paraAray[] = new String[10];
	paraAray[0] = "0";
	paraAray[1] = "01";
	paraAray[2] = opCode;
	paraAray[3] = work_no;
	paraAray[4] = "";
	paraAray[5] = phone_no;
	paraAray[6] = "";
	
	paraAray[7] = cardtype;
	paraAray[8] = cardno;
	paraAray[9] = efftime;
	
	String retCode = "000000";
	String retMsg = "成功";
	
%>

<wtc:service name="sb464Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
	retCode = errCode;
	retMsg = errMsg;
	
	if(retCode.equals("0")||retCode.equals("000000"))
	{
		System.out.println("调用服务sb464Cfm  成功@@@@@@@@@@@@@@@@@@@@@@@@@@");	        	
	}else
	{
		System.out.println("调用服务sb464Cfm  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(retCode+"   retCode    "+retMsg+"    retMsg");
	}
%>
	
var response = new AJAXPacket();
response.data.add("retCode",'<%=retCode%>');
response.data.add("retMsg",'<%=retMsg%>');
core.ajax.receivePacket(response);
<%
System.out.println("======================================");
%>