<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String iChnSource = (String)request.getParameter("iChnSource");
        String iLoginNo = (String)request.getParameter("iLoginNo");
        String iLoginPWD = (String)request.getParameter("iLoginPWD");
        String iPhoneNo = (String)request.getParameter("iPhoneNo");
        String iNewOfferId = (String)request.getParameter("iNewOfferId");
String outType = "";
String outPrice = "";
String outBusName = "";
String outOldName = "";
StringBuffer buf = new StringBuffer();
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++"+iNewOfferId);
%>
        <wtc:service name="s1270Notice" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="4" >
                <wtc:param value="0"/>
                <wtc:param value="<%=iChnSource%>"/>
                <wtc:param value="1270"/>
                <wtc:param value="<%=iLoginNo%>"/>
                <wtc:param value="<%=iLoginPWD%>"/>
                <wtc:param value="<%=iPhoneNo%>"/>
                <wtc:param value=""/>
                <wtc:param value="<%=iNewOfferId%>"/>
        </wtc:service>
	<wtc:array id="result" scope="end"/>
<%
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++"+retCode);
String retrunCode =retCode;
String returnMsg  =retMsg;

if(retrunCode.equals("000000") &&result.length> 0){
	outType = result[0][0];
	outPrice = result[0][1];
	outBusName = result[0][2];
	outOldName = result[0][3];

System.out.println("++++++++++++++++++++++++++++++++++++++++++++++"+outType);
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++"+outPrice);
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++"+outBusName);
System.out.println("++++++++++++++++++++++++++++++++++++++++++++++"+outOldName);
}

buf.append(retrunCode).append("~")
	.append(returnMsg).append("~")
	.append(outType).append("~")
	.append(outPrice).append("~")
	.append(outBusName).append("~")
	.append(outOldName).append("~");
out.print(buf.toString());

%>

