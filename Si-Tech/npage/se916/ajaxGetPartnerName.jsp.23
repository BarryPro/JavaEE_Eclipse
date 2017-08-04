
   <%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

/************************************************************
 *@ 服务名称：sPartnerCode
 *@ 编码日期：2012/08/05
 *@ 服务版本: Ver1.0
 *@ 编码人员：chenlina
 *@ 功能描述：工号信息校验服务
 *@
 *@ 输入参数：
 *@inparam0 iLoginAccept 流水
 *@inparam1 iChnSource 渠道标识
 *@inparam2 iOpCode 操作代码
 *@inparam3 iLoginNo 操作工号
 *@inparam4 iLoginPwd 操作工号密码
 *@inparam5 iPhoneNo 手机号码
 *@inparam6 iUserPwd 用户密码
 *@inparam7 iOpNote     备注
 *@inparam8 iSmCode     宽带品牌
 *@inparam9 iPartnerCode 合作者编码
 *@
 *@ 返回参数：
 *@outparam0 vPartnerName 合作方名称
 ************************************************************/

String iLoginAccept	="0";
String iChnSource	="01";
String iOpCode		="4977";
String iLoginNo		=(String)session.getAttribute("workNo");
String iLoginPwd	=(String)session.getAttribute("password");
String iPhoneNo		="";
String iUserPwd		="";
String iOpNote		="合作方名称查询";
String iSmCode		=request.getParameter("iSmCode");
String iPartnerCode	=request.getParameter("partnerCode");
System.out.println("4977!~~~iLoginNo="+iLoginNo);
System.out.println("4977!~~~iLoginPwd="+iLoginPwd);
System.out.println("4977!~~~iSmCode="+iSmCode);
System.out.println("4977!~~~iPartnerCode="+iPartnerCode);
String regCode	=(String)session.getAttribute("regCode");

%>

<wtc:service name="sPartnerCode" routerKey="region"
	routerValue="<%=regCode%>" retcode="ptRtCode" retmsg="ptRtMsg" outnum="4" >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iOpNote%>"/>
	<wtc:param value="<%=iSmCode%>"/>
	<wtc:param value="<%=iPartnerCode%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
System.out.println("4977~~~~ptRtCode=="+ptRtCode);
if (ptRtCode.equals("000000"))
{
%>
var response = new AJAXPacket();
var ptRtCode= "<%=ptRtCode%>";
var ptRtMsg="<%=ptRtMsg%>";
var ptName = "<%=result[0][0]%>";
response.data.add("ptRtCode",ptRtCode);
response.data.add("ptRtMsg",ptRtMsg);
response.data.add("ptName",ptName);
core.ajax.receivePacket(response);
<%
}
else
{
%>

var response = new AJAXPacket();
var ptRtCode= "<%=ptRtCode%>";
var ptRtMsg="<%=ptRtMsg%>";
response.data.add("ptRtCode",ptRtCode);
response.data.add("ptRtMsg",ptRtMsg);
core.ajax.receivePacket(response);
<%
}

%>

 