
   <%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

/************************************************************
 *@ �������ƣ�sPartnerCode
 *@ �������ڣ�2012/08/05
 *@ ����汾: Ver1.0
 *@ ������Ա��chenlina
 *@ ����������������ϢУ�����
 *@
 *@ ���������
 *@inparam0 iLoginAccept ��ˮ
 *@inparam1 iChnSource ������ʶ
 *@inparam2 iOpCode ��������
 *@inparam3 iLoginNo ��������
 *@inparam4 iLoginPwd ������������
 *@inparam5 iPhoneNo �ֻ�����
 *@inparam6 iUserPwd �û�����
 *@inparam7 iOpNote     ��ע
 *@inparam8 iSmCode     ���Ʒ��
 *@inparam9 iPartnerCode �����߱���
 *@
 *@ ���ز�����
 *@outparam0 vPartnerName ����������
 ************************************************************/

String iLoginAccept	="0";
String iChnSource	="01";
String iOpCode		="4977";
String iLoginNo		=(String)session.getAttribute("workNo");
String iLoginPwd	=(String)session.getAttribute("password");
String iPhoneNo		="";
String iUserPwd		="";
String iOpNote		="���������Ʋ�ѯ";
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

 