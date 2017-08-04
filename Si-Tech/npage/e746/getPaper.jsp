<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String loginNo = request.getParameter("loginNo");
		String region_code = request.getParameter("region_code");
		String bank_code = request.getParameter("bank_code");
	    String[] inParas2 = new String[2];
		inParas2[0]="select S_INVOICE_NUMBER,E_INVOICE_NUMBER,INVOICE_CODE from QD_WLOGININVOICE where LOGIN_NO=:loginNo and region_code=:region_code and bank_code=:bank_code";	
		inParas2[1]="loginNo="+loginNo+",region_code="+region_code+",bank_code="+bank_code;
	     
%>		

		<wtc:service name="TlsPubSelCrm"    retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>	
	    </wtc:service>
	  
		<wtc:array id="limits" scope="end" />			
<%
		String S_INVOICE_NUMBER = "";
		String E_INVOICE_NUMBER = "";
		String INVOICE_CODE ="";
		String return_code = retCode1;
		String return_msg = retMsg1;
		//xl 判断 
		System.out.println("88888888888888888888888 limits.length is "+limits.length+" and loginNo is "+loginNo);
		
		if(limits.length < 0)
		{
		   %>
			var response = new AJAXPacket();
	 
			var return_code = "<%=return_code%>";
			var return_msg = "<%=return_msg%>";
		    response.data.add("return_code","111111");
			response.data.add("return_msg","无结果"); 
			core.ajax.receivePacket(response);
		<%}
		else if(limits.length==0)
		{
			%>
			var response = new AJAXPacket();
	 
			var return_code = "000000";
			var return_msg = "<%=return_msg%>";
			var S_INVOICE_NUMBER = "<%=S_INVOICE_NUMBER%>";
			var E_INVOICE_NUMBER = "<%=E_INVOICE_NUMBER%>";
			var INVOICE_CODE = "<%=INVOICE_CODE%>";
			var result = "<%=limits%>";
			response.data.add("return_code",return_code);
			response.data.add("return_msg",return_msg);
			response.data.add("result",result);
			response.data.add("S_INVOICE_NUMBER","0000000000");
			response.data.add("E_INVOICE_NUMBER","0000000000");
			response.data.add("INVOICE_CODE","00000000000000");
			core.ajax.receivePacket(response);
		    response.data.add("return_code",return_code);
			response.data.add("return_msg",return_msg); 
			core.ajax.receivePacket(response);
			<%
		}
		else
		{
			 
			 
			S_INVOICE_NUMBER = limits[0][0].trim();
			E_INVOICE_NUMBER = limits[0][1].trim();
			INVOICE_CODE = limits[0][2].trim();
			//System.out.println("0000000000000000000000000000查询的结果不是空 ···················");
			//System.out.println("return_code is "+return_code+" and outPledge is "+outPledge+" and f_temp_total_pay is "+f_temp_total_pay );
			%>
			var response = new AJAXPacket();
	 
		var return_code = "<%=return_code%>";
		var return_msg = "<%=return_msg%>";
		var result = "<%=limits%>";
		var S_INVOICE_NUMBER = "<%=S_INVOICE_NUMBER%>";
		var E_INVOICE_NUMBER = "<%=E_INVOICE_NUMBER%>";
		var INVOICE_CODE = "<%=INVOICE_CODE%>";
		response.data.add("return_code",return_code);
		response.data.add("return_msg",return_msg);
		response.data.add("result",result);
	    response.data.add("S_INVOICE_NUMBER",S_INVOICE_NUMBER);
		response.data.add("E_INVOICE_NUMBER",E_INVOICE_NUMBER);
		response.data.add("INVOICE_CODE",INVOICE_CODE);
		core.ajax.receivePacket(response);
			<%
		}

%>
		
