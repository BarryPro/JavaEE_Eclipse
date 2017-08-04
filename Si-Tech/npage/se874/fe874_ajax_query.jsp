<%
    /*************************************
    * ��  ��: �������ܿز�ѯ e874
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-6-7
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String startTime = WtcUtil.repStr(request.getParameter("startTime"), "");
	String endTime = WtcUtil.repStr(request.getParameter("endTime"), "");
	String region_code = WtcUtil.repStr(request.getParameter("region_code"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="se874Qry" routerKey="region" routerValue="<%=regCode%>" 
		retcode="retCode" retmsg="retMsg" outnum="11">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=region_code%>"/> 
		<wtc:param value="<%=startTime%>"/>
		<wtc:param value="<%=endTime%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
System.out.println("---e874------diling------------region_code="+region_code);
System.out.println("---e874------diling------------retCode="+retCode);
    if("000000".equals(retCode)){
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�������ܿز�ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>���д���</th>
					<th>��������</th>
					<th>ͨѶ�ͻ���</th>
					<th>�������û���</th>
					<th>Ŀǰռ��</th>
					<th>����ռ��</th>
					<th>�������������Ա��</th>
					<%
					  if(!"00".equals(region_code)){
					%>
    					<th>����ʱ��</th>
    				  <th>��������</th>
    				  <th>��������</th>
    				  <th>����˵��</th>
					<%  
					 }else{
					%>
					    <th>����</th>
					<%
					 }
					%>
					
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='11'>");
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
						<td class="<%=tbclass%>"><%=ret[i][4]%>%</td>
						
						<%
						  if("00".equals(region_code)){/*diling update for ���ѡ������Ϊ��������������ռ�ȿ��޸�@2012/8/27*/
						%>
						    <td class="<%=tbclass%>">
						      <input type="text" id="limitRatio<%=i%>" name="limitRatio<%=i%>" value="<%=ret[i][5]%>%" size="7" class="InputGrey" readonly="true" />  
						    </td>
						<%
						  }else{
						%>
						    <td class="<%=tbclass%>"><%=ret[i][5]%>%</td>
						<%
						  }
						%>
						<td class="<%=tbclass%>"><%=ret[i][6]%></td>
						<%
					  if(!"00".equals(region_code)){/*diling update for ���ѡ������Ϊ����������չʾ������@2012/8/27*/
					  %>
  						<td class="<%=tbclass%>"><%=ret[i][7]%></td>
  						<td class="<%=tbclass%>"><%=ret[i][8]%></td>
  						<td class="<%=tbclass%>"><%=ret[i][9]%></td>
  						<td class="<%=tbclass%>"><%=ret[i][10]%></td>
						<%
					  }else{/*diling update for ���ѡ������Ϊ���������ɶ�����ռ�Ƚ����޸�@2012/8/27*/
					  %>
					    <td class="<%=tbclass%>"><input class="b_text" type="button" id="uptBtn<%=i%>" name="uptBtn<%=i%>" value="�޸�" onClick="chgMsg(this,'<%=ret[i][0]%>')" /></td>
					  <%
					  }
						%>
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