<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode = (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag = "";
	
		String bianhao = request.getParameter("bianhao");
		String cus_pass = request.getParameter("cus_pass");
		String opnote = workNo + "����g610��ϸ��Ϣ��ѯ";

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
		routerValue="<%=regionCode%>"  id="loginAccept" />
		
	<wtc:service name="sg529InfoQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="60">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="g610"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=cus_pass%>"/>
		<wtc:param value="<%=opnote%>"/>
		<wtc:param value="<%=bianhao%>"/>
	</wtc:service>
	<wtc:array id="dcust3" scope="end" />

<body>
  <div id="Main">
	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi">��ѯ��Ϣ</div>
		</div>
<%
			if(retCode2.equals("000000")) {
			   if(dcust3.length>0) {
			   for(int i=0;i<dcust3.length; i++) {
%>
			<table>
				<tr>
	    <td class="blue" width="15%">���Ŷ�����</td>
	    <td><%=dcust3[i][0]%></td> 
	    <td width="15%" class="blue">�������󷽱�ʶ</td>
	    <td><%=dcust3[i][1]%></td>
	    <td width="15%" class="blue">������������</td>
	    <td><%=dcust3[i][2]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">����ʱ��</td>
	    <td><%=dcust3[i][3]%></td>
	    <td width="15%" class="blue">�ͻ�����</td>
	    <td><%=dcust3[i][4]%></td>
	    <td width="15%" class="blue">֤������</td>
	    <td><%=dcust3[i][5]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">֤������</td>
	    <td><%=dcust3[i][6]%></td>
	    <td width="15%" class="blue">���Ź���ʡ</td>
	    <td><%=dcust3[i][7]%></td>
	    <td width="15%" class="blue">���Ź�������</td>
	    <td><%=dcust3[i][8]%></td>
		</tr>
		<tr>
	    <td class="blue" width="15%">�ջ�����������</td>
	    <td><%=dcust3[i][9]%></td>
	    <td width="15%" class="blue">��ϵ�绰</td>
	    <td><%=dcust3[i][10]%></td>
	    <td width="15%" class="blue">�̶��绰</td>
	    <td><%=dcust3[i][11]%></td>
		</tr>
	
		<tr>
	    <td class="blue" width="15%">�ͻ���ַ</td>
	    <td><%=dcust3[i][12]%></td>
	    <td width="15%" class="blue">�ջ���ʡ������</td>
	    <td><%=dcust3[i][13]%></td>
	    <td width="15%" class="blue">�ջ��˵�������</td>
	    <td><%=dcust3[i][14]%></td>
		</tr>

		<tr>
	    <td class="blue" width="15%">�ջ�����������</td>
	    <td><%=dcust3[i][15]%></td>
	    <td width="15%" class="blue">��������</td>
	    <td><%=dcust3[i][16]%></td>
	    <td width="15%" class="blue">����ʱ��Ҫ��</td>
	    <td>
	    	<%if ("1".equals(dcust3[i][17])){
	    				out.write("ֻ�������ͻ���˫���ա����ղ��ͻ���");
	    		} else if ("2".equals(dcust3[i][17])){
	    				out.write("˫���ա������ͻ��������ղ��ͻ���");
	    		} else if ("3".equals(dcust3[i][17])){
	    				out.write("�����ա�˫��������վ����ͻ�");
	    		} %></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">�ײͱ���</td>
	    <td><%=dcust3[i][18]%></td>
	    <td width="15%" class="blue">�ײ�����</td>
	    <td><%=dcust3[i][19]%></td>
	    <td width="15%" class="blue">Ԥ���</td>
	    <td><%=dcust3[i][20]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">֧����ˮ</td>
	    <td><%=dcust3[i][21]%></td>
	    <td width="15%" class="blue">֧��ʱ��</td>
	    <td><%=dcust3[i][22]%></td>
	    <td width="15%" class="blue">֧������</td>
	    <td><%=dcust3[i][23]%></td>
		</tr>
		
		<tr>
	    <td class="blue" width="15%">�ֻ�֧������</td>
	    <td><%=dcust3[i][24]%></td>
	    <td width="15%" class="blue">��������</td>
	    <td><%=dcust3[i][25]%></td>
	    <td width="15%" class="blue">֤����ַ</td>
	    <td><%=dcust3[i][26]%></td>
		</tr>
				<tr height='25' align='center'><td colspan='6'>
					<input class="b_foot" name=close  onClick="window.close()" type=button value="�ر�" />
					</td>
				</tr>
					 
			</table>
<%
		    }
		 	}else {
%>
			<table >					
				<tr height='25' align='center'><td colspan='6'>��ѯ��ϢΪ�գ�</td></tr>
			</table>
<%
			}}else {
%>
			<script language="JavaScript">
			  rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
			</script>
<%
			}
%>
		</div>
	</div>
</body>
</html>
