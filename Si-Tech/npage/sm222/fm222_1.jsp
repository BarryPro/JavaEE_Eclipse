<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------后台人员：王文刚--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	
	String oprLoginNo = WtcUtil.repNull(request.getParameter("oprLoginNo"));
	String beginDate  = WtcUtil.repNull(request.getParameter("beginDate"));
	String endDate    = WtcUtil.repNull(request.getParameter("endDate"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[10];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = oprLoginNo;
	paraAray[8] = beginDate;
	paraAray[9] = endDate;

	String serverName = "sY249Qry";
	
	for(int jjj=0;jjj<paraAray.length;jjj++){
			System.out.println("---------------------paraAray["+jjj+"]=-----------------"+paraAray[jjj]);
		}
		
try{
%>
		<wtc:service name="<%=serverName%>" outnum="15" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />						
			<wtc:param value="<%=paraAray[7]%>" />		
			<wtc:param value="<%=paraAray[8]%>" />		
			<wtc:param value="<%=paraAray[9]%>" />		
		</wtc:service>
		<wtc:array id="result_t1" scope="end" start="0"  length="4"  />
		<wtc:array id="result_t2" scope="end" start="4"  length="11" />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
 	if(result_t1.length>0){
	 	if(!"0".equals(result_t1[0][3])){//长度大于0
		
			//拼装返回数组
			for(int i=0;i<result_t2.length;i++){
		%>
				 retArray[<%=i%>] = new Array();
		<%	
				for(int j=0;j<result_t2[i].length;j++){
				
				System.out.println("--hejwa--------result_t2["+i+"]["+j+"]--------------"+result_t2[i][j]);
		%>
				    retArray[<%=i%>][<%=j%>] = "<%=result_t2[i][j]%>";
		<%		
				}
			}
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
