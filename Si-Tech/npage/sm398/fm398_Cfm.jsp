<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm @ 20110225
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/common/serverip.jsp" %>

<%
		String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
		String opName     = WtcUtil.repNull(request.getParameter("opName"));
		String ipAddr     = realip; 
    String loginNo    = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String passWord   = (String)session.getAttribute("password");
 
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept"   routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept"/>
<% 
 String[] input_parms = new String[15];
 					input_parms[0]  = sysAccept;
 					input_parms[1]  = "01";
 					input_parms[2]  = opCode;
 					input_parms[3]  = loginNo;
 					input_parms[4]  = passWord;
 					input_parms[5]  = "";
 					input_parms[6]  = "";
 					input_parms[7]  = WtcUtil.repNull(request.getParameter("optype"));/*操作类型:0单个号码录入;1批量号码录入;2按号码段录入*/
 					input_parms[8]  = WtcUtil.repNull(request.getParameter("unit_name"));/*归属的集团名称*/
 					input_parms[9]  = "";/*文件名*/
 					input_parms[10] = "";/*文件路径*/
 					input_parms[11] = ipAddr;/*IP地址*/
 					input_parms[12] = WtcUtil.repNull(request.getParameter("phoneNo_b"));/*号码段开始;iOpType为0时号码段开始和号码段结束相同*/
 					input_parms[13] = WtcUtil.repNull(request.getParameter("phoneNo_e"));/*号码段结束*/
 					input_parms[14] = "备注："+opName;/*备注*/
 					
 					for(int i=0;i<input_parms.length;i++){
 						System.out.println("----------------input_parms["+i+"]--------------------->"+input_parms[i]);
 					}
 					
%>
<wtc:service name="sm398Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3" >
        <wtc:param value="<%=input_parms[0]%>"/>
        <wtc:param value="<%=input_parms[1]%>"/>
        <wtc:param value="<%=input_parms[2]%>"/>
        <wtc:param value="<%=input_parms[3]%>"/>
        <wtc:param value="<%=input_parms[4]%>"/>
        <wtc:param value="<%=input_parms[5]%>"/>
        <wtc:param value="<%=input_parms[6]%>"/>
        <wtc:param value="<%=input_parms[7]%>"/>
        <wtc:param value="<%=input_parms[8]%>"/>
        <wtc:param value="<%=input_parms[9]%>"/>
        <wtc:param value="<%=input_parms[10]%>"/>
        <wtc:param value="<%=input_parms[11]%>"/>
        <wtc:param value="<%=input_parms[12]%>"/>
        <wtc:param value="<%=input_parms[13]%>"/>
        <wtc:param value="<%=input_parms[14]%>"/>														

</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result2" start="2" length="1" scope="end" />
		
<%
System.out.println("=========================errCode================================   "+errCode);

if(errCode.equals("000000")){

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		window.location = "fm398_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
</script>
</head>
<body>
<form name="form1" id="form1" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div>
	<div class="title">
		<div id="title_zi">操作结果</div>
	</div>
 
		<table>
			<%if(errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">导入成功的号码个数：<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>手机号码</th>
				<th>失败原因</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>

		</table>
	<table cellspacing="0">
  <tr>
  	<td id="footer" colspan="3">
  		<input type="button" name="back" class="b_foot" value="返回" onClick="goback()"  >
  	</td>
  </tr>
  </table>
	</div>
    <%@ include file="/npage/include/footer.jsp"%>
   </form>
</body>
<%
} else {
	%>
	<script language="javascript">
		rdShowMessageDialog("操作失败！错误代码<%=errCode%>,错误原因<%=errMsg%>.");
		window.location.href = "fm398_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
}
%>