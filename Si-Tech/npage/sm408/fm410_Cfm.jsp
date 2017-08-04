<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016/11/15 10:32:31-------------------
 
 -------------------------后台人员：liyang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));
  String iOfferId       = WtcUtil.repNull(request.getParameter("iOfferId"));
	String iEmeiCode      = WtcUtil.repNull(request.getParameter("iEmeiCode"));
	String iEmeiCodeOld   = WtcUtil.repNull(request.getParameter("iEmeiCodeOld"));
	String opNote         = WtcUtil.repNull(request.getParameter("opNote"));
			                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[11];
	
	paraAray[0] = loginAccept;                              //### 0	iLoginAccept	业务流水               
	paraAray[1] = "01";                                     //### 1	iChnSource		渠道标识               
	paraAray[2] = opCode;                                   //### 2	iOpCode			操作代码                 
	paraAray[3] = (String)session.getAttribute("workNo");   //### 3	iLoginNo		工号                     
	paraAray[4] = (String)session.getAttribute("password"); //### 4	iLoginPwd		工号密码                 
	paraAray[5] = phoneNo;                                  //### 5	iPhoneNo		号码                     
	paraAray[6] = "";                                       //### 6	iUserPwd		号码密码                 
	paraAray[7] = iOfferId ;                                //### 7	iOfferId		资费代码 无资费是传0     
  paraAray[8] = iEmeiCode;                                //### 8	iEmeiCode		IMEI码	 订购和更新时必传
  paraAray[9] = iEmeiCodeOld;                             //### 9	iEmeiCodeOld	原IMEI码         
  paraAray[10] = opNote;        
  
  
  
  
	String serverName = "sHeMuProdOffChg";
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
