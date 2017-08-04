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
		String phoneNo = request.getParameter("phoneNo");
		String[] inParas = new String[2];
		inParas[0]="select t.phone_type from DBCUSTADM.dTestPhoneMsg t where t.phone_no = :phoneNo";
		inParas[1]="phoneNo="+phoneNo;
%>			
		<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="3">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>	
		</wtc:service>
		<wtc:array id="result1" scope="end" />			
<%
		String s_result = "";
		String return_code = retCode1;
		String return_msg = retMsg1;
		if(result1==null||result1.length==0)
		{
			s_result="";
		}
		else
		{
			s_result=result1[0][0];
		}

%>	
var response = new AJAXPacket();
var return_code = "<%=return_code%>";
var return_msg = "<%=return_msg%>";
var s_result = "<%=s_result%>";
response.data.add("return_code",return_code);
response.data.add("return_msg",return_msg);
response.data.add("s_result",s_result);
core.ajax.receivePacket(response);	