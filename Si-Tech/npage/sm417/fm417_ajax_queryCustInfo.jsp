<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-10-9 9:51:43-------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo     = WtcUtil.repNull(request.getParameter("phoneNo"));
	                   
  String workNo      = (String)session.getAttribute("workNo");
  String regionCode  = (String)session.getAttribute("regCode");
	String retCode     = "";
	String retMsg      = "";
	                   
	String  oCustOprFlag = ""; /* 0 没经办人记录；1有经办人记录*/
	String  oCustName    = "";
	String  oOprName     = "";
	String  oOprIdType   = "";
	String  oOprIdIccid  = "";
	String  oOprAddr     = "";
	String  vIdType      = "";
	String  vIdIccid     = "";
	String  vIdTypeName  = "";
	String  vCustId      = "";
	
	
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	
		
    String paraAray[]  = new String[7];
				   paraAray[0] = "";
				   paraAray[1] = "01";
				   paraAray[2] = opCode;
				   paraAray[3] = (String)session.getAttribute("workNo");
				   paraAray[4] = (String)session.getAttribute("password");
				   paraAray[5] = phoneNo;
				   paraAray[6] = "";
 		for(int jjj=0;jjj<paraAray.length;jjj++){
			System.out.println("-------------hejwa--------paraAray["+jjj+"]=-----------------"+paraAray[jjj]);
		}  
try{
%>
		<wtc:service name="sm417Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="code" retmsg="msg" outnum="10" >
		      <wtc:param value="<%=paraAray[0]%>"/>
		      <wtc:param value="<%=paraAray[1]%>"/>
		      <wtc:param value="<%=paraAray[2]%>"/>
		      <wtc:param value="<%=paraAray[3]%>"/>
		      <wtc:param value="<%=paraAray[4]%>"/>
		      <wtc:param value="<%=paraAray[5]%>"/>
		      <wtc:param value="<%=paraAray[6]%>"/>
		  </wtc:service>
		<wtc:array id="result_t2" scope="end" />		
			
<%
	retCode = code;
	retMsg = msg;

	if(result_t2.length>0){	
		   oCustOprFlag = result_t2[0][0];
			 oCustName    = result_t2[0][1];
			 oOprName     = result_t2[0][2];
			 oOprIdType   = result_t2[0][3];
			 oOprIdIccid  = result_t2[0][4];
			 oOprAddr     = result_t2[0][5];
			 vIdType      = result_t2[0][6];
			 vIdIccid     = result_t2[0][7];
			 vIdTypeName  = result_t2[0][8];
			 vCustId      = result_t2[0][9];
	}
	   
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务sUserCustInfo出错，请联系管理员";
}



System.out.println("-hejwa------------oCustOprFlag--------------------->"+oCustOprFlag);
System.out.println("-hejwa------------oCustName------------------------>"+oCustName);
System.out.println("-hejwa------------oOprName------------------------->"+oOprName);
System.out.println("-hejwa------------oOprIdType----------------------->"+oOprIdType);
System.out.println("-hejwa------------oOprIdIccid---------------------->"+oOprIdIccid);
System.out.println("-hejwa------------oOprAddr------------------------->"+oOprAddr);
System.out.println("-hejwa------------vIdType-------------------------->"+vIdType);
System.out.println("-hejwa------------vIdIccid------------------------->"+vIdIccid);
System.out.println("-hejwa------------vIdTypeName---------------------->"+vIdTypeName);
System.out.println("-hejwa------------vCustId-------------------------->"+vCustId);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");

response.data.add("oCustOprFlag","<%=oCustOprFlag%>");
response.data.add("oCustName","<%=oCustName%>");
response.data.add("oOprName","<%=oOprName%>");
response.data.add("oOprIdType","<%=oOprIdType%>");
response.data.add("oOprIdIccid","<%=oOprIdIccid%>");
response.data.add("oOprAddr","<%=oOprAddr%>");
response.data.add("vIdType","<%=vIdType%>");
response.data.add("vIdIccid","<%=vIdIccid%>");
response.data.add("vIdTypeName","<%=vIdTypeName%>");
response.data.add("vCustId","<%=vCustId%>");

core.ajax.receivePacket(response);
