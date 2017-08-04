<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2011-9-2 8:27:15
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
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	
	System.out.println("------------activePhone-----------"+activePhone);
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
	<SCRIPT language=JavaScript>
		
	var roleStr = "";
	
		function reSetThis(){
			location = location;	
		}
 
		function getMrole(){
				var packet = new AJAXPacket("ajaxGetMRole.jsp","请稍后...");
				packet.data.add("sysRoleId",document.all.sysRoleId.value.trim());
				packet.data.add("mRoleName",document.all.mRoleName.value.trim());
				core.ajax.sendPacket(packet,doGetMrole);
				packet1 =null;
		}
		function doGetMrole(packet){
				var error_code = packet.data.findValueByName("code");
				var error_msg =  packet.data.findValueByName("msg");	
				if(error_code!="000000"){
					rdShowMessageDialog(error_code+":"+error_msg);
					return;
				}else{
					var resultArray = packet.data.findValueByName("retArray");	
				  	var innerHTMLStr = "";
					for(var i=0;i<resultArray.length;i++){
 
						innerHTMLStr +=  "<tr>"+
														 "<td><input type='text' readOnly size=15 class='InputGrey' value='"+resultArray[i][1]+"'></td>"+
														 "<td><input type='text' readOnly class='InputGrey' value='"+resultArray[i][4]+"'></td>"+
														 "<td><input type='text' readOnly class='InputGrey' value='"+resultArray[i][2]+"'></td>"+
														 "<td><input type='text' readOnly class='InputGrey' value='"+resultArray[i][3]+"'></td>"+
														 "<td><input type='button' value='删除' class='b_text' onclick='opThis(this,\""+resultArray[i][0]+"\")'></td>"+
														 "</tr>";
					}
					$("#mRoleTab tr:gt(0)").each(function(){
						$(this).remove();
					});
					if(innerHTMLStr!="")
						$("#mRoleTab").append(innerHTMLStr);
				}
		}
var sBt = null;
var sFlag = 0;
function queryPowerCode(bt){
	var path = "/npage/opManage/roleTree/roletree.jsp";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	sBt = bt;
	sFlag = 1;
}
function queryPowerCodeSys(bt){
	var path = "roletree.jsp";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	sBt = bt;
	sFlag = 0;
}

 
function setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes){
	 
	if(sFlag==0){	
		$(sBt).parent().parent().find("td:eq(0)").children().val(retRoleId);
		$(sBt).parent().parent().find("td:eq(1)").children().val(retRoleName);
	}
	if(sFlag==1){
		$(sBt).parent().parent().find("td:eq(2)").children().val(retRoleId);
		$(sBt).parent().parent().find("td:eq(3)").children().val(retRoleName);
	}
	$(sBt).hide();
	sBt = null;
}

function addMrole(){
	var inHtml = "<tr>"+
				 "<td><input type='text' readOnly class='InputGrey' size=30><input type='button' value='选择' class='b_text' onclick='queryPowerCodeSys(this)'> </td>"+
				 "<td><input type='text' readOnly class='InputGrey'></td>"+
				 "<td><input type='text' readOnly class='InputGrey'><input type='button' value='选择' class='b_text' onclick='queryPowerCode(this)'> </td>"+
				 "<td><input type='text' readOnly class='InputGrey'></td>"+
				 "<td><input type='button' value='保存' class='b_text' onclick='opThis(this)'>"+
				 "<input type='button' value='删除' class='b_text' onclick='delThis(this)'>"+
				 "</td>"+
				 "<tr>"
	
	$("#mRoleTab").append(inHtml);
}
function delThis(bt){
	$(bt).parent().parent().remove();
}
function opThis(bt,mbId){
	if($(bt).val()=="保存"){
		var sysRole   = $(bt).parent().parent().find("td:eq(0)").children().val().trim();
		var sysRoleName   = $(bt).parent().parent().find("td:eq(1)").children().val().trim();
		var mRole     = $(bt).parent().parent().find("td:eq(2)").children().val().trim();
		var mRoleName = $(bt).parent().parent().find("td:eq(3)").children().val().trim();
		if(sysRole==""||mRole==""){
			rdShowMessageDialog("请选择角色");
			return;
		}
		
		var packet = new AJAXPacket("mRoleCfm.jsp","请稍后...");
			packet.data.add("optype","a");
			packet.data.add("sysRole",sysRole);
			packet.data.add("sysRoleName",sysRoleName);
			packet.data.add("mRole",mRole);
			packet.data.add("mRoleName",mRoleName);
			core.ajax.sendPacket(packet,doSave);
			packet1 =null;
	}else{
		var packet = new AJAXPacket("mRoleCfm.jsp","请稍后...");
			packet.data.add("optype","d");
			packet.data.add("mbid",mbId);
			core.ajax.sendPacket(packet,doDel);
			packet1 =null;
	}
}		
function doSave(packet){
	var error_code = packet.data.findValueByName("code");
	var error_msg =  packet.data.findValueByName("msg");	
	if(error_code!="000000"){
		rdShowMessageDialog(error_code+":"+error_msg);
		return;
	}else{
		rdShowMessageDialog("操作成功",2);
		location = location;
	}
}
function doDel(packet){
	var error_code = packet.data.findValueByName("code");
	var error_msg =  packet.data.findValueByName("msg");	
	if(error_code!="000000"){
		rdShowMessageDialog(error_code+":"+error_msg);
		return;
	}else{
		rdShowMessageDialog("操作成功",2);
		location = location;
	}
}
$(document).ready(function(){
	getMrole();
});
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header_mop.jsp" %>	
<div class="title"><div id="title_zi">订单查询</div></div>
<TABLE cellSpacing=0>
	<tr>
		<td class="blue"  width='20%'>角色ID</td>
		<td width='30%'><input type="text" name="sysRoleId" id="sysRoleId" value=""> </td>
		<td class="blue" width='20%'>角色名称</td>
		<td width='30%'><input type="text" name="mRoleName" id="mRoleName">  </td>
	</tr>
</table>
	<table id="mRoleTab"  cellSpacing=0>
		<tr>
			<th width='20%'>系统角色</th>
			<th width='20%'>系统角色名称</th>
			<th width='30%'>工作台角色</th>
			<th width='20%'>工作台角色名称</th>
			<th width='30%'>操作</th>
		</tr>
	</table>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" value="查询" class="b_foot" onclick="getMrole()">
	 		<INPUT class=b_foot onclick="addMrole()" type=button value=新增> 
			<INPUT class=b_foot onclick="removeCurrentTab()" type=button value=关闭> 
	 	</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>