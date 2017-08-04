<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by qidp @ 2009-01-04
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%

int  inputNumber = 7;
//String outputNumber = "5";
String [] inputParam = new String[inputNumber];
inputParam[0] = request.getParameter("phoneNo");
inputParam[1] = request.getParameter("simOldNo");
inputParam[2] = request.getParameter("simNewNo");
inputParam[3] = request.getParameter("orgCode");
inputParam[4] = request.getParameter("op_code");
inputParam[5] = request.getParameter("cardtype");
inputParam[6] = request.getParameter("cardsim_type");
System.out.println(inputParam[4]);
//SPubCallSvrImpl s1210 = new SPubCallSvrImpl();
//String[] retStr = s1210.callService("s1220SimVer",inputParam,outputNumber,"phone",inputParam[0]);
%>
<wtc:service name="s1220SimVer" routerKey="phone" routerValue="<%=inputParam[0]%>" retcode="s1220SimVerCode" retmsg="s1220SimVerMsg" outnum="5">
    <wtc:param value="<%=inputParam[0]%>"/>
    <wtc:param value="<%=inputParam[1]%>"/>
    <wtc:param value="<%=inputParam[2]%>"/>
    <wtc:param value="<%=inputParam[3]%>"/>
    <wtc:param value="<%=inputParam[4]%>"/>
    <wtc:param value="<%=inputParam[5]%>"/>
    <wtc:param value="<%=inputParam[6]%>"/>   	
</wtc:service>
<wtc:array id="s1220SimVerArr" scope="end" />
<%
System.out.println("222222");
String errCode= s1220SimVerCode;
String errMsg= s1220SimVerMsg;
String simFee="";
String simType="";
String simTypeName = "";
System.out.println("333333     "+s1220SimVerCode);
if(s1220SimVerArr.length>0 && s1220SimVerCode.equals("000000"))
{
  simFee=s1220SimVerArr[0][0]; 
  simTypeName = s1220SimVerArr[0][3]; 
  simType=s1220SimVerArr[0][4];
}
System.out.println("simType" + simType);

%>

var response = new AJAXPacket();
var errCode = "<%=errCode%>";
var errMsg = "<%=errMsg%>";
var simFee = "<%=simFee%>";
var simType = "<%=simType%>";
var simTypeName = "<%=simTypeName%>";

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("simFee",simFee);

response.data.add("simType",simType);
response.data.add("simTypeName",simTypeName);

core.ajax.receivePacket(response);




