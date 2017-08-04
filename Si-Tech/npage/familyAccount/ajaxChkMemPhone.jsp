<%
/********************
 version v2.0
开发商: si-tech
*
* create hejwa
* 校验家庭手机号码
* 2013-4-28 8:53:29
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var retArray = new Array();
<%
	String regionCode     = (String)session.getAttribute("regCode");
	String workNo         = (String)session.getAttribute("workNo");
	String wPassword      = (String)session.getAttribute("password");
	String memPhone       = request.getParameter("memPhoneIpt");
	String sLoginAccept   = request.getParameter("sLoginAccept");
	String opCode         = request.getParameter("opCode");
	String famContractNo  = request.getParameter("famContractNo");
	String srv_no         = request.getParameter("srv_no");
	String r_acc_opType   = request.getParameter("r_acc_opType");
	String retCode        = "";
	String retMsg         = "";
	String isMemFlag      = "";
	String defContractNo  = "";
	String feeLimit       = "";
	String retStrs        = "";
	String feelName       = "";
	System.out.println("hejwa----------------famContractNo-------------------"+famContractNo);
try{
%>
  <wtc:service name="sG630Check" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sLoginAccept%>" />
		<wtc:param value="01" />	
		<wtc:param value="<%=opCode%>" />	
		<wtc:param value="<%=workNo%>" />	
		<wtc:param value="<%=wPassword%>" />			
		<wtc:param value="<%=memPhone%>" />		
		<wtc:param value="" />				
		<wtc:param value="<%=srv_no%>" />
		<wtc:param value="<%=famContractNo%>" />	
		<wtc:param value="<%=r_acc_opType%>" />		
	</wtc:service>
	<wtc:array id="result_t1"  start="0"  length="3"  scope="end"/> 
	<wtc:array id="result_t2"  start="3"  length="5"  scope="end"/>
 
<%
	if(result_t1.length>0){
		isMemFlag     = result_t1[0][0];
		defContractNo = result_t1[0][1];
		feeLimit      = result_t1[0][2];
	}
	for(int i=0;i<result_t2.length;i++){
		for(int j=0;j<result_t2[i].length;j++){
			retStrs += result_t2[i][j]+",";
		}
		retStrs += "|";
	}
		
	retCode   = code;
	retMsg    = msg;
}catch(Exception e){
	retCode   = "444444";
	retMsg    = "系统错误";
	isMemFlag = "1";
}

%>		 	
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("memPhone","<%=memPhone%>");
response.data.add("isMemFlag","<%=isMemFlag%>");
response.data.add("feeLimit","<%=feeLimit%>");
response.data.add("defContractNo","<%=defContractNo%>");
response.data.add("retStrs","<%=retStrs%>");

core.ajax.receivePacket(response);