<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-10
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%

String cust_name   = "";
String strUnPayFlagName = "";
String strUnPayFromName = "";
String strSpTranName = "";
String strSpTranType = "";
String strSpDesc = "";
String strOpDesc = "";
String strFeeMoney = "";
String strBackMoney = "";
String strBackPreMoney = "";
String strCompMoney = "";
String retCode = "";
String retMsg = "";
String SqlStr1 = "";
//String[][]psot = new String [][]{};
String phoneNo = request.getParameter("phoneNo");
String strSpEnterCode = request.getParameter("spEnterCode");
String strSpTranCode = request.getParameter("spTranCode");
String strUseingTime="";
//comImpl co1 = new comImpl();


SqlStr1 = "select b.cust_name from dcustmsg a, dCustDoc b where a.cust_id = b.cust_id and  a.phone_no =:phoneNo and substr(run_code,2,1) < 'a'";
retMsg = "用户信息资料不存在，不能录入!";
	 
String [] paraIn = new String[2];
paraIn[0] = SqlStr1;    
paraIn[1]="phoneNo="+phoneNo;

System.out.println(SqlStr1);
//ArrayList arr1 = co1.spubqry32("1", SqlStr1);	
%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="psot" scope="end"/>
<%

if(psot.length == 1){
	cust_name = psot[0][0];
}else{
	retCode = "100001";
}

SqlStr1 = "";
SqlStr1 = "select unpayflagname,unpayfromname,sptranname,sptrantype,spdesc,opdesc,fee_money,back_money,back_premoney,comp_money,useing_time from dSpUnPayMsg where phone_no =:phoneNo and SPENTERCODE=:strSpEnterCode and SPTRANCODE=:strSpTranCode";
retMsg = "用户SP全网退费信息不存在，不能进行删除!";

paraIn[0] = SqlStr1;    
paraIn[1]="phoneNo="+phoneNo+",strSpEnterCode="+strSpEnterCode+",strSpTranCode="+strSpTranCode;

System.out.println(SqlStr1);
//ArrayList arr2 = co1.spubqry32("11", SqlStr1);	
%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="11" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="psot" scope="end"/>
<%


if(psot.length == 1){
	strUnPayFlagName = psot[0][0];
	strUnPayFromName = psot[0][1];
	strSpTranName = psot[0][2];
	strSpTranType = psot[0][3];
	strSpDesc = psot[0][4];
	strOpDesc = psot[0][5];
	strFeeMoney = psot[0][6];
	strBackMoney = psot[0][7];
	strBackPreMoney = psot[0][8];
	System.out.println("strFeeMoney="+strFeeMoney);
	System.out.println("strBackMoney="+strBackMoney);
	strCompMoney = psot[0][9];
	strUseingTime =psot[0][10];
}else{
	retCode = "100001";
}

System.out.println("1111111");
String rpcPage = "postSim";

%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var cust_name = "<%=cust_name%>";
var UnPayFlagName = "<%=strUnPayFlagName%>";
var UnPayFromName = "<%=strUnPayFromName%>";
var SpTranName = "<%=strSpTranName%>";
var SpTranType = "<%=strSpTranType%>";
var SpDesc = "<%=strSpDesc%>";
var OpDesc = "<%=strOpDesc%>";
var FeeMoney = "<%=strFeeMoney%>";
var BackMoney = "<%=strBackMoney%>";
var BackPreMoney = "<%=strBackPreMoney%>";
var CompMoney = "<%=strCompMoney%>";
var UseingTime ="<%=strUseingTime%>";
var rpcPage = "<%=rpcPage%>";

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("cust_name",cust_name); 
response.data.add("UnPayFlagName",UnPayFlagName);
response.data.add("UnPayFromName",UnPayFromName);
response.data.add("SpTranName",SpTranName);
response.data.add("SpTranType",SpTranType);
response.data.add("SpDesc",SpDesc);
response.data.add("OpDesc",OpDesc);
response.data.add("FeeMoney",FeeMoney);
response.data.add("BackMoney",BackMoney);
response.data.add("BackPreMoney",BackPreMoney);
response.data.add("CompMoney",CompMoney);
response.data.add("UseingTime",UseingTime);
core.ajax.receivePacket(response);