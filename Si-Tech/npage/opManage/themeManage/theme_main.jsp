<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String opCode = request.getParameter("opCode");
	opCode = (opCode==null||"".equals(opCode))?"e485":opCode;
	String opName = request.getParameter("opName");
	opName = (opName==null||"".equals(opName))?"�������":opName;
	
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
			$("#tCode").focus();
	$("select").width("150");
	$("input[type='text']").width("150");
});
		function addTemplate(){
			var path = "theme_add.jsp";
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
			
		//��ѯ
		function queryTemplate(){
			document.qrythemeFrm.submit();
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
       
        //��ɫ����
	    function roleManage(){
	    	var path = "theme_role.jsp";	
	    	// window.open(path);
			window.open(path,"","dialogWidth:55;dialogHeight:40;scroll:no;");
		}
		
		//�༭
		function editTemp(theme_css){
			var path = "theme_add.jsp?theme_css="+theme_css;
			var retInfo = window.open(path,"","dialogWidth:45;dialogHeight:35;");			 
		}
		
		//ɾ��
		function delTemp(tempId,mRole,isDefault){
				if(rdShowConfirmDialog("ȷ��Ҫɾ������ģ����")==1)
	       		{
					var delPacket = new AJAXPacket("theme_op.jsp","����ִ��,���Ժ�...");
			      	delPacket.data.add("opType", "delete");
			      	delPacket.data.add("tCode", tempId);
			      	delPacket.data.add("mRole", mRole);
			      	core.ajax.sendPacket(delPacket,doProcess,true);
			      	delPacket = null; 
			    }
		}
		
		function delTempMod(layoutId){
			if(rdShowConfirmDialog("ȷ��Ҫɾ������ģ����")==1)
	       		{
					var delPacket = new AJAXPacket("/npage/opManage/delModCfm.jsp","����ִ��,���Ժ�...");
			      	delPacket.data.add("layoutId", layoutId);
			      	delPacket.data.add("delType", "t");
			      	core.ajax.sendPacket(delPacket,doDelTempMod,true);
			      	delPacket = null; 
			    }
		}
		
		function doDelTempMod(packet){
	       var retCode = packet.data.findValueByName("code"); 
	       var retMsg = packet.data.findValueByName("msg"); 
	       if(retCode=="000000"){
       				rdShowMessageDialog("ɾ���ɹ���",2);
       				location=location;
       			}else{
       				rdShowMessageDialog("ɾ��ʧ��!<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
       				return false;
       			}
		}
	</script>
	<body>
		
		<form name="qrythemeFrm" action="theme_main.jsp" method=post>
			<%@ include file="/npage/include/header_mop.jsp"%>
			
					<div class="title"> 
							<div id="title_zi">
								�����ѯ
							</div>
					</div>
						<table cellspacing="0">
							<tr>
								<td class="blue">������</td>
								<td class="blue"><input type="text"  v_must=1 v_type="string" v_maxlength="20" name="tCode" id="tCode"/></td>
								<td class="blue">��������</td>
								<td class="blue"><input type="text" v_must=1 v_type="string" v_maxlength="20" name="tName" id="tName"/></td>
							</tr>
							<tr>
								<td class="blue">�Ƿ񷢲�</td>
								<td class="blue">
									<select id="tShow" name="tShow">
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
								<td class="blue">����̨��ɫ</td>
								<td class="blue">
									<input type="text"  name="mrole" id="mrole"/></td>
							</tr>
							<tr>
								<td class="blue" colspan="4" style="text-align:center">
									<input type="button" class="b_foot" value="��ѯ" onclick="queryTemplate()" />
									<input type="button" class="b_foot" value="����" onclick="addTemplate()" />
									<input type="button" class="b_foot_long"  value="��ɫȨ�޹���" onclick="roleManage()" />
								</td>
							</tr>
						</table>
					</div>
					<div id="Operation_Table">
					<div class="title">
							<div id="title_zi">
								����ģ���б�
							</div>
						</div>
						
						<table cellspacing="0" >
							<th width="20%">
									����ģ����
								</th>
								<th width="20%">
									����ģ������
								</th>
								<th width="20%">
									�Ƿ񷢲�
								</th>
								<th width="20%">
									�汾��
								</th>
								<th width="20%">
									����
								</th>
								<%
								String tCode = request.getParameter("tCode")==null?"":((String)request.getParameter("tCode")).trim();
								String tName = request.getParameter("tName")==null?"":(request.getParameter("tName")).trim();
								String tShow = request.getParameter("tShow")==null?"":(request.getParameter("tShow")).trim();
								String mrole = request.getParameter("mrole")==null?"":(request.getParameter("mrole")).trim();
								int  the = 0;
								String sqlTheMode = "select a.theme_css,a.theme_name,a.is_effect,a.version from dthememsg a where";
								if(!"".equals(tCode)){
									the++;
									sqlTheMode +=" a.theme_css='"+tCode +"' and ";
								}
								if(!"".equals(tName)){
									the++;
									sqlTheMode += " a.theme_name like '%"+tName+"%' and ";
								}
								if(!"".equals(tShow)){
									the++;
									sqlTheMode +=" a.is_effect='"+tShow+"' and ";
								}
								if(the==0){
									sqlTheMode = "select a.theme_css,a.theme_name,a.is_effect,a.version from dthememsg a ";
								}else{
									sqlTheMode +="1=1";
								}
								//out.println("-----------sqlTheMode---------------"+sqlTheMode);
								%>
								
	<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=sqlTheMode%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_th" scope="end"/>
		
		<%
		String outStr = "";
		for(int ih=0;ih<result_th.length;ih++){
		 	outStr += "<tr>";
			outStr += "<td class='blue'>"+result_th[ih][0]+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][1]+"</td>";
			outStr += "<td class='blue'>"+("0".equals(result_th[ih][2])?"��":"��")+"</td>";
			outStr += "<td class='blue'>"+result_th[ih][3]+"</td>";
			outStr += "<td><img src='/images/ico_edit.gif'    onclick=\"editTemp('"+result_th[ih][0]+"')\" style='cursor:hand' alt='�޸�'/>&nbsp;&nbsp;&nbsp;"+
	               		  "<img src='/images/ico_delete.gif'  style='cursor:hand' alt='ɾ��' onclick=\"delTempMod('"+result_th[ih][0]+"')\"/>"+
						"</td>";
		 	outStr += "</tr>";
		}
		 
		 out.print(outStr);
		%>
						</table>
					</div>
					<div id="Operation_Table">
						<div class="title">
							<div id="title_zi">
								����̨��ɫ�����б�
							</div>
						</div>
						<table id="mTable" cellspacing="0">
							<tr>
								<th width="20%">
									������
								</th>
								<th width="20%">
									��������
								</th>
								<th width="20%">
									����̨��ɫ
								</th>
								 
								<th width="20%">
									�Ƿ�Ĭ��
								</th>
								<th width="20%">
									����
								</th>
							</tr>
							<%
								//�����ѯʱ����ȡ�ύ��ֵ��Ȼ����й��˲�ѯ
																
								String sql = "select a.theme_css, a.theme_name, a.is_effect, b.is_default ,b.op_role from dthememsg a, dthemerole_rel b where a.IS_EFFECT='1' and ";
								
								/*
								if(!"".equals(tCode)){
									sql +=" a.theme_css='"+tCode +"' and ";
								}
								if(!"".equals(tName)){
									sql += " a.theme_name like '%"+tName+"%' and ";
								}
								if(!"".equals(tShow)){
									sql +=" a.is_effect='"+tShow+"' and ";
								}
								*/
								sql+=" a.theme_css = b.theme_css and b.op_role like '%"+mrole+"%'";
			
							%>
								
							<wtc:service name="TlsPubSelCrm" outnum="5" routerKey="region" routerValue="<%=regionCode %>">
								<wtc:param value="<%=sql%>" />
							</wtc:service>
							<wtc:array id="themeList" scope="end"/>
							<%			
							
							if("000000".equals(retCode)){ 
								for(int i=0;i<themeList.length;i++){
									%>
									<tr>
										<td class='blue'><%=themeList[i][0]%></td>
										<td class='blue'><%=themeList[i][1]%></td>
										<td class='blue'><%=themeList[i][4]%></td>
										<td class='blue'><%="1".equals(themeList[i][3])?"��":"��"%></td>
										<td class='blue'>
	               			<img src='<%=request.getContextPath()%>/images/ico_delete.gif'  style='cursor:hand' alt='ɾ��' onclick="delTemp('<%=themeList[i][0]%>','<%=themeList[i][4]%>','<%=themeList[i][3]%>')"/>
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
