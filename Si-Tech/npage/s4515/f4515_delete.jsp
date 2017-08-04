<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>

<%
String pkg_id    = request.getParameter("pkg_id");
String work_no   = (String)session.getAttribute("workNo");
String op_code= "4515";
String region_code = request.getParameter("region_code");
String pkg_code = request.getParameter("pkg_code");
if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
String inputParam[] = new String[3];
inputParam[0] = pkg_id;
inputParam[1] = work_no;
inputParam[2] = op_code;
String errCode ="";
String errMsg = "";
%>

<wtc:service name="s4515DeleteCfm"  routerKey="region" routerValue="<%=region_code%>" retcode="code" retmsg="msg" outnum="0">
    <wtc:param value="<%=inputParam[0]%>"/>
    <wtc:param value="<%=inputParam[1]%>"/>
    <wtc:param value="<%=inputParam[2]%>"/>	
</wtc:service>
<%
	errCode = code;
	errMsg =msg;
	
	%>
<script language="javascript">
 	var pkg_code = '<%=pkg_code%>';
	var region_code = '<%=region_code%>';
	var m = '<%=errMsg%>';
	rdShowMessageDialog(m);
	 window.close();
   opener.location.href="f4515_main.jsp?regionCode="+region_code+"&pkgCode="+pkg_code;    		
</script>	






  
	
