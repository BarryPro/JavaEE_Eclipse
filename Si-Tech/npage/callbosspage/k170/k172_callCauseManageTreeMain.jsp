<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->����(ҵ���߼�)
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:   yinzx 2009/07/17  �ͷ����ܵ���  1.�޸Ľ�����ʽ opCode
�� */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "K410";
	String opName = "����ԭ��ά��";
%>
<html>
<head>
<title>����ԭ��ά��</title>

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
	<div class="title"><div id="title_zi">����ԭ������</div></div>
	<table  cellspacing="0">
  	<tr>
  		<td>
	     <input name="add" type="button" class="b_text"  id="add" value="����" onClick="addttt();return false;">
	     <input name="modify" type="button"  class="b_text" id="modify" value="�޸�" onClick="modifyttt();return false;">
			 <input name="delete" type="button" class="b_text" id="delete" value="ɾ��" onClick="delttt();return false;">
			 <input type="button" class="b_text" id="relateButton" value="ά����άһ��" disabled="disabled" onClick="relation();return false;">
	     <!--<input name="close" type="button" class="b_text" id="close" value="�ر�" onClick="closettt();return false;"> -->
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
					��ǰά���ڵ�
				</td>
				<td class="blue">
					<div id="nodeName" align="top"></div>
				</td>
			</tr>
			<tr>
				<td width="20%" class="blue">
		      ��������
				</td>
				<td width="80%" class="blue">
					<div id="node_city" align="top"></div>
				</td>
			</tr>
			<tr>
				<td width="20%" class="blue">
		      �������
				</td>
				<td width="80%" class="blue">
					<div id="tele_code" align="top"></div>
				</td>
			</tr>
			<tr>
				<td width="20%" class="blue">
				  �ڵ����
				</td>
				<td width="80%" class="blue">
					<div id="node_code" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					�ϼ��ڵ�
				</td>
				<td width="80%" class="blue" >
					<div id="super_id" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					�ڵ�����
				</td>
				<td width="80%" class="blue" >
					<div id="node_bak" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					��������
				</td>
				<td width="80%" class="blue" >
					<div id="call_type" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					ȫ·��
				</td>
				<td width="80%" class="blue" >
					<div id="full_name" align="top"></div>
				</td>
			</tr>
			<tr class="grey" >
				<td width="20%" class="blue" >
					�Ƿ���ʾ
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
