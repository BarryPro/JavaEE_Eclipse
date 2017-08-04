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
	                   
	String gestoresIdType   = WtcUtil.repNull(request.getParameter("gestoresIdType"));
	String gestoresIccId    = WtcUtil.repNull(request.getParameter("gestoresIccId"));
	String gestoresName     = WtcUtil.repNull(request.getParameter("gestoresName"));
	String gestoresAddr     = WtcUtil.repNull(request.getParameter("gestoresAddr"));
	
	String id_type          = WtcUtil.repNull(request.getParameter("id_type"));
	String id_iccid         = WtcUtil.repNull(request.getParameter("id_iccid"));
	
	
        	                   
  String workNo      = (String)session.getAttribute("workNo");
  String regionCode  = (String)session.getAttribute("regCode");
	String retCode     = "";
	String retMsg      = "";
	                   
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	
		
		if(gestoresIdType.indexOf("|")!=-1){
			String[] temp_arr = gestoresIdType.trim().split("\\|");
			gestoresIdType = temp_arr[0];
		}
		
    String paraAray[]  = new String[14];
				   paraAray[0] = "";
				   paraAray[1] = "01";
				   paraAray[2] = opCode;
				   paraAray[3] = (String)session.getAttribute("workNo");
				   paraAray[4] = (String)session.getAttribute("password");
				   paraAray[5] = phoneNo;
				   paraAray[6] = "";
				   
				   paraAray[7] = id_type;
				   paraAray[8] = id_iccid;
				   
				   paraAray[9] = gestoresName ;
				   paraAray[10] = gestoresIdType ;
				   paraAray[11] = gestoresIccId;
				   paraAray[12] = gestoresAddr;
				   paraAray[13] = "备注：客户信息补全";
				   
try{
%>
		<wtc:service name="sm417Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="code" retmsg="msg" outnum="10" >
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]-------------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>				
		  </wtc:service>
		<wtc:array id="result_t2" scope="end" />		
			
<%
	retCode = code;
	retMsg = msg;
 
	   
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务sm417Cfm出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");


core.ajax.receivePacket(response);
