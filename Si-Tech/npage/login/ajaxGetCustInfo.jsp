<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
 <%
 
 String phone_no = request.getParameter("phone_no");
 String regionCode = (String)session.getAttribute("regCode");
 
 System.out.println("--------------phone_no-----------------"+phone_no);
 
 String custName = "";
 String custGs = "";
 String idType = "";
 String custPPv = "";
 String payType = "";
 String inDate = "";
 String custXe = "";
 String custXyz = "";
 String custTcDm = "";
 String custTcMc = "";
 String custSimNo = "";
 String custTypev = "";
 String idNo = "";
 String concPhone = "";
 %>
 
  <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code39" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="39" />	
		</wtc:service>
		<wtc:array id="result_t39" scope="end" />
			
	
					 
  <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code35" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="35" />	
		</wtc:service>
		<wtc:array id="result_t35" scope="end" />  
  <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code31" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="31" />	
		</wtc:service>
		<wtc:array id="result_t31" scope="end" /> 
			
			
  <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code78" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="78" />	
		</wtc:service>
		<wtc:array id="result_t78" scope="end" /> 
   <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code147" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="147" />	
		</wtc:service>
		<wtc:array id="result_t147" scope="end" />
			 
   <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code14" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="14" />	
		</wtc:service>
		<wtc:array id="result_t14" scope="end" />
			
   <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code12" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="12" />	
		</wtc:service>
		<wtc:array id="result_t12" scope="end" />
			
			
   <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code11" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="11" />	
		</wtc:service>
		<wtc:array id="result_t11" scope="end" />
			
    <wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code27" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="27" />	
		</wtc:service>
		<wtc:array id="result_t27" scope="end" />
			
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code34" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="34" />	
		</wtc:service>
		<wtc:array id="result_t34" scope="end" />
			
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code6" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="6" />	
		</wtc:service>
		<wtc:array id="result_t6" scope="end" />
			
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code10" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="10" />	
		</wtc:service>
		<wtc:array id="result_t10" scope="end" />	
			
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="msg" retcode="code72" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phone_no%>" />	
			<wtc:param value="72" />	
		</wtc:service>
		<wtc:array id="result_t72" scope="end" />
				
				

<%
		if(code147.equals("000000")&&result_t147.length>0){
			  custTcDm = result_t147[0][1];
 				custTcMc = result_t147[0][2];
		}
		
		if(code39.equals("000000")&&result_t39.length>0){
		 	concPhone = result_t39[0][2];
		 }
   if(code35.equals("000000")&&result_t35.length>0){
		 	idNo = result_t35[0][2];
		 }
   if(code31.equals("000000")&&result_t31.length>0){
		 	custTypev = result_t31[0][2];
		 }
		 
   if(code78.equals("000000")&&result_t78.length>0){
		 	custSimNo = result_t78[0][2];
		 }
		 
		if(code14.equals("000000")&&result_t14.length>0){
		 	custXyz = result_t14[0][2];
		 }
		 
		if(code12.equals("000000")&&result_t12.length>0){
		 	custXe = result_t12[0][2];
		 }
		 
		if(code72.equals("000000")&&result_t72.length>0){
		 	payType = result_t72[0][2];
		 }
		 
		if(code10.equals("000000")&&result_t10.length>0){
		 	inDate = result_t10[0][1];
		 }
		 
		if(code6.equals("000000")&&result_t6.length>0){
		 	custPPv = result_t6[0][2];
		 }
		 
		 if(code27.equals("000000")&&result_t27.length>0){
		 	custName = result_t27[0][1];
		 }
		 
		 if(code11.equals("000000")&&result_t11.length>0){
		 	custGs = result_t11[0][2];
		 }
		 
		 if(code34.equals("000000")&&result_t34.length>0){
		 	idType = result_t34[0][2];
		 } 
		 
		 
	 
%>
 
var response = new AJAXPacket();
response.data.add("custName","<%=custName%>");
response.data.add("custGs","<%=custGs%>");
response.data.add("idType","<%=idType%>");
response.data.add("custPPv","<%=custPPv%>");
response.data.add("payType","<%=payType%>");
response.data.add("inDate","<%=inDate%>");
response.data.add("custXe","<%=custXe%>");
response.data.add("custXyz","<%=custXyz%>");
response.data.add("custTcDm","<%=custTcDm%>");
response.data.add("custTcMc","<%=custTcMc%>");
response.data.add("custSimNo","<%=custSimNo%>");
response.data.add("custTypev","<%=custTypev%>");
response.data.add("idNo","<%=idNo%>");
response.data.add("concPhone","<%=concPhone%>");
core.ajax.receivePacket(response);