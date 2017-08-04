<%
  /*
   * 功能: 质检权限管理->维护质检组和组->修改质检组
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: 
　 * 版权: sitech
   * update:yinzx 20091002
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>修改质检组</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>

<script language=javascript>

// 清除表单记录
function cleanValue(){
document.getElementById("groupName").value="";
document.getElementById("note").value="";		
}
function initValue(){	
	var pdoc = window.dialogArguments;
	var selectItemId     =pdoc.tree.getSelectedItemId();
	var selectItemName   =pdoc.tree.getSelectedItemText();
  	var parnertId        =pdoc.tree.getParentId(selectItemId);	
  	var parnertName      =pdoc.tree.getItemText(parnertId);	
  	var note             =pdoc.tree.getUserData(selectItemId,"note");
	document.getElementById('parNodeName').value=parnertName;
	document.getElementById('parNode').value=parnertId;
	document.getElementById('nodeId').value=selectItemId;
	document.getElementById('groupName').value=selectItemName;
  	document.getElementById('note').value=note;

}
function closeWin(){
	window.close();
}

function modifyNode(){
	var pdoc = window.dialogArguments;
	var nodeName = document.getElementById("groupName").value;
	var nodeId=document.getElementById('nodeId').value;
	var note=document.getElementById('note').value;
	if(nodeName == ""){
		similarMSNPop("请输入质检组的名称！");
		return;
	}
	
	/*add by yinx 20091002*/
		if(note.length >100)
		{
			 similarMSNPop("描述信息太长请重新输入！");
			 return false;
		}
	
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K290/k2901/k290_modifyNewNode.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("retType","modifyNode");
	packet.data.add("nodeName",nodeName);
	packet.data.add("nodeId",nodeId);
	packet.data.add("note",note);
	core.ajax.sendPacket(packet,doneModifyProcess,false);
	packet=null;
	
}

function doneModifyProcess(packet) {
	var pdoc = window.dialogArguments;
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	
	if (retType == 'modifyNode' && retCode == "000000") {
		var nodeName = packet.data.findValueByName("nodeName");
		var note = packet.data.findValueByName("note");
		// 更新修改节点的名称
		var nodeId = pdoc.tree.getSelectedItemId();
		pdoc.tree.setItemText(nodeId,nodeName);
		pdoc.tree.setUserData(nodeId,"note",note);	
		similarMSNPop("修改质检组成功！");
		setTimeout("window.close()",2000);
		return;
		} else {
		similarMSNPop("修改质检组失败！");
		return false;
		setTimeout("window.close()",2000);
		}
	
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
	<div id="Operation_Title"><B>修改质检组</B></div>
    <div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
    <div class="title"></div>  
		<table>
					 <tr>
  				<td>上层节点编号：</td>
  				<td width="70%">
  					<input id="parNode" name="parNode" size="30" type="text"  Class="InputGrey" readOnly value="">
	  			</td>
			</tr>
						<tr>
  				<td>上层节点名称：</td>
  				<td width="70%">
       <input id="parNodeName" name="parNodeName" size="30" type="text" readOnly  Class="InputGrey" value="">
	  			</td>
			</tr>
			<tr>
  				<td>当前节点编号：</td>
  				<td width="70%">
  					<input id="nodeId" name="nodeId" size="30" readOnly  Class="InputGrey"  type="text" value="">
	  			</td>
			</tr>
			<tr>
  				<td>当前节点名称：</td>
  				<td width="70%">
  					<input id="groupName" name="groupName" size="30" type="text" value="">
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr>
  				<td>描述：</td>
  				<td  width="60%">
  					<textarea name="note" id="note" cols="30" rows="4"></textarea>

	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="确定" onClick="modifyNode()">
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
</form>
</body>
</html>
<script language=javascript>
initValue();
</script>