<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016/12/1 9:33:35 -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	
	String iOpType        = WtcUtil.repNull(request.getParameter("iOpType"));
	String iQryPhoneNo    = WtcUtil.repNull(request.getParameter("iQryPhoneNo"));
	String iIMSINo        = WtcUtil.repNull(request.getParameter("iIMSINo"));
	String iCfmLogin      = WtcUtil.repNull(request.getParameter("iCfmLogin"));
	String iIdIccid       = WtcUtil.repNull(request.getParameter("iIdIccid"));
	String iIMEINo        = WtcUtil.repNull(request.getParameter("iIMEINo"));
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[14];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = iOpType;  /*查询类型:手机号码：0;IMSI:1;宽带账号:2;证件号码:3;IMEI:4(仅支持5选1)*/
	paraAray[8] = iQryPhoneNo; /*手机号码*/
	paraAray[9] = iIMSINo; /*IMSI*/
	paraAray[10] = iCfmLogin; /*宽带账号*/
	paraAray[11] = iIdIccid; /*证件号码*/
	paraAray[12] = iIMEINo;  	/*IMEI*/
	paraAray[13] = "备注：查询安保信息"; /*备注*/

	
	String serverName = "sm433Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="14" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]-------------------->"+paraAray[i]);
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
	System.out.println("--hejwa--------code-----serverName=["+serverName+"]---------"+code);
	System.out.println("--hejwa--------msg------serverName=["+serverName+"]---------"+msg);
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
		
				System.out.println("--hejwa--------出参------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
