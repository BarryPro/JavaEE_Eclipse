<%
  /*
   * 功能: 用户历史呼叫信息
　 * 版本: 1.0.0
　 * 日期: 2009/02/16
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.*"%>
<html>
  <head>
    
    <title>历史呼叫信息</title>
		<%
			String[][] dataRows = new String[][] {};
			String phone = (String)request.getParameter("phone");
			String tablename = "dcallcall";
			SimpleDateFormat sdf  = new SimpleDateFormat("yyyyMM");
			Date now = new Date();
			String tai = sdf.format(now);
			tablename += tai;
			String querySql = "select to_char(begin_date,'yyyy-MM-dd HH:mi:ss'),to_char(end_date,'yyyy-MM-dd HH:mi:ss'),caller_phone,callee_phone from "+tablename+" where accept_phone='"+phone+"' and rownum <= 10";			
		%>		
  </head>
  
  <body>
    <wtc:service name="s151Select" outnum="7">
			<wtc:param value="<%=querySql %>" />
		</wtc:service>
		<wtc:array id="queryList" start="0" length="7" scope="end" />
		<%
		dataRows = queryList;
		%>
		<div id="Operation_Table">
			<table cellspacing="0">
				<tr align="center">
					<th>
						开始时间
					</th>
					<th>
						结束时间
					</th>
					<th>
						主叫
					</th>
					<th>
						被叫
					</th>					
				</tr>
				<%
						for (int i = 0; i < dataRows.length; i++) {
						String tdClass = "";
				%>
				<%
							if ((i + 1) % 2 == 1) {
							tdClass = "grey";
				%>
				<tr>
					<%
					} else {
					%>
				
				<tr>
					<%
					}
					%>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][0].length() != 0) ? dataRows[i][0]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][1].length() != 0) ? dataRows[i][1]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][2].length() != 0) ? dataRows[i][2]
						: "&nbsp;"%>
					</td>
					<td align="center" class="<%=tdClass%>">
						<%=(dataRows[i][3].length() != 0) ? dataRows[i][3]
						: "&nbsp;"%>
					</td>					
				</tr>
				<%
				}
				%>
				<tr align="center">
					<td colspan="4">
						<input type="button" class="b_foot" value="关闭" onClick="window.close();">
					</td>
				</tr>
			</table>
		</div>
  </body>

</html>
