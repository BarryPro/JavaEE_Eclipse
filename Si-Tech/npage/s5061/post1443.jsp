   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>

<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%
	String cust_name   = "";
	String user_name = "";
	String address = "";
	String id_iccid = "";
	String retCode = "";
	String retMsg = "";
	String SqlStr1 = "";
	String[][]psot = new String [][]{};
	String phoneNo = request.getParameter("phoneNo");
	String regionCode = (String)session.getAttribute("regCode");
	
	System.out.println("regionCode ===: "+ regionCode);

	SqlStr1 = "select a.phone_no,b.CUST_NAME,b.CUST_ADDRESS,b.id_iccid,a.id_no FROM dcustmsg a,dcustdoc b WHERE a.cust_id=b.cust_id and a.phone_no ='"+phoneNo+"'";
	retMsg="用户资料不存在!";
	
	//ArrayList arr1 = co1.spubqry32("5", SqlStr1);	
%>
	<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=SqlStr1%></wtc:sql>
 	</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
<%	
	if(result_t!=null)
	{
		psot = result_t; 
	}
	System.out.println("00000"+psot[0][0]);
	if(psot.length == 1){
		cust_name = psot[0][0];
		user_name = psot[0][1];
		address = psot[0][2];
		id_iccid = psot[0][3];
		retCode="0";
	}else{
		retCode = "100001";
	}
	
	String rpcPage = "postSim";
%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var cust_name = "<%=cust_name%>";
var user_name = "<%=user_name%>";
var address = "<%=address%>";
var id_iccid = "<%=id_iccid%>";
var rpcPage = "<%=rpcPage%>";
response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("cust_name",cust_name);
response.data.add("user_name",user_name);
response.data.add("address",address);
response.data.add("id_iccid",id_iccid);
core.ajax.receivePacket(response);
