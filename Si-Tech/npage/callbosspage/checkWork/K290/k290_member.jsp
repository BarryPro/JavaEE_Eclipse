<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά���ʼ�Ա����->��Ա����ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: donglei
�� * ��Ȩ: sitech
   * update:
   *           mixh 2009/02/11 ��Ϊÿ��չʾ300��
   *          
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>
	<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/css/dtmltree_css/style.css"
			type=text/css rel=STYLESHEET>
<style  TYPE='text/css'>
	.item_a  { text-decoration:none;cursor: hand; }
</style>
	</HEAD>
	<BODY>
		<form name="testForm">
		<TABLE width="100%" border="0" height="420">
				<TR>
				<TD>
		    <div id="dataTableDiv">
	
       </div>
			</TD>
			</TR>
		</TABLE>
		</form>
	</BODY>
</html>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>

<SCRIPT type=text/javascript> 
//parent.rightFootFrame.window.showTable();
	// ˵���� �� Javascript ��֤����form���ж�ѡ��checkbox��ֵ
function getCheckboxValue(checkbox)
{
	if (!checkbox.length && checkbox.type.toLowerCase() == 'checkbox') 
	{ return (checkbox.checked)?checkbox.value:''; }
	
	if (checkbox[0].tagName.toLowerCase() != 'input' || 
		checkbox[0].type.toLowerCase() != 'checkbox')
	{ return ''; }

	var val = [];
	var len = checkbox.length;
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked)
		{
			val[val.length] = checkbox[i].value;
		}
	}
	
	return (val.length)?val:'';
}

// ˵���� �� Javascript ��֤����form���еĵ�ѡ��radio��ֵ
function getRadioValue(radio)
{
	if (!radio.length && radio.type.toLowerCase() == 'radio') 
	{ return (radio.checked)?radio.value:'';  }

	if (radio[0].tagName.toLowerCase() != 'input' || 
		radio[0].type.toLowerCase() != 'radio')
	{ return ''; }

	var len = radio.length;
	for(i=0; i<len; i++)
	{
		if (radio[i].checked)
		{
			return radio[i].value;
		}
	}
	return '';
}
// ��ȡ��ǰѡ������
function ischeckBoxSelect(selectedItemId){
var checkBoxValue=parent.rightTopFrame.window.getCheckboxValue();
var radioValue=parent.rightTopFrame.window.getRadioValue();
if(checkBoxValue==""){
	var dataTable = document.getElementById("dataTable");
	clearRow(dataTable);
	return;
	}
 getLoginNo(selectedItemId,checkBoxValue,radioValue);
 }
function getLoginNo(selectedItemId,checkBoxValue,radioValue){
// ���������һ������ת�������򲻻�������
	var strCheckBoxValue="" + checkBoxValue;
  var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K290/k290_getLoginNoList.jsp","aa");
	packet.data.add("selectedItemId",selectedItemId);
	packet.data.add("checkBoxValue",strCheckBoxValue);
	packet.data.add("radioValue",radioValue);
	core.ajax.sendPacket(packet,doProcessLoginNo,false);
	packet=null;
}

//getLoginNo�Ļص�����
function doProcessLoginNo(packet){
   	var loginNoList = packet.data.findValueByName("nodes");
   	insertTable_(loginNoList);
}
function setGroupLoginNoNum(tree,num){
	if(tree.getUserData(tree.getSelectedItemId(),"flag")!='0'){
	if(tree.getUserData(tree.getSelectedItemId(),"isleaf")=='Y'){
		tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')��');
		tree.setUserData(tree.getSelectedItemId(),"flag",'0');	
	}else{
		tree.setItemText(tree.getSelectedItemId(),tree.getSelectedItemText()+'('+num+')��,��������������');
		tree.setUserData(tree.getSelectedItemId(),"flag",'0');	
		}
	}
	} 
function insertTable_(dataStr){	
	var dataTableDiv = document.getElementById("dataTableDiv");
	dataTableDiv.innerHTML = dataStr;
}
//�������
function insertTable(dataArr,flag){
	var dataTable = document.getElementById("dataTable");
	clearRow(dataTable);
	var rowObj = dataTable.insertRow();
	var m=0;
	var cellObj2;
	var strArr=new Array();
	if(flag!=""){
		strArr=flag.split(",");
		}
	var temp_str = new Array();
	for(var i = 0; i <dataArr.length; i++ ){
		m = i%300;
		
		if(i == 0 || m == 0){
			if(i!=0){
			  cellObj2.innerHTML = temp_str.join('\n');
		  }
			cellObj2 = rowObj.insertCell();
			temp_str = new Array();
			if(isStr(dataArr[i][2],strArr)){
			temp_str.push("<input type='checkbox' checked='checked' isgroup='true'  name='loginNo' value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>");	
			}else{
			temp_str.push("<input type='checkbox' name='loginNo' isgroup='false'  value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>");		
			}
      cellObj2.setAttribute("vAlign","top");
      cellObj2.setAttribute("width",160);
      cellObj2.setAttribute("class","title_zi");
      cellObj2.setAttribute("height",420);
		}else{			
			if(isStr(dataArr[i][2],strArr)){
			temp_str.push("<input type='checkbox' checked='checked' isgroup='true'   name='loginNo' value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>");	
			}else{
			temp_str.push("<input type='checkbox' name='loginNo' isgroup='false'  value='"+dataArr[i][2]+"'/>"+dataArr[i][2]+""+dataArr[i][1]+"<br/>");		
			}
		}
		
	}
	if(dataArr.length>0){
		cellObj2.innerHTML = temp_str.join('\n');
	}
 
}
//������
function clearRow(objTable){ 
var length= objTable.rows.length ; 
for( var i=0; i<length; i++ )
{
objTable.deleteRow(i); 
}
}
  function   findInPage(str)     
  {     
    var   txt,   i,   found,n   =   0;     
    if   (str == "")     
    {     
      return   false;     
    }     
    txt   =   document.body.createTextRange();     
    for   (i   =   0;   i   <=   n   &&   (found   =   txt.findText(str))   !=   false;   i++)     
    {     
      txt.moveStart("character",   1);     
      txt.moveEnd("textedit");     
    }     
    if   (found)     
    {     
      txt.moveStart("character",   -1);     
      txt.findText(str);     
      txt.select();     
      txt.scrollIntoView();     
      n++;         
    }else{     
      if   (n   >   0){     
        n   =   0;     
        findInPage(str);     
      }else{     

      }     
    }     
    return   false;     
  }
  
//��Χѡ��λ����
function selectCheckLoginNo(flag,loginNo) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == 'loginNo')) {
            if(loginNo==el[i].value){
            	if(flag=='0'){
            	 el[i].checked = true;
            	}
	            if(flag=='1'){
	            	el[i].checked = false;
	            }	 
            }
        }
    }
}

/**
  *��Χѡ����
  *mixh add 20090402
  */
function selectRange(flag, start, end) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    /*modify by zhengjiang 20090925 start el[i].value��.substring(2)*/
    if(flag == '0'){
	    for (var i = 0; i < len; i++) {
	    	if(Math.floor(el[i].value.substring(2)) >= Math.floor(start) && Math.floor(el[i].value.substring(2)) <= Math.floor(end)){
	    		el[i].checked = true;
	    	}
	    }    	
    }else if(flag == '1'){
	    for (var i = 0; i < len; i++) {
	    	
	    	if(Math.floor(el[i].value.substring(2)) >= Math.floor(start) && Math.floor(el[i].value.substring(2)) <= Math.floor(end)){
	    		el[i].checked = false;
	    	}
	    } 
    }
    /*modify by zhengjiang 20090925 end el[i].value��.substring(2)*/
}

//���ȫ��ѡ�и�ѡ��
function clearAll(name) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == name)) {
            el[i].checked = false;
        }
    }
}
//ѡ��ȫ����ѡ��
function checkAll(name) {
    var el = document.getElementsByTagName('input');
    var len = el.length;
    //alert(len);
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == name)) {
            el[i].checked = true;
        }
    }
}
//��ѡ��ť����Ӧ�¼�
function isRadioSelect(){
var selectItemId=parent.frameleft.window.tree.getSelectedItemId();
setHiddenOrShow();
ischeckBoxSelect(selectItemId);
 }
//���ò�����ť���ػ�����ʾ
function setHiddenOrShow(){
var radioValue=parent.rightTopFrame.window.getRadioValue();
if(radioValue=='selfAndSub'){

	parent.rightFootFrame.window.hiddenTable();
	}
if(radioValue=='self'){
    parent.rightFootFrame.window.showTable();

	}
}
 //�ж�һ���ַ����Ƿ��������г���
function isStr(str,strArr){
	if(strArr!=null&&strArr!=''){
		for(var j=0;j<strArr.length;j++){
     		if(str==strArr[j]){
     			return true;
     		}
		}
	}
	return false;
}
function getUnCheckboxValue()
{
	var checkbox =document.all('loginNo');
	var val = [];
	var len = checkbox.length;
	if(len=='undefined'||len==undefined){
	 if (checkbox.checked&&checkbox.isgroup=='false')
	 {
			return checkbox.value;
	 }else{
	 	  return '';
	 	}
	}else{
	for(i=0; i<len; i++)
	{
		if (checkbox[i].checked&&checkbox[i].isgroup=='false')
		{
			val[val.length] = checkbox[i].value;
		}
	}
	}
	return (val.length)?val:'';
}
function getGroupCheckboxValue()
{
	var checkbox =document.all('loginNo');
	var val = [];
	var len = checkbox.length;
	if(len=='undefined'||len==undefined){
	 if (!checkbox.checked&&checkbox.isgroup=='true')
	 {
			return checkbox.value;
	 }else{
	 	  return '';
	 	}
	}else{
	for(i=0; i<len; i++)
	{
		if (!checkbox[i].checked&&checkbox[i].isgroup=='true')
		{
			val[val.length] = checkbox[i].value;
		}
	}
	}
	return (val.length)?val:'';
}

//�������
function saveChange(){
	var loginNo=document.all('loginNo');
	if(loginNo=='undefined'||loginNo==null||loginNo==undefined){
		similarMSNPop("�Բ�����ѡ������Ӧ�Ĺ��ţ�");
		return;
	}
	var unCheckValue=getUnCheckboxValue();
	var groupCheckValue=getGroupCheckboxValue();
	if(unCheckValue==''&&groupCheckValue==''){
		similarMSNPop("�Բ�����û�жԸ����Ա�����޸ģ�");
		return;
	}else{
		saveCheckLoginNo(parent.frameleft.window.tree.getSelectedItemId(),unCheckValue,groupCheckValue);
	}
}

function saveCheckLoginNo(selectedItemId,unCheckValue,groupCheckValue){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K290/k2901/k290_saveLoginNo.jsp","aa");
	packet.data.add("selectedItemId",selectedItemId);
	packet.data.add("unCheckValue",""+unCheckValue);
	packet.data.add("groupCheckValue",""+groupCheckValue);
	core.ajax.sendPacket(packet,doProcessCheckLoginNo,true);
	packet=null;
}

//getLoginNo�Ļص�����
function doProcessCheckLoginNo(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode="000000"){
		ischeckBoxSelect(parent.frameleft.window.tree.getSelectedItemId());
		similarMSNPop("����ɹ���");
		//parent.frameleft.window.location.reload();
	} else {
		similarMSNPop("����ʧ�ܣ�");
		return;
	}
}

function cancel(){
	if(rdShowConfirmDialog('��ȷ���˳���')==1){
		window.top.close();
		}
	
}

function showCheckItemWin(){
	var time     = new Date();
	var winParam = 'dialogWidth=360px;dialogHeight=220px';
	window.showModelessDialog("k290_selectCheckOrUnCheckWin.jsp?time="+time,window, winParam);
}
function memberMsgWin(){

	var time     = new Date();
	var winParam = 'dialogWidth=400px;dialogHeight=240px';
	window.showModalDialog("k290_showLoginNoInfoWin.jsp?time="+time,window, winParam);
}

function showStaffInfo(work_no){
	var winParam = 'dialogWidth=520px;dialogHeight=480px';
	window.showModalDialog("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/K280_staff_info.jsp?work_no="+work_no,window, winParam);
}

</SCRIPT>