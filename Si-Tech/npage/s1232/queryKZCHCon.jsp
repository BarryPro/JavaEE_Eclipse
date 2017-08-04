<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
update:liutong@2008.09.05
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
 
 
	   String contractno = request.getParameter("contractno");
     String regionCode = (String)session.getAttribute("regCode");
     
     		String[] inParamsss1 = new String[2];
	      inParamsss1[0] = "select count(1) from dagtbasemsg where status='Y' and contract_no=:contractss";
	      inParamsss1[1] = "contractss="+contractno;
	      System.out.println("============="+inParamsss1[0]);
	      System.out.println("============="+inParamsss1[1]);
	  
%>
				
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>	
	  <wtc:array id="dcustarry" scope="end" />
<%
       String queryCount = "0";
       if(dcustarry.length>0){
       	queryCount = dcustarry[0][0];
       }
		System.out.println("----------------------queryCount----------------"+queryCount);
%>

var response = new AJAXPacket();
response.data.add("queryCount","<%=queryCount%>");
core.ajax.receivePacket(response);

