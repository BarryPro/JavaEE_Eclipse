<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ע�����������-��ѯ������Ϣ
�� * �汾: v3.0
�� * ����: 2008-10-14
�� * ����: zhanghonga
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="com.sitech.boss.util.page.*"%>		
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
 		String opCode = "9614";
 		String opName = "ע�����������";

		String regionCode  = (String)session.getAttribute("regCode");

		String sAuditAccept = WtcUtil.repNull(request.getParameter("sAuditAccept"));
		String release_action = WtcUtil.repNull(request.getParameter("release_action"));
		String IsNotCreateLoginModify = WtcUtil.repNull(request.getParameter("IsNotCreateLoginModify"));
		
		//������ˮ,�鿴�����Ƿ���ָ���������������Ĺ���
		String isAuditValidSql = "select audit_login from dPromptAudit where audit_accept = '"+sAuditAccept+"'";
	%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=isAuditValidSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>		
	<%
		
		
		String getRegionSql = "";
		getRegionSql = "SELECT distinct b.function_name, c.bill_name, d.prompt_name, a.prompt_seq,"
							       +" f.group_name,"
							       +" DECODE (a.release_action,"
			               +" 1, '����',"
			               +" 2, 'ɾ��',"
			               +" 3, '����',"
			               +" a.release_action"
				             +"),"
							       +" a.prompt_content, decode(a.valid_flag,'Y','��Ч','N','��Ч',a.valid_flag), a.create_login, a.create_time,"
							       +" a.create_accept, a.valid_time, a.invalid_time, a.modify_login,"
							       +" a.modify_time, a.modify_accept,"
							       +" DECODE (a.is_print,"
							               +" 1, '��ʾ',"
							               +" 2, '��ӡ',"
							               +" 3, '��ӡ����ʾ',"
							               +" a.is_print"
							               +"),"
							               +" DECODE (a.valid_flag, 'Y', '��Ч', 'N', '��Ч', a.valid_flag)	,   "
							               +" g.Channels_Name   "
							  +" FROM sfuncpromptaudit a,"
							       +" sfunccode b,"
							       +" sprintbilltype c,"
							       +" sfuncprompttype d,"
							       +" dchngroupmsg f ,"
							       +" sChannelsCode g"
							 +" WHERE a.function_code = b.function_code"
							   +" AND a.bill_type = c.bill_type"
							   +" AND a.prompt_type = d.prompt_type"
								 +" and f.GROUP_ID = a.modify_group"
								 +" and g.Channels_Code = a.Channels_Code";

		if(release_action.equals("1")){
			getRegionSql += " and a.create_accept = "+sAuditAccept;
		}else
			{
				getRegionSql += " and a.modify_accept = '"+sAuditAccept+"'";
			}
		
		System.out.println(getRegionSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="19"> 
		<wtc:sql><%=getRegionSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			//���ӵ��Ȩ��,���������Ĺ��ܲ�����ʾ����
			onload=function(){
				parent.document.all.sAuditAccept.value="<%=sAuditAccept%>";
				parent.document.getElementById("oprAuditTable").style.display = "block";
			}
			
			
			//������,�ݲ�ɾ��.
			function doChange(oprInfoCheckBox){
				var oprInfoCheckBoxs = document.getElementsByName("oprInfoCheckBox");	
				var impValue="";
				
				if(oprInfoCheckBox.checked==true){
						impValue = oprInfoCheckBox.value;
						for(var j=0;j<oprInfoCheckBoxs.length;j++){
							if(oprInfoCheckBoxs[j].value==impValue){
								oprInfoCheckBoxs[j].checked=true;	
							}
						}
						
						parent.document.all.sAuditAccept.value=impValue;
						parent.document.getElementById("oprAuditTable").style.display = "block";						
				}
				
				if(oprInfoCheckBox.checked==false){
						impValue = oprInfoCheckBox.value;
						for(var j=0;j<oprInfoCheckBoxs.length;j++){
							if(oprInfoCheckBoxs[j].value==impValue){
								oprInfoCheckBoxs[j].checked=false;	
							}
						}
						
						parent.document.all.sAuditAccept.value="";
						parent.document.getElementById("oprAuditTable").style.display = "none";		
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<th nowrap>����������ˮ</th>
				<th nowrap>��������</th>
				<th nowrap>ģ������</th> 
				<th nowrap>Ʊ������</th>  
				<th nowrap>��ʾ����</th>
				<th nowrap>��ʾ���</th>
				<th nowrap>��������</th>
				<th nowrap>��ӡѡ��</th>
				<th nowrap>��Ч��־</th>
				<th nowrap>��������</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=sAuditAccept%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][16]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][17]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][18]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 	</div>
</body>
</html>    


