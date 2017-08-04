<%
/********************
 version v2.0
开发商: si-tech
公共提交页面
需要参数：用户输入的变量，工单号 和订单号
********************/
%>



<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%request.setCharacterEncoding("ISO-8859-1");%>  

<%

 	MultipartRequest multi = new MultipartRequest(request, "./");
   Map inputMap = new HashMap();                
   Enumeration params = multi.getParameterNames();
      while (params.hasMoreElements()) {
        String name = (String)params.nextElement();
        String[] value = multi.getParameterValues(name);
        inputMap.put(name,value);
      }
    System.out.println("提交的时候组装的map="+inputMap);  
      
	String wano=multi.getParameter("_wano");
	String _dataid=multi.getParameter("dataid");
  String group_id=(String)session.getAttribute("_wb_groupid");
	
	String regionCode = "1";
	String opCode="6";
	
	//从cache中获取数据，保存成功后删除
	ParseParaxml parsexml = (ParseParaxml)WorkFlowCacheManager.get(_dataid);
	System.out.println("----in commit,dataid:"+_dataid);
	 System.out.println("提交的时候组装的map================"+inputMap);  
	if(parsexml==null)
	{
	%>
		<script>
		alert('页面失效，请重新处理');
		window.close();
	</script>
		<%
		return;
	}
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
<script>
alert("保存失败,原因为：<%=retMsg%>");
window.close();
</script>

<%
return;
}
%>

<%
		
    System.out.println("@@@@sGetWAParamPage="+xmlstr);
    Map wbMap = parsexml.ParameterMap2WbMap(inputMap);
 		String str = ParseData2XML.getOutputXMLStr(xmlstr,wbMap,"OUTPUT_PARAM","UTF-8") ;
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
//进行提交操作
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
	//保存成功后，删除缓存
	WorkFlowCacheManager.remove(_dataid);
%>
<script>
	alert("提交成功");
	window.close();
</script>

<%
	return;
}
else
{
%>
<script>
	alert("提交失败,原因为：<%=retMsg%>");
	window.close();
</script>

<%
}
%>

<%
}
else
{
%>
<script>
	alert("保存失败,原因为：<%=retMsg%>");
	window.close();
</script>

<%
}
%>
