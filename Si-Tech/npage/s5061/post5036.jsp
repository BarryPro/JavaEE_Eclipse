<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String fav_save1   = "";
String fav_call   = "";
String fav_char   = "";
String fav_type = "";
String retCode = "0";
String retMsg = "";
String region_code = request.getParameter("region_code");
String SqlStr1 = "";
String modeCode = request.getParameter("modeCode");
String feeType = request.getParameter("feeType");
String typecode = request.getParameter("typecode");
String regionCode= (String)session.getAttribute("regCode");
modeCode = modeCode.replaceAll("%23","#");
modeCode = modeCode.replaceAll("%26","&");
modeCode = modeCode.replaceAll("%2b","+");
modeCode = modeCode.replaceAll("%3f","?");
modeCode = modeCode.replaceAll("%5f","_");

System.out.println("region_code ===: "+ region_code);
System.out.println("modeCode ===: "+ modeCode);
System.out.println("feeType ===: "+ feeType);
	SqlStr1 = "select fav_char,fav_call,fav_save1,fav_type from sFav1860Cfg a  where a.region_code ='"+region_code+"' and a.mode_code = '"+modeCode+"'"; 
	 retMsg="套餐配制信息不存在!";
System.out.println(SqlStr1);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:sql><%=SqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="psot" scope="end" />
	
<%

System.out.println("00000");
if(psot.length == 1){
	fav_char = psot[0][0];
	fav_call = psot[0][1];
	fav_save1 = psot[0][2];
	fav_type = psot[0][3];
	
}else{
	fav_char = "";
	fav_call = "";
	fav_save1 = "";
	fav_type = "";
	retCode = "100001";
}
System.out.println("sunzx:"+fav_char+":"+fav_call+":"+fav_save1+":"+fav_type);
String rpcPage = "post5036";
%>
var response = new AJAXPacket();
var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var fav_char = "<%=fav_char%>";
var fav_call = "<%=fav_call%>";
var fav_save1 = "<%=fav_save1%>";
var fav_type = "<%=fav_type%>";
var rpcPage = "<%=rpcPage%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("fav_char",fav_char);
response.data.add("fav_call",fav_call); 
response.data.add("fav_save1",fav_save1);
response.data.add("fav_type",fav_type);
response.data.add("typecode","<%=typecode%>");
core.ajax.receivePacket(response);
