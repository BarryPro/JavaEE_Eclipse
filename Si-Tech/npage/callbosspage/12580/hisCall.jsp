<%
  /*
   * ����: �û���ʷ������Ϣ
�� * �汾: 1.0.0
�� * ����: 2009/02/16
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.*"%>
<html>
  <head>
    
    <title>��ʷ������Ϣ</title>
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
						��ʼʱ��
					</th>
					<th>
						����ʱ��
					</th>
					<th>
						����
					</th>
					<th>
						����
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
						<input type="button" class="b_foot" value="�ر�" onClick="window.close();">
					</td>
				</tr>
			</table>
		</div>
  </body>

</html>
