<%
  /*
   * ����: m255����ʡ�мۿ���¼Ͷ�ߵ��� 
   * �汾: 1.0
   * ����: 2015/4/6 
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String operateNo = WtcUtil.repStr(request.getParameter("operateNo"), "");
	String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
	String password = (String)session.getAttribute("password");
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="sm256zjQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="12">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=operateNo%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    System.out.println("diling---ret.length="+ret.length);
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1" vColorTr='set'>
				<tr>
					<th>�ͻ�����</th>
					<th>�ͻ��绰</th>
					<th>��������</th>
					<th>������ˮ</th>
					<th>����ʱ��</th>
					<th>Ͷ�ߵ���</th>
					<th>����</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='7'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
%>
					<tr align="center" id="row_<%=i%>">
						<td><%=ret[i][3]%></td>
						<td><%=ret[i][4]%></td>
						<td><%=ret[i][0]%></td>
						<td><%=ret[i][2]%></td>
						<td><%=ret[i][1]%></td>
						<td><input type="text" id="orderNo" name="orderNo" value="" maxlength="20" /><font class="orange">*</font></td>
						<td><input type="button" id="subBtn" name="subBtn" class="b_foot" value="ȷ��" onClick="subInfo(this)" /></td>
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