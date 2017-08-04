<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>

<%
 
  String smCode = WtcUtil.repNull(request.getParameter("smCode")); 
System.out.println(" ^^gaopengSeeLog===smCode=^^^^^^^^^^^^^ " + smCode);
  String regionCode = (String)session.getAttribute("regCode");
  String strArray="var retResult; ";  //must
  String arrStr = "var retResult; ";
  String goodKind = WtcUtil.repNull(request.getParameter("goodKind")); 
	System.out.println("gaopengSeeLog==========goodKind=="+goodKind);  	
  String opCode = WtcUtil.repNull(request.getParameter("opCode")); 
  System.out.println("gaopengSeeLog==========opCode=="+opCode);  	
  if(goodKind==null||"".equals(goodKind)){
  	 goodKind = "P";
  }
  System.out.println(" ^^gaopengSeeLog===opCode=^^^^^^^^^^^^^ " + opCode);
  String sqlFlag="222";
   if("1104".equals(opCode)){
   		sqlFlag="222";
   }else if("4977".equals(opCode)){
   		sqlFlag="226";
   }else if("e887".equals(opCode)){
			/* 如果是IMS固话centrex，229 */
			sqlFlag = "229";
   }else if("g629".equals(opCode)){
		/* 家庭开户 */
		sqlFlag = "231";
	}else if("m462".equals(opCode)){
	/* 家庭开户 */
	sqlFlag = "233";
}
	 System.out.println("gaopengSeeLog==========sqlFlag=="+sqlFlag);  
  System.out.println(smCode+"-hejwa--------------------goodKind-----------------"+goodKind + " , " + sqlFlag);
%>
	<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		  <wtc:param value="<%=sqlFlag%>"/>
		  <wtc:param value="<%=smCode%>"/>
		  <wtc:param value="<%=goodKind%>"/>	
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>	
<%
	 strArray = WtcUtil.createArray("retResult",result_t.length);	
	 
	   System.out.println("result_t.length = " + result_t.length);
%>
<%=strArray%>
<%
	for(int i=0;i<result_t.length;i++){
	  System.out.println("value = " + result_t[i][1]);
	%>
		retResult[<%=i%>][0] = "<%=result_t[i][0]%>";
		retResult[<%=i%>][1] = "<%=result_t[i][1]%>";
	<%
	}
	
	
	/*
	 * 如果宽带品牌是“集团宽带(ki)”，则并老户时只允许20开头的号码办理。
	 * hejwa chenlin的服务
	 * 关于集团宽带支撑系统第三批优化需求
	 */

	String retCode1        = "";
	String retMsg1         = "";

	//7个标准化入参
	String paraAray[] = new String[8];
		 
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = WtcUtil.repNull(request.getParameter("phoneNo"));                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = smCode;


	String serverName = "sJtKDOpenChk";
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
	retCode1 = code;
	retMsg1 = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}
%>


var response = new AJAXPacket();
response.data.add("retResult",retResult);
response.data.add("code","<%=retCode1%>");
response.data.add("msg","<%=retMsg1%>");
core.ajax.receivePacket(response);
