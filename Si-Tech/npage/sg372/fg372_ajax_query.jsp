<%
    /*************************************
    * ��  ��: �ֻ�Ǯ��Ӧ�����ؼ���ͨ��ѯ g372
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-12-20
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
  String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String opName = WtcUtil.repStr(request.getParameter("opName"), "");
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String orgCode=WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
%>
	<wtc:service name="s451dSnd" routerKey="regionCode" routerValue="<%=regCode%>" 	retcode="retCode" retmsg="retMsg" outnum="9">
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=phoneNo%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("0000".equals(retCode)){
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�ֻ�Ǯ��Ӧ�����ؼ���ͨ��ѯ</div>
			</div>
			<table cellspacing="0" name="t1" id="t1"  border="1"  width="200"  style="word-break:break-all;word-wrap:break-word">
			  <%
			    if(ret.length>0){
			  %>
			  <tr>
					<th>�ֻ�����</th>
					<td colspan="2"><%=ret[0][1]%></td>
					<th>SEID</th>
					<td colspan="2"><%=ret[0][2]%></td>
				</tr>
				<%
				  }
				%>
				<tr>
					<th width="150">���</th>
					<th width="150">Ӧ������</th>
					<th width="150">���ذ�װ����</th>
					<th width="150">Ӧ���ṩ��</th>
					<th width="150">Ӧ�����</th>
					<th width="150">������Ϣ��Ӧ���˺ŵȣ�</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='3'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
%>
					<tr align="center" id="row">
						<td width="16.6%"><%=i%></td>
						<td width="16.6%"><%=ret[i][4]%></td>
						<td width="16.6%"><%=ret[i][5]%></td>
						<td width="16.6%"><%=ret[i][6]%></td>
						<td width="16.6%"><%=ret[i][7]%></td>
						<td width="16.6%"><%=ret[i][8]%></td>
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
