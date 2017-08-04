<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String familyCode = request.getParameter("familyCode");
	String parentPhone = request.getParameter("parentPhone");
	String familyProdInfo = request.getParameter("familyProdInfo");
	
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
	
	<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode_updFaml" retmsg="retMsg1_updFaml" outnum="9">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=parentPhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="9"/>
		<wtc:param value="<%=familyCode%>"/>
		<wtc:param value="<%=familyProdInfo%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
	<%
	if("000000".equals(retCode_updFaml)){
		for(int i = 0 ; i < result0.length ; i ++){
	%>
			<tr>
				<input type="hidden" id="rolerow_<%=i%>" value="<%=i%>" />
				<input type="hidden" id="familyrole_<%=i%>" value="<%=result0[i][1]%>" />
				<input type="hidden" id="familyroleName_<%=i%>" value="<%=result0[i][2]%>" />
				<input type="hidden" id="memRoleId_<%=i%>" value="<%=result0[i][0]%>" />
				<input type="hidden" id="payType_<%=i%>" value="<%=result0[i][5]%>" />
				<input type="hidden" id="selectedMem_<%=i%>" value="<%=result0[i][6]%>" />
				<input type="hidden" id="memMaxNum_<%=i%>" value="<%=result0[i][3]%>" />
				<td><%=result0[i][2]%></td>
				<td><%=result0[i][3]%></td>
				<td><%=result0[i][4]%></td>
				<td>
					<%=result0[i][6]%>
				</td>
				<td><%=result0[i][5]%></td>
				<td>
					<input type="button" name="addRole<%=i%>" id="addRole<%=i%>" 
					 value="Ìí¼Ó" class="b_text" onclick="addRole(<%=i%>)" />
				</td>
			</tr>
	<%
		}
	}
	%>
<input type="hidden" id="retCode_updFaml" name="retCode_updFaml" value="<%=retCode_updFaml%>" />
<input type="hidden" id="retMsg1_updFaml" name="retMsg1_updFaml" value="<%=retMsg1_updFaml%>" />	