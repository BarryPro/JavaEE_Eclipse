<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String opCode = "g982";
    String opName = "�ʷ����ն˷���Ŀ���û����� ";
    String workno = (String)session.getAttribute("workNo");
	String nopass =(String)session.getAttribute("password");
	String ipAddr =(String)session.getAttribute("ipAddr");
	String phone_brand = WtcUtil.repStr(request.getParameter("phone_brand"), "");
	String phone_type = WtcUtil.repStr(request.getParameter("phone_type"), "");
	String regionCode = (String)session.getAttribute("regCode");
	String regionCode1 = WtcUtil.repStr(request.getParameter("region_code"), "");
	String remark = "����Ա��"+workno+"�������ʷ����ն˷���Ŀ���û������ѯ";
%>

	<wtc:service name="sg982Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="8" >
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value="q"/>   <%/*������ʶ q ��ѯ 0 ���� 1 ɾ��*/%>
		<wtc:param value="<%=phone_brand%>"/>
		<wtc:param value="<%=phone_type%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=regionCode1%>"/> <%/*���д��� ɾ����ֵ*/%>
	</wtc:service>
	<wtc:array id="ret" scope="end" />
<%
    if("000000".equals(retCode)){
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>����</th>
					<th>Ʒ��</th>
					<th>����</th>
					<th>��ʼʱ��</th>
					<th>����ʱ��</th>
					<th>�ɹ�����</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='6'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length > 0){
					for(int i=0;i<ret.length;i++){
					
					
%>
					<tr align="center" id="row_<%=i%>">
						<td><%=ret[i][0]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][4]%></td>
						<td><%=ret[i][5]%></td>
						<td><%=ret[i][6]%></td>
						<td><%=ret[i][7]%></td>
					</tr>
<%
					}
				}
%>
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />