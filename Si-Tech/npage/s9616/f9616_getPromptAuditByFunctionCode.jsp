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
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
		/**��Ҫ�������.�������ҳ��,��ɾ��**/
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "9616";
 		String opName = "��˼�¼��ѯ";

		/**��ҪregionCode���������·��**/
		ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arrSession.get(0);
		String orgCode = baseInfo[0][16];
		String regionCode = orgCode.substring(0,2);
		String groupId = baseInfo[0][21];
		String workNo = baseInfo[0][2];
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
											+" login_accept, b.audit_flag_name,login_name"
											+" FROM dpromptaudit a,sauditflag b,dloginmsg c"
											+" WHERE audit_accept = '"+create_accept+"'"
											+" and a.audit_flag = b.audit_flag"
											+" and a.audit_login = c.login_no";
		System.out.println("#######getInfoSql322->"+getInfoSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="8"> 
		<wtc:sql><%=getInfoSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%	
System.out.println("#######getInfoSql322->"+getInfoSql);
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
	<!--����css-->
	<link href="/css/jl.css" rel="stylesheet" type="text/css">
</head>
<body bgColor=#FFFFFF leftmargin="0" topmargin="0px" background="/images/jl_background_2.gif">
	<div id="Operation_Table">
     <table  bgcolor="#FFFFFF" width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
			<tr bgcolor='649ECC' height=25 align="center">
				<td nowrap>ѡ��</td>
				<td nowrap>������ˮ</td>
				<td nowrap>�Ƿ�ͨ��</td> 
				<th nowrap>��������</th>
				<th nowrap>������</th>
				<td nowrap>���ʱ��</td> 
				<td nowrap>������</td>
				<td nowrap>�Ƿ������</td> 
				<td nowrap>�����˲�����ˮ</td>
				<td nowrap>audit_flag</td>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr bgcolor='#EEEEEE' height='25' align='center'><td colspan='11'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				for(int i=0;i<sVerifyTypeArr.length;i++){
	%>
						<tr bgcolor="E8E8E8" align="center">
							<td>
								<input type="radio" name="regionRadio" id="regionRadio" value="<%=sVerifyTypeArr[i][3]%>" onclick="doChange()">	
							</td>
							<td><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td>
								<%
								System.out.println("===========sVerifyTypeArr[i][5]"+sVerifyTypeArr[i][5]);
									if (sVerifyTypeArr[i][5].equals("��"))
									{
											if (sVerifyTypeArr[i][1].equals("Y"))
											{
												out.println("���ͨ��");
											}
										else
											{
												out.println("��˲�ͨ��");
											}
									}
								else
									{
											out.println("�����11");
									}
								%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 	</div>
</body>
</html>    

