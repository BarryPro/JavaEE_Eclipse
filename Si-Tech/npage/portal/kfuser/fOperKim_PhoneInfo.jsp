<%
	 /*
	 * ����: �������-��ʾ
	 * �汾: 1.0.0
	 * ����: 2009/02/20
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<% 
	 String opCode = "";
  	 String opName = "��������ѯ���";
  	 
  	 String kim_phone = request.getParameter("kim_phone")!=null?request.getParameter("kim_phone"):"";
  	 String vphone_no = request.getParameter("vphone_no")!=null?request.getParameter("vphone_no"):"";
  	 String[] phone = kim_phone.split("\\|");
%>


<html>
	<head>
		<title>�������</title>
		<script language=javascript>
		

		</script>
</head>
<body >
 <%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
				<div class="title">
					�������
				</div>
				
				<table cellSpacing="0">
					<tr>
						<th>��������</th>
						<th>�������</th>
					</tr>
					<tr>
						<td rowspan="<%=phone.length+1 %>" valign="top">
							<%=vphone_no %>
						</td>
					</tr>
						<% 
							for(int i = 0;i<phone.length;i++){
								String tdClass = "";
								if ((i + 1) % 2 == 1) {
								tdClass = "grey";
								}
						%>
					<tr>	
						<td align="center" class="<%=tdClass%>" nowrap="nowrap">
						<%=phone[i] %>
						</td>
					</tr>	
						<% 
							}
						%>
				</table>
			</div>
	    </form>
  <%@ include file="/npage/include/footer.jsp"%>
</body>	
</html>		