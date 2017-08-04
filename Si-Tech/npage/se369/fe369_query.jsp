<%
/********************
 * version v2.0
 * 开发商: si-tech
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		
		String lac_id = request.getParameter("lac_id").trim();
		String cell_id 	= request.getParameter("cell_id").trim();
		String regionCode= (String)session.getAttribute("regCode");
		String sqlsss="select lac_code,cell_id,home_area_code,note from dbbillprg.lac_cell_info where lac_code='"+lac_id+"' and cell_id='"+cell_id+"'";

		%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="Recd" retmsg="RetMs" outnum="4">
			<wtc:sql><%=sqlsss%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end"  />
			<%

if("000000".equals(Recd)){
if(result1.length>0) {
		
		%>
<body>
	<div class="title">
				<div id="title_zi">信息查询列表</div>
			</div>
							<table >
							<tr >
								<th>lac_id</th>
								<th>cell_id</th>
								<th>小区地址</th>
								<th>归属地</th>
			
							
							</tr>
							<%for(int i=0;i<result1.length;i++) {%>
							<tr> 
								<td><%=result1[i][0]%></td>
								<td><%=result1[i][1]%></td>
								<td><%=result1[i][2]%></td>
								<td><%=result1[i][3]%></td>
								
						  </tr>
						  <%}%>
						</talbe>
</body>
</html>
<%
	}
	
else {
			%>
<body>
		<div class="title">
				<div id="title_zi">信息查询列表</div>
			</div>
							<table >
							<tr >
								<th>lac_id</th>
								<th>cell_id</th>
								<th>小区地址</th>
								<th>归属地</th>
			
							
							</tr>
									
									<tr height='25' align='center'><td colspan='4'>查询信息为空！</td></tr>
									
						</talbe>
</body>
</html>
<%
	}
	}
else {
		
		%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=Recd%>"+"<%=RetMs%>",0);	
					</script>
					<%
	}
%>