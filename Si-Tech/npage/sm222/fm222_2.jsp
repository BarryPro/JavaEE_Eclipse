<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-29 14:53:49-------------------
 更改二级tab为一级tab将页面原来的直接查询放到ajax中查询
 -------------------------后台人员：无--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

 	  String retCode  = "";
	  String retMsg   = "";
	
		String custName = "";
		/*用户状态*/
		String run_code = "";
		/*用户上次状态标志*/
		String run_code_last = "";
		/*用户上次状态名称*/
		String run_name_last = "";
		/*用户当前状态标志*/
		String run_code_now = "";
		/*用户当前状态名称*/
		String run_name_now = "";
		
try{

 		String opCode      = (String)request.getParameter("opCode");
		String opName      = (String)request.getParameter("opName");
		String phoneNo     = (String)request.getParameter("phoneNo");
		String loginAccept = (String)request.getParameter("loginAccept");
/*		
		System.out.println("------hejwa------------opCode----------->"+opCode);
		System.out.println("------hejwa------------opName----------->"+opName);
		System.out.println("------hejwa------------phoneNo---------->"+phoneNo);
		System.out.println("------hejwa------------loginAccept------>"+loginAccept);
*/		
    String regionCode  = (String)session.getAttribute("regCode");
    String loginNo     = (String)session.getAttribute("workNo");
 		String noPass      = (String)session.getAttribute("password");
 		String groupID     = (String)session.getAttribute("groupId");
		String ipAddrM     = (String)session.getAttribute("ipAddr");

		
		
 		String inst = "通过phoneNo[" + phoneNo + "]查询";
	
		
		
%>
  	
   <wtc:service name="sUserCustInfo" outnum="41"  retmsg="msg" retcode="code"  >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddrM%>"/>
      <wtc:param value="<%=inst%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
	<wtc:array id="result11" scope="end" />
<%
	
	retCode = code;
	retMsg = msg;
 	if(result11.length <= 0){
 		retCode = "m222_ERR1";
 		retMsg = "该用户不是在网用户或状态不正常！";
	}else{
		custName = result11[0][5];
	}
%>
	
	<wtc:service name="sUserInfoQry" outnum="51"  retmsg="msg1" retcode="code1" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
  </wtc:service>
	<wtc:array id="result22" scope="end" />
<%		
		retCode = code1;
		retMsg = msg1;
		if(result22.length > 0){
			/*用户状态*/
			run_code = result22[0][29];
			/*用户上次状态标志*/
			run_code_last = result22[0][30];
			/*用户上次状态名称*/
			run_name_last = result22[0][31];
			/*用户当前状态标志*/
			run_code_now = result22[0][32];
			/*用户当前状态名称*/
			run_name_now = result22[0][33];
		}
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务sUserInfoQry出错，请联系管理员";
}

/*
		System.out.println("------hejwa------------retCode----------->"+retCode);
		System.out.println("------hejwa------------retMsg------------>"+retMsg);
		System.out.println("------hejwa------------run_code---------->"+run_code);
		System.out.println("------hejwa------------run_code_last----->"+run_code_last);
		System.out.println("------hejwa------------run_name_last----->"+run_name_last);
		System.out.println("------hejwa------------run_code_now------>"+run_code_now);
		System.out.println("------hejwa------------run_name_now------>"+run_name_now);
		System.out.println("------hejwa------------custName---------->"+custName);
*/		
		
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("run_code","<%=run_code%>");
response.data.add("run_code_last","<%=run_code_last%>");
response.data.add("run_name_last","<%=run_name_last%>");
response.data.add("run_code_now","<%=run_code_now%>");
response.data.add("run_name_now","<%=run_name_now%>");
response.data.add("custName","<%=custName%>");
core.ajax.receivePacket(response);
