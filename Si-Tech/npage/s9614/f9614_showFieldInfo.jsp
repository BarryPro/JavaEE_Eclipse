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
		
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 10;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;
		
		String sAuditAccept = WtcUtil.repNull(request.getParameter("sAuditAccept2"));
		String release_action = WtcUtil.repNull(request.getParameter("release_action"));
		String IsNotCreateLoginModify = WtcUtil.repNull(request.getParameter("IsNotCreateLoginModify"));
		
		String getRegionSql = "";
		getRegionSql =" SELECT distinct  decode(a.release_action, 1, a.create_accept, a.modify_accept), e.GROUP_NAME,decode(c.function_name,null,'���й���', c.function_name), d.BILL_NAME, "
							      +" f.PROMPT_NAME,a.prompt_seq,"
							      +" DECODE (a.is_print,"
							      +" 1, '��ʾ',"
							      +" 2, '��ӡ',"
							      +" 3, '��ӡ����ʾ',"
							      +" a.is_print"
							      +" ),"
							      +" DECODE (a.release_action,"
							      +" 1, '����',"
							      +" 2, 'ɾ��',"
							      +" 3, '����',"
							      +" a.release_action"
							      +" ),"
							      +" DECODE (a.valid_flag, 'Y', '��Ч', 'N', '��Ч', a.valid_flag)	   "
							  +" FROM sdomainpromptaudit a,"
							  +" sfunccode c,"
							  +" sprintbilltype d,"
							  +" dchngroupmsg e,"
							  +" sfuncprompttype f"
							  +" WHERE "
							  +" a.op_code = c.function_code(+)"
							  +" and d.BILL_TYPE = a.BILL_TYPE"
						   +" and e.GROUP_ID = a.modify_group";
	
		getRegionSql +=" and f.PROMPT_TYPE = a.PROMPT_TYPE";
							  
		if("1".equals(release_action)){
			getRegionSql +=" and create_accept = '"+sAuditAccept.trim()+"'";
		}else
			{
				getRegionSql +=" and modify_accept = '"+sAuditAccept.trim()+"'";
			}
		
		System.out.println("11############getRegionSql->"+getRegionSql);
		
		String sqlStr0  = "SELECT count(*) from (" + getRegionSql + ")"; 
		String sqlStr1 = "select * from (select row_.*,rownum id from (" + getRegionSql + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; 

%>

		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=sqlStr0%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="allNumArr"  scope="end"/> 
			
		<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="10"> 
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%		


		int totalNum = allNumArr.length>0?Integer.parseInt(allNumArr[0][0]):0;
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
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
						
						parent.document.all.sAuditAccept2.value=impValue;
						parent.document.getElementById("oprAuditTable2").style.display = "block";						
				}
				
				if(oprInfoCheckBox.checked==false){
						impValue = oprInfoCheckBox.value;
						for(var j=0;j<oprInfoCheckBoxs.length;j++){
							if(oprInfoCheckBoxs[j].value==impValue){
								oprInfoCheckBoxs[j].checked=false;	
							}
						}
						
						parent.document.all.sAuditAccept2.value="";
						parent.document.getElementById("oprAuditTable2").style.display = "none";		
				}
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr align="center">
				<!--<td nowrap>ѡ��</td>-->
				<th nowrap>����������ˮ</th>
				<th nowrap>��������</th>
				<th nowrap>ģ������</th> 
				<th nowrap>Ʊ������</th>
				<th nowrap>��ʾ����</th>
				<th nowrap>��ʾ���</th>
				<th nowrap>��ӡѡ��</th>
				<th nowrap>��������</th>
				<th nowrap>��Ч��־</th>
			</tr> 
	<%
			if(sVerifyTypeArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='13'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(sVerifyTypeArr.length>0){
				String tbclass = "";
				for(int i=0;i<sVerifyTypeArr.length;i++){
						tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][1]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][2]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][3]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][4]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][5]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][6]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][7]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=sVerifyTypeArr[i][8]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
		<tr align="right">
			<td colspan="20" style="background:#E6E6E6">
			  <div style="position:relative;font-size:12px;">
						<%	
						   int iQuantity = totalNum;
						   Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						   PageView view = new PageView(request,out,pg); 
						   view.setVisible(true,true,0,0);       
						%>	
				</div>	
			</td>	
		</tr>
  </table>
 	</div>
</body>
</html>    



