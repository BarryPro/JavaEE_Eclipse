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
	String phoneNo = request.getParameter("phoneNo");
	String offerId = request.getParameter("offerId");
	String seq = request.getParameter("seq");

	String paraAray[] = new String[9];
	paraAray[0] = "";
	paraAray[1] = "01";
	paraAray[2] = "d194";
	paraAray[3] = work_no;
	paraAray[5] = "";
	paraAray[5] = phoneNo;
	paraAray[6] = "";
	paraAray[7] = offerId;
	paraAray[8] = seq;
	
	String retCode = "000000";
	String retMsg = "成功";
	
%>

	<wtc:service name="sd194Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%

	retCode = errCode;
	retMsg = errMsg;
	if(retCode.equals("0")||retCode.equals("000000"))
	{
		System.out.println("调用服务sd194Cfm  成功@@@@@@@@@@@@@@@@@@@@@@@@@@");	        	
	}else
	{
		System.out.println("调用服务sd194Cfm  失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(retCode+"   retCode    "+retMsg+"    retMsg");
	}
%>
var response = new AJAXPacket();
response.data.add("retCode",'<%=retCode%>');
response.data.add("retMsg",'<%=retMsg%>');
core.ajax.receivePacket(response);
<%
System.out.println("======================================sd194Cfm end");
%>

