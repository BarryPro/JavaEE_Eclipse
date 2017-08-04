<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String phone_type     = WtcUtil.repNull(request.getParameter("phone_type"));
	
	String retCode        = "";
	String retMsg         = "";
	
	String regionCode     = (String)session.getAttribute("regCode");
	String serverName = "sm463Cfm";
	
	String workNo = (String)session.getAttribute("workNo");
	System.out.println("--hejwa--------phone_type-------------"+phone_type);
			

if("2".equals(phone_type)){
	//先调用sGetBroadPhone服务转换手机号码
%>
			<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>"  outnum="2"  retcode="errCodeGetPhone" retmsg="errMsgGetPhone">
          <wtc:param  value="0"/>
          <wtc:param  value="01"/>
          <wtc:param  value=""/>
          <wtc:param  value="<%=workNo%>"/>
          <wtc:param  value=""/>
          <wtc:param  value=""/>
          <wtc:param  value=""/>
          <wtc:param  value="<%=phoneNo%>"/>
      </wtc:service>
      <wtc:array id="sGetBroadPhone_result" scope="end"/>
	
<%

	for(int iii=0;iii<sGetBroadPhone_result.length;iii++){
		for(int jjj=0;jjj<sGetBroadPhone_result[iii].length;jjj++){
			System.out.println("--------hejwa-------------sGetBroadPhone_result["+iii+"]["+jjj+"]=-----------------"+sGetBroadPhone_result[iii][jjj]);
		}
	}
			if("000000".equals(errCodeGetPhone) && sGetBroadPhone_result.length >0){
          phoneNo = sGetBroadPhone_result[0][0];
      }else{
      		retCode = "m463y1";
					retMsg  = "未查询到宽带号码对应的手机号";
      }
      
      if("".equals(phoneNo)){
      		retCode = "m463y1";
					retMsg  = "未查询到宽带号码对应的手机号";
      }
        	
}
	System.out.println("--hejwa--------phoneNo-------------"+phoneNo);

		System.out.println("--hejwa--------retCode--------------"+retCode);
		System.out.println("--hejwa--------retMsg---------------"+retMsg);
		
if(!"m463y1".equals(retCode)){
	
	//7个标准化入参
	String paraAray[] = new String[8];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = phoneNo;



%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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
		System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
		System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
}
 

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
