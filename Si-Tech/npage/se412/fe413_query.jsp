<%
/********************
 * version v2.0
 * ������: si-tech
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		
		String password = (String)session.getAttribute("password");		
		String regionCode= (String)session.getAttribute("regCode");
		String groupId= (String)session.getAttribute("groupId");
		
		String phoneNo = request.getParameter("phoneNo");
		String ykh_workNo = request.getParameter("ykh_workNo");
		String renzhengtype = request.getParameter("renzhengtype");
		String beginTimegd 	= request.getParameter("beginTimegd");
		String endTimegd = request.getParameter("endTimegd");
		String opCode 	= request.getParameter("opCode");
		%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
			<%
			String  inputParsm [] = new String[13];
			inputParsm[0] = "";
			inputParsm[1] = "";
			inputParsm[2] = opCode;
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";
			inputParsm[7] = "����"+workNo+"ִ���������������ѯ";
			inputParsm[8] = phoneNo;
			inputParsm[9] = ykh_workNo;
			inputParsm[10] = renzhengtype;
			inputParsm[11] = beginTimegd;
			inputParsm[12] = endTimegd;
			%>
					<wtc:service name="sE413Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="13">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
			  <wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"  />
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sE413Qry ���óɹ� ========"  + retCode + " | " + retMsg);
		%>
<body>
							<table >
							<tr >
								<th>Ԥ�����ֻ�����</th>
								<th>����״̬</th>
								<th>Ԥ��������</th>
								<th>ʵ�ʿ�������</th>
								<th>����״̬</th>
								<th>�������ɹ���</th>
								<th>��������ʱ��</th>
								<th>�������ʱ��</th>
							
							</tr>
							<%for(int i=0;i<result1.length;i++) {%>
							<tr> 
								<td><%=result1[i][0]%></td>
								<td><%if(result1[i][1].trim().equals("0")){out.print("δ����");}else{out.print("�ѿ���");}%></td>
								<td><%=result1[i][2]%></td>
								<td><%=result1[i][3]%></td>
								<td><%if(result1[i][4].trim().equals("1")){out.print("δ���");}else{out.print("�����");}%></td>
								<td><%=result1[i][5]%></td>
								<td><%=result1[i][6]%></td>
								<td><%=result1[i][7]%></td>
						  </tr>
						  <%}%>
						</talbe>
</body>
</html>
<%
	}
else {
		System.out.println(" ======== sE413Qry ����ʧ�� ========" + retCode + " | " + retMsg);
		%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode%>"+"<%=retMsg%>",0);	
					</script>
					<%
	}
%>