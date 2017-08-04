<%
  /*
   * 功能: 添加智能网vpmn闭合群资费 
   * 版本: 1.8.2
   * 日期: 2011/03/01
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.text.*"%>

<%
String op_code= "d211";
String work_no = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");
String orgCode = (String)session.getAttribute("orgCode");
String loginregionCode = orgCode.substring(0,2);
String region_code = request.getParameter("region_code");
String closeFee_code = request.getParameter("closeFee_code");
String closeFee_name = request.getParameter("closeFee_name");
String stop_time = request.getParameter("stop_time");
String power_right = request.getParameter("power_right");
String login_accept="";
login_accept = getMaxAccept();
if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
String inputParam[] = new String[10];

inputParam[0] = login_accept;
inputParam[1] = op_code;
inputParam[2] = work_no;
inputParam[3] = password;
inputParam[4] = region_code;
inputParam[5] = closeFee_code;
inputParam[6] = closeFee_name;
inputParam[7] = region_code;
inputParam[8] = stop_time;
inputParam[9] = power_right;

String errCode ="";
String errMsg = "";
%>
<wtc:service name="sd211AddFee"  routerKey="region" routerValue="<%=region_code%>" retcode="code" retmsg="msg" outnum="0">
    <wtc:param value="<%=inputParam[0]%>"/>
    <wtc:param value="<%=inputParam[1]%>"/>
    <wtc:param value="<%=inputParam[2]%>"/>	
    <wtc:param value="<%=inputParam[3]%>"/>
    <wtc:param value="<%=inputParam[4]%>"/>
    <wtc:param value="<%=inputParam[5]%>"/>	
    <wtc:param value="<%=inputParam[6]%>"/>	
    <wtc:param value="<%=inputParam[7]%>"/>
    <wtc:param value="<%=inputParam[8]%>"/>
    <wtc:param value="<%=inputParam[9]%>"/>	    	
</wtc:service>

<%
	errCode = code;
	errMsg =msg;
%>
<script language="javascript">
	var region_code = '<%=region_code%>';
	var m = '<%=errMsg%>';
	var r = '<%=code%>';
	rdShowMessageDialog(m); 

	//document.URL = "fd211_addCloseFee.jsp?add_region_code="+region_code;	

	if(r=='000000'){
		document.URL="fd211.jsp";
	}else{
		history.go(-1);
	}
		
</script>	



  
	

