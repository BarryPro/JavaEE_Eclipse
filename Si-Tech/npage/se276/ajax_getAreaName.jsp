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
	String AreaName = WtcUtil.repStr(request.getParameter("AreaName"),"");
%>
<wtc:service name="se276AreaNaQry" routerKey="region" retcode="areaCode" retmsg="areaMsg" outnum="1" routerValue="<%=regionCode%>">
	<wtc:param value="<%=LoginAccept%>"/>
	<wtc:param value="<%=ChnSource%>"/>
	<wtc:param value="<%=OpCode%>"/>
	<wtc:param value="<%=LoginNo%>"/>
	<wtc:param value="<%=LoginPwd%>"/>
	<wtc:param value="<%=PhoneNo%>"/>
	<wtc:param value="<%=UserPwd%>"/>
	<wtc:param value="<%=OpNote%>"/>
	<wtc:param value="<%=AreaName%>"/>
</wtc:service>	
<wtc:array id="areaResult"  scope="end"/>

var areaArray = new Array();//定义返回数组 
<%
if(areaCode.equals("000000")){
	for(int i=0;i<areaResult.length;i++){
%>
		areaArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<areaResult[i].length;j++){
%>
			areaArray[<%=i%>][<%=j%>] = "<%=areaResult[i][j]%>";
<%		
		}
	}
}

System.out.println("----------------"+areaCode);
System.out.println("----------------"+areaMsg);
System.out.println("----------------"+areaResult.length);
%>
//areaArray[0] = new Array();
//areaArray[0][0]="测试数据0";
//areaArray[1] = new Array();
//areaArray[1][0]="测试数据1";
//areaArray[2] = new Array();
//areaArray[2][0]="测试数据2";
var response = new AJAXPacket();
var areaCode = "<%=areaCode%>";
var areaMsg = "<%=areaMsg%>";

response.data.add("areaCode",areaCode);
response.data.add("areaMsg",areaMsg);
response.data.add("areaArray",areaArray);

core.ajax.receivePacket(response);