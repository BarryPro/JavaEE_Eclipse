<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/03 liangyl 关于全面恢复省际跨区补卡服务的通知
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");

	String bipCode       = "BIP2B021";//业务代码
	String transCode     = "T2000021";//交易代码
	String loginNo 		 = WtcUtil.repStr(request.getParameter("loginNo"),"");/* 操作工号   */ 
	String orgCode 		 = WtcUtil.repStr(request.getParameter("orgCode"),"");/* 归属代码   */
	String idValue 		 = WtcUtil.repStr(request.getParameter("idValue"),"");//号码
	String seq 	 		 = WtcUtil.repStr(request.getParameter("seq"),"");//操作流水号,可不填
	String cardSN 	 	 = WtcUtil.repStr(request.getParameter("cardSN"),"");//空卡序列号
	String ICCID 		 = WtcUtil.repStr(request.getParameter("ICCID"),"");//ICCID
	
	String[] names = null;
	String name = WtcUtil.repStr(request.getParameter("name"),"");//扩展参数名  数组
	if(!"".equals(name)){
		names=name.split(",");
	}
	String[] values =null;	 
	String value = WtcUtil.repStr(request.getParameter("value"),"");//扩展参数值  数组
	if(!"".equals(value)){
		values=value.split(",");
	}
	String opNote        = "异地单卡写卡操作,"+loginNo+"进行异地写USIM卡";//备注
	
	String  inputParsm [] = new String[9];
	inputParsm[0] = bipCode;
	inputParsm[1] = transCode;
	inputParsm[2] = loginNo;
	inputParsm[3] = orgCode;
	inputParsm[4] = idValue;
	inputParsm[5] = seq;
	inputParsm[6] = cardSN;
	inputParsm[7] = ICCID;
	inputParsm[8] = opNote;
	String retCode1="";
	String retMsg1="";
try{
%>
<wtc:service name="sTSNPubSnd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>
	<wtc:params value="<%=names%>"/>
	<wtc:params value="<%=values%>"/>
	<wtc:param value="<%=inputParsm[8]%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
var resultmsg = new Array();
<%
	retCode1=retCode;
	retMsg1=retMsg;
	if(result.length>0 && "000000".equals(retCode)){
		for(int i=0;i<result.length;i++){
		%>
			resultmsg[<%=i%>]=new Array();
		<%
			for(int j=0;j<result[i].length;j++){
			System.out.println("liangyl---------------------"+result[i][j]);
		%>
		
			resultmsg[<%=i%>][<%=j%>] = "<%=result[i][j]%>";
		<%		
			}	
		}
	}else{
		
	}
}catch(Exception e){
	System.out.println(e);
	System.out.println("cuocuowa111133");
	retCode1= "444444";
	retMsg1= "系统异常";
	System.out.println("retMsg="+retMsg1);
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
response.data.add("resultmsg",resultmsg);
core.ajax.receivePacket(response);