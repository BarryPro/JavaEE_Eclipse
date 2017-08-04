<%
  /*
   * 功能: 12580预约服务时间间隔
　 * 版本: 1.0.0
　 * 日期: 2009/02/18
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
  <head>
		
		<%
			String serial_no = (String)request.getParameter("serial_no");
			String[][] dataRows = new String[][] {};
		%>
  </head>
  
  <body>
    	<div id="Operation_Table">

				<div class="title">

					时间间隔

				</div>
    	<table cellspacing="0">
    		<tr align="center">
    			<th>间隔</th>
    			<th>时间(分钟)</th>
    		</tr>
    		<%
    			String sql = "select interval from DPRESERVICETIME where serial_no = '"+serial_no+"' order by order_no";    			
	    	%>
	    	<wtc:service name="s151Select" outnum="2">
					<wtc:param value="<%=sql %>"/>
				</wtc:service>
				<wtc:array id="queryList"  scope="end"/>
				<%
					if(queryList.length > 0){
						
						dataRows = queryList;
						
						for(int i = 0; i < dataRows.length; i++){
				%>
				<tr align="center">
	    		<td>第<%=i+1 %>次~第<%=i+2 %>次</td><td><%=dataRows[i][0] %></td>	    		
	    	</tr>
				<%			
						}
				  					  	
				  }
				%>
    		<tr align="center">
    			<td colspan="2"><input type="button" class="b_foot" value="关闭" onClick="window.close();"></td>    			
    		</tr>
    	</table>
    	</div>
  </body>
</html>
