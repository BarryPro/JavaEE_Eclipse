   <%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*
* 功能: 宽带小区信息查询
* 版本: 1.0
* 日期: 2010-11-2
* 作者: lijy
* 版权: sitech
*/
%>

<%
	System.out.println("==============进入小区查询=============== ");
	String areaName = request.getParameter("area_name")==null?"":request.getParameter("area_name");
	String regionName=request.getParameter("regionName")==null?"":request.getParameter("regionName");
	String smCode=request.getParameter("smCode")==null?"":request.getParameter("smCode");
	
	System.out.println("小区名称是=============== "+areaName);
	System.out.println("regionName=============== "+regionName);
	System.out.println("smCode=============== "+smCode);
	
	String opName="宽带资源查询";
	String iMsg="FIELDCHNAME=小区名称|地市名称|运营商（品牌）,FIELDENNAME=distName|regionName|serviceProvider,FIELDCONTENT="+areaName+"|"+regionName+"|"+smCode;
  
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
	//result[0][0]="fieldChName=小区名称%小区编码%所属市/县%带宽%接入类型#小区名称%小区编码%所属市/县%带宽%接入类型#小区名称%小区编码%所属市/县%带宽%接入类型#小区名称%小区编码%所属市/县%带宽%接入类型,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=七台河移动公司%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16c9c029a%七台河/勃利县%100M%1#七台河宏伟小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%七台河/勃利县%100M%2#七台河勃利小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%七台河/勃利县%100M%1#七台河卫星小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%七台河/勃利县%100M%0";
	//result[0][0]="fieldChName=小区名称%小区编码%接入类型%电信局编码%合作方编码#小区名称%小区编码%接入类型%电信局编码%合作方编码,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=七台河/勃利县%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be629140c%0%80045%paers#七台河/勃利县/七台河宏伟小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%2%00113%par02#七台河/勃利县/七台河勃利小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%3%00114%par03#七台河/勃利县/七台河卫星小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%0%00115%par04";
if(!retcode.equals("000000")){
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
core.ajax.receivePacket(response);
<%}else {
  System.out.println("diling--返回的数据========="+result[0][0]);
/*  
  result[0][0] = "fieldChName="
+"地址全称%地址编码%接入类型%电信局编码%合作方编码%小区编码%小区接入情况%小区建设性质%归属类别%承载方式#"
+"地址全称%地址编码%接入类型%电信局编码%合作方编码%小区编码%小区接入情况%小区建设性质%归属类别%承载方式#"
+"地址全称%地址编码%接入类型%电信局编码%合作方编码%小区编码%小区接入情况%小区建设性质%归属类别%承载方式#"
+"地址全称%地址编码%接入类型%电信局编码%合作方编码%小区编码%小区接入情况%小区建设性质%归属类别%承载方式#"
+"地址全称%地址编码%接入类型%电信局编码%合作方编码%小区编码%小区接入情况%小区建设性质%归属类别%承载方式,"
+"fieldEnName="
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType#"
+"distName%distCode%connectType%stationCode%partnersCode%distKdCode%nearInfo%propertyUnit%belongCategory%bearType,"
+"fieldContent="
+"黑龙江/哈尔滨/南岗区/铁通哈分公司/工程师街/铁通哈分公司%T_SPACE_STANDARD_ADDRESS-8aee349d33ac8ab50133c5bf3cf52765%0%80040%1200000000%kd01000000%垄断%移动%城市%有线#"
+"黑龙江/哈尔滨/尚志市/-/尚志铁通公路振兴二胡同/尚志市尚志铁通公路振兴二胡同%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5e15ac78fe%1%80054%2000000000%kd01000000%竞争%铁通%城市%有线#"
+"黑龙江/哈尔滨/尚志市/-/尚志铁通公路振兴一胡同/尚志市尚志铁通公路振兴一胡同%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5df3ee78f4%1%80054%2000000000%kd01000000%竞争%铁通%农村%有线#"
+"黑龙江/哈尔滨/尚志市/-/尚志铁通公路振兴三胡同/尚志市尚志铁通公路振兴三胡同%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5e384d7908%1%80054%2000000000%kd01000000%竞争%铁通%城市%无线#"
+"黑龙江/哈尔滨/尚志市/-/尚志铁通公路振兴四胡同/尚志市尚志铁通公路振兴四胡同%T_SPACE_STANDARD_ADDRESS-8aee349d3a8d9306013aba5e59f57912%1%80054%2000000000%kd01000000%竞争%铁通%农村%无线";
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
