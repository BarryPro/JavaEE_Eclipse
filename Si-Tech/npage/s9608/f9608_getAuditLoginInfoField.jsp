<%
   /*
   * ����: ע�����������-��ѯ��������Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-10
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="java.util.ArrayList" %>
<%
 		String opCode = "9605";
 		String opName = "ע�����������";

		String groupId = (String)session.getAttribute("groupId");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		String getAuditLoginSql = "";
		String createLoginNo = WtcUtil.repNull(request.getParameter("createLoginNo"));
		
		String checkSql = "select root_distance from dloginmsg a,dchngroupmsg b where a.login_no = '"+workNo+"' and a.group_id = b.group_id";
		
		%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����createLoginRootDistance���жϹ���Ȩ������**/
		int createLoginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				createLoginRootDistance = sVerifyTypeArr[0][0].equals("")?createLoginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		
		if(createLoginRootDistance==1)
		{
		getAuditLoginSql = "select login_no, login_name "
															 +" from dLoginMsg"
															 +" where login_no in"
															+" ("
															+" select a.login_no"
															            +" from sLoginPdomRelation a, sPopedomCode b"
															            +" where a.POPEDOM_CODE = b.POPEDOM_CODE"
															            +" and   b.PDT_CODE in ('03','05')"
															            +" and   a.end_date  >  sysdate"
															            +" and   b.reflect_code ='9614' "
															+" )"
															+" and (substr(login_no,1,1) between  'a' and  'm' OR substr(login_no,1,1) like '2%')"
															+" and group_id = '10014'";
		}
	else 
		{
		getAuditLoginSql = "select login_no, login_name "
															 +" from dLoginMsg"
															 +" where login_no in"
															+" ("
															+" select a.login_no"
															            +" from sLoginPdomRelation a, sPopedomCode b"
															            +" where a.POPEDOM_CODE = b.POPEDOM_CODE"
															            +" and   b.PDT_CODE in ('03','05')"
															            +" and   a.end_date  >  sysdate"
															            +" and   b.reflect_code ='9614' "
															+" )"
															+" and (substr(login_no,1,1) between  'a' and  'm' OR substr(login_no,1,1) like '2%')"
															+" and group_id = ("
															+" select group_id from dChnGroupMsg where group_id" 
															 +" in (select parent_group_id from dChnGroupInfo  where group_id = '"+groupId+"' )"
															 +" and ROOT_DISTANCE = 2)";
		}
		
	/*zhangyan add */	
	String accountType=(String)session.getAttribute("accountType");
	if ( accountType.equals("2") )
	{
		getAuditLoginSql=  "SELECT login_no, login_name	"
			+"  FROM dLoginMsg	"
			+" WHERE login_no IN	"
			+"          (SELECT a.login_no	"
			+"             FROM sLoginPdomRelation a, sPopedomCode b	"
			+"            WHERE     a.POPEDOM_CODE = b.POPEDOM_CODE	"
			+"                  AND b.PDT_CODE IN ('03', '05')	"
			+"                  AND a.end_date > SYSDATE	"
			+"                  AND b.reflect_code = '9614')	"
			+"       AND GROUP_ID = (SELECT GROUP_ID	"
			+"                         FROM dChnGroupMsg	"
			+"                        WHERE GROUP_ID IN (SELECT parent_group_id	"
			+"                                             FROM dChnGroupInfo	"
			+"                                            WHERE GROUP_ID = '"+groupId+"')	"
			+"                              AND ROOT_DISTANCE = 4)	";	

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
				parent.document.getElementById('sAuditLoginInfoFrame2').style.height=parent.document.sAuditLoginInfoFrame2.document.body.scrollHeight+'px';	
				parent.parent.document.all.qryFieldInfoFrame.style.height = parent.parent.document.qryFieldInfoFrame.document.body.scrollHeight+'px';	
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
				//alert(impCodeStr);
			}
		//-->
	</script>
</head>
<body>
		<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th width="15%" nowrap>ѡ��</td>
				<th width="35%" nowrap>�����˹���</td>
				<th nowrap>����������</td> 
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
				<td colspan="3" nowrap><font class="orange">(ע:�����ѡ��5�������,������Ҫѡ��1�������)</font></td>
			</tr> 
  </table>
</div>
</body>
</html>    
