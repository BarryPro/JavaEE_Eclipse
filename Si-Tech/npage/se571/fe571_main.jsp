<%
  /*
   * ����: e571����ʡר�߲�Ʒ����״̬�б��ѯ
   * �汾: 1.0
   * ����: 20120220
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	String opCode = "e571";
	String opName = "��ʡר�߲�Ʒ����״̬�б��ѯ";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String chanceId = request.getParameter("chanceId");
	
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 0 = 0");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 1 = 01");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 2 = e571");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 3 = " + workNo);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 4 = " + password);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 5 = ");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 6 = ");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 7 = " + chanceId);
%>
	<wtc:service name="se571Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="e571"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=chanceId%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%
	if (!"000000".equals(retCode1)) {
		%>
		<script language="javascript">
			rdShowMessageDialog("se571Qry��ѯ����<%=retCode1%>, <%=retMsg1%>", 1);
		</script>
		<%
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>��ʡר�߲�Ʒ����״̬�б��ѯ</title>
<script type=text/javascript>

</script>

</head>
<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ʡר�߲�Ʒ����״̬�б��ѯ</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">���̻����</td>
		<td width="70%">
			<%=chanceId%>
		</td>
	</tr>
</table>
<table>
	<tr>
		<th>�̻����</th>
		<th>��Ʒ������</th>
		<th>��Ʒ������ϵ����</th>
		<th>��Ʒ������</th>
		<th>��Ʒ������ϵ����</th>
		<th>��Ʒ����״̬</th>
		<th>����ʱ��</th>
	</tr>
	<%
	if ("000000".equals(retCode1) && result1.length > 0) {
		for (int i = 0; i < result1.length; i ++) {
			%>
			<tr>
				<td><%="".equals(result1[i][0]) ? "��" : result1[i][0]%></td>
				<td><%="".equals(result1[i][1]) ? "��" : result1[i][1]%></td>
				<td><%="".equals(result1[i][2]) ? "��" : result1[i][2]%></td>
				<td><%="".equals(result1[i][3]) ? "��" : result1[i][3]%></td>
				<td><%="".equals(result1[i][4]) ? "��" : result1[i][4]%></td>
				<td>
					<%
					if ("".equals(result1[i][5].trim())) {
						out.print("��");
					} else if ("0".equals(result1[i][5].trim())) {
						out.print("��ʼ��");
					} else if ("1".equals(result1[i][5].trim())) {
						out.print("�������粿ʩ��");
					} else if ("2".equals(result1[i][5].trim())) {
						out.print("���粿ʩ����");
					} else if ("3".equals(result1[i][5].trim())) {
						out.print("ʩ�����");
					} else if ("4".equals(result1[i][5].trim())) {
						out.print("��������");
					} else if ("5".equals(result1[i][5].trim())) {
						out.print("��ȡ����");
					} else if ("6".equals(result1[i][5].trim())) {
						out.print("��������");
					} else if ("7".equals(result1[i][5].trim())) {
						out.print("��ͨ��");
					} else if ("8".equals(result1[i][5].trim())) {
						out.print("�ѿ�ͨ");
					} else if ("9".equals(result1[i][5].trim())) {
						out.print("��ȡ��");
					} else {
						out.print("δ֪״̬");
					}
					%>
				</td>
				<td><%="".equals(result1[i][6]) ? "��" : result1[i][6]%></td>
			</tr>
			<%
		}
	}
	%>
</table>

<table>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onclick="window.location='fe571.jsp'">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onclick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>