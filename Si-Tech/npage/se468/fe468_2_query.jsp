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
		
		String groupId=request.getParameter("groupid");
		String kehujlxingm = request.getParameter("kehujlxingm");
		String kehujlhaom = request.getParameter("kehujlhaom");
		String kehudanwei = request.getParameter("kehudanwei");
		String opCode 	= request.getParameter("opCode");
System.out.println("--------------------������������������������������---------------------"+groupId);
			String  inputParsm [] = new String[12];
			inputParsm[0] = "0";
			inputParsm[1] = "01";
			inputParsm[2] = opCode;
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = "";
			inputParsm[6] = "";
			inputParsm[7] = "����"+workNo+"ִ���������Ƚ���ͻ������ѯ";
			inputParsm[8] = groupId;
			inputParsm[9] = kehudanwei;
			inputParsm[10] = kehujlxingm;
			inputParsm[11] = kehujlhaom;

			%>
					<wtc:service name="sE468Qry" routerKey="region" routerValue="<%=regionCode%>"
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
		</wtc:service>
		<wtc:array id="result1" scope="end"  />
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sE413Qry ���óɹ� ========"  + retCode + " | " + retMsg);
		%>
<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�ͻ���Ϣ��ѯ�б�</div>
			</div>

							<table >
							<tr >
								<th>����</th>
								<th>���أ�Ӫ������</th>
								<th>�ֻ�����</th>
								<th>�ͻ�����</th>
								<th>�ͻ���λ</th>
								<th>�ͻ���������</th>
								<th>�ͻ��������</th>
								<th>��������</th>
								<th>��������</th>
								<th></th>
							
							</tr>
							<%for(int i=0;i<result1.length;i++) {%>
							<tr> 
								<td><%=result1[i][0]%></td>
								<td><%=result1[i][1]%></td>
								<td><%=result1[i][2]%></td>
								<td><%=result1[i][3]%></td>
								<td><%=result1[i][4]%></td>
								<td><%=result1[i][5]%></td>
								<td><%=result1[i][6]%></td>
								<td><%=result1[i][7]%></td>
								<td><%=result1[i][8]%></td>
									
								<td><input class="b_text" type="button" name="" value="ɾ��" onclick="tests1(<%=result1[i][2].trim()%>)" ></td>
						  </tr>
						  <%}%>
						</talbe>
					</div>
				</div>
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