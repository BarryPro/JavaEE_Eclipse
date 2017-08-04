<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
	
	

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));                     
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String op_flag = "";
	
	if("m427".equals(opCode)){
		op_flag = "06";
	}else{
		op_flag = "07";
	}
	
%>

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="select to_char( sysdate+3 ,'yyyyMMddHH24miss')  as datef72 from dual" />
	</wtc:service>
	<wtc:array id="result_datef72" scope="end" />	
		
<%

String eff_date = "";
if(result_datef72.length>0){
	eff_date = result_datef72[0][0];
}
  String currentDate = "";
	
	//7个标准化入参
	String paraAray[] = new String[15];
	
	paraAray[0] = loginAccept;                              /*业务流水*/                
	paraAray[1] = "01";                                     /*渠道类型*/                
	paraAray[2] = opCode;                                   /*操作代码*/                
	paraAray[3] = (String)session.getAttribute("workNo");   /*操作工号*/                
	paraAray[4] = (String)session.getAttribute("password"); /*工号密码*/                
	paraAray[5] = phoneNo;                                  /*手机号码*/                
	paraAray[6] = "";                                       /*手机密码 */               
	                                                          
	paraAray[7] = "ZY";                            /*业务类型 ZY */                         
	paraAray[8] = "045112";                            /*企业代码 045112 */                     
	paraAray[9] = "ZY1201";                            /*业务代码 ZY1201 */                     
	paraAray[10] = op_flag;                            /*操作类型 06丁欧07退订 */               
	paraAray[11] = currentDate;                            /*生效时间 14位 */                       
	paraAray[12] = eff_date;                            /*失效时间 20501230000000 */             
	paraAray[13] = currentDate;                            /*操作时间 14位 */                       
	paraAray[14] = "备注："+opCode;                            /*操作备注*/                
	

	String serverName = "sProWorkFlowCfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
