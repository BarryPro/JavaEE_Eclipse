   <%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*
* ����: ���С����Ϣ��ѯ
* �汾: 1.0
* ����: 2010-11-2
* ����: lijy
* ��Ȩ: sitech
*/
%>

<%
	System.out.println("==============����С����ѯ=============== ");
	String areaName = request.getParameter("area_name")==null?"":request.getParameter("area_name");
	String regionName=request.getParameter("regionName")==null?"":request.getParameter("regionName");
	String smCode=request.getParameter("smCode")==null?"":request.getParameter("smCode");
	
	System.out.println("С��������=============== "+areaName);
	System.out.println("regionName=============== "+regionName);
	System.out.println("smCode=============== "+smCode);
	
	String opName="�����Դ��ѯ";
	String iMsg="FIELDCHNAME=С������|��������|��Ӫ�̣�Ʒ�ƣ�,FIELDENNAME=distName|regionName|serviceProvider,FIELDCONTENT="+areaName+"|"+regionName+"|"+smCode;
  
  System.out.println("gaopengSeeLog==== 111=============== "+regionName);
%>
<wtc:service name="sGetAreaInfo" routerKey="region"   retcode="retcode" retmsg="retmsg"  outnum="5" >
	<wtc:param value="<%=iMsg%>"/>  
</wtc:service>	
<wtc:array id="result"  scope="end"/>
<%
	System.out.println("gaopengSeeLog==== retcode======"+retcode);
	System.out.println("retMsg======"+retmsg);
	
	//retcode="000000";
	//result[0][0]="fieldChName=С������%С������%������/��%����%��������#С������%С������%������/��%����%��������#С������%С������%������/��%����%��������#С������%С������%������/��%����%��������,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=��̨���ƶ���˾%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16c9c029a%��̨��/������%100M%1#��̨�Ӻ�ΰС��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%��̨��/������%100M%2#��̨�Ӳ���С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%��̨��/������%100M%1#��̨������С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%��̨��/������%100M%0";
	//result[0][0]="fieldChName=С������%С������%��������%���žֱ���%����������#С������%С������%��������%���žֱ���%����������,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=��̨��/������%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be629140c%0%80045%paers#��̨��/������/��̨�Ӻ�ΰС��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%2%00113%par02#��̨��/������/��̨�Ӳ���С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%3%00114%par03#��̨��/������/��̨������С��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%0%00115%par04";
if(!retcode.equals("000000")){
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
core.ajax.receivePacket(response);
<%}else {
  System.out.println("diling--���ص�����========="+result[0][0]);
/*  
  result[0][0] = "fieldChName="
+"��ַȫ��%��ַ����%��������%���žֱ���%����������%С������%С���������%С����������%�������%���ط�ʽ#"
+"��ַȫ��%��ַ����%��������%���žֱ���%����������%С������%С���������%С����������%�������%���ط�ʽ#"
+"��ַȫ��%��ַ����%��������%���žֱ���%����������%С������%С���������%С����������%�������%���ط�ʽ#"
+"��ַȫ��%��ַ����%��������%���žֱ���%����������%С������%С���������%С����������%�������%���ط�ʽ#"
+"��ַȫ��%��ַ����%��������%���žֱ���%����������%С������%С���������%С����������%�������%���ط�ʽ,"
+"fieldEnName="
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType,"
+"fieldContent="
+"������/������/�ϸ���/��ͨ���ֹ�˾/����ʦ��/��ͨ���ֹ�˾%T_SPACE_STANDARD_ADDRESS-8aee349d33ac8ab50133c5bf3cf52765%0%80040%1200000000%kd01000000%¢��%�ƶ�%����%����#"
+"������/������/��־��/-/��־��ͨ��·���˶���ͬ/��־����־��ͨ��·���˶���ͬ%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5e15ac78fe%1%80054%2000000000%kd01000000%����%��ͨ%����%����#"
+"������/������/��־��/-/��־��ͨ��·����һ��ͬ/��־����־��ͨ��·����һ��ͬ%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5df3ee78f4%1%80054%2000000000%kd01000000%����%��ͨ%ũ��%����#"
+"������/������/��־��/-/��־��ͨ��·��������ͬ/��־����־��ͨ��·��������ͬ%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5e384d7908%1%80054%2000000000%kd01000000%����%��ͨ%����%����#"
+"������/������/��־��/-/��־��ͨ��·�����ĺ�ͬ/��־����־��ͨ��·�����ĺ�ͬ%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5e59f57912%1%80054%2000000000%kd01000000%����%��ͨ%ũ��%����";
*/
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("result","<%=result[0][0]%>");
core.ajax.receivePacket(response);
<%}%>
