<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e490":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"ҵ���򵼹���":opName;
	
	String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����

	String orgCode =  (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	
%>

	<head>
		<title><%=opName%></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	
	<script language="javascript" type="text/javascript" src="/njs/si/autocomplete.js"></script>
	<script language="javascript" type="text/javascript" src="/njs/si/common.js"></script>

	</head>
	
	<script>
		$(document).ready(function(){
	$("select").width("150");
	$("input[type='text']").width("150");
});
	
		//����ҵ����
		function addGuide(){
			var path = "busiguide_add.jsp";
			var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			 
			if(typeof(retInfo)=="undefined")      
    		{   
    			return false;   
    		}
    		if(retInfo){//���سɹ���������²�ѯҳ��
    			queryGuide();
    		}
		}
			
		//����ģ��
		function addTemp(){
				var path = "template_add.jsp";
				var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
		
		
		//ģ�����
		function tempManage(){
				var path = "template_manage.jsp";
				window.open(path,"","height=450, width=800,top=150,left=300,scrollbars=yes, resizable=no,location=no, status=yes");	
				//var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			
		}
		//��ѯ
		function queryGuide(){
			document.qrybusiguideFrm.submit();
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
       				queryGuide();
       			}else{
       				rdShowMessageDialog("ɾ��ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
       				return false;
       			}
       			
       	   }
       }
       

		//�༭
		function editGuide(busiguide_seq){
			var path = "busiguide_add.jsp?busiguide_seq="+busiguide_seq;
			var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");			 
			if(typeof(retInfo)=="undefined")      
    		{   
    			return false;   
    		}
    		if(retInfo){//���سɹ���������²�ѯҳ��
    			queryGuide();
    		}
		}
		
		//ɾ��
		function delGuide(tempId){
			if(rdShowConfirmDialog("ȷ��Ҫɾ����")==1)
       		{
						var delPacket = new AJAXPacket("busiguide_op.jsp","����ִ��,���Ժ�...");
		      	delPacket.data.add("opType", "delete");
		      	delPacket.data.add("busiguide_seq", tempId);
		      	core.ajax.sendPacket(delPacket,doProcess,true);
		      	delPacket = null; 
		    }
			
		}
		
		function showStep(busiguide_seq){
				var path = "busiguide_showstep.jsp?busiguide_seq="+busiguide_seq;
				//window.open(path);
				var retInfo = window.showModalDialog(path,"","dialogWidth:25;dialogHeight:25;");	
		}
		
	</script>
	<body>
		
		<form name="qrybusiguideFrm" action="busiguide_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								ҵ���򵼲�ѯ
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">����ҵ��</td>
								<td class="blue">
									<input type="text" name="guideCode" id="guideCode"/>
								</td>
								<td class="blue">������</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="tempName" id="tempName"/></td>
							</tr>
							<tr>
								<td class="blue">�Ƿ�����</td>
								<td class="blue">
									<select id="is_effect" name="is_effect">
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
									<input type="button" class="b_foot" value="��ѯ" onclick="queryGuide()" />
									<input type="button" class="b_foot" value="������" onclick="addGuide()" />
									<input type="button" class="b_foot" value="����ģ��" onclick="addTemp()" />
									<input type="button" class="b_foot" value="ģ�����" onclick="tempManage()" />
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								ҵ�����б�˫��Ԥ�����裩
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th>
									����ҵ��
								</th>
								<th>
									������
								</th>
								<th>
									��������
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
								String guideCode = request.getParameter("guideCode")==null?"":((String)request.getParameter("guideCode")).trim();
								String tempName = request.getParameter("tempName")==null?"":(request.getParameter("tempName")).trim();
								String is_effect = request.getParameter("is_effect")==null?"":(request.getParameter("is_effect")).trim();
								
								String sql = " select to_char(a.seq),a.template_id,trim(b.function_name)||'['||trim(a.op_code)||']' function_name,a.detail,a.is_effect,to_char(a.op_time,'yyyy-mm-dd hh24:mi:ss'), "+
														 " (select to_char(count(*)) from dbusiguidetemp where template_id = a.template_id) step from dbusiguidemsg a,sfunccodenew b where ";
								if(!"".equals(guideCode)){
									sql +=" a.op_code='"+guideCode.trim() +"' and ";
								}
								if(!"".equals(tempName)){
									sql += " a.detail like '%"+tempName.trim()+"%' and ";
								}
								if(!"".equals(is_effect)){
									sql +=" is_effect='"+is_effect+"' and ";
								}
								sql+=" a.op_code=b.function_code order by a.op_time desc";
								//out.println(sql);
								
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="7" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="busiguideList" scope="end"/>
							<%			
							System.out.println("---------"+retCode);
							if("000000".equals(retCode)){ 
								for(int i=0;i<busiguideList.length;i++){
									%>
									<tr ondblclick="showStep('<%=busiguideList[i][0]%>')" style="cursor: pointer;">
										<td class='blue'><%=busiguideList[i][2]%></td>
										<td class='blue'><%=busiguideList[i][3]%></td>
										<td class='blue'><%=busiguideList[i][6]%></td>
										<td class='blue'><%="1".equals(busiguideList[i][4])?"��":"��"%></td>
										<td class='blue'>
											<img src='<%=request.getContextPath()%>/images/ico_edit.gif'  onclick="editGuide('<%=busiguideList[i][0]%>')" style='cursor:hand' alt='�޸�'/>&nbsp;&nbsp;&nbsp;
	               							<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='ɾ��' onclick="delGuide('<%=busiguideList[i][0]%>')"/>
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
