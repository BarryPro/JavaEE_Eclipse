<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e487":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"������ͨѶ����":opName;
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	
%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>
	
	<script>
		
		function addTemplate(){
			var path = "commun_add.jsp?opCode=<%=opCode%>";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
			
		//��ѯ
		function queryTemplate(){
			document.qrycommunFrm.submit();
		}
		
		function doProcess(packet)      
 		{
	       var opType = packet.data.findValueByName("opType"); 
	       var retCode = packet.data.findValueByName("retCode"); 
	       var retMsg = packet.data.findValueByName("retMsg"); 
	       var tempInfos = packet.data.findValueByName("tempInfos"); 
	      
	       if(opType=="delete"){
       			if(retCode=="000000"){
       				rdShowMessageDialog("ɾ���ɹ���",2);
       				queryTemplate();
       			}else{
       				rdShowMessageDialog("ɾ��ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       

		//�༭
		function editTemp(commun_seq){
			var path = "commun_add.jsp?opCode=<%=opCode%>&commun_seq="+commun_seq;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
			 
		}
		
		//ɾ��
		function delTemp(tempId){
			if(rdShowConfirmDialog("ȷ��Ҫɾ����")==1)
       		{
				var delPacket = new AJAXPacket("commun_op.jsp","����ִ��,���Ժ�...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("wkSeq", tempId);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		    }
			
		}
		
$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
	$("#wkCode").focus();
});
	</script>
	<body>
		
		<form name="qrycommunFrm" action="commun_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								������ͨѶ��ѯ
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">����������</td>
								<td class="blue"><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="wkCode" id="wkCode"/></td>
								<td class="blue">����������</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="wkName" id="wkName"/></td>
							</tr>
							<tr>
								<td class="blue">�Ƿ���Ч</td>
								<td class="blue">
									<select id="wkShow" name="wkShow">
										<option value="" selected>
											��ѡ��
										</option>
										<option value="0" >
											��
										</option>
										<option value="1">
											��
										</option>
									</select>
								</td>
								<td class="blue">&nbsp;</td>
								<td class="blue">&nbsp;</td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="��ѯ" onclick="queryTemplate()" />
									<input type="button" class="b_foot" value="����" onclick="addTemplate()" />
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								������ͨѶ��Ϣ�б�
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th>
									���������
								</th>
								<th>
									����������
								</th>
								<th>
									ͨѶ�ֶ�
								</th>
								<th>
									�Ƿ���Ч
								</th>
								<th>
									����
								</th>
							</tr>
							<%
								//�����ѯʱ����ȡ�ύ��ֵ��Ȼ����й��˲�ѯ
								String wkCode = request.getParameter("wkCode")==null?"":((String)request.getParameter("wkCode")).trim();
								String wkName = request.getParameter("wkName")==null?"":(request.getParameter("wkName")).trim();
								String wkShow = request.getParameter("wkShow")==null?"":(request.getParameter("wkShow")).trim();
								System.out.println("----------------wkCode--------------"+wkCode);
								String sql = "select to_char(seq),wkspace_code,wkspace_name,field,is_effect from dcommunicate where ";
								if(!"".equals(wkCode)){
									sql +=" wkspace_code='"+wkCode.trim() +"' and ";
								}
								if(!"".equals(wkName)){
									sql += " wkspace_name like '%"+wkName.trim()+"%' and ";
								}
								if(!"".equals(wkShow)){
									sql +=" is_effect='"+wkShow+"' and ";
								}
								sql+=" 1 = 1 ";
								//out.println(sql);
								
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="communList" scope="end"/>
							<%			
							
							if("000000".equals(retCode)){ 
								for(int i=0;i<communList.length;i++){
									%>
									<tr>
										<td class='blue'><%=communList[i][1]%></td>
										<td class='blue'><%=communList[i][2]%></td>
										<td class='blue'><%=communList[i][3]%></td>
										<td class='blue'><%="1".equals(communList[i][4])?"��":"��"%></td>
										<td class='blue'>
											<img src='<%=request.getContextPath()%>/images/ico_edit.gif'  onclick="editTemp('<%=communList[i][0]%>')" style='cursor:hand' alt='�޸�'/>&nbsp;&nbsp;&nbsp;
	               							<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='ɾ��' onclick="delTemp('<%=communList[i][0]%>')"/>
	               						</td>
	               					</tr>	
									<%
								}
							}
							%>		
						
						</table>					
					
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</body>
</html>
