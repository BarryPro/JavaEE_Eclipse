<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String regionCode=(String)session.getAttribute("regCode");
String op_name =  "魔百和机顶盒回库";
String org_code = (String)session.getAttribute("orgCode");//归属代码
String login_passwd = (String)session.getAttribute("password");//工号密码
String region_code = org_code.substring(0,2);
String phoneNo  = request.getParameter("phoneno");
String ImeiNo  = request.getParameter("imeino");
String UnitId  = request.getParameter("unitid");
String TypeId = request.getParameter("typeid");
String returnCode = "";
String returnMessage = "";

System.out.println("+++++++++++++++++++++++++++++魔百和机顶盒回库1");
String [] inputParam = new String [10] ;
	inputParam[0]="0";
	inputParam[1]="08";
	inputParam[2]="J105";
	inputParam[3]=workNo;
	inputParam[4]=login_passwd;
	inputParam[5]=phoneNo;
	inputParam[6]="";
	inputParam[7]=ImeiNo;
	inputParam[8]=UnitId;
	inputParam[9]=TypeId;
System.out.println("+++++++++++++++++++++++++++++魔百和机顶盒回库2");
%>
<wtc:service name="sJ104Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=inputParam[0]%>"/>
	<wtc:param value="<%=inputParam[1]%>"/>
	<wtc:param value="<%=inputParam[2]%>"/>
	<wtc:param value="<%=inputParam[3]%>"/>
	<wtc:param value="<%=inputParam[4]%>"/>
	<wtc:param value="<%=inputParam[5]%>"/>
	<wtc:param value="<%=inputParam[6]%>"/>
	<wtc:param value="<%=inputParam[7]%>"/>
	<wtc:param value="<%=inputParam[8]%>"/>
	<wtc:param value="<%=inputParam[9]%>"/>
</wtc:service>

<%
	returnCode = retCode;
	returnMessage = retMsg;
System.out.println("+++++++++++++++++++++++++++++魔百和机顶盒回库3 :"+returnCode);
	if(returnMessage==null){
		returnMessage = "";
	}
System.out.println("+++++++++++++++++++++++++++++魔百和机顶盒回库3 :"+returnMessage);
%>

var response = new AJAXPacket();
response.data.add("verifyType" ,"phoneno");
response.data.add("errorCode","<%=returnCode%>");
response.data.add("errorMsg","<%=returnMessage%>");
core.ajax.receivePacket(response);
