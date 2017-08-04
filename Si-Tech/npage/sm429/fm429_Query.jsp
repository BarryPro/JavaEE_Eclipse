<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016/11/17 16:43:25-------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String sel_q_accept   = WtcUtil.repNull(request.getParameter("sel_q_accept"));
		                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String current_time   = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	
	//7个标准化入参
	String paraAray[] = new String[12];
	
	paraAray[0] = "BIP3A309";                               //业务代码	字符串	F8	BIP3A309	固定为缺省值
	paraAray[1] = "T3000312";                               //交易代码	字符串	F8	T3000312	固定为缺省值
	paraAray[2] = (String)session.getAttribute("workNo");   //操作工号	字符串	F6		                    
	paraAray[3] = (String)session.getAttribute("orgCode");  //工号归属	字符串	F9		ORGCODE             
	paraAray[4] = sel_q_accept;                                       //发起方的操作流水号	字符串	V32		可为空    
	paraAray[5] = phoneNo;                                  //手机号码	字符串	V32		                    
	paraAray[6] = "451";                                    //省代码	字符串	F3	451	固定为缺省值        
	paraAray[7] = current_time;                             //操作时间	字符串	F14		YYYYMMDDHH24MISS    
	paraAray[8] = "0";                                       //参数个数	字符串	F9		                    
	paraAray[9] = "";                                       //参数名称	字符串数组	V10		                
	paraAray[10] = "";                                      //参数值	字符串数组	V256		                
	paraAray[11] = "备注："+phoneNo+"国际漫游套餐预办理查询"+opCode;                 //操作备注	字符串	V256		                  
	
	

	String serverName = "sTSNPubSnd";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="24" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
