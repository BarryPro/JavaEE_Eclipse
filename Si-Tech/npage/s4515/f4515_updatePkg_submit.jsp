<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>

<%
String op_code= "4515";
String work_no = (String)session.getAttribute("workNo");
String region_code = request.getParameter("region_code");
String pkg_code = request.getParameter("pkg_code");
String stop_time = request.getParameter("stop_time");
String power_right = request.getParameter("power_right");
if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
String inputParam[] = new String[6];
inputParam[0] = region_code;
inputParam[1] = pkg_code;
inputParam[2] = stop_time;
inputParam[3] = power_right;
inputParam[4] = op_code;
inputParam[5] = work_no;

String errCode ="";
String errMsg = "";
%>
<wtc:service name="s4515UpdatePkg"  routerKey="region" routerValue="<%=region_code%>" retcode="code" retmsg="msg" outnum="0">
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
	var region_code = '<%=region_code%>';
	var pkg_code = <%=pkg_code%>;
	var m = '<%=errMsg%>';
	rdShowMessageDialog(m); 
	document.URL = "f4515_updatePkg.jsp?regionCode="+region_code+"&pkgCode="+pkg_code;
</script>	



  
	
