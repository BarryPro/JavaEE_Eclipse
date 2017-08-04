<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.text.*"%>

<%
String feeIndex_id    = request.getParameter("feeIndex_id");
String work_no   = (String)session.getAttribute("workNo");
String pass = (String)session.getAttribute("password");
String orgCode = (String)session.getAttribute("orgCode");
String loginregionCode = orgCode.substring(0,2);
String op_code= "b809";
String region_code = request.getParameter("region_code");
String feeIndex_code = request.getParameter("feeIndex_code");
String login_accept="";
login_accept = getMaxAccept();
if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
String inputParam[] = new String[6];
inputParam[0] = login_accept;
inputParam[1] = op_code;
inputParam[2] = work_no;
inputParam[3] = pass;
inputParam[4] = loginregionCode;
inputParam[5] = feeIndex_id;
String errCode ="";
String errMsg = "";
%>

<wtc:service name="sb80DelCfg"  routerKey="region" routerValue="<%=region_code%>" retcode="code" retmsg="msg" outnum="0">
    <wtc:param value="<%=inputParam[0]%>"/>
    <wtc:param value="<%=inputParam[1]%>"/>
    <wtc:param value="<%=inputParam[2]%>"/>	
    <wtc:param value="<%=inputParam[3]%>"/>
    <wtc:param value="<%=inputParam[4]%>"/>	
    <wtc:param value="<%=inputParam[5]%>"/>	
</wtc:service>
<%
	errCode = code;
	errMsg =msg;
	
	%>
<script language="javascript">
 	var feeIndex_code = '<%=feeIndex_code%>';
	var region_code = '<%=region_code%>';
	var m = '<%=errMsg%>';
	rdShowMessageDialog(m);
	 window.close();
   opener.location.href="fb809_main.jsp?regionCode="+region_code+"&feeIndexCode="+feeIndex_code;    		
</script>	






  
	

