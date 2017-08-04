<%
  /*
   * 功能: 删除智能网vpmn闭合群资费详细配置 
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
String closeFee_id    = request.getParameter("closeFee_id");
String work_no   = (String)session.getAttribute("workNo");
String password   = (String)session.getAttribute("password");
String orgCode = (String)session.getAttribute("orgCode");
String loginregionCode = orgCode.substring(0,2);
String op_code= "d211";
String region_code = request.getParameter("region_code");
String closeFee_code = request.getParameter("closeFee_code");
String login_accept="";
login_accept = getMaxAccept();
if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
String inputParam[] = new String[6];
inputParam[0] = login_accept;
inputParam[1] = op_code;
inputParam[2] = work_no;
inputParam[3] = password;
inputParam[4] = loginregionCode;
inputParam[5] = closeFee_id;
String errCode ="";
String errMsg = "";
%>

<wtc:service name="sd211DelCfg"  routerKey="region" routerValue="<%=region_code%>" retcode="code" retmsg="msg" outnum="0">
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
 	var closeFee_code = '<%=closeFee_code%>';
	var region_code = '<%=region_code%>';
	var m = '<%=errMsg%>';
	rdShowMessageDialog(m);
	 window.close();
   opener.location.href="fd211_main.jsp?regionCode="+region_code+"&closeFeeCode="+closeFee_code;    		
</script>	






  
	
