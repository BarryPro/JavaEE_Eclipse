<%
/********************
 version v2.0
������: si-tech
�����ύҳ��
��Ҫ�������û�����ı����������� �Ͷ�����
********************/
%>

<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
	request.setCharacterEncoding("utf-8");
  String wono=request.getParameter("wono");
	String wano=request.getParameter("wano");
	String regionCode = "1";
	String opCode="6";
%>

<wtc:service name="sGetWAParamPage" outnum="2" >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="2"/>
        <wtc:param value="<%=wano%>"/>
</wtc:service>
<wtc:array id="ret"  start="0" length="2" scope="end" /> 
	
<% 
String xmlstr = "";
if(retCode.equals("000000"))
{
	xmlstr = ret[0][0];
}
else
{
%>
alert("����ʧ��,ԭ��Ϊ��<%=retMsg%>");
<%
return;
}
%>

<%
    System.out.println("@@@@sGetWAParamPage="+xmlstr);
    Map isoMap = ParseParaxml.ToISO88591(request);
 		String str = ParseData2XML.getOutputXMLStr(xmlstr,isoMap,"OUTPUT_PARAM","utf-8") ;
    System.out.println("@@@@@@@@@@"+str);
 		response.setContentType("text/html;charset=gb2312");

%>

<wtc:service name="sSetWAObj" outnum="0">
	      <wtc:param value="<%=loginNo%>"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=wano%>"/>
	      <wtc:param value="<%=str%>"/>
        <wtc:param value="<%=regionCode%>"/>
</wtc:service>

<% 
if(retCode.equals("000000"))
{
%>
	alert("����ɹ�");
<%
}
else
{
%>
	alert("����ʧ��,ԭ��Ϊ��<%=retMsg%>");
<%
}
%>
