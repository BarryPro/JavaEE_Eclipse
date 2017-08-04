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
	String opTypeCode     = WtcUtil.repNull(request.getParameter("opTypeCode"));
	String prodId         = WtcUtil.repNull(request.getParameter("prodId"));
		
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String current_time   = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	
	//7个标准化入参
	String paraAray[] = new String[15];
	
	paraAray[0] = "BIP3A305";                               //1	业务代码	字符串	F8	BIP3A305	固定为缺省值
	paraAray[1] = "T3000308";                               //2	交易代码	字符串	F8	T3000308	固定为缺省值
	paraAray[2] = (String)session.getAttribute("workNo");   //3	操作工号	字符串	F6		                    
	paraAray[3] = (String)session.getAttribute("orgCode");  //4	工号归属	字符串	F9		ORGCODE             
	paraAray[4] = "";                                       //5	发起方的操作流水号	字符串	V32		可为空    
	paraAray[5] = phoneNo;                                  //6	手机号码	字符串	V32		                    
	paraAray[6] = "451";                                    //7	省代码	字符串	F3	451	固定为缺省值        
	paraAray[7] = current_time;                             //8	操作时间	字符串	F14		YYYYMMDDHH24MISS    
	paraAray[8] = prodId;                                       //9	产品ID代码	字符串	F14		                  
	paraAray[9] = opTypeCode;                               //10	操作类型	字符串	V32		01:订购  02:取消  03:销户退订        
	paraAray[10] = "0";                                      //11	参数个数	字符串	F9		          
	paraAray[11] = "";                                      //12	参数名称	字符串数组	V10		      
	paraAray[12] = "";                                      //13	参数值	字符串数组	V256		      
	paraAray[13] = "";                                      //14	操作备注	字符串	V256		        
	paraAray[14] = "备注："+phoneNo+"操作"+opCode+"类型为"+opTypeCode;                 //15                                  
	                                                                  
	                                                                  



	String serverName = "sTSNPubSnd";
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
