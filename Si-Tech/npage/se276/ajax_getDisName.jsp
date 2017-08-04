<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/02/10 关于双鸭山分公司申请在BOSS系统开发友商固网信息收集功能的请示
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = (String)session.getAttribute("regCode");
	
	String LoginAccept = WtcUtil.repStr(request.getParameter("LoginAccept"),"");
	String ChnSource = WtcUtil.repStr(request.getParameter("ChnSource"),"");
	String OpCode = WtcUtil.repStr(request.getParameter("OpCode"),"");
	String LoginNo = WtcUtil.repStr(request.getParameter("LoginNo"),"");
	String LoginPwd = WtcUtil.repStr(request.getParameter("LoginPwd"),"");
	String PhoneNo = WtcUtil.repStr(request.getParameter("PhoneNo"),"");
	String UserPwd = WtcUtil.repStr(request.getParameter("UserPwd"),"");
	String OpNote = WtcUtil.repStr(request.getParameter("OpNote"),"");
%>
<wtc:service name="se276DisCodeQry" routerKey="region" retcode="disCode" retmsg="disMsg" outnum="2" routerValue="<%=regionCode%>">
	<wtc:param value="<%=LoginAccept%>"/>
	<wtc:param value="<%=ChnSource%>"/>
	<wtc:param value="<%=OpCode%>"/>
	<wtc:param value="<%=LoginNo%>"/>
	<wtc:param value="<%=LoginPwd%>"/>
	<wtc:param value="<%=PhoneNo%>"/>
	<wtc:param value="<%=UserPwd%>"/>
	<wtc:param value="<%=OpNote%>"/>
</wtc:service>	
<wtc:array id="disResult0" start="0" length="1" scope="end"/>
<wtc:array id="disResult1" start="1" length="1" scope="end"/>
var batchdisArray = new Array();//定义返回数组 
<%
String disName="";
String batchDisName="";
if(disCode.equals("000000")){
	disName = disResult0[0][0];
	for(int i=0;i<disResult1.length;i++){
%>
		batchdisArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<disResult1[i].length;j++){
%>
			batchdisArray[<%=i%>][<%=j%>] = "<%=disResult1[i][j]%>";
<%		
		}
	}
}
System.out.println("----------------"+disCode);
System.out.println("----------------"+disMsg);
System.out.println("----------------"+disName);
System.out.println("----------------"+batchDisName);
%>
var response = new AJAXPacket();
var disCode = "<%=disCode%>";
var disMsg = "<%=disMsg%>";
var disName = "<%=disName%>";

response.data.add("disCode",disCode);
response.data.add("disMsg",disMsg);
response.data.add("disName",disName);
response.data.add("batchdisArray",batchdisArray);
core.ajax.receivePacket(response);