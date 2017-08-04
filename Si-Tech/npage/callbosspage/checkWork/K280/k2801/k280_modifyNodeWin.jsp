<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->修改被质检组
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

 String object_id=request.getParameter("object_id");
 String sqlStr="select t.object_name from dqcobject t where trim(t.object_id)= :object_id";
 myParams = "object_id="+object_id ;
 String str="";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
  <wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:row id="row"   start="0"  length="1">
<% str=row [0];%>	
</wtc:row>



<html>
<head>
<title>修改被质检组</title>
<style>
		img{
				cursor:hand;
		}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
/**
  *修改节点信息
  */
function modifyNode(login_group_id,login_group_name,note,objectType){
	var nodeName   = document.getElementById("groupName").value;
	var nodeId     = document.getElementById('nodeId').value;
	var note       = document.getElementById('note').value;
	var objectType = document.getElementById('objectType').value;
	
	if(nodeName == ""){
		similarMSNPop("请输入被质检组的名称！");
		return;
	}if(objectType == ""){
		similarMSNPop("请选择所属被检对象类别！");
		return;
	}
		/*add by yinx 20091002*/
		if(note.length >100)
		{
			 rdShowConfirmDialog("描述信息太长请重新输入",1)
			 return false;
		}
			
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k2801/k280_modifyNewNode.jsp","...");
	packet.data.add("retType","modifyNode");
	packet.data.add("nodeName",nodeName);
	packet.data.add("nodeId",nodeId);
	packet.data.add("note",note);
	packet.data.add("objectid",objectType);	
	core.ajax.sendPacket(packet,doProcessModifyNode,true);
	packet=null;
}

/**
  *返回处理函数
  */
function doProcessModifyNode(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");

	if (retType == 'modifyNode' && retCode == "000000") {
		similarMSNPop("更新被质检组信息成功！");
		updTree();
		setTimeout("window.close()",1500);
  		
	} else {
		similarMSNPop("更新被质检组信息失败！");
		setTimeout("window.close()",1500);
	}
}

/**
  *更新树中节点信息
  */
function updTree(){
var nodeId     = document.getElementById('nodeId').value;
var nodeName   = document.getElementById("groupName").value;
var object_id  = document.getElementById('objectType').value;
var note       = document.getElementById('note').value;
var pdoc       = window.dialogArguments;
pdoc.tree.setItemText(nodeId,nodeName);
pdoc.tree.setUserData(nodeId,"object_id",object_id);	
pdoc.tree.setUserData(nodeId,"note",note);	
}


// 清除表单记录
function cleanValue(){
document.getElementById("groupName").value="";
document.getElementById("objectTypeName").value="";	
document.getElementById("note").value="";		
}

function closeWin(){
	window.close();
}

function initValue(){
	var pdoc = window.dialogArguments;	
	var selectItemId     =pdoc.tree.getSelectedItemId();
	var selectItemName   =pdoc.tree.getSelectedItemText();
  	var parnertId        =pdoc.tree.getParentId(selectItemId);	
  	var parnertName      =pdoc.tree.getItemText(parnertId);	
  	var objectType       =pdoc.tree.getUserData(selectItemId,"object_id");
  	var note             =pdoc.tree.getUserData(selectItemId,"note");
  	var objectTypeName   = "<%=str%>";
	document.getElementById('parNodeName').value=parnertName;
	document.getElementById('parNode').value=parnertId;
	document.getElementById('nodeId').value=selectItemId;
	document.getElementById('groupName').value=selectItemName;
	document.getElementById('objectTypeName').value=objectTypeName;
	document.getElementById('objectType').value=objectType;
  	document.getElementById('note').value=note;
}


function showObjectCheckTree(){
  openWinMid('<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/k280_objectIdTree.jsp','选择被检对象类别',300, 250);
}

function openWinMid(urll,name,iHeight,iWidth){
  	var time     = new Date();
	var winParam = 'dialogWidth=400px;dialogHeight=400px;toolbar=no;menubar=no;scrollbars=yes;resizeable=no;location=no;status=no';
	window.showModalDialog(urll+"?time="+time,window, winParam);
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
	<div id="Operation_Title"><B>修改被检组</B></div>
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
  					<input id="nodeId" name="nodeId" size="30" readOnly  Class="InputGrey"  type="text" value=""/>
	  			</td>
			</tr>
			<tr>
  				<td>当前节点名称：</td>
  				<td width="70%">
  					<input id="groupName" name="groupName" size="30" type="text" value=""
  					       v_must="1" v_type="string" onBlur="checkElement(this)"/>
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr>
  				<td>所属被检对象类别：</td>
  				<td  width="70%">
  					<input id="objectTypeName" name="objectTypeName" size="20" readOnly type="text" value="">
  					<input id="objectType" name="objectType" size="20"  type="hidden" value="">
  					<font color="orange">*</font>
  					<img onclick="showObjectCheckTree();"  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
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

</div>
</form>
</body>
</html>
<script language=javascript>
initValue();
</script>