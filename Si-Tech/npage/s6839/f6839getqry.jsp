<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ��ʵ���û����ÿͻ���Ϣ����
�� * �汾: 1.0
�� * ����: 2009-10-28
�� * ����: gaolw
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		String opCode = "6839";
		String opName = "��ʵ���û����ÿͻ���Ϣ����";
		
		/**��ҪregionCode���������·��**/
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		
		String tPhoneNo = WtcUtil.repNull(request.getParameter("tPhoneNo2"));
		
		String sql = " SELECT A.PHONE_NO,to_char(A.CUST_ID),to_char(A.ID_NO),A.CUST_NAME,"+
		             " decode(A.ID_TYPE,0,'���֤',1,'����֤',2,'���ڲ�',3,'�۰�ͨ��֤',4,'����֤',5,'̨��ͨ��֤',6,'���������',7,'����',8,'Ӫҵִ��',9,'����'),A.ID_ICCID,A.ID_ADDRESS,A.CONTACT_PHONE,A.CONTACT_EMAILL,to_char(A.LOGIN_ACCEPT),A.LOGIN_NO,to_char(A.OP_TIME,'yyyy-MM-dd hh24:mi:ss')   "+ 
		             " FROM DCUSTREALDOC A,DCUSTMSG B WHERE A.ID_NO=B.ID_NO AND A.PHONE_NO=:phoneno";
		
		String [] paraIn = new String[2];
  		paraIn[0] = sql;
  		paraIn[1] = "phoneno="+tPhoneNo;
%>
		<wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />
 
<%
		//System.out.println("retCode===="+retCode1);
		//System.out.println("retMsg===="+retMsg1);
%>

<html>
<head>
<title><%=opName%></title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<script language="javascript">
<!--

//-->
</script>
</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0" id="tabList">
			<tr align="center">
				<th nowrap>�ֻ�����</th>
				<th nowrap>�û�ID</th>
				<th nowrap>�ͻ�ID</th> 
				<th nowrap>�ͻ�����</th>
				<th nowrap>֤������</th>
				<th nowrap>֤������</th>
				<th nowrap>��ϵ�绰</th>
				<th nowrap>��������</th>
				<th nowrap>��ϵ��ַ</th>
				<th nowrap>������ˮ</th>
				<th nowrap>��������</th>
				<th nowrap>��������</th>
			</tr> 
<%
			if(result.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='9'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
				
			}else if(result.length>0)
			{
				for(int i=0;i<result.length;i++)
				{
%>
					<tr align="center">
						<td nowrap><%=result[i][0]%>&nbsp;</td>
						<td nowrap><%=result[i][2]%>&nbsp;</td>
						<td nowrap><%=result[i][1]%>&nbsp;</td>
						<td nowrap><%=result[i][3]%>&nbsp;</td>
						<td nowrap><%=result[i][4]%>&nbsp;</td>
						<td nowrap><%=result[i][5]%>&nbsp;</td>
						<td nowrap><%=result[i][7]%>&nbsp;</td>
						<td nowrap><%=result[i][8]%>&nbsp;</td>
						<td><%=result[i][6]%>&nbsp;</td>	
						<td nowrap><%=result[i][9]%>&nbsp;</td>
						<td nowrap><%=result[i][10]%>&nbsp;</td>
						<td nowrap><%=result[i][11]%>&nbsp;</td>		
<%				
				}
			}
%>
 		</table>
  	</div>
</body>
</html>