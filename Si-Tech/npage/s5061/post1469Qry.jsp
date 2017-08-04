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
String strSpSum   = "";
String retCode = "";
String retMsg = "";
String SqlStr1 = "";
//String[][]psot = new String [][]{};
//String[][]psot2 = new String [][]{};
String phoneNo = request.getParameter("phoneNo");
String strEnterCode = request.getParameter("EnterCode");
String strTranCode = request.getParameter("TranCode");

System.out.println("phoneNO ===: "+ phoneNo);
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

SqlStr1 = "select count(*) from oneboss.dobspbizinfomsg where trim(spid)='"+strEnterCode.trim()+"' and trim(bizcode) = '"+strTranCode.trim()+"'";

//ArrayList arr2 = co1.spubqry32("1", SqlStr1);	
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

System.out.println("strSpSum="+strSpSum);
String rpcPage = "postSim";

%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var cust_name = "<%=cust_name%>";
var sp_sum = "<%=strSpSum%>";
var rpcPage = "<%=rpcPage%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("cust_name",cust_name); 
response.data.add("sp_sum",sp_sum);
core.ajax.receivePacket(response);
