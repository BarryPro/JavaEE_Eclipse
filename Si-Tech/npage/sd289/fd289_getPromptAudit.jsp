<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ��˼�¼��ѯ-���ݽ����ѯ��Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: yangrq
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "d289";
 		String opName = "���Ѷ�����˼�¼��ѯ";

		/**��ҪregionCode���������·��**/
		String regionCode  = (String)session.getAttribute("regCode");
		
		
		/** 
		 	*@inparam			audit_accept ������ˮ
			*@inparam			op_time_begin      ����ʱ�䣨����ʱ�䡢���޸�ʱ�䣩
			*@inparam			op_time_end      ����ʱ�䣨����ʱ�䡢���޸�ʱ�䣩
			*@inparam			op_code      ��������
			*@inparam			bill_type    Ʊ������
			*@inparam			prompt_type  ��ʾ����
			*@inparam			login_no     �����˹��ţ��������ˡ��޸��ˡ�ɾ���ˣ�
		 **/
		String create_accept = WtcUtil.repNull(request.getParameter("create_accept"));
		String getInfoSql = "SELECT audit_accept, is_pass, "
											+"  audit_login, change_audit_date,"
											+"  decode(audit_suggestion,'NULL','��',audit_suggestion), "
											+" decode(is_audit,'Y','��','N','��',is_audit), "
											+" login_accept, b.audit_flag_name"
											+" FROM dpromptaudit a,sauditflag b"
											+" WHERE audit_accept = '"+create_accept+"'"
											+" and a.audit_flag = b.audit_flag";
		System.out.println("#######getInfoSql322->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="8"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
System.out.println("11sVerifyTypeArr.length=" + sVerifyTypeArr.length);	
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			/*function doChange(){
				var regionRadios = document.getElementById("regionRadio");	
				if(regionRadios.checked){
					alert(regionRadios.checked)
					var radioValue = regionRadios.value;
					parent.document.getElementById("qryFieldAuditInfoFrame").style.display = "block";
					parent.document.qryFieldAuditInfoFrame.location = "f9616_getPromptAuditByClassCode.jsp?create_accept="+radioValue;
				}
			}*/
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>������ˮ</th>
				<th nowrap>�Ƿ�ͨ��</th> 
				<th nowrap>������</th>
				<th nowrap>���ʱ��</th> 
				<th nowrap>������</th>
				<th nowrap>�Ƿ������</th> 
				<th nowrap>�����˲�����ˮ</th>
				<th nowrap>�������</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>">
								<%
								System.out.println("===========sVerifyTypeArr[i][5]"+sVerifyTypeArr[i][5]);
									if (sVerifyTypeArr[i][5].equals("��"))
									{
										if (sVerifyTypeArr[i][1].equals("Y"))
										{
											out.print("���ͨ��");
										}
									else
										{
											out.print("��˲�ͨ��");
										}
									}
								else
									{
											out.print("�����");
									}
								%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 	</div>
</body>
</html>    

