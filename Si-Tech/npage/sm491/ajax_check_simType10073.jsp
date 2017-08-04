<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-9-20 20:29:11-------------------
 
 -------------------------后台人员：xiahk--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	
	//7个标准化入参
	String paraAray[] = new String[9];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = "10073"; 
	paraAray[8] = "52205,55086"; 

	String serverName = "sm404Check";
	String result_flag = "";
	String offer_flag = "";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-----sm404Check--------paraAray["+i+"]-------------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
	System.out.println("--hejwa--------code--------sm404Check------"+code);
	System.out.println("--hejwa--------msg---------sm404Check------"+msg);
	
	if("000000".equals(code)){
		if(serverResult.length>0){
			String oSimType = serverResult[0][0];
			String oOfferId = serverResult[0][1];
			
			System.out.println("--hejwa--------oOfferId---------------"+oOfferId);
			System.out.println("--hejwa--------oSimType---------------"+oSimType);
			
			/**
				相同代表有
				
				如果SIM卡类型是‘10073--NFC城市通卡’ 	并且		没有城市通卡可选资费(包括预约生效，预约失效)，
				
				则界面增加提示
				52205,55086
			*/
			if("10073".equals(oSimType)&&!"52205,55086".equals(oOfferId)){
				result_flag = "1"; 
			}
			
			if("52205,55086".equals(oOfferId)){
				offer_flag = "1"; 
			}
			
		}
	}
	
	System.out.println("--hejwa--------result_flag---------------"+result_flag);
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result_flag","<%=result_flag%>");
response.data.add("offer_flag","<%=offer_flag%>");
core.ajax.receivePacket(response);
