<%
/********************
 * version v2.0
 * ¿ª·¢ÉÌ: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%

String cust_name   = "";
String strSpSum   = "";
String first_order_date   = "";
String opr_time   = "";
String end_time   = "";
String retCode = "";
String retMsg = "";
String SqlStr1 = "";
String phoneNo = request.getParameter("phoneno1");
String strEnterCode = request.getParameter("EnterCode");
String strTranCode = request.getParameter("TranCode");

System.out.println("phoneNO ===: "+ phoneNo);

  

%>
 

System.out.println("SqlStr1="+SqlStr1);
System.out.println("psot.length="+psot.length);
System.out.println("cust_name="+cust_name);


SqlStr1 = "select count(*) from ddsmpspbizinfo where trim(spid)='"+strEnterCode.trim()+"' and trim(bizcode) = '"+strTranCode.trim()+"'";

%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="1" retcode="retCode3" retmsg="retMsg3">
	<wtc:sql><%=SqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="psot2" scope="end"/>
<%

if(psot2.length == 1){
	strSpSum = psot2[0][0];
}else{
	retCode = "100002";
}

System.out.println("SqlStr1="+SqlStr1);
System.out.println("psot2.length="+psot2.length);
System.out.println("strSpSum="+strSpSum);

String rpcPage = "postSim";


SqlStr1 = "select first_order_date,opr_time,end_time from ddsmpordermsg where trim(spid)='"+strEnterCode.trim()+"' and trim(bizcode) = '"+strTranCode.trim()+"' and phone_no='"+phoneNo+"'";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="3" retcode="retCode4" retmsg="retMsg4">
	<wtc:sql><%=SqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="psot3" scope="end"/>
<%

if(psot3.length == 1){
System.out.println("psot3="+psot3);
	first_order_date = psot3[0][0];
	opr_time = psot3[0][1];
	end_time = psot3[0][2];
}else{
	//retCode = "100003";
}

System.out.println("SqlStr1="+SqlStr1);
System.out.println("psot3.length="+psot3.length);
System.out.println("first_order_date="+first_order_date);
System.out.println("opr_time="+opr_time);
System.out.println("end_time="+end_time);

%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var cust_name = "<%=cust_name%>";
var sp_sum = "<%=strSpSum%>";
var rpcPage = "<%=rpcPage%>";

var first_order_date = "<%=first_order_date%>";
var opr_time = "<%=opr_time%>";
var end_time = "<%=end_time%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("cust_name",cust_name); 
response.data.add("sp_sum",sp_sum);
response.data.add("retType","<%= request.getParameter("retType") %>");
response.data.add("first_order_date",first_order_date); 
response.data.add("opr_time",opr_time); 
response.data.add("end_time",end_time); 
core.ajax.receivePacket(response);
