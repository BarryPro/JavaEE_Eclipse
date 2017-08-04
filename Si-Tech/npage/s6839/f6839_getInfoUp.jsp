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
	String tPhoneNo1= request.getParameter("tPhoneNo1");
	//System.out.println("tPhoneNo1======================="+tPhoneNo1);
	String sql1 = "SELECT b.CUST_NAME, c.RUN_NAME FROM DCUSTMSG a, DCUSTDOC b, SRUNCODE c " +
	             "WHERE a.CUST_ID = b.CUST_ID AND SUBSTR(a.RUN_CODE, 2, 1) = c.RUN_CODE AND a.PHONE_NO =:phoneno AND ROWNUM<2";             
	String sql = "SELECT A.CUST_NAME,A.ID_TYPE,A.ID_ICCID,A.ID_ADDRESS,A.CONTACT_PHONE,A.CONTACT_EMAILL,B.ID_NAME,to_char(A.ID_NO) "+ 
	              " FROM DCUSTREALDOC A,SIDTYPE B,DCUSTMSG C WHERE A.ID_NO=C.ID_NO AND A.ID_TYPE=B.ID_TYPE AND A.PHONE_NO=:phoneno1";
	
	//System.out.println("sql======================"+sql);
	String [] paraIn = new String[2];
  	paraIn[0] = sql1;
  	paraIn[1] = "phoneno="+tPhoneNo1;
  	
  	String [] paraIn1 = new String[2];
  	paraIn1[0] = sql;
  	paraIn1[1] = "phoneno1="+tPhoneNo1;
%>	
  <wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />

	<wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="8">
		<wtc:param value="<%=paraIn1[0]%>"/>
		<wtc:param value="<%=paraIn1[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
	
	String retCode2=retCode1;
	String retMsg2=retMsg1;

	
 	if(retMsg2.equals(""))
 	{ 		
		retMsg2 = "未知的错误信息";
	}
	if( retMsg2.equals("null"))
	{			
		retMsg2 ="未知的错误信息";
	}

if(result.length==0)
{
	//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	
	var response = new AJAXPacket();
	response.data.add("retCode0",'<%=retCode2%>');
	response.data.add("retMsg",'<%=retMsg2%>');
	response.data.add("rpc_flag","4");
	core.ajax.receivePacket(response);

<%

}
else
{
%>
  var response = new AJAXPacket();
	response.data.add("retCode0",'<%=retCode2%>');
	response.data.add("retMsg",'<%=retMsg2%>');
	response.data.add("custName1",'<%=result1[0][0]%>');
	response.data.add("runName1",'<%=result1[0][1]%>');
	response.data.add("custName",'<%=result[0][0]%>');
	response.data.add("idType",'<%=result[0][1]%>');
	response.data.add("idiccid",'<%=result[0][2]%>');
	response.data.add("idAddr",'<%=result[0][3]%>');
	response.data.add("contactphone",'<%=result[0][4]%>');
	response.data.add("contactemail",'<%=result[0][5]%>');
	response.data.add("idName",'<%=result[0][6]%>');
	response.data.add("idNo",'<%=result[0][7]%>');
	response.data.add("rpc_flag","5");
	core.ajax.receivePacket(response);
<%
}
%>