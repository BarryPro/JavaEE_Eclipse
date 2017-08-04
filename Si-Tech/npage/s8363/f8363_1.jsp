<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:营业厅与mac地址绑定配置
   * 版本: 1.0
   * 日期: 2009/12/17
   * 作者: gaolw
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "8363";
	String opName = "营业厅与mac地址绑定配置";
	String iLoginAccept = "";
	iLoginAccept = getMaxAccept();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
onload=function()
{		
	init();
}

function init()
{
	document.form1.confirm.disabled = true;
}	
var bind_values1 = new Array() ;
var notes = new Array() ;
//----弹出一个新页面选择组织节点--- 增加
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptree_login.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
//校验mac地址
function macAddrCheck() {
	var macAddr = document.form1.macAddr.value;
	if (macAddr.search(/^\w{2}(-\w{2}){5}$/) != -1)
	{
	  //rdShowMessageDialog("校验成功!",2);	
		return true;
	}
	else{
		rdShowMessageDialog("mac地址格式错误！mac地址格式应为：(XX-XX-XX-XX-XX-XX)");
		document.form1.macAddr.value = "";
	  document.form1.macAddr.focus();
	  return false;
	}
}
//添加mac地址
function addRow(){
	
	if(document.all.groupName.value.length < 1) {
		rdShowMessageDialog("请选择营业厅！");
		return false;
	}
	
	if(document.all.macAddr.value.length < 1) {
		rdShowMessageDialog("请输入mac地址！");
		document.getElementById("macAddr").focus();
		return false;
	}
	if(document.all.macAddr.value.length != 17) {
		rdShowMessageDialog("mac地址必须是17位，请重新输入！");
		document.getElementById("macAddr").value = "";
		document.getElementById("macAddr").focus();
		return false;
	}
	var bool = macAddrCheck();
	if (bool == true) {
	document.form1.confirm.disabled = false;
	if(bind_values1.length>0) {
		for(i=0; i<bind_values1.length; i++) {
			if(document.getElementById("macAddr").value== notes[i]) {				
				rdShowMessageDialog("添加信息重复！");
				document.getElementById("macAddr").value = "";
		    return false;
			}
		}
	}
	if(bind_values1.length>=20){
		rdShowMessageDialog("不能超过20行，请提交！");
		document.getElementById("macAddr").value = "";
		return false;
	}
	
		
  var tableobj=document.getElementById("table_1"); 
	var rowobj=tableobj.insertRow(tableobj.rows.length); 

	var cell1=rowobj.insertCell(rowobj.cells.length); 
	var cell2=rowobj.insertCell(rowobj.cells.length); 
	var cell3=rowobj.insertCell(rowobj.cells.length); 
	var cell4=rowobj.insertCell(rowobj.cells.length); 
	
    cell1.innerHTML = '<td><input type="text" name="bind_values" id="bind_values" value="'+document.getElementById("groupId").value+'" class="input-read"  readonly/></td>' ; 
    cell2.innerHTML = '<td><input type="text" name="townname" id="townname" size="40" value="'+document.getElementById("groupName").value+'" class="input-read" readonly/></td>' ; 
    cell3.innerHTML = '<td><input type="text" name="notes" id="notes" value="'+document.getElementById("macAddr").value+'" class="input-read" readonly/></td>' ; 
    cell4.innerHTML = '<td><img src="../../images/ico_delete.gif" alt="删除" border="0" onclick="deleteRow('+(tableobj.rows.length-1)+');leo()"></td>' ;
  
	bind_values1.push(document.getElementById("groupId").value) ;
	notes.push(document.getElementById("macAddr").value) ;
	document.getElementById("macAddr").value = "";
	//alert(bind_values1.length);
	if(bind_values1.length>=20){
		rdShowMessageDialog("不能超过20行，请提交！");
		return false;
	}
}
}

function deleteRow(i){                        
  var tableobj = document.getElementById("table_1"); 
  var returnValue = rdShowConfirmDialog("您确定要删除该条信息吗？");
  
  if (returnValue == rdConstOK) {
		tableobj.deleteRow(i); 
	}
	
	var temp = bind_values1[i-1];
	for(j=i-1 ; j<bind_values1.length-1; j++) {
		bind_values1[j] = bind_values1[j+1] ;
	}
	bind_values1[bind_values1.length-1] = temp ;
	bind_values1.pop() ;
	
	var temp = notes[i-1];
	for(j=i-1 ; j<notes.length-1; j++) {
		notes[j] = notes[j+1] ;
	}
	notes[notes.length-1] = temp ;
	notes.pop() ;
}

function leo(){//当删除一行后，对各行重新建立索引！！！ 
	var tableobj=document.getElementById("table_1"); 
	for(i=1;i<tableobj.rows.length;i++) { 
		tableobj.rows[i].cells[3].innerHTML = '<img src="../../images/ico_delete.gif" alt="Delete" border="0" onclick="deleteRow('+i+');leo()">';
	} 
} 

function CommitJsp(){//确认按钮
	var groupidList="";
	var macAddrList="";
	
	if(bind_values1.length==0){
		rdShowMessageDialog("请配置营业厅与mac地址对应关系！");
		return false;
	}
	
	document.all.opCount.value=bind_values1.length;
	//alert(document.all.opCount.value);

	if(bind_values1.length>0) {
		for(i=0; i<bind_values1.length; i++) {
			groupidList=groupidList+bind_values1[i]+",";
			macAddrList=macAddrList+notes[i]+",";
		}	
	}
	document.all.groupidStr.value=groupidList;
	//alert(document.all.groupidStr.value);
	document.all.macAddrStr.value=macAddrList;
	//alert(document.all.macAddrStr.value);
	document.form1.action="f8363_2.jsp";
 	form1.submit();
}

function commitJspQry(){//查询按钮
	if(document.all.groupName.value.length < 1) {
		rdShowMessageDialog("请选择营业厅！");
		return false;
	}
	document.form1.action="f8363_3.jsp";
 	form1.submit();
}

</script> 
 
<title>营业厅与mac地址绑定配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="form1"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">营业厅与mac地址绑定配置</div>
	</div>
<table cellspacing="0">             
	<tr>
		<td class="blue" width="10%">营业厅</td>
		<td colspan="3">
			<input type="hidden" name="groupId" id="groupId">
			<input type="text" name="groupName" id="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly size="30">&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text" type="button" value="选择" onClick="select_groupId()" >	
		</td>
	</tr>
	
	<tr>
		<td class="blue" width="10%">mac地址</td>
		<td colspan="3">
			<input type="text" name="macAddr" id="macAddr" v_must="1" v_type="string" maxlength="17" size="30">&nbsp;&nbsp;&nbsp;
			<input name="addButton" class="b_text" type="button" value="添加" onClick="addRow()" >
			&nbsp;<font color="orange">(格式：XX-XX-XX-XX-XX-XX)</font>
		</td>
	</tr>	
	
	<tr>
		<td colspan="4">
			<table id="table_1">       
				<tr>
				<td class="blue" width="20%">营业厅代码</td>
				<td class="blue" width="40%">营业厅名称</td>
				<td class="blue" width="30%">mac地址</td>
				<td class="blue" width="10%">操作</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="fileimport" class="b_foot" value="文件导入" onclick="location='f8363_import.jsp'">
			&nbsp;
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="CommitJsp()">
			&nbsp;
			<input type="button" name="querry"  class="b_foot" value="查询" onclick="commitJspQry()">
			&nbsp;
			<input type="button" name="close" class="b_foot" value="关闭" onclick="removeCurrentTab()">
		</td>
	</tr>
</table>
  <input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="iLoginAccept" value="<%=iLoginAccept%>">
	
	<input type="hidden" name="groupidStr">   
	<input type="hidden" name="macAddrStr">   
	<input type="hidden" name="opCount">  
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>