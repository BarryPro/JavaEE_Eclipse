<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	 String opName= "����Ȩ������";
	 String simNo =   (String)request.getParameter("simNo");
	 String loginNo = (String)request.getParameter("loginNo");
	 String status =  (String)request.getParameter("status");
	 String bdate =  (String)request.getParameter("bdate");
	 String edate =  (String)request.getParameter("edate");
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�޸�Ȩ������</title>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">�޸�Ȩ������</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
						 <td class="blue" width="20%">sim����</td>
						 <td width="30%"><input type="text" name="simno" id="simno" value="<%=simNo%>" disabled maxlength="32"><font class="orange">*</font> </td>
						 
						 <td class="blue" width="20%">����</td>
						 <td width="30%"><input type="text" name="loginNo" id="loginNo"  value="<%=loginNo%>" disabled maxlength="6"><font class="orange">*</font> </td>
						</tr>
						<tr>
						 <td class="blue"  >��ʼʱ��</td>
						 <td  ><input type="text" id="beginDate" readOnly  value="<%=bdate%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"><font class="orange">*</font> </td>
						 
						 <td class="blue"  >����ʱ��</td>
						 <td  ><input type="text" id="endDate" readOnly  value="<%=edate%>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"><font class="orange">*</font> </td>
						</tr>
						<tr>
						 <td class="blue"  >״̬</td>
						 <td  >
						 	<select id="status" name="status">
						 		<option value="0" <%if(status.equals("0")) out.print("selected");%>>����</option>
		 						<option value="1" <%if(status.equals("1")) out.print("selected");%>>��ͣ</option>
						 	</select><font class="orange">*</font> </td>
						 
						 <td class="blue"  >&nbsp;</td>
						 <td  >&nbsp;</td>
						</tr>
											
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
							  	<input class="b_foot" name="update" id="update"  type=button value="�޸�" onclick="doUpd()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="ȡ��" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>
				</div>
			</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<script type="text/javascript">
$(document).ready(function(){
 	$("select").width("150");
	$("input[type='text']").width("150");
});	
function doUpd(){
	mm = /^\w+$/;
	 
	if(document.all.beginDate.value==""){
		rdShowMessageDialog("�����뿪ʼʱ��");
		document.all.beginDate.focus();
		return;
	}
	if(document.all.endDate.value==""){
		rdShowMessageDialog("���������ʱ��");
		document.all.endDate.focus();
		return;
	}
	
	if(document.all.endDate.value<document.all.beginDate.value){
		rdShowMessageDialog("����ʱ�䲻��С�ڿ�ʼʱ�䣬����������");
		document.all.beginDate.focus();
		document.all.beginDate.value="";
		document.all.endDate.value="";
		return;
	}
	var permiPacket = new AJAXPacket("updPermiCfm.jsp","����ִ��,���Ժ�...");
		permiPacket.data.add("simno",     document.all.simno.value.trim());
		permiPacket.data.add("loginNo",     document.all.loginNo.value.trim());
		permiPacket.data.add("beginDate",     document.all.beginDate.value.trim());
		permiPacket.data.add("endDate",     document.all.endDate.value.trim());
		permiPacket.data.add("status",     document.all.status.value);
		core.ajax.sendPacket(permiPacket,doUpdCfm);
		permiPacket = null; 
}
function doUpdCfm(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("�����ɹ�",2);
		window.opener.getPermi();
		window.close();
	}else{
		rdShowMessageDialog("����ʧ��"+code+"��"+msg,0);
	}
}
</script> 
</body>
</html>
