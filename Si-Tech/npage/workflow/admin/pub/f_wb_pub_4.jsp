<%
/********************
 version v2.0
������: si-tech
�����ύҳ��
��Ҫ�������û�����ı����������� �Ͷ�����
********************/
%>
<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%request.setCharacterEncoding("ISO-8859-1");%>  

<%
  String wono=request.getParameter("wono");
	String wano=request.getParameter("wano");
	//String regionCode = request.getParameter("_region");
	String group_id=(String)session.getAttribute("_wb_groupid");
	String opCode="6";
	System.out.println("====="+group_id);
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
 xmlstr = new String(ParseParaxml.processByte(ret[0][0].getBytes()));
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
 		String str = ParseData2XML.getOutputXMLStr(xmlstr,request.getParameterMap(),"OUTPUT_PARAM","UTF-8") ;
    System.out.println("@@@@@@@@@@"+str);
 		response.setContentType("text/html;charset=gb2312");

%>

<wtc:service name="sSetWAObj" outnum="0">
	      <wtc:param value="<%=loginNo%>"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=wano%>"/>
	      <wtc:param value="<%=str%>"/>
</wtc:service>

<% 
if(retCode.equals("000000"))
{
//�����ύ����
%>
<wtc:service name="sLoadWA" outnum="0"  >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="7"/>
        <wtc:param value="<%=wano%>"/>
        <wtc:param value="<%=group_id%>"/>
</wtc:service>
<%
if(retCode.equals("000000"))
{
%>

	alert("�ύ�ɹ�");

<%
	return;
}
else
{
%>

	alert("�ύʧ��,ԭ��Ϊ��<%=retMsg%>");

<%
}
%>

<%
}
else
{
%>

	alert("����ʧ��,ԭ��Ϊ��<%=retMsg%>");

<%
}
%>
