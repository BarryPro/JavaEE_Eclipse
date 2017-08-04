<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 【2017/3/6 星期一 13:32:08】-------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String ipt_llCardNo   = WtcUtil.repNull(request.getParameter("ipt_llCardNo"));
	
	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	String itype          = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[11];
	
	paraAray[0] = "0";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] =  "";                                       //用户密码
	paraAray[7] =  ipt_llCardNo;                                       //流量卡号码
	paraAray[8] =  "";                                       //注释信息
	paraAray[9] =  "";                                       //业务流水号
	paraAray[10] = "";                                       //业务流水号

	String serverName = "si127Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming1-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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
	if(serverResult.length>0){
		itype = serverResult[0][10];
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}


	System.out.println("--duming1--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming1--------retMsg------serverName=["+serverName+"]---------"+retMsg);
	System.out.println("--duming1--------itype------serverName=["+serverName+"]---------"+itype);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("itype","<%=itype%>");
core.ajax.receivePacket(response);
