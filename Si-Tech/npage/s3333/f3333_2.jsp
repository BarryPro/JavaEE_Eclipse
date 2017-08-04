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
    
 		String opCode = "3333";
 		String opName = "停机查询";
 		String regionCode  = (String)session.getAttribute("regCode");
 		String loginNo =(String)session.getAttribute("workNo");
 		String pass = (String)session.getAttribute("password"); 	
 			
 		String phone_no = WtcUtil.repNull(request.getParameter("phone_no"));
		String startMonth = WtcUtil.repNull(request.getParameter("startMonth"));
		String endMonth = WtcUtil.repNull(request.getParameter("endMonth"));
		
		
%>		 
		<wtc:service  name="s3070Qry"  routerKey="region"  routerValue="<%=regionCode%>" 
				outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param  value="<%=loginNo%>"/>
			<wtc:param  value="<%=pass%>"/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=phone_no%>"/>
			<wtc:param  value="<%=startMonth%>"/>
			<wtc:param  value="<%=endMonth%>"/>
		</wtc:service>
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<script language="javascript">
			rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
		</script>
<%
	}else{
%>

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
				<th>操作代码</th>
				<th>操作时间</th>
				<th>操作描述</th> 
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='4'>");
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
			</tr>
	<%				
				}
			}
	%>			
	 </table>	
 	</div>
</body>
</html>  	 			
<%
	}
%>