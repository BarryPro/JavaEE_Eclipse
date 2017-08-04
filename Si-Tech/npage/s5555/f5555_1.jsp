<%
  /*
   * 功能: 清理记录
   * 版本: 1.0
   * 日期: 2009/04/04
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
 	String opCode = request.getParameter("opCode");
 	String opName = request.getParameter("opName");

 
	String orgCode    = (String)session.getAttribute("orgCode");
	String workNo     = (String)session.getAttribute("workNo"); 
	String password   = (String)session.getAttribute("password");
	String regionCode = orgCode.substring(0,2);
	String table_name    = request.getParameter("table_name");
	String owner_name    = request.getParameter("owner_name");
	String clean_stime    = request.getParameter("clean_stime");
	String clean_etime    = request.getParameter("clean_etime");	
	
%> 
<wtc:service name="tbclean_msg" routerKey="regionCode" routerValue="<%=regionCode%>"  outnum="10" >
	<wtc:param value="<%=table_name%>"/>
	<wtc:param value="<%=owner_name%>"/>		
	<wtc:param value="<%=clean_stime%>"/>
	<wtc:param value="<%=clean_etime%>"/>
</wtc:service>
<wtc:array id="result1" start="0" length="2" scope="end" />
<wtc:array id="result" start="2" length="8" scope="end" />
<%
	System.out.println("111111111"+retCode);
	if(!result1[0][0].equals("000000")){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=result1[0][0]%>:<%=result1[0][1]%>!!!",0);
			history.go(-1);
		</script>
<%
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>                 
		<title><%=opName%></title>   
		<script>

		</script>
	</head>
	<body>
		<form name="form1" action="jspDemo_1.jsp">
		<div id="Operation_Table">
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>属主 </th>
				<th nowrap>表名 </th>
				<th nowrap>清理开始时间 </th>
				<th nowrap>清理结束时间</th>
				<th nowrap>清理掉的记录数</th>
				<th nowrap>清理数据空间 </th> 
				<th nowrap>清理人员</th>
				<th nowrap>清理数据源库</th> 
				<th nowrap>备份数据记录大小 </th>
				<th nowrap>备份路径 </th> 
			</tr> 
	<%
			if(result.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
			}else if(result.length>0){
				String tbclass = "";
				for(int i=0;i<result.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=owner_name%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=table_name%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=result[i][7]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
				<tr> 
					<td colspan="10" id="footer"> 
					<input class="b_foot" type="button" name="back" value="返回" onClick="history.go(-1);">  
					</td>
				</tr>
  </table>				
		<%@ include file="/npage/include/footer.jsp" %> 
		</form>
	</body>
</html>
