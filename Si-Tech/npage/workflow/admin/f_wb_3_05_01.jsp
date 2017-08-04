<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String login_no = (String)request.getParameter("login_no");
String group_id = (String)request.getParameter("group_id");
String wano = (String)request.getParameter("wano");
%>

	<wtc:pubselect name="sPubSelect" outnum="2">
					<wtc:sql>select a.login_no , a.login_name from dloginmsg a, dwsrolememb b where group_id = '?' and a.login_no<> '?' and a.login_no = b.login_no and b.role_code in( select assign_role from dwamsg where wa_no = '?' and assign_type = 0 union all select role_code from dwsrolememb c, dwamsg d where d.wa_no = '?' and d.assign_type = 1 and c.login_no = d.ASSIGN_LOGIN)</wtc:sql>
					<wtc:param value='<%=group_id%>'/>
					<wtc:param value='<%=login_no%>'/>
					<wtc:param value='<%=wano%>'/>
					<wtc:param value='<%=wano%>'/>
	</wtc:pubselect>

	<wtc:array id="ret"  start="0" length="2" scope='end' /> 

				<%
				if(retCode.equals("000000"))
				{
				%>
				<wtc:array id="ret"  start="0" length="2" scope='end' /> 
				
				<%
					out.println(JsonTool.toJson(ret));
				}
				else
				{
					out.println("");
				}
				%>