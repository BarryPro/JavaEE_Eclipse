<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015/4/3 9:32-------------------
 提交页面
 -------------------------后台人员：jingang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode          = WtcUtil.repNull(request.getParameter("opCode"));
	String idno            = WtcUtil.repNull(request.getParameter("idno"));
	String iOldCardNoStart = WtcUtil.repNull(request.getParameter("iOldCardNoStart"));
	String iOldCardNoEnd   = WtcUtil.repNull(request.getParameter("iOldCardNoEnd"));
	String iNewCardNoStart = WtcUtil.repNull(request.getParameter("iNewCardNoStart"));
	String iNewCardNoEnd   = WtcUtil.repNull(request.getParameter("iNewCardNoEnd"));
	String iOpNote         = WtcUtil.repNull(request.getParameter("iOpNote"));
	String icardnumber     = WtcUtil.repNull(request.getParameter("icardnumber"));
	String iOldMoney       = WtcUtil.repNull(request.getParameter("iOldMoney"));
	String iNewMoney       = WtcUtil.repNull(request.getParameter("iNewMoney"));
	
					    
	String workNo     = (String)session.getAttribute("workNo");
	String password   = (String)session.getAttribute("password");
	String workName   = (String)session.getAttribute("workName");
	String orgCode    = (String)session.getAttribute("orgCode");
	String ipAddrss   = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	  
	String retCode    = "";
	String retMsg     = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[16];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                        
	paraAray[6] = "";                                        
	paraAray[7] = idno;   
	paraAray[8] = iOldCardNoStart;   
	paraAray[9] = iOldCardNoEnd;   
	paraAray[10] = iNewCardNoStart;   
	paraAray[11] = iNewCardNoEnd;   
	paraAray[12] = iOpNote;   
	paraAray[13] = icardnumber;   
	paraAray[14] = iOldMoney;   
	paraAray[15] = iNewMoney;   
	
	
	for(int jjj=0;jjj<paraAray.length;jjj++){
			System.out.println("---------------------paraAray["+jjj+"]=-------hejwa----------"+paraAray[jjj]);
	}
		
		
	String serverName = "sm256Cfm";
	String[] iOldCardNoStart_arr = iOldCardNoStart.split(",");
	String[] iNewCardNoStart_arr = iNewCardNoStart.split(",");
	String[] iOldMoney_arr = iOldMoney.split(",");
	String[] iNewMoney_arr = iNewMoney.split(",");
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />						
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:params value="<%=iOldCardNoStart_arr%>" />
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:params value="<%=iNewCardNoStart_arr%>" />
			<wtc:param value="<%=paraAray[11]%>" />
			<wtc:param value="<%=paraAray[12]%>" />
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:params value="<%=iOldMoney_arr%>" />
			<wtc:params value="<%=iNewMoney_arr%>" />
		</wtc:service>
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------sm256Cfm------"+code);
	System.out.println("--hejwa--------msg---------sm256Cfm------"+msg);
	 
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);