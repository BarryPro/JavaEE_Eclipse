<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	 String opName= "����ģ������";
	 String opCode = (String)request.getParameter("opCode");
	 String templateId = (String)request.getParameter("templateId");
	 String regionCode = (String)session.getAttribute("regCode");
	 String selSql = "select conf_funccode,conf_key_name,conf_key,conf_value,memo from dng35_Template_conf where templateId=:templateId";
	 String sqlParam = "templateId="+templateId;
%>
  <wtc:service name="TlsPubSelCrm" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=selSql%>" />
		<wtc:param value="<%=sqlParam%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
<%
String conf_funccode = "";
String conf_key_name = "";
String conf_key = "";
String conf_value = "";
String memo = "";
if(result_t.length>0){
	conf_funccode =result_t[0][0]; 
	conf_key_name =result_t[0][1]; 
	conf_key =result_t[0][2]; 
	conf_value =result_t[0][3]; 
	memo =result_t[0][4]; 
}
%>		

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�޸�ģ������</title>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" >
$(document).ready(function(){
	$("input[type='text']:visible").bind("focus",function(){
		$(this).select();
	})
});
</script>
</head>
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">�޸�ģ������</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue" width="15%">��������</td>
							<td  width="35%"><input type="text" name="funccode" id="funccode"  maxlength="6"	value="<%=conf_funccode%>"	readOnly class="InputGrey" /> </td>
									<td class="blue"  width="15%">�ֶ�����</td>
							<td><input type="text" name="elName" id="elName" value="<%=conf_key_name%>"> </td>
						</tr>
					 	
					 	<tr>
							<td class="blue">�ֶ�ID��NAME</td>
							<td><input type="text" name="inputId" id="inputId" value="<%=conf_key%>" /> </td>
									<td class="blue">ģ������</td>
							<td><input type="text" name="tempcont" id="tempcont" value="<%=conf_value%>"> </td>
						</tr>
						 
						 <tr>
							<td class="blue">��ע</td>
							<td colspan="3"><input type="text" name="memo" id="memo" value="<%=memo%>" /> </td>
						</tr>
						
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add"   type=button value="ȷ��" onclick="doUpd()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="ȡ��" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>
				</div>
			</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
	<input type="hidden" name="recodeID" id="recodeID"  value=""/>
</form>
<script type="text/javascript">
 
function doUpd(){
  var mm = /<|>|\\|\"|#|&/;
 if(mm.test(document.all.elName.value.trim())){
			rdShowMessageDialog("������������� < > \\ \" # &amp;");
			document.all.elName.value="";
			document.all.elName.focus();
			return;
		}
	if(mm.test(document.all.inputId.value.trim())){
			rdShowMessageDialog("������������� < > \\ \" # &amp;");
			document.all.inputId.value="";
			document.all.inputId.focus();
			return;
		}	
		if(mm.test(document.all.tempcont.value.trim())){
			rdShowMessageDialog("������������� < > \\ \" # &amp;");
			document.all.tempcont.value="";
			document.all.tempcont.focus();
			return;
		}	
		if(rdShowConfirmDialog('ȷ���޸ļ�¼��')!=1) return;
		$("#recodeID").val( window.opener.parent.parent.oprInfoRecode('','2','<%=opCode%>','�޸Ĳ���ģ��'));
	var permiPacket = new AJAXPacket("updTemplateCfm.jsp","����ִ��,���Ժ�...");
		permiPacket.data.add("templateId",    "<%=templateId%>");
		permiPacket.data.add("elName",     document.all.elName.value.trim());
		permiPacket.data.add("inputId",     document.all.inputId.value.trim());
		permiPacket.data.add("tempcont",     document.all.tempcont.value.trim());
		permiPacket.data.add("memo",     document.all.memo.value.trim());
		core.ajax.sendPacket(permiPacket,doAddCfm);
		permiPacket = null; 
}
function doAddCfm(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	window.opener.parent.parent.oprInfoRecode('','','','',$("#recodeID").val());
	if(code=="000000"){
		rdShowMessageDialog("�����ɹ�",2);
		window.opener.getList();
		window.close();
	}else{
		rdShowMessageDialog("����ʧ��"+code+"��"+msg,0);
	}
	
}
</script> 
</body>
</html>