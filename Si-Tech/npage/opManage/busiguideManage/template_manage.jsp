<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"8207":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"ҵ���򵼹���":opName;
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	
%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>
	
	<script>
			$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
	
		//����ģ��
		function addTemp(){
				var path = "template_add.jsp";
				var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
		
		
		//ģ�����
		function tempManage(){
				var path = "template_manage.jsp";
				var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			
		}
		//��ѯ
		function queryTemp(){
			document.qryTempFrm.submit();
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
       				queryTemp();
       			}else{
       				rdShowMessageDialog("ɾ��ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       

		//�༭
		function editTemp(template_id){
			var path = "template_add.jsp?template_id="+template_id;
			var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			 
			if(typeof(retInfo)=="undefined")      
    		{   
    			return false;   
    		}
    		if(retInfo){//���سɹ���������²�ѯҳ��
    			queryTemp();
    		}
		}
		
		//ɾ��
		function delTemp(tempId){
			if(rdShowConfirmDialog("ɾ��ģ���Ѷ�Ӧ����ɾ����ȷ��Ҫɾ����")==1)
      {
						var delPacket = new AJAXPacket("template_op.jsp","����ִ��,���Ժ�...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("template_id", tempId);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		  }
			
		}
		
		function showStep(template_id){
				var path = "busiguide_showstep.jsp?template_id="+template_id;
				//alert(path);
				//window.open(path);
				var retInfo = window.showModalDialog(path,"","dialogWidth:15;dialogHeight:25;");	
		}
	</script>
	<body>
		
		<form name="qryTempFrm" action="template_manage.jsp" method=post>
				<%@ include file="/npage/include/header_pop.jsp" %>
			
					<div class="title"> 
							<div id="title_zi">
								ҵ����ģ���ѯ
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">ģ��ID</td>
								<td class="blue"><input type="text"  name="temp_id" id="temp_id"/></td>
								<td class="blue">ģ������</td>
								<td class="blue"><input type="text" name="temp_name" id="temp_name"/></td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="��ѯ" onclick="queryTemp()" />	
									<input type="button" class="b_foot" value="����ģ��" onclick="addTemp()" />
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								��ģ���б�˫��Ԥ�����裩
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th>
									ģ��ID
								</th>
								<th>
									ģ������
								</th>
								<th>
									��������
								</th>
								<th>
									����
								</th>
							</tr>
							<%
								//�����ѯʱ����ȡ�ύ��ֵ��Ȼ����й��˲�ѯ
								String temp_id = request.getParameter("temp_id")==null?"":((String)request.getParameter("temp_id")).trim();
								String temp_name = request.getParameter("temp_name")==null?"":(request.getParameter("temp_name")).trim();
																
								String sql = " select a.template_id,a.template_name,(select to_char(count(*)) from  dbusiguidetemp where template_id=a.template_id) stepcount from  dbusiguidetemp a where ";
								if(!"".equals(temp_id)){
									sql +=" a.template_id='"+temp_id.trim() +"' and ";
								}
								if(!"".equals(temp_name)){
									sql += " a.template_name like '%"+temp_name.trim()+"%' and ";
								}
	
								sql+=" 1=1 group by a.template_id,a.template_name ";
								System.out.println(sql);
								
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="templateList" scope="end"/>
							<%			
							System.out.println("---------"+retCode);
							if("000000".equals(retCode)){ 
								for(int i=0;i<templateList.length;i++){
									%>
									<tr ondblclick="showStep('<%=templateList[i][0]%>')" style="cursor: pointer;">
										<td class='blue'><%=templateList[i][0]%></td>
										<td class='blue'><%=templateList[i][1]%></td>
										<td class='blue'><%=templateList[i][2]%></td>
										<td class='blue'>
											<img src='<%=request.getContextPath()%>/images/ico_edit.gif'  onclick="editTemp('<%=templateList[i][0]%>')" style='cursor:hand' alt='�޸�'/>&nbsp;&nbsp;&nbsp;
	               							<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='ɾ��' onclick="delTemp('<%=templateList[i][0]%>')"/>
	               						</td>
	               					</tr>	
									<%
								}
							}
							%>		
						
						</table>					
					
				<%@ include file="/npage/include/footer_pop.jsp" %>
		</form>
	</body>
</html>
