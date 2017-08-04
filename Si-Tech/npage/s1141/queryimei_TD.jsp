<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%


   		    	String org_Code = (String)session.getAttribute("orgCode");
   		    	String  group_id = (String)session.getAttribute("groupId");
   					String imei_no = WtcUtil.repStr(request.getParameter("imei_no")," ");
	       	 	String op_code = WtcUtil.repStr(request.getParameter("opcode")," ");
	        	String regionCode = org_Code.substring(0,2);

	        System.out.println("op_codeop_code="+op_code);

					String[] inParamsss1 = new String[2];
			inParamsss1[0] = "select count(*) from DBCHNTERM.schnrescodetac a, DBCHNTERM.schnrescode b  where b.kind_code='92' and a.res_code = b.res_code and a.tac_code=:imeno";
			inParamsss1[1] = "imeno="+imei_no.substring(0,8);
			System.out.println("imei"+imei_no.substring(0,8));
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retResult" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="result1" scope="end" />


<%
			 if(retResult.equals("0")||retResult.equals("000000")){
 	        				String num1 = (result1[0][0]).trim();
							System.out.println("num1="+num1);
							if(num1.equals("0")){
									retResult="000003";
							}else{
									retResult="000000";
							}
 	        	
 	        	
 	        	
 	     	}else{
 			}
	    


%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
response.data.add("retResult","<%=retResult%>");
core.ajax.receivePacket(response);



 
