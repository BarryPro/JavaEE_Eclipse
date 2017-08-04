<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->新增被质检组页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>新增被质检组</title>
<style>
		img{
				cursor:hand;
		}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>

<script language=javascript>

// 清除表单记录
function cleanValue(){
document.getElementById("groupName").value="";
document.getElementById("objectTypeName").value="";	
document.getElementById("note").value="";		
 	
}

function closeWin(){
	window.close();
}

function addNewNode(){
	var nodeName = document.getElementById("groupName").value;
	var strValue=document.getElementById("nodeType").options[document.getElementById("nodeType").selectedIndex].value;
	var parNode=document.getElementById("parNode").value;
	var objectType=document.getElementById("objectType").value;
	var note=document.getElementById("note").value;
	var pdoc = window.dialogArguments;
	
		/*add by yinx 20091002*/
		if(note.length >400)
		{
			 rdShowConfirmDialog("描述信息太长请重新输入",1)
			 return false;
		}
	if(nodeName == ""){
		similarMSNPop("请输入被质检组的名称！");
		return;
	}if(objectType == ""){
		similarMSNPop("请选择所属被检对象类别！");
		return;
	}
	var nodeId = parNode;
	var isleaf =pdoc.tree.getUserData(nodeId,"isleaf");
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k280_insertNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","insertNewNode");
	packet.data.add("nodeName",nodeName);
	packet.data.add("nodeId",parNode);
	packet.data.add("note",note);
	packet.data.add("isleaf",isleaf);
	packet.data.add("objectid",objectType);
	core.ajax.sendPacket(packet,doUpdateProcess,true);
	packet=null;
}

function doUpdateProcess(packet) {
	var pdoc = window.dialogArguments;
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if (retType == 'insertNewNode' && retCode == "000000") {
		var login_group_id = packet.data.findValueByName("login_group_id");
		var parent_group_id = packet.data.findValueByName("parent_group_id");
		var login_group_name = packet.data.findValueByName("login_group_name");
		var object_id = packet.data.findValueByName("object_id");
		var note = packet.data.findValueByName("note");	
		pdoc.tree.insertNewItem(parent_group_id,login_group_id,login_group_name,0,0,0,0,'SELECT');
		pdoc.tree.setUserData(login_group_id,"isleaf",'Y');
		pdoc.tree.setUserData(login_group_id,"object_id",object_id);	
		pdoc.tree.setUserData(login_group_id,"note",note);
		/*
		if(rdShowConfirmDialog("添加被检组成功，是否继续添加？",2) != 1){
			window.close();
		}
		*/
		similarMSNPop("添加被检组成功！");
		setTimeout("window.close()",1500);
  	} else {
		similarMSNPop("添加被检组失败！");
		setTimeout("window.close()",1500);
	}
}

function showObjectCheckTree(){
  openWinMid('k280_objectIdTree.jsp','选择被检对象类别',300, 250);
}

function openWinMid(url,name,iHeight,iWidth)
{
  	var time     = new Date();
	var winParam = 'dialogWidth=400px;dialogHeight=400px';
	window.showModalDialog(url+"?time="+time,window, winParam);
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top">
	<div id="Operation_Title"><B>添加被检对象</B></div>
    <div id="Operation_Table" style="width: 100%;">
    <div class="title"></div>
		<table>
						<tr>
  				<td>节点类别：</td>
  				<td width="70%">
<select name="nodeType" size="1" id="nodeType"  
    onChange="changeType();">
 <option value="0" selected>同层节点</option>
 <option value="1">同层子节点</option>
</select>
	  			</td>
			</tr>
			<tr>
  				<td>上层节点编号：</td>
  				<td width="70%">
      <input id="parNode" name ="parNode" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>
			<tr>
  				<td>上层节点名称：</td>
  				<td width="70%">
       <input id="nodeName" name ="nodeName" size="30" type="text" readOnly  Class="InputGrey" value=""/>
	  			</td>
			</tr>
			<tr>
  				<td>新增节点名称：</td>
  				<td  width="70%">
  					<input id="groupName" name ="groupName" size="20" type="text" value=""
  					       v_must="1" v_type="string" onBlur="checkElement(this)"/>
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr>
  				<td>所属被检对象类别：</td>
  				<td  width="70%">
  					<input id="objectTypeName" name ="objectTypeName" size="20" type="text" readOnly value="">
  					<input id="objectType" name ="objectType" size="20"  type="hidden" value="">
  					<font color="orange">*</font>
  					<img onclick="showObjectCheckTree(0);"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
	  			</td>
			</tr>
			<tr>
  				<td>描述：</td>
  				<td  width="60%">
  					<textarea name="note" cols="30" rows="4"  ></textarea>
	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="确定" onClick="addNewNode()">
   					<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="关闭" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
	<br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>
</form>
</body>
</html>
<SCRIPT type=text/javascript> 
//节点选择事件
initValue();	
function initValue(){

	var pdoc = window.dialogArguments;
	var selectItemId =pdoc.tree.getSelectedItemId();
	var level=pdoc.tree.getLevel(selectItemId);
	if(level=='1'){

		  document.getElementById("nodeName").value=pdoc.tree.getSelectedItemText();
	    document.getElementById("parNode").value=pdoc.tree.getSelectedItemId();
	    document.getElementById("nodeType").value="1";
	    document.getElementById("nodeType").disabled = true;
		}else{
	    var parnertId    =pdoc.tree.getParentId(selectItemId);	
      var parnertName  =pdoc.tree.getItemText(parnertId);	
		  document.getElementById("nodeName").value=parnertName;
	    document.getElementById("parNode").value=parnertId;
			}


}

function changeType(){
	var pdoc = window.dialogArguments;
     var strValue=document.getElementById("nodeType").options[document.getElementById("nodeType").selectedIndex].value;
     var selectItemId =pdoc.tree.getSelectedItemId();
		if(strValue=="0"){
			var parnertId    =pdoc.tree.getParentId(selectItemId);	
      var parnertName  =pdoc.tree.getItemText(parnertId);	
		  document.getElementById("nodeName").value=parnertName;
	    document.getElementById("parNode").value=parnertId;

		}else{
			document.getElementById("nodeName").value=pdoc.tree.getSelectedItemText();
	    document.getElementById("parNode").value=selectItemId;
		}	
	}

</SCRIPT>