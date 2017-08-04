<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String wono = (String)request.getAttribute("wono");
String wano = (String)request.getAttribute("wano");
String _acceptFlag = (String)request.getParameter("_acceptFlag");
request.setAttribute("_acceptFlag",_acceptFlag);
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
	String urlFlag = ret[0][1];
	System.out.println("urlFlag==="+urlFlag);
	
	if(urlFlag.equals("1"))
	{
			//url处理逻辑
			byte[] enc1 = ret[0][0].getBytes();
			byte[] enc2 = ParseParaxml.processByte(enc1);
			ParseParaxml tmp = new ParseParaxml(new String(enc2));
			System.out.println("--------in pub1---:"+ret[0][0]);
			tmp.parse();
			System.out.println("--------1--------------");
			Map map = tmp.WbMap2ParameterMap();
			System.out.println("in pub1 map:"+map);
			request.setAttribute("_paraMap",map);
			request.setAttribute("_wano",wano);
			request.setAttribute("_dataId",tmp.getId());
			System.out.println("--------2--------------");
			//缓存ParseParaxml
			if(tmp !=null)
			{
			System.out.println("--------???--------");
			}
			//WorkFlowCacheManager.put(tmp.getId(),tmp);
			System.out.println("--------hello--------------");
			%>
				 <jsp:forward page="f_wb_pub_url_frame.jsp" />
			<%
	}
	else
	{
		//原来的处理逻辑
		request.setAttribute("xmlStr",ret[0][0]);
		System.out.println("************in pub1***********:"+ret[0][0]);		
		%>
		<jsp:forward page="f_wb_pub_2.jsp" />
		<%
	}			
}
else
{
	throw new Exception("error");
}

%>
