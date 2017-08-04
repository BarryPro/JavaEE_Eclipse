<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2017/3/6 星期一 14:40:08-------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	
	String in_unitid     = WtcUtil.repNull(request.getParameter("in_unitid"));//集团编码
	String in_ecid   = WtcUtil.repNull(request.getParameter("in_ecid"));//EC集团编码
	String in_productofferId = WtcUtil.repNull(request.getParameter("in_productofferId"));//订购关系id
	String in_starttime   = WtcUtil.repNull(request.getParameter("in_starttime"));
	String in_endtime   = WtcUtil.repNull(request.getParameter("in_endtime"));
	String sel_opType   = WtcUtil.repNull(request.getParameter("sel_opType"));

			
				                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//标准化入参
	String paraAray[] = new String[13];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                	 	 //手机号码
	paraAray[6] = "";                                       //号码密码
	paraAray[7] = in_unitid;                                       //集团编码
	paraAray[8] = in_ecid;                                       //EC集团编码
	paraAray[9] = in_productofferId;                                       //订购关系ID
	paraAray[10] = in_starttime;                                       //归档日期开始
	paraAray[11] = in_endtime;                                       //归档日期结束
	paraAray[12] = sel_opType;                                       //sel_opType

	String serverName = "sm461Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="6" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="4"  />
		<wtc:array id="result_t2" scope="end" start="4"  length="2" />
<%


	retCode = result_t2[0][0];
	retMsg  = result_t2[0][1];
System.out.println("--duming--------retCode="+retCode);
System.out.println("--duming--------retMsg="+retMsg);
	if("000000".equals(retCode)){

	//拼装返回数组
	for(int i=0;i<result_t1.length;i++){

%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<result_t1[i].length;j++){
				System.out.println("--duming--------出参------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+result_t1[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=result_t1[i][j]%>";
<%		
		}
	}
	}else{
			System.out.println("============  失败==========");
		}
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

	retMsg = retMsg.trim();
	System.out.println("--duming--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
