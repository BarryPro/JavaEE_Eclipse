<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 【2017/3/25 星期六 13:32:08】-------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String iImeiNo         = WtcUtil.repNull(request.getParameter("iImeiNo"));
	String optype         = WtcUtil.repNull(request.getParameter("optype"));
	String iMember_No         = WtcUtil.repNull(request.getParameter("iMember_No"));

	
		

	
	System.out.println("--duming----iImeiNo-------------"+iImeiNo);
	System.out.println("--duming----optype-------------"+optype);
	System.out.println("--duming----iMember_No-------------"+iMember_No);
	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	String serverName="";

	if("add".equals(optype)){

	String iSale_Price         = WtcUtil.repNull(request.getParameter("fee"));

			 serverName = "sm461Cfm";

	System.out.println("--duming----fee-------------"+iSale_Price);
	//标准化入参
	String paraAray[] = new String[10];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                	 	 //手机号码
	paraAray[6] = "";                                       //号码密码
	paraAray[7] = iImeiNo;                                       //imei号码
	paraAray[8] = iMember_No;                                       //成员终端序列号
	paraAray[9] = iSale_Price;                                       //押金



	try{
%>
		<wtc:service name="<%=serverName%>" outnum="8" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="6"  />
		<wtc:array id="result_t2" scope="end" start="6"  length="2" />
<%
	retCode = result_t2[0][0];
	retMsg = result_t2[0][1];
System.out.println("--duming--------retCode="+retCode);
System.out.println("--duming--------retMsg="+retMsg);
	//拼装返回数组
	for(int i=0;i<result_t1.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<result_t1[i].length;j++){
				System.out.println("--duming--------出参------serverName=["+serverName+"]--------result_t1["+i+"]["+j+"]------->"+result_t1[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=result_t1[i][j]%>";
<%		
		}
	}


	
	
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
response.data.add("retArray",retArray);
response.data.add("iSale_Price",<%=iSale_Price%>);
response.data.add("optype","<%=optype%>");
core.ajax.receivePacket(response);



<%	
	}

%> 	


<%
	if("del".equals(optype)){
			 serverName = "sm461Cfm_In";

			 //标准化入参
	String paraAray[] = new String[9];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                	 	 //手机号码
	paraAray[6] = "";                                       //号码密码
	paraAray[7] = iImeiNo;                                       //imei号码
	paraAray[8] = iMember_No;                                       //成员终端序列号



	try{
%>
		<wtc:service name="<%=serverName%>" outnum="9" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="7"  />
		<wtc:array id="result_t2" scope="end" start="7"  length="2" />
<%
	retCode = result_t2[0][0];
	retMsg = result_t2[0][1];
System.out.println("--duming--------retCode="+retCode);
System.out.println("--duming--------retMsg="+retMsg);
	//拼装返回数组
	for(int i=0;i<result_t1.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<result_t1[i].length;j++){
				System.out.println("--duming--------出参------serverName=["+serverName+"]--------result_t1["+i+"]["+j+"]------->"+result_t1[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=result_t1[i][j]%>";
<%		
		}
	}


	
	
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
response.data.add("retArray",retArray);
response.data.add("optype","<%=optype%>");
core.ajax.receivePacket(response);


<%	
	}

%> 	
