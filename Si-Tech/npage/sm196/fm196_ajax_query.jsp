<%
    /*************************************
    * ��  ��: �����ɼ���Ϣ��ѯ  m196
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2014/11/5
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String v_startTime = WtcUtil.repStr(request.getParameter("startTime"), "");
	String v_endTime = WtcUtil.repStr(request.getParameter("endTime"), "");
	String idIccid = WtcUtil.repStr(request.getParameter("idIccid"), "");
	String operNo = WtcUtil.repStr(request.getParameter("operNo"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String opNote = workNo+"������"+opCode+"[���������ѯ]����";
	String startTime = v_startTime + "000000";
	String endTime = v_endTime + "000000";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="sM196Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="9">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opNote%>"/>
		<wtc:param value="<%=idIccid%>"/>
		<wtc:param value="<%=operNo%>"/>
		<wtc:param value="<%=startTime%>"/>
		<wtc:param value="<%=endTime%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�����ɼ���Ϣ��ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>�ͻ�����</th>
					<th>֤������</th>
					<th>֤����ַ</th>
					<th>��֤���</th>
					<th>��֤��ͨ������</th>
					<th>��֤�����������</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='6'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
%>
					<tr align="center" id="row_<%=i%>">
						<td><%=ret[i][1]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][3]%></td>
						<td><%=ret[i][5]%></td>
						<td><%if("".equals(ret[i][6])){%>��<%}else{%><%=ret[i][6]%><%}%></td>
						<td><%if("".equals(ret[i][7])){%>��<%}else{%><%=ret[i][7]%><%}%></td>
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