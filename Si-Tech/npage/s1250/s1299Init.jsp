<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.util.*;"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
//ArrayList arr = (ArrayList)session.getAttribute("allArr");
//String[][] baseInfo = (String[][])arr.get(0);
//String region_code = (baseInfo[0][16]).substring(0,2);
//String grade_name = "";
//String retCode = "";
//String retMsg = "";  

String[][]result = new String [][]{};    
String retType = request.getParameter("retType"); 
String op_code = request.getParameter("op_code");
String Grade_num = request.getParameter("Grade_num");

     
String region_code = request.getParameter("region_code"); 
String grade_name = request.getParameter("grade_name"); 
String retCode = request.getParameter("retCode"); 
String retMsg = request.getParameter("retMsg"); 
System.out.println("Grade_num ===: "+ Grade_num);

System.out.println("region_code ===: "+ region_code);

//comImpl co = new comImpl();

//String SqlStr = "select grade_name from sMarkGradeCode where BEGIN_POINT <= '"+ Grade_num +"' and END_POINT >= '" + Grade_num +"' and REGION_CODE = '" + region_code +"' and GRADE_CODE < 'A'";

//ÍõÃ·ÐÞ¸Ä20060322
String SqlStr = "select grade_name from sMarkGradeCode where BEGIN_POINT <= '"+ Grade_num +"' and END_POINT >= '" + Grade_num +"' and REGION_CODE = '" + region_code +"' and GRADE_CODE >= 'a'";
System.out.println(SqlStr);
//ArrayList arr1 = co.spubqry32("1", SqlStr);
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
    	<wtc:sql><%=SqlStr%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="arr1" scope="end"/>
<%	
if(arr1.length != 0)
{
	result = arr1;
}

if(result.length == 1){

	grade_name=result[0][0];
	
}


//String rpcPage = "s1299Init";

%>

var response = new AJAXPacket();
var retType = "";
var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg	%>";
var grade_name = "<%=grade_name%>";

var retType = "<%=retType%>";
//var rpcPage = "";

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("retType",retType);
//response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("grade_name",grade_name); 
//alert('qqqqqqqqq');
core.ajax.receivePacket(response);
