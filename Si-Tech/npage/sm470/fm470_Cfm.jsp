<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String id_no        = WtcUtil.repNull(request.getParameter("id_no"));
	String sel_opType        = WtcUtil.repNull(request.getParameter("sel_opType"));
	String opr        = WtcUtil.repNull(request.getParameter("opr"));
	String run_code = WtcUtil.repNull(request.getParameter("run_code"));
	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	//String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	//标准化入参
	String paraAray[] = new String[15];
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                 	 //服务号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = "";                                       //操作说明
	paraAray[8] = "";                                       //操作时间
	paraAray[9] = id_no;                                       //集团产品id
	paraAray[10] = opr;                                       //操作类型00停机,01开机
	paraAray[11] = "";                                       //停机短信需要的年月
	paraAray[12] = "";                                       //停机短信语中欠费
	paraAray[13] = "1";                                       //短信标志
	paraAray[14] = run_code;                                       //新状态
	
	String serverName = "sWlOprCfm";
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
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--duming--------出参------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
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
core.ajax.receivePacket(response);
