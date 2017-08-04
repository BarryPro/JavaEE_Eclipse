<html>
 <%
   /*
   * 功能: 审核记录查询-根据界面查询信息
　 * 版本: v3.0
　 * 日期: 2008-10-10
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**需要清楚缓存.如果是新页面,可删除**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "3334";
 		String opName = "促销品库存查询";
 		String regionCode  = (String)session.getAttribute("regCode");
 		String loginNo =(String)session.getAttribute("workNo");
 		String pass = (String)session.getAttribute("password");
 		
 		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));
		String dq_code = WtcUtil.repNull(request.getParameter("dq_code"));
 		String qx_code = WtcUtil.repNull(request.getParameter("qx_code"));
		String query_type = WtcUtil.repNull(request.getParameter("query_type"));
 		String query_code = WtcUtil.repNull(request.getParameter("query_code"));
		String query_name = WtcUtil.repNull(request.getParameter("query_name"));				
		
%>		 
		<wtc:service  name="sSalesPromQry"  routerKey="region"  routerValue="<%=regionCode%>" outnum="7">
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=pass%>"/>
			<wtc:param value="<%=dq_code%>"/>
			<wtc:param value="<%=qx_code%>"/>
			<wtc:param value="<%=query_type%>"/>
			<wtc:param value="<%=query_code%>"/>				
			<wtc:param value="<%=query_name%>"/>	
		</wtc:service>
		<wtc:array id="sVerifyTypeArr" start="2" length="5"  scope="end"/>
<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
</head>
<body>
   <div id="Operation_Table"> 
	     <table cellspacing="0"> 
				<tr>
					<th>促销品代码</th>
					<th>促销品名称</th>
					<th>营业厅代码</th>
					<th>营业厅名称</th> 
					<th>库存数据</th> 
				</tr> 
		<%
				if(sVerifyTypeArr.length==0){
					out.println("<tr height='25' align='center'><td colspan='5'>");
					out.println("<font class='orange'>没有任何记录！</font>");
					out.println("</td></tr>");
				}else if(sVerifyTypeArr.length>0){
					String tbclass = "";
					for(int i=0;i<sVerifyTypeArr.length;i++){
							tbclass = (i%2==0)?"Grey":"";
		%>			
				<tr>
					<td class="<%=tbclass%>"><%=(sVerifyTypeArr[i][0]).trim()%></td>
					<td class="<%=tbclass%>"><%=(sVerifyTypeArr[i][1]).trim()%></td>
					<td class="<%=tbclass%>"><%=(sVerifyTypeArr[i][2]).trim()%></td>
					<td class="<%=tbclass%>"><%=(sVerifyTypeArr[i][3]).trim()%></td>
					<td class="<%=tbclass%>"><%=(sVerifyTypeArr[i][4]).trim()%></td>
				</tr>
		<%				
					}
				}
		%>			
		 </table>	
	</div>
</body>
</html>  	 			