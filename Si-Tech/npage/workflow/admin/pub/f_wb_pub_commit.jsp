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
	System.out.println("00----------��ʼ�ύҳ��:"+wano);
  //new test.LogCommit().write(seq,"00----------��ʼ�ύҳ��:"+wano);
	
	String _dataid=request.getParameter("dataid");
  String group_id=(String)session.getAttribute("_wb_groupid");
	
	String regionCode = "1";
	String opCode="6";
	
	//��cache�л�ȡ���ݣ�����ɹ���ɾ��
	ParseParaxml parsexml = (ParseParaxml)WorkFlowCacheManager.get(_dataid);
	//new test.LogCommit().write(seq,"0----in commit,dataid:"+_dataid);
	if(parsexml==null)
	{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9300","commit�У�ҳ��ʧЧ�������´���"+" loginno:"+loginNo);
	//new test.LogCommit().write(seq,"1---ҳ��ʧЧ�������´���:"+loginNo);
	%>
		<script>
		alert('ҳ��ʧЧ�������´���');
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
//new test.LogCommit().write(seq,"2-------���÷���sGetWAParamPage�ȴ����ز�=================================");

if(retCode.equals("000000"))
{
    //new test.LogCommit().write(seq,"3--------�������ݳɹ�==sGetWAParamPage");
	xmlstr = ret[0][0];
}
else
{
//new test.LogCommit().write(seq,"4-------����ʧ��,ԭ��Ϊ��"+retMsg);
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9800","commit�У�sGetWAParamPageʧ��:ԭ��Ϊ��"+retMsg+" loginno:"+loginNo);
%>
<script>
alert("����ʧ��,ԭ��Ϊ��<%=retMsg%>");
window.close();
_refreshParent();
</script>

<%
return;
}
}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9900","commit�У�sGetWAParamPage�����쳣"+" loginno:"+loginNo);
	throw new Exception("�������ʧ��");
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
//new test.LogCommit().write(seq,"5-------���÷���sSetWAObj�ȴ����ز�===opCode=="+opCode+"=========wano===="+wano+"================="+loginNo);
if(retCode.equals("000000"))
{
//new test.LogCommit().write(seq,"6--------���÷���sSetWAObj���سɹ�");
//�����ύ����
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
//new test.LogCommit().write(seq,"7-----------���÷���sLoadWA�ȴ����ز�===group_id=="+group_id+"=========wano===="+wano+"========loginNo======="+loginNo);
if(retCode.equals("000000"))
{
//new test.LogCommit().write(seq,"8--------���÷���sLoadWA���سɹ�");
	//����ɹ���ɾ������
	WorkFlowCacheManager.remove(_dataid);
%>
<script>
	alert("�ύ�ɹ�");
window.close();
	_refreshParent();
//ˢ��ҳ��

</script>

<%
	return;
}
else
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9500","commit�У�sLoadWAʧ��:"+retMsg+" loginno:"+loginNo);
//new test.LogCommit().write(seq,"9-------���÷���sLoadWAʧ��:"+retMsg);
%>
<script>
	alert("�ύʧ��,ԭ��Ϊ��<%=retMsg%>");
	window.close();
	_refreshParent();
</script>

<%
}

}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9600","commit�У�sLoadWA�����쳣"+" loginno:"+loginNo);
		throw new Exception("�������ʧ��");
}

%>

<%
}
else
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9400","commit�У�sSetWAObjʧ��:"+retMsg+" loginno:"+loginNo);
//new test.LogCommit().write(seq,"10-------����ʧ��:"+retMsg);
%>
<script>
	alert("����ʧ��,ԭ��Ϊ��<%=retMsg%>");
	window.close();
	_refreshParent();
</script>

<%
}
%>
<%
}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9700","commit�У�sSetWAObj�����쳣"+" loginno:"+loginNo);
		throw new Exception("�������ʧ��");
}
%>
