<%
	/********************
	 version v2.0
	 开发商: si-tech
	********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String tPhoneNo= request.getParameter("tPhoneNo");
	//System.out.println("tPhoneNo======================="+tPhoneNo);
	String sql1 = "SELECT b.CUST_NAME, c.RUN_NAME,to_char(a.ID_NO),to_char(a.CUST_ID) FROM DCUSTMSG a, DCUSTDOC b, SRUNCODE c " +
	             "WHERE a.CUST_ID = b.CUST_ID AND SUBSTR(a.RUN_CODE, 2, 1) = c.RUN_CODE AND a.PHONE_NO =:phoneno AND ROWNUM<2";
	String sql2 = "SELECT A.PHONE_NO,to_char(A.CUST_ID),to_char(A.ID_NO),A.CUST_NAME,A.ID_TYPE,A.ID_ICCID,A.ID_ADDRESS,A.CONTACT_PHONE,A.CONTACT_EMAILL,A.LOGIN_NO,to_char(A.OP_TIME,'yyyy-MM-dd hh24:mi:ss'),to_char(A.LOGIN_ACCEPT),to_char(A.TOTAL_DATE)  "+ 
	              " FROM DCUSTREALDOC A,DCUSTMSG B WHERE A.ID_NO=B.ID_NO AND A.PHONE_NO=:phoneno1 ";
	//System.out.println("sql1======================"+sql1);
	String [] paraIn = new String[2];
  	paraIn[0] = sql1;
  	paraIn[1] = "phoneno="+tPhoneNo;
  	String [] paraIn1 = new String[2];
  	paraIn1[0] = sql2;
  	paraIn1[1] = "phoneno1="+tPhoneNo;
%>
	<wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
		</wtc:service>
	<wtc:array id="result1" scope="end" />
		
	<wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="13">
		<wtc:param value="<%=paraIn1[0]%>"/>
		<wtc:param value="<%=paraIn1[1]%>"/>
		</wtc:service>
	<wtc:array id="result2" scope="end" />
<%
	
	String retCode2=retCode1;
	String retMsg2=retMsg1;
	String retCode4=retCode3;
	String retMsg4=retMsg3;
	
 	if(retMsg2.equals(""))
 	{ 		
		retMsg2 = "未知的错误信息";
	}
	if( retMsg2.equals("null"))
	{			
		retMsg2 ="未知的错误信息";
	}
	if(retMsg4.equals(""))
 	{ 		
		retMsg4 = "未知的错误信息";
	}
	if( retMsg4.equals("null"))
	{			
		retMsg4 ="未知的错误信息";
	}

if(result1.length == 0)
{
	//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	
	var response = new AJAXPacket();
	response.data.add("retCode0",'<%=retCode2%>');
	response.data.add("retMsg",'<%=retMsg2%>');
	response.data.add("retCode1",'<%=retCode4%>');
	response.data.add("retMsg1",'<%=retMsg4%>');
	response.data.add("rpc_flag","1");
	core.ajax.receivePacket(response);

<%

}
else if(result2.length == 0)
{
%>
  var response = new AJAXPacket();
	response.data.add("retCode0",'<%=retCode2%>');
	response.data.add("retMsg",'<%=retMsg2%>');
	response.data.add("retCode1",'<%=retCode4%>');
	response.data.add("retMsg1",'<%=retMsg4%>');
	response.data.add("custName",'<%=result1[0][0]%>');
	response.data.add("runName",'<%=result1[0][1]%>');
	response.data.add("idNo",'<%=result1[0][2]%>');
	response.data.add("custId",'<%=result1[0][3]%>');
	response.data.add("rpc_flag","2");
	core.ajax.receivePacket(response);
<%
}
else
{
%>
  var response = new AJAXPacket();
	response.data.add("retCode0",'<%=retCode2%>');
	response.data.add("retMsg",'<%=retMsg2%>');
	response.data.add("retCode1",'<%=retCode4%>');
	response.data.add("retMsg1",'<%=retMsg4%>');
	response.data.add("rpc_flag","3");
	core.ajax.receivePacket(response);
	
<%
}
%>