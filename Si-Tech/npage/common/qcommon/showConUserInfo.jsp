<%@ page contentType="text/html;charset=GB2312"%>
			<table>
				<tr>
					<th>帐户ID</th>
					<th>缴费科目</th>
					<th>比例</th>
				</tr>
				<%
					String info = request.getParameter("info");
					System.out.println("info======"+info);
					if(!"".equals(info)){
						String[] tr = info.split("\\|");
						for(int i = 0 ; i< tr.length;i++){
							String[] td = tr[i].split("~");
							out.println("<tr>");
							for(int j = 0; j<td.length;j++ ){
								out.println("<td>"+td[j]+"</td>");
							}
							out.println("</tr>");
					  }
				  }
				%>
 </table>
