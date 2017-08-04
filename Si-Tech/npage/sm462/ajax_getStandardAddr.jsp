 <%@ page contentType="text/html; charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

String areaCode = request.getParameter("areaCode")==null?"":request.getParameter("areaCode");
String buildNo = request.getParameter("buildNo")==null?"":request.getParameter("buildNo");
String unitNo = request.getParameter("unitNo")==null?"":request.getParameter("unitNo");
String connectType = request.getParameter("connectType")==null?"":request.getParameter("connectType");
String propertyUnitVal = request.getParameter("propertyUnitVal")==null?"":request.getParameter("propertyUnitVal");
/* 多了个字 */

System.out.println("标准地址查询服务的调用，入参为小区代码："+areaCode+" 楼号:"+buildNo);
String iMsg="FIELDCHNAME=小区编号|楼号|单元号|小区建设性质|接入类型,FIELDENNAME=distCode|buildNo|unitNo|propertyUnit|connectType,FIELDCONTENT="+areaCode+"|"+buildNo+"|"+unitNo+"|"+propertyUnitVal+"|"+connectType;
%>

<wtc:service name="sIMSGStandAddr"  outnum="3" routerKey="phone" routerValue="">                                                                                               
	<wtc:param value="<%=iMsg%>"/>                                                                                          
</wtc:service>                                                
<wtc:array id="result" scope="end" /> 
<%
System.out.println("标准地址查询的返回");
	System.out.println("retCode======"+retCode);
	System.out.println("retMsg======"+retMsg);
	//retCode="000000";
	//result[0][0]="fieldChName=标准地址标识%标准地址编码#标准地址标识%标准地址编码,fieldEnName=ADDRESS_ID%CUID#ADDRESS_ID%CUID,fieldContent=七台河移动公司18号11栋%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16cfd029c#七台河移动公司18号11栋1单元%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d2e029d";
if(!retCode.equals("000000")){
%>
var response = new AJAXPacket();
var returnCode= "<%=retCode%>";
var returnMsg="<%=retMsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
core.ajax.receivePacket(response);
<%
}else {
System.out.println("返回的数据========="+result[0][0]);

%>
var response = new AJAXPacket();
var returnCode= "<%=retCode%>";
var returnMsg="<%=retMsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("result","<%=result[0][0]%>");
core.ajax.receivePacket(response);
<%}%>
 

 
