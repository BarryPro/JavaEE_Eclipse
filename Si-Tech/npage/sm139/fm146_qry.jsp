<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String PhoneNo = request.getParameter("PhoneNo");
		String opCode = request.getParameter("opCode");
		String workPwd = (String)session.getAttribute("password");
		String beizhu=workNo+"�Ժ���"+PhoneNo+"���в�ѯ";

/*System.out.println("--wanghyd"+begin_time2);
  System.out.println("--wanghyd"+end_time2);
*/
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
		
     <wtc:service name="sm146Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="14">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=PhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=beizhu%>"/
	</wtc:service>
        <wtc:array id="dcust2" scope="end" />
<%
/*System.out.println("--wanghyd"+dcust2.length);*/
%>

<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ѯ��Ϣ</div>
			</div>

							<table name="qryInfo" id="qryInfo">
									<tr >
								<th>�ֻ�����</th>						
								<th>ҵ������</th>
							<th>���ʱ��</th>
							<th>��ݵ���</th>
							<th>������˾����</th>
							<th>SIM����</th>
							<th>�ײ���Ϣ</th>
							<th>������Ϣ</th>
							<th>���״̬</th>
							<th>ҵ��״̬</th>
							<th>����ʱ��</th>
		
							
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   for(int i=0;i<dcust2.length; i++) {
							   System.out.println("@@@@@@@@@@m146" + dcust2[i][12]);
							%>
							<tr align="center" id="row_<%=i%>"> 
								<td ><%=dcust2[i][0]%></td>
								<td><%if(dcust2[i][1].equals("0")){out.print("����������");}else {out.print("����");}%></td>
								<td ><%=dcust2[i][2]%></td>
								<td ><%=dcust2[i][3]%></td>
								<td ><%=dcust2[i][4]%></td>
								<td ><%=dcust2[i][5]%></td>
								<td >
									<%if("0".equals(dcust2[i][8])){
										out.print("58Ԫ");
									}else if("1".equals(dcust2[i][8])){
										out.print("88Ԫ");
									}else if("2".equals(dcust2[i][8])){
										out.print("30Ԫ������");
									}
									%>
								</td>
								<td ><%=dcust2[i][9]%>&nbsp;&nbsp;<%=dcust2[i][10]%>&nbsp;&nbsp;<%=dcust2[i][11]%></td>
								<td >
									<%if(dcust2[i][6].equals("0")){
										out.print("���ͨ��");
										}else if(dcust2[i][6].equals("1")){
											out.print("���δͨ��");
											out.print("<br/>");
											out.print(dcust2[i][12]);
										}else if(dcust2[i][6].equals("")){
											out.print("δ���");
										}else if(dcust2[i][6].equals("2")){
											out.print("�Ѽ���");
										}%>
								</td>
								<td ><%=dcust2[i][7]%></td>
								<td ><%=dcust2[i][13]%></td>

						  </tr>
						  		<%
		    }%>
		    <tr> 
					<td align="center" id="footer" colspan="11"> 
						<input type="button" name="expBtn"  class="b_foot" value="����" onclick="printTable(qryInfo)">
					</td>
				</tr>
		    <%}
		  else {
		%>
		<tr height='25' align='center'><td colspan='8'>��ѯ��ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<%
	}%>
						</table>
						
					</div>
				</div>
</body>
</html>
