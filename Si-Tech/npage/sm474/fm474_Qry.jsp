<%
/********************

 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 2017.4.24------------------
关于部署近期重点流量业务支撑系统改造的通知
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String iOfferId       = WtcUtil.repNull(request.getParameter("iOfferId"));
	String iProductId     = WtcUtil.repNull(request.getParameter("iProductId"));
	String iServicId      = WtcUtil.repNull(request.getParameter("iServicId"));
	String iProdOffInsId  = WtcUtil.repNull(request.getParameter("iProdOffInsId"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String opr_type       = WtcUtil.repNull(request.getParameter("opr_type"));
	String new_iServicId  = WtcUtil.repNull(request.getParameter("new_iServicId"));	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	
	//标准化入参
	String paraAray[] = new String[12];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] =  "";                                       //用户密码
	paraAray[7] =  iOfferId;                              //资费代码    
	paraAray[8] =  iProductId;  														//产品代码
	paraAray[9] =  iProdOffInsId; 														//资费实例
	paraAray[10] =  new_iServicId; 														//ServiceID串
	paraAray[11] =  iServicId;                            //旧APP的ServiceID串         
	

	String serverName = "sDXSPLLOfferChk";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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

	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}


	System.out.println("--duming--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("opr_type","<%=opr_type%>");
core.ajax.receivePacket(response);
