 <%@ page contentType="text/html; charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

String areaCode = request.getParameter("areaCode")==null?"":request.getParameter("areaCode");
String buildNo = request.getParameter("buildNo")==null?"":request.getParameter("buildNo");
String unitNo = request.getParameter("unitNo")==null?"":request.getParameter("unitNo");
String connectType = request.getParameter("connectType")==null?"":request.getParameter("connectType");
String propertyUnitVal = request.getParameter("propertyUnitVal")==null?"":request.getParameter("propertyUnitVal");
/* ���˸��� */

System.out.println("��׼��ַ��ѯ����ĵ��ã����ΪС�����룺"+areaCode+" ¥��:"+buildNo);
String iMsg="FIELDCHNAME=С�����|¥��|��Ԫ��|С����������|��������,FIELDENNAME=distCode|buildNo|unitNo|propertyUnit|connectType,FIELDCONTENT="+areaCode+"|"+buildNo+"|"+unitNo+"|"+propertyUnitVal+"|"+connectType;
%>

<wtc:service name="sIMSGStandAddr"  outnum="3" routerKey="phone" routerValue="">                                                                                               
	<wtc:param value="<%=iMsg%>"/>                                                                                          
</wtc:service>                                                
<wtc:array id="result" scope="end" /> 
<%
System.out.println("��׼��ַ��ѯ�ķ���");
	System.out.println("retCode======"+retCode);
	System.out.println("retMsg======"+retMsg);
	//retCode="000000";
	//result[0][0]="fieldChName=��׼��ַ��ʶ%��׼��ַ����#��׼��ַ��ʶ%��׼��ַ����,fieldEnName=ADDRESS_ID%CUID#ADDRESS_ID%CUID,fieldContent=��̨���ƶ���˾18��11��%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16cfd029c#��̨���ƶ���˾18��11��1��Ԫ%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d2e029d";
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
System.out.println("���ص�����========="+result[0][0]);

%>
var response = new AJAXPacket();
var returnCode= "<%=retCode%>";
var returnMsg="<%=retMsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("result","<%=result[0][0]%>");
core.ajax.receivePacket(response);
<%}%>
 

 
