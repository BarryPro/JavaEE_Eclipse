<%
    /*************************************
    * ��  ��: ���Ų�Ʒ�첽�ӿڽ���״̬��ѯ g500
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: yanpx @ 2012-12-22
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName=WtcUtil.repNull((String)request.getParameter("opName"));
  String loginNo = (String)session.getAttribute("loginNo");
  String regCode = (String)session.getAttribute("regCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgId = (String)session.getAttribute("orgId");
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sG500Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="9">
	  <wtc:param value="<%=printAccept%>"/>
	  <wtc:param value="01"/>
	  <wtc:param value="<%=opCode%>"/>
	  <wtc:param value="<%=loginNo%>"/>
	  <wtc:param value=""/>
	  <wtc:param value="<%=phoneNo%>"/>
	  <wtc:param value="<%=%>"/>
	  <wtc:param value="<%=%>"/>
	</wtc:service>
	<wtc:array id="retList"  scope="end"/>
<%
    if("000000".equals(retCode)){
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
				  <th>�̻�����</th>
					<th>�û�ID</th>
					<th>����ʱ��</th>
					<th>�������ʱ��</th>
					<th>���ش���</th>
					<th>������Ϣ</th>
					<th>״̬</th>
					<th>��Ԫ</th>
					<th>��������</th>
				</tr>
<%
				if(retList.length==0){
					out.println("<tr height='25' align='center'><td colspan='8'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(retList.length>0){
					String tbclass = "";
					for(int i=0;i<retList.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
					<tr align="center" id="row_<%=i%>">
					  <td class="<%=tbclass%>"><%=retList[i][2]%></td>
					  <td class="<%=tbclass%>"><%=retList[i][3]%></td>
						<td class="<%=tbclass%>"><%=retList[i][4]%></td>
						<td class="<%=tbclass%>"><%=retList[i][5]%></td>
						<td class="<%=tbclass%>"><%=retList[i][0]%></td>
						<td class="<%=tbclass%>"><%=retList[i][1]%></td>
						<td class="<%=tbclass%>"><%=retList[i][6]%></td>
						<td class="<%=tbclass%>"><%=retList[i][8]%></td>
						<td class="<%=tbclass%>"><%=retList[i][7]%></td>
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