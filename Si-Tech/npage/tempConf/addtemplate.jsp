<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	 String opName= "����ģ������";
	 String opCode = (String)request.getParameter("opCode");
%>
 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>����ģ������</title>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" >

function checkFuncCode(){
	if($("#funccode").val().trim()=="") return ;
	var checkFuncCodePacket = new AJAXPacket("ajaxCheckFuncCode.jsp","����ִ��,���Ժ�...");	
		checkFuncCodePacket.data.add("funccode",$("#funccode").val().trim());
		core.ajax.sendPacket(checkFuncCodePacket,doCheckFuncCode);
		getSimNaPacket = null; 
}
function doCheckFuncCode(packet){
	var countOpcode = packet.data.findValueByName("countOpcode"); 
	if(countOpcode=="0"){
		rdShowMessageDialog("�������������������������",0);
		$("#funccode").val("");
		$("#funccode").focus();
	}
}
</script>


</head>
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">����ģ������</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							<td class="blue" width="15%">��������</td>
							<td  width="35%"><input type="text" name="funccode" id="funccode"  maxlength="6"	 onkeyup="ng35_autoChgFocus(this,4,'elName')" onblur="checkFuncCode()"	/> <font class="orange">*</font></td>
									<td class="blue"  width="15%">�ֶ�����</td>
							<td><input type="text" name="elName" id="elName" value=""> </td>
						</tr>
					 	
					 	<tr>
							<td class="blue">�ֶ�ID��NAME</td>
							<td><input type="text" name="inputId" id="inputId"  /> </td>
									<td class="blue">ģ������</td>
							<td><input type="text" name="tempcont" id="tempcont" value=""> </td>
						</tr>
						 
						 <tr>
							<td class="blue">��ע</td>
							<td colspan="3"><input type="text" name="memo" id="memo"  /> </td>
						</tr>
						
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add"   type=button value="����" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="update" id="update" style="display:none" type=button value="�޸�" onclick="doUpate()">
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
function doAdd(){
	if(document.all.funccode.value==""){
		rdShowMessageDialog("�������������");
		document.all.funccode.focus();
		return;
	}
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
		if(rdShowConfirmDialog('ȷ�ϱ����¼��')!=1) return;
	var permiPacket = new AJAXPacket("addTemplateCfm.jsp","����ִ��,���Ժ�...");
		permiPacket.data.add("funccode",     document.all.funccode.value.trim());
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