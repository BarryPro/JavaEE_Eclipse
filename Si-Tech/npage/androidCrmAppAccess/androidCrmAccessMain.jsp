<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2013-12-6 13:59:00
********************/
%>
              
<%
		String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	String regionCode = (String)session.getAttribute("regCode");
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
$(document).ready(function(){
});

//�����
function delBond(imeiNo){
      if(rdShowConfirmDialog('ȷ�Ͻ���ð󶨹�ϵô��')!=1) return;
	var packet = new AJAXPacket("androidCrmAccessDelBondCfm.jsp","����ִ��,���Ժ�...");
			packet.data.add("imeiNo",imeiNo);
			packet.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(packet,doDelBond);
			packet = null; 
}
function doDelBond(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("���ɹ�",2);
		qryFunc();
	}else{
		rdShowMessageDialog("����ʧ��"+code+"��"+msg,0);
	}
}

//ɾ����¼
function del(imeiNo){
      if(rdShowConfirmDialog('ȷ��ɾ�������ն˼�¼��')!=1) return;
	var packet = new AJAXPacket("androidCrmAccessDelCfm.jsp","����ִ��,���Ժ�...");
			packet.data.add("imeiNo",imeiNo);
			packet.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(packet,doDel);
			packet = null; 
}
function doDel(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("ɾ���ɹ�",2);
		qryFunc();
	}else{
		rdShowMessageDialog("����ʧ��"+code+"��"+msg,0);
	}
}

function addFunc(){
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("��ѡ����֯�ڵ�");
			return;
	}

	window.location = "androidCrmAccessAdd.jsp?opCode=<%=opCode%>&opName=<%=opName%>&input_group_name="+$("#input_group_name").val()+"&input_group_id="+$("#input_group_id").val();
} 

function addFuncP(){
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("��ѡ����֯�ڵ�");
			return;
	}
 
	window.location = "androidCrmAccessAdd_P.jsp?opCode=<%=opCode%>&opName=<%=opName%>&input_group_name="+$("#input_group_name").val()+"&input_group_id="+$("#input_group_id").val();
}

function selGroupid(){
	var path = "common/grouptree.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
function retGroupInfo(retGroupId,retGroupName){
	$("#input_group_name").val(retGroupName);
	$("#input_group_id").val(retGroupId);
	if(typeof(retGroupId)!="undefined"&&retGroupId.trim()!=""){
		qryFunc();
	}
}
//�޸�
function upd(imeiNo,astatus,bDate,eDate,bTime,eTime,custName,phoneNo){
	//alert("imeiNo = "+imeiNo+"\n"+"astatus = "+astatus+"\n"+"bDate = "+bDate+"\n"+"eDate = "+eDate+"\n"+"bTime = "+bTime+"\n"+"eTime = "+eTime);
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("��ѡ����֯�ڵ�");
			return;
	}
	var h=400;
	var w=880;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var gourl = "androidCrmAccessUpd.jsp?opCode=<%=opCode%>"+
																			"&input_group_name="+$("#input_group_name").val()+
																			"&imeiNo="+imeiNo+
																			"&astatus="+astatus+
																			"&bDate="+bDate+
																			"&eDate="+eDate+
																			"&bTime="+bTime+
																			"&eTime="+eTime+
																			"&custName="+custName+
																			"&phoneNo="+phoneNo+
																			"&input_group_id="+$("#input_group_id").val();
	var ret=window.showModalDialog(gourl,"",prop);
	if(typeof(ret)!="undefined"){
		if(ret=="2"){
			//��ӳɹ��������б�
			qryFunc();
		}
	}
	
}

//��ѯ��Ȩ�б�
function qryFunc(){
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("��ѡ����֯�ڵ�");
			return;
	}
	
	var packet = new AJAXPacket("androidCrmAccessList.jsp","����ִ��,���Ժ�...");
			packet.data.add("input_group_id",$("#input_group_id").val());
			packet.data.add("imeiNo",$("#imeiNo").val().trim());
			core.ajax.sendPacket(packet,doQryFunc);
			packet = null; 
}

function doQryFunc(packet){
	var code = packet.data.findValueByName("code"); 
	var msg  = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		var retArray  = packet.data.findValueByName("retArray"); 
		$("#accesMainTab tr:gt(0)").remove();
		var trObjdStr = "";
		var dataStr = "";
		for(var i=0;i<retArray.length;i++){
			 if(retArray[i][3]=="1970-01-01"&&retArray[i][4]=="1970-01-01"){
			 	dataStr = "������";
			 }else{
			 	dataStr = retArray[i][3]+"--"+retArray[i][4];
			 }
			 var disablStr = "";
			 if(retArray[i][10]==""){
			 		disablStr = "disabled='true'";
			 }else{
			 		disablStr = "";
			 }
			trObjdStr += "<tr>"+
									 "<td>"+retArray[i][0]+"</td>"+
									 "<td>"+retArray[i][11]+"</td>"+
									 "<td>"+retArray[i][9]+"</td>"+
									 "<td>"+retArray[i][2]+"</td>"+
									 "<td>"+dataStr+"</td>"+
									 "<td>"+retArray[i][5]+"--"+retArray[i][6]+"</td>"+
									 "<td>"+retArray[i][7]+"</td>"+
									 "<td>"+
									 		"<input type='button' class='b_text' value='�޸�' onclick='upd(\""+retArray[i][0]+"\",\""+retArray[i][2]+"\",\""+retArray[i][3]+"\",\""+retArray[i][4]+"\",\""+retArray[i][5]+"\",\""+retArray[i][6]+"\",\""+retArray[i][9]+"\",\""+retArray[i][11]+"\")'>"+
									 		"<input type='button' class='b_text' value='ɾ��' onclick='del(\""+retArray[i][0]+"\")'>"+
									 		"<input type='button' class='b_text' value='���' onclick='delBond(\""+retArray[i][0]+"\")' "+disablStr+">"+
									 "</td>"+
									 "</tr>";
		}
		$("#accesMainTab tr:eq(0)").after(trObjdStr);
	}else{
		rdShowMessageDialog("��ѯʧ��"+code+"��"+msg,0);
		$("#input_group_name").val("");
		$("#input_group_id").val("");
	}
}

function resetThisPage(){
	location = location;
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
	<input type="hidden" name="opCode" value=<%=opCode%>>
	<input type="hidden" name="opName" value=<%=opName%>>
<div class="title"><div id="title_zi"><%=opName%></div></div>
<TABLE cellSpacing=0>
	<tr>
		<td class="blue" width="20%">��֯�ڵ�</td>
		<td class="blue" width="30%">
			
			<input type="text"   id="input_group_name" name="input_group_name"  readOnly class="InputGrey" size="40" />
			<input type="hidden" id="input_group_id"   name="input_group_id"   />
			<input type="button"  value="ѡ��" class="b_text" onclick="selGroupid()"/>
		</td>
		 
		  <td class="blue" width="20%">IMEI����</td>
		 <td width="30%"><input type="text" id="imeiNo" name="imeiNo" maxLength="15"></td>
	</tr>
</table>

<div class="title"><div id="title_zi">�ն˽����б�</div></div>
<TABLE cellSpacing="0" id="accesMainTab" >
	<tr>
		<th width="14%">IMEI��</th>
		<th width="10%">�ֻ�����</th>
		<th width="12%">��������</th>
		<th width="6%">״̬</th>	
		<th width="18%">�����½����</th>	
		<th width="18%">�����½ʱ��</th>	
		<th width="18%">��������</th>	
		<th>����</th>	
	</tr>
 
</table>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" value="��ѯ" class="b_foot" onclick="qryFunc()">
	 		<input type="button" value="����" class="b_foot" onclick="addFunc()">
	 		<input type="button" value="��������" class="b_foot" onclick="addFuncP()">
	 		<input type="button" value="����" class="b_foot" onclick="resetThisPage()">
			<INPUT class=b_foot onclick="removeCurrentTab()" type=button value=�ر�> 
	 	</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>