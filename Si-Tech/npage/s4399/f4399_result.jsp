<%
/********************
 version v2.0
 开发商: si-tech
 update by wangzn @ 2010-1-26 18:48:54
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="import java.sql.*"%>
<%@ page import="java.text.*" %>
<% 
  String arcGroupNo = request.getParameter("acr_group_no");
   
  String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String iOrgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String iLoginPwd = WtcUtil.repNull((String)session.getAttribute("password"));
  String iIpAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
  String iRegionCode = iOrgCode.substring(0,2);
  String opName ="";
  String opCode = "";
%>
<wtc:service name="s4399Qry" outnum="3" routerKey="region" routerValue="<%=iRegionCode%>">
	<wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=iLoginPwd%>"/>
  <wtc:param value="<%=iOrgCode%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
	<wtc:param value="<%=arcGroupNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%@ include file="/npage/include/header.jsp" %>
<%
System.out.println("result[0][0]:["+result[0][0]+"].......       \n");
%>


<table cellspacing="0">
			   <tr>
			    <th nowrap>集团编号</th> 
	        <th nowrap>集团名称</th>     
	      </tr>
	      <%
	        if(!"".equals(result[0][0])){
	        String[] row = result[0][0].split("&");
	        for(int i = 0; i < row.length ;i++){
	        
	      %>
	      	<tr>
	      		<td><%=row[0]%></td>
	      		<td><%=row[1]%></td>
	      	</tr>
	      <%}}%>      
</table>