<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.27
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%

	String cust_name   = "";
	String retCode = "";
	String retMsg = "";
	String SqlStr1 = "";
	String[] inParams = new String[2];
	String[][]psot = new String [][]{};
	
	String phoneNo = request.getParameter("phoneNo");
	System.out.println("phoneNO ===: "+ phoneNo);
	
	SqlStr1 = "select c.CUST_NAME from dcustmsg b, dcustdoc c where b.cust_id = c.cust_id  and b.phone_no='"+phoneNo+"'";
	inParams[0] = "select c.CUST_NAME from dcustmsg b, dcustdoc c where b.cust_id = c.cust_id  and b.phone_no=:phoneNo";
	inParams[1] = "phoneNo="+phoneNo;
	System.out.println("SqlStr1="+SqlStr1);
	//ArrayList arr1 = co1.spubqry32("1", SqlStr1);	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	if(result1.length>0)
	{
		psot = result1;
	}
	if(psot.length == 1){
		cust_name = psot[0][0];
		retMsg = "用户存在!"; 
	}else{
		retCode = "100001";
		retMsg = "用户不存在!"; 
	}
	
	String rpcPage = "post7114";

%>
var response = new AJAXPacket();
var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var cust_name = "<%=cust_name%>";
var rpcPage = "<%=rpcPage%>";
response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("cust_name",cust_name); 
core.ajax.receivePacket(response);
