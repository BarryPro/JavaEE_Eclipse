<%@ page language="java"  pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String flag = ( null == request.getParameter("flag") ? "0" : request.getParameter("flag") );
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
%>
<HTML>
<HEAD>
<title>����IVR</title>
<SCRIPT type=text/javascript>
var inFlag = '<%=flag%>';
var CalledNo = "10086";

var array_yuyin = new Array();
var array_yewu = new Array();
var ids = new Array();

window.onload = function(){
//	document.getElementById("called_no").value=CalledNo;
	document.getElementById("inFlag").value="<%=flag%>";
	var checkboxs = $("input:checkbox",window.dialogArguments.document.getElementById("ivr"));
	
	if(checkboxs.length != 0){
		for(var i=0 ;i < checkboxs.length ;i++){
			ids[i] = checkboxs.eq(i).val();
		}
	}
	//��ʼ������ԭ����,��ҪCalledNo(������),inFlag(����,ҵ�������������)
	initRootNodes('baseTree', '0', '0', '1',CalledNo,inFlag);
}

/*
@function ���Ѿ���ѡ�ڵ�
*/
function check(id){
	var checkBoxItem = document.getElementById("chk" + id);
	if(checkBoxItem)
		checkBoxItem.checked=true;
	return checkBoxItem;
}

function checkedSelected(){
	if(ids.length != 0){
		for(var i =0 ;i<ids.length;i++){
			var checkBoxItem = check(ids[i]);
			if(checkBoxItem){
				checkBoxItem.disabled = true;
			}
		}
	}
	if(inFlag == "0" && array_yewu.length != "0"){
		for(var i=0 ; i < array_yewu.length; i++){
			check(array_yewu[i].id);	
		}
	}else if(inFlag =="1" && array_yuyin.length != "0"){
		for(var i=0 ;i <array_yuyin.length ;i++){
			check(array_yuyin[i].id);
		}
	}
}

//���������ĸı���������ivr��
function rebuildTree(){
//	CalledNo = document.getElementById("called_no").value;
	inFlag = document.getElementById("inFlag").value;
	initRootNodes('baseTree', '0', '0', '1',CalledNo,inFlag);
}


function spanClick(parSpan) {
	var par_id = parSpan.id.substring(1,parSpan.id.length-4);
	changeColor(parSpan);
	//var parSpan = document.getElementById('m' + par_id + 'span');
	//��Է�Ҷ�ӽڵ㣬�򿪼�������,is_Leaf='0'��ʾ��Ҷ�ӽڵ�
	if (parSpan.is_Leaf == '0') {
		if (parSpan.isOpen == '0') {
			if (parSpan.hasLoad == '0') {
				getChildren(parSpan,document.getElementById("inFlag").value,CalledNo);
				parSpan.isOpen = '1';
				parSpan.hasLoad='1';
				hideOrShow_(parSpan);
			} else {
				parSpan.isOpen = '1';
				hideOrShow_(parSpan);
			}
		}else {
			parSpan.isOpen = '0';
			hideOrShow_(parSpan);
		}
	} else {
		var checkBoxItem = $(parSpan).prevAll("input[type='checkbox']").get(0);
		if (checkBoxItem.checked == false) {
				checkBoxItem.checked = true;
				checkBoxClick(checkBoxItem);
		} else {
				if(!isExists(ids,par_id)){
					checkBoxItem.checked = false;
					checkBoxClick(checkBoxItem);
				}
		}
	}
}

function img2Click(img2) {
	spanClick($(img2).nextAll("span").get(0));
}


function img1Click(img1){
	spanClick($(img1).nextAll("span").get(0));
}

function spandblClick(parSpan){
	spanClick(parSpan);
}

/*
@function ������array��ɾ��valueֵ��Ԫ��
*/
function remove(array,value){
	for(var i=0 ;i<array.length;i++){
		if(value.id == array[i].id && value.servicename == array[i].servicename){
			array.splice(i,1);
			return;
		}
	}
}

//��ѡ��ѡ��ʱ���¼�,
function checkBoxClick(checkBoxItem) {
	//var parSpan = document.getElementById('m' + id + 'span');
	var parSpan = $(checkBoxItem).nextAll("span").get(0);
	//is_Leaf="0"��ʾ�ǷǸ��ڵ�,is_Leaf="1"��ʾ�Ǹ��ڵ�
	var is_Leaf = parSpan.is_Leaf;
	var digitcode = parSpan.digitcode;
	var ttansfercode = parSpan.ttansfercode;
	var typeId = parSpan.typeid;
	var usertype = parSpan.usertype;
	var servicename = parSpan.servicename;
	changeColor(parSpan);
	var value = checkBoxItem.value;
	var item = {"id":value,"servicename":servicename};
	if (checkBoxItem.checked == false) {
		if(inFlag == "0"){
			remove(array_yewu,item);
		}else if(inFlag == "1"){
			remove(array_yuyin,item);
		}
	} else {
		if(is_Leaf == "0"){
			checkBoxItem.checked=false;
			return;
		}
		if(inFlag == "0"){
			array_yewu.push(item);
		}
		else if(inFlag == "1"){
			array_yuyin.push(item);
		}
	}
}


function isExists(array,id){
	for(var i=0;i<array.length;i++){
		if(array[i] == id)
			return true;
	}
	return false;
} 
 
function isInShowName(node_id) {
	var els = parent.document.form1.select_Name.options;
	if (els.length < 0)
		return false;
	for ( var i = 0; i < els.length; i++) {
		if (els[i].value == node_id) {
			return true;
		}
	}
	return false;
}

/*�ύ��������*/
function submit(){
	var par_win = window.dialogArguments;
	var result = "";
	par_win.generateCheckBox(array_yewu,0);
	par_win.generateCheckBox(array_yuyin,1);
	window.close();
}



//�Ƿ���ڸ�ѡ��
var hasSelectOption = "1";
//��ǰ������span
var operateSpan = null;

with (document) {
	write("<STYLE TYPE='text/css'>");
	write(".parent { font: 12px/14px; margin:0px; Times; text-decoration: none; color: black;}");
	write(".child { font:12px/14px margin:0px; Times; display:none;color:black;}");
	write(".child_show { font:12px/14px margin:0px; Times; display:block;color:black;}");
	write(".item { color: black;border:0px; margin:0px; text-decoration:none; cursor: hand;display: inline  }");
	write(".highlight { color: blue; text-decoration:none }");
	write(".icon { margin-right: 5 }")		
	write("</STYLE>");
}

//��¼��ʼ�����ĸ��ڵ�
//var parentNodeId ;
//��ʼ�����ڵ㣬divId����¼������div��id��par_id����¼�����ڵ��ID��isRoot��0��ʾ���ڵ�,1��ʾ�ӽڵ㣬ʵ����Ҫ�����ݿ� ��hasSelect���Ƿ���Ҫ��ѡ��
function initRootNodes(divId,par_id,isVisual,hasSelect,CalledNo,inFlag){
  hasSelectOption = hasSelect;
  //parentNodeId = divId;
  var packet = new AJAXPacket("/npage/callbosspage/k171/k171_mixedtree_rpc.jsp?","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("CalledNo",CalledNo);
  packet.data.add("inFlag",inFlag);
  packet.data.add("nodeId",par_id);
  packet.data.add("nodeLevel","0");
  packet.data.add("inFlag",inFlag);
  packet.data.add("isRoot","1");
  packet.data.add("isVisual",isVisual);
  packet.data.add("hasSelectOption",hasSelectOption);
  packet.data.add("hasSelectNodes",window.dialogArguments.document.getElementById("node_Id").value);
  core.ajax.sendPacket(packet,function(packet){getInitCallBack(packet,divId);},true);
	packet=null;
}



function getInitCallBack(packet,parentNodeId){
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  var curPardiv=document.getElementById(parentNodeId);
  curPardiv.className='child_show';
  curPardiv.innerHTML = nodesHtml;
}

/**
* ��ȡ�ӽڵ�
*/
function getChildren(parSpan,inFlag,calledNo){
  var packet = new AJAXPacket("/npage/callbosspage/k171/k171_mixedtree_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  var par_id = parSpan.id.substring(1,parSpan.id.length-4);
  packet.data.add("nodeId",par_id);
  packet.data.add("CalledNo",CalledNo);
  var reg = /[+]/g;
  var servicename = parSpan.servicename.replace(reg,"#");
  packet.data.add("servicename",servicename);
  packet.data.add("nodeLevel",parSpan.nodeLevel);
  packet.data.add("inFlag",inFlag);
  packet.data.add("isRoot","0");
  packet.data.add("hasSelectNodes",window.dialogArguments.document.getElementById("node_Id").value);
  packet.data.add("lastChildRoute",parSpan.lastChildRoute);
  packet.data.add("hasSelectOption",hasSelectOption);
  core.ajax.sendPacket(packet,function(packet){getChildCallBack(packet,parSpan);},true);
	packet=null;
}

function getChildCallBack(packet,parSpan){
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  var servicename = packet.data.findValueByName("servicename");
  //var curPardiv=document.getElementById("m"+nodeId+"Child");
  var curPardiv=$(parSpan).parent().parent().next().next();
  if(curPardiv){
	  curPardiv.append(nodesHtml);
	  parSpan.hasLoad='1';
	}
}

function hideOrShow_(parSpan){
	var imgs = $(parSpan).prevAll("img");
	var img1div=imgs.get(1);
	var img2div=imgs.get(0);
	var pardiv=$(parSpan).parent().parent().next().next().get(0);
	var pardiv2=parSpan
	if(pardiv){
		if(pardiv2.isOpen=='0'){
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tplus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lplus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/foldericon.gif";
			pardiv.style.display='none';
		}
		else{
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tminus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lminus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/openfoldericon.gif";
			pardiv.style.display='block';
		}
	}
}

function changeColor(curSpan){
	if(operateSpan){
		operateSpan.style.color = '#000000';
		operateSpan.style.backgroundColor = '';
	}
	operateSpan = curSpan;
	if(curSpan){
		curSpan.style.color = '#FFFFFF';
		curSpan.style.backgroundColor = '#000BB0';
	}
}

</SCRIPT>  
</HEAD>
<BODY>
<table>
	<tr>
		 <td>�������</td>
		 <td>
		 	<select id="inFlag" name="inFlag" onchange="rebuildTree();">
		 		<option value="0">תҵ�����</option>
		 		<option value="1">ת��ѯ����</option>
		 	</select>
		 	<input type="button" value="ȷ��" class="b_text" onclick="submit()"/>
		 </td>
	</tr>
</table>
<TABLE>
	<TR>
		<TD vAlign=top>
		<DIV id="baseTree"></DIV>
		</TD>
		<TD vAlign=top>
		<DIV id="childTree"></DIV>
		</TD>
	</TR>
</TABLE>
</BODY>
</html>