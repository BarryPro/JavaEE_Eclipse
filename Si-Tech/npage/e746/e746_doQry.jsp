<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String regionCode = (String)session.getAttribute("regCode");
		String qd_login = request.getParameter("qd_login");
		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(S_INVOICE_NUMBER),to_char(E_INVOICE_NUMBER),to_char(INVOICE_CODE) from qd_WLOGININVOICE where LOGIN_NO = :qd_login";
		inParas2[1]="qd_login="+qd_login;
%>			
		<wtc:service name="TlsPubSelCrm"    retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>	
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		String s_result = "";
		String return_code = retCode1;
		String return_msg = retMsg1;
		String s_out_sinvoice="";
		String s_out_einvoice="";
		String s_out_invoicecode="";
		if(result1==null||result1.length==0)
		{
			s_result="1";
		}
		else
		{
			s_result="0";
			s_out_sinvoice=result1[0][0];
			s_out_einvoice=result1[0][1];
			s_out_invoicecode=result1[0][2];
		}

%>	
		
		var response = new AJAXPacket();
	 
		var return_code = "<%=return_code%>";
		var return_msg = "<%=return_msg%>";
	
		var s_result = "<%=s_result%>";
		var s_out_sinvoice = "<%=s_out_sinvoice%>";
		var s_out_einvoice = "<%=s_out_einvoice%>";
		var s_out_invoicecode = "<%=s_out_invoicecode%>";

		response.data.add("return_code",return_code);
		response.data.add("return_msg",return_msg);
		response.data.add("s_result",s_result);
		response.data.add("s_out_sinvoice",s_out_sinvoice);
		response.data.add("s_out_einvoice",s_out_einvoice);
		response.data.add("s_out_invoicecode",s_out_invoicecode);
		core.ajax.receivePacket(response);
		