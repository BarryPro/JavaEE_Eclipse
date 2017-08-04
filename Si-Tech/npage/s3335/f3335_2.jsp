 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    
 		String opCode = "3335";
 		String opName = "投诉处理信誉管理查询";
 		String regionCode  = (String)session.getAttribute("regCode");
 		String loginNo =(String)session.getAttribute("workNo");
 		String pass = (String)session.getAttribute("password"); 	
 			
 		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));
		String sql = "select phone_no,consume_info,cust_property,cust_base_info,state,complaints_mark,total,mark_level  from wreputationinfo where phone_no = '"+phone_no+"'";
		System.out.println("sql ============"+sql);
%>		 
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="sVerifyTypeArr" scope="end" />			
<html>
<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
</head>
<body>
	<div id="Operation_Table">	
     <table cellspacing="0">
			<tr>
				<th>手机号码</th>
				<th>消费信息</th>
				<th>客户属性</th>
				<th>客户基本信息</th> 
				<th>当前状态</th>
				<th>投诉积分</th>
				<th>总分</th>
				<th>积分等级</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='8'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>			
			<tr>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
				<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>				
			</tr>
	<%				
				}
			}
	%>			
	 </table>	
 	</div>
</body>
</html>  	 			