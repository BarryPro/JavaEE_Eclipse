<%
/**********************
*
*������ѯҳ�棬���ڵ�ǰ���̵���ϸ��ѯ
*֧�������Զ�����ģʽ��urlģʽ
*
***********************/
%>
<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String wono = (String)request.getAttribute("wono");
String wano = (String)request.getAttribute("wano");
%>

<wtc:service name="sGetWAParamPage" outnum="2"  >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="2"/>
        <wtc:param value="<%=wano%>"/>
</wtc:service>

<% 
if(retCode.equals("000000"))
{

%>

<wtc:array id="ret"  start="0" length="2" scope="end" /> 
<%

	byte[] enc2 = ParseParaxml.processByte(ret[0][0].getBytes());
	//request.setAttribute("xmlStr",ret[0][0]);
	request.setAttribute("xmlStr",new String(enc2));
	System.out.println(".......xmlstr:"+ret[0][0]);
			
	if(ret[0][1].equals("1"))
	{
			ParseParaxml tmp = new ParseParaxml(new String(enc2));
			//ParseParaxml tmp = new ParseParaxml(ret[0][0]);
			tmp.parse();
			Map map = tmp.WbMap2ParameterMap();
			request.setAttribute("_paraMap",map);
			request.setAttribute("_wano",wano);
			request.setAttribute("wano",wano);
			
		//�ֹ�urlģʽ
		%>
		<jsp:include page="f_wb_pub_url_view_frame.jsp" flush="true" /> 
		<%
	}
	else
	{
		//�Զ�ҳ�����ģʽ
		%>
		<jsp:include page="f_wb_pub_6.jsp" flush="true" /> 		
		<%
	}
}
else
{
	throw new Exception("error");
}

%>