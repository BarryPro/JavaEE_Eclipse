<%
  /*
   * ����: ���������֤��ѯ g688
   * �汾: 1.0
   * ����: 2012/5/20
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
	String opName = WtcUtil.repStr(request.getParameter("opName"), ""); 
	String idIccid = WtcUtil.repStr(request.getParameter("idIccid"), ""); //���֤����
  String regCode = (String)session.getAttribute("regCode");
  String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
  String password=WtcUtil.repNull((String)session.getAttribute("password"));
  String notes = workNo+"������"+opName;
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sG688Qry" routerKey="region" routerValue="<%=regCode%>" 
		retcode="retCode" retmsg="retMsg" outnum="4">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=notes%>"/>
		<wtc:param value="<%=idIccid%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">���������֤��ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>�绰����</th>
					<th>������������</th>
					<th>����ʱ��</th>
					<th>Ӫҵ������</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='4'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
					<tr align="center" id="row_<%=i%>">
						<td class="<%=tbclass%>"><%=ret[i][0]%></td>
						<td class="<%=tbclass%>"><%=ret[i][1]%></td>
						<td class="<%=tbclass%>"><%=ret[i][2]%></td>
						<td class="<%=tbclass%>"><%=ret[i][3]%></td>
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