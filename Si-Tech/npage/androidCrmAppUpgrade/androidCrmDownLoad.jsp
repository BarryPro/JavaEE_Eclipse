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
 
 
function delAndroidFile(apkName,versionId){
	//alert("delAndroidFile-->\napkName = "+apkName+"\nversionId = "+versionId);
      if(rdShowConfirmDialog('ȷ��ɾ��Ȩ�޼�¼��')!=1) return;
	
	var packet = new AJAXPacket("androidCrmUpgDelCfm.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");
			packet.data.add("versionId",versionId);
			packet.data.add("apkName",apkName);
			core.ajax.sendPacket(packet,doDel);
			packet = null; 
}
function doDel(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("ɾ���ɹ�",2);
		ajaxGetAndroidCrmUpgList();
	}else{
		rdShowMessageDialog("����ʧ��"+code+"��"+msg,0);
	}
}
 
function androidCrmUpgAdd(){
	 document.prodCfm.action = "androidCrmUpgAdd.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 document.prodCfm.submit();
} 

function downloadApk(apkName){
	 document.prodCfm.action="androidCrmUpgDownLoad.jsp?opCode=<%=opCode%>&opName=<%=opName%>&apkName="+apkName;
 	 document.prodCfm.submit();
}

$(document).ready(function(){
	//���÷����ѯ�����б�
	ajaxGetAndroidCrmUpgList();
});
function ajaxGetAndroidCrmUpgList(){
	var packet = new AJAXPacket("ajaxGetAndroidCrmUpgList.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(packet,doAjaxGetAndroidCrmUpgList);
			packet = null; 
}
function doAjaxGetAndroidCrmUpgList(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		var retArray = packet.data.findValueByName("retArray"); 
		//ƴtable
		var trObjdStr = "";
		$("#upgMainTab tr:gt(0)").remove();
		for(var i=0;i<retArray.length;i++){
			trObjdStr += "<tr>"+
									 "<td>"+retArray[i][0]+"</td>"+
									 "<td>"+retArray[i][3]+"</td>"+
									 "<td>"+retArray[i][2]+"</td>"+
									 "<td><a href=\"javascript:void(0)\" onclick=\"downloadApk('"+retArray[i][1]+"')\">"+retArray[i][1]+"</a>"+"</td>"+
									 "<td>"+retArray[i][4]+"</td>"+
									 "</tr>";
		}
		$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		rdShowMessageDialog("��ѯandroid��CRM���������б�ʧ�ܣ�"+code+"��"+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
	<input type="hidden" name="opCode" value=<%=opCode%>>
	<input type="hidden" name="opName" value=<%=opName%>>
 
<div class="title"><div id="title_zi">�����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
	<tr>
		<th width="10%">Ӧ�ð汾��</th>
		<th width="10%">��������</th>
		<th width="15%">��������</th>
		<th width="25%">����</th>	
		<th width="340%">�汾����</th>
	</tr>
</table>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input class="b_foot" type="button" value="��ѯ"  onclick="ajaxGetAndroidCrmUpgList()"					/>
			<INPUT class="b_foot" type="button" value="�ر�"  onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>