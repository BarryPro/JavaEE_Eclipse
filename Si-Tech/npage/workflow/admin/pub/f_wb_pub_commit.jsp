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


<script>
function _refreshParent()
{
	opener.condquery2();
	opener.condquery1();
}
</script>

<%
	String xmlstr = "";
	//long seq = test.LogCommit.getId();
	String wano=request.getParameter("_wano");
	System.out.println("00----------开始提交页面:"+wano);
  //new test.LogCommit().write(seq,"00----------开始提交页面:"+wano);
	
	String _dataid=request.getParameter("dataid");
  String group_id=(String)session.getAttribute("_wb_groupid");
	
	String regionCode = "1";
	String opCode="6";
	
	//从cache中获取数据，保存成功后删除
	ParseParaxml parsexml = (ParseParaxml)WorkFlowCacheManager.get(_dataid);
	//new test.LogCommit().write(seq,"0----in commit,dataid:"+_dataid);
	if(parsexml==null)
	{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9300","commit中，页面失效，请重新处理"+" loginno:"+loginNo);
	//new test.LogCommit().write(seq,"1---页面失效，请重新处理:"+loginNo);
	%>
		<script>
		alert('页面失效，请重新处理');
		window.close();
		_refreshParent();
	</script>
		<%
		return;
	}
%>
 
<%
try
{
%>
<wtc:service name="sGetWAParamPage" outnum="2" >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="2"/>
        <wtc:param value="<%=wano%>"/>
</wtc:service>
<wtc:array id="ret"  start="0" length="2" scope="end" /> 
	
<% 
//new test.LogCommit().write(seq,"2-------调用服务sGetWAParamPage等待返回参=================================");

if(retCode.equals("000000"))
{
    //new test.LogCommit().write(seq,"3--------保存数据成功==sGetWAParamPage");
	xmlstr = ret[0][0];
}
else
{
//new test.LogCommit().write(seq,"4-------保存失败,原因为："+retMsg);
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9800","commit中，sGetWAParamPage失败:原因为："+retMsg+" loginno:"+loginNo);
%>
<script>
alert("保存失败,原因为：<%=retMsg%>");
window.close();
_refreshParent();
</script>

<%
return;
}
}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9900","commit中，sGetWAParamPage调用异常"+" loginno:"+loginNo);
	throw new Exception("服务调用失败");
}


    System.out.println("@@@@sGetWAParamPage="+xmlstr);
    Map wbMap = parsexml.ParameterMap2WbMap(request.getParameterMap());
 		String str = ParseData2XML.getOutputXMLStr(xmlstr,wbMap,"OUTPUT_PARAM","UTF-8") ;
    System.out.println("@@@@@@@@@@"+str);
 		response.setContentType("text/html;charset=gb2312");

try{
%>
<wtc:service name="sSetWAObj" outnum="0">
	      <wtc:param value="<%=loginNo%>"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=wano%>"/>
	      <wtc:param value="<%=str%>"/>
</wtc:service>

<% 
//new test.LogCommit().write(seq,"5-------调用服务sSetWAObj等待返回参===opCode=="+opCode+"=========wano===="+wano+"================="+loginNo);
if(retCode.equals("000000"))
{
//new test.LogCommit().write(seq,"6--------调用服务sSetWAObj返回成功");
//进行提交操作
%>

<%
try{
%>
<wtc:service name="sLoadWA" outnum="0"  >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="7"/>
        <wtc:param value="<%=wano%>"/>
        <wtc:param value="<%=group_id%>"/>
</wtc:service>


<%
//new test.LogCommit().write(seq,"7-----------调用服务sLoadWA等待返回参===group_id=="+group_id+"=========wano===="+wano+"========loginNo======="+loginNo);
if(retCode.equals("000000"))
{
//new test.LogCommit().write(seq,"8--------调用服务sLoadWA返回成功");
	//保存成功后，删除缓存
	WorkFlowCacheManager.remove(_dataid);
%>
<script>
	alert("提交成功");
window.close();
	_refreshParent();
//刷新页面

</script>

<%
	return;
}
else
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9500","commit中，sLoadWA失败:"+retMsg+" loginno:"+loginNo);
//new test.LogCommit().write(seq,"9-------调用服务sLoadWA失败:"+retMsg);
%>
<script>
	alert("提交失败,原因为：<%=retMsg%>");
	window.close();
	_refreshParent();
</script>

<%
}

}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9600","commit中，sLoadWA调用异常"+" loginno:"+loginNo);
		throw new Exception("服务调用失败");
}

%>

<%
}
else
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9400","commit中，sSetWAObj失败:"+retMsg+" loginno:"+loginNo);
//new test.LogCommit().write(seq,"10-------保存失败:"+retMsg);
%>
<script>
	alert("保存失败,原因为：<%=retMsg%>");
	window.close();
	_refreshParent();
</script>

<%
}
%>
<%
}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9700","commit中，sSetWAObj调用异常"+" loginno:"+loginNo);
		throw new Exception("服务调用失败");
}
%>
