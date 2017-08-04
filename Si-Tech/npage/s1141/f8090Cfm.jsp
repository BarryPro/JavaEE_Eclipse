<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>修改IMEI绑定关系</title>

<%
		String regionCode = (String)session.getAttribute("regCode");
		String opCode = "8090";
		String opName = "修改IMEI绑定关系";
		String iLoginNo = request.getParameter("iLoginNo2");
		String inAcceptCode = request.getParameter("inAcceptCode");
   	String old_imei_no = request.getParameter("imei_no");
   	String new_imei_no = request.getParameter("new_imei_no");
%>

<wtc:service name="s8090Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="10" >
		<wtc:param value="<%=inAcceptCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>		
		<wtc:param value="<%=old_imei_no%>"/>
		<wtc:param value="<%=new_imei_no%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
		
	<%
		if (!sReturnCode.equals("000000") )
    {
  %>
  	
  	<script language="JavaScript">
        rdShowMessageDialog("<%=sErrorMessage%>",0);
        window.location="f8090.jsp";
    </script>
    <% }else{   %>
    <script language="JavaScript">
        rdShowMessageDialog("<%=sErrorMessage%>",2);
        window.location="f8090.jsp";
    </script>
  <%
  }
  %>