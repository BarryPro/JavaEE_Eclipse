<%
   /*
   * ����: ע��������޸�-��ѯ��������Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *
   * ʹ�ô�ҳ��ǰ,���Ȳ鿴ҵ���߼��Ƿ���ȷ
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
 		String opCode = "9607";
 		String opName = "ע��������޸�";

		String groupId = (String)session.getAttribute("groupId");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		
		
		String getAuditLoginSql = "";
		
		/**�����ʡ������,�������Լ������Լ�**/
		if(groupId.equals("10014")){
			getAuditLoginSql = "select login_no,login_name from dLoginMsg where group_id = '10014'";
		}else{
		
	 		getAuditLoginSql = "select login_no, login_name "
															 +" from dLoginMsg"
															 +" where login_no in"
															+" ("
															+" select a.login_no"
															            +" from sLoginPdomRelation a, sPopedomCode b"
															            +" where a.POPEDOM_CODE = b.POPEDOM_CODE"
															            +" and   b.PDT_CODE in ('03','05')"
															            +" and   a.end_date  >  sysdate"
															            +" and   b.REFLECT_CODE = '9614'"
															/*
															            +" union"
															+" select b.login_no"
																+" from sRolePdomRelation a, sLoginRoalRelation b,  sPopedomCode c"
																+" where  a.role_code = b.role_code" 
																+" and    a.POPEDOM_CODE = c.POPEDOM_CODE"
																+" and    c.REFLECT_CODE = '9614'"
																+" and    b.end_date > sysdate"
																*/
															+" )"
															+" and substr(login_no,1,1) between  'a' and  'm'"
															+" and group_id = ("
															+" select group_id from dChnGroupMsg where group_id" 
															 +" in (select parent_group_id from dChnGroupInfo  where group_id = '"+groupId+"' )"
															 +" and ROOT_DISTANCE = 2)";
															 
		}
	System.out.println("1111="+getAuditLoginSql);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=getAuditLoginSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%		
		int totalNum = sVerifyTypeArr.length;
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			//**���iframe����Ӧ��С������**/
			onload = function(){
				parent.document.getElementById('sAuditLoginInfoFrame').style.height=parent.document.sAuditLoginInfoFrame.document.body.scrollHeight+'px';	
			}
		
			//**��ѡ��ѡ�л���ȡ������Ҫ�¼�**/
			function doChange(thisRadio){
				var auditLoginChecks = document.getElementsByName("auditLoginCheck");	
				var impCodeStr = "";
				var impNameStr = "";
				var regionLength = 0;
				for(var i=0;i<auditLoginChecks.length;i++){
					if(auditLoginChecks[i].checked){
						var impValue = auditLoginChecks[i].value;
						var impArr = impValue.split("|");
						if(regionLength==0){
							impCodeStr = impArr[0];
							impNameStr = impArr[0]+" "+impArr[1];
						}
						regionLength++;
						if(regionLength>5){
							rdShowMessageDialog("���ֻ��ѡ��5��������!");
							thisRadio.checked = false;
							break;
						}else{
							if(regionLength>1){
								impCodeStr += (","+impArr[0]);
								impNameStr += (","+impArr[0]+" "+impArr[1]);
							}	
						}
					}
				}
				
				//��ҳ�洫ֵ
				parent.document.all.sAuditLogins.value = impCodeStr;
				
				//�ø����ڵĸ����ڵ�"�ύ�޸�"��ť����
				parent.parent.document.all.confirmButton.disabled = false;
				//alert(impCodeStr);
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th width="15%" nowrap>ѡ��</th>
				<th width="35%" nowrap>�����˹���</th>
				<th nowrap>����������</th> 
			</tr> 
	<%
			if(totalNum==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(totalNum>0){
				String tbclass = "";
				for(int i=0;i<totalNum;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="checkbox" name="auditLoginCheck" value="<%=sVerifyTypeArr[i][0]%>|<%=sVerifyTypeArr[i][1]%>" onclick="doChange(this)">	
							</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
			<tr bgcolor="gray" height="20" align="center">
				<td colspan="3" nowrap>(ע:�����ѡ��5�������,������Ҫѡ��1�������)</td>
			</tr> 
  </table>
</div>
</body>
</html>    
