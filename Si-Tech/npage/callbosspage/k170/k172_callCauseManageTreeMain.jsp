<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 098权限角色管理->维护权限功能->新增(业务逻辑)
　 * 版本: 1.0.0
　 * 日期: 2008/1/16
　 * 作者: fangyuan
　 * 版权: sitech
   * update:   yinzx 2009/07/17  客服功能调试  1.修改界面样式 opCode
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "K410";
	String opName = "来电原因维护";
%>
<html>
<head>
<title>来电原因维护</title>

<script language=javascript>

function addttt(){

myFrame.window.insertCause();

}
function modifyttt(){
 myFrame.window.updateCause();

}
function delttt(){
myFrame.window.delCause();

	}

function closettt()
{
  window.close();
}

function relation(){
 	var tree = myFrame.window.tree;
 	var sel_id= tree.getSelectedItemId();
	var sel_text=tree.getSelectedItemText();
	var city_no = tree.getUserData(sel_id,"cityid");
	var height = 450;
	var width = 500;
	var top = (screen.availHeight - height)/2;
	var left = (screen.availWidth - width)/2;
	var winParam = "height="+height+",width="+width+",top="+top+",left="+left+",toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=yes";
	window.open("../k171/k171_callcause_ivr_knowledage.jsp?sel_text="+sel_text+"&sel_id="+sel_id+"&city_no="+city_no,"callcause_ivr_knowlodage",winParam);
}

$(document).ready(function() {
	var workPanelHeight = parent.document.getElementById("workPanel").clientHeight;
	document.getElementById("myFrame").style.height = workPanelHeight - 160;
});

window.onresize = function() {
	var workPanelHeight = parent.document.getElementById("workPanel").clientHeight;
	document.getElementById("myFrame").style.height = workPanelHeight - 160;
}
</script>
</head>
<body>

<form name="form1" method="POST" action="">
 	<div id="Operation_Table">
	<div class="title"><div id="title_zi">来电原因功能树</div></div>
	<table  cellspacing="0">
  	<tr>
  		<td>
	     <input name="add" type="button" class="b_text"  id="add" value="增加" onClick="addttt();return false;">
	     <input name="modify" type="button"  class="b_text" id="modify" value="修改" onClick="modifyttt();return false;">
			 <input name="delete" type="button" class="b_text" id="delete" value="删除" onClick="delttt();return false;">
			 <input type="button" class="b_text" id="relateButton" value="维护三维一体" disabled="disabled" onClick="relation();return false;">
	     <!--<input name="close" type="button" class="b_text" id="close" value="关闭" onClick="closettt();return false;"> -->
  		</td>
  	</tr>
	</table>

	<div id="frameDiv" style="width:52%;height:100%;float:left;">
		<iframe name="myFrame" id="myFrame" src="k172_callCauseManageTree.jsp" style="width:100%;" frameborder="0"></iframe>
	</div>

	<div style="width:47%;float:right;">
		<table>
			<tr>
				<td width="20%" class="blue" >
					当前维护节点
				</td>
				<td class="blue">
					<div id="nodeName" align="top"></div>
				</td>
			</tr>
			<tr>
				<td width="20%" class="blue">
		      所属地市
				</td>
				<td width="80%" class="blue">
					<div id="node_city" align="top"></div>
				</td>
			</tr>
			<tr>
				<td width="20%" class="blue">
		      来电编码
				</td>
				<td width="80%" class="blue">
					<div id="tele_code" align="top"></div>
				</td>
			</tr>
			<tr>
				<td width="20%" class="blue">
				  节点编码
				</td>
				<td width="80%" class="blue">
					<div id="node_code" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					上级节点
				</td>
				<td width="80%" class="blue" >
					<div id="super_id" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					节点描述
				</td>
				<td width="80%" class="blue" >
					<div id="node_bak" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					来电类型
				</td>
				<td width="80%" class="blue" >
					<div id="call_type" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					全路径
				</td>
				<td width="80%" class="blue" >
					<div id="full_name" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					是否显示
				</td>
				<td width="80%" class="blue" >
					<div id="flag" align="top"></div>
				</td>
			</tr>
		</table>
	</div>
	</div>
</form>

</body>
</html>
