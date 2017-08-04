<%
/********************
 version v1.0
开发商: si-tech
create:zhangyan
2011-12-26 17:54:07
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%


String opCode="1211";
String work_no =(String)session.getAttribute("workNo");//工号
String region_code = (String)session.getAttribute("regCode");
String iLoginAccept=	"";
String iChnSource=		"";
String iOpCode=      	opCode;
String iLoginNo=		work_no;       								/*查询工号*/
String iLoginPwd=		"";     
String iPhoneNo=		"";										/*标准入参，暂时不用*/    
String iUserPwd=   		"";										/*标准入参，暂时不用*/

String inOpNote=		"";								/*开始时间 YYYY-MM-DD HH:mi:ss*/
String iIdIccid=		"";
String inLoginAccept=	request.getParameter("bookingId");

System.out.println("zhangyan@add@iLoginAccept=["+iLoginAccept+"]");
System.out.println("zhangyan@add@iChnSource=["+iChnSource+"]");
System.out.println("zhangyan@add@iOpCode=["+iOpCode+"]");
System.out.println("zhangyan@add@iLoginNo=["+iLoginNo+"]");
System.out.println("zhangyan@add@iLoginPwd=["+iLoginPwd+"]");
System.out.println("zhangyan@add@iPhoneNo=["+iPhoneNo+"]");
System.out.println("zhangyan@add@iUserPwd=["+iUserPwd+"]");
System.out.println("zhangyan@add@inOpNote=["+inOpNote+"]");
System.out.println("zhangyan@add@iIdIccid=["+iIdIccid+"]");
System.out.println("zhangyan@add@iLoginAccept=["+iLoginAccept+"]");

%>

<wtc:service name="sE385Qry" routerKey="regionCode" routerValue="<%=region_code%>" 
	retcode="retcode" retmsg="retmsg"  outnum="7">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>	
		<wtc:param value="<%=inOpNote%>"/>
		<wtc:param value="<%=iIdIccid%>"/>
		<wtc:param value="<%=inLoginAccept%>"/>				
</wtc:service>
<wtc:array id="resultList" scope="end" />
<%
	String phone_no = "";
	String cussid = "";
	if (resultList.length == 0)
	{
		retcode = "000001";
		retmsg = "没有预约信息";
		phone_no = "";
		cussid = "";
	}
	else
	{
		phone_no = resultList[0][1];
		cussid = resultList[0][6];	
	}
%>
var response = new AJAXPacket();
response.data.add("vBookingPhoneNo","<%=phone_no%>"); 
response.data.add("rpc_page","queryBookingId");
response.data.add("retcode","<%=retcode%>"); 
response.data.add("retmsg","<%=retmsg%>"); 
core.ajax.receivePacket(response);