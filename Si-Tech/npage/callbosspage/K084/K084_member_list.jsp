<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<HTML>
	<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/style.css"
			type=text/css rel=STYLESHEET>
	</HEAD>
	<BODY>
		<form name="testForm">
		<TABLE width="100%" border="0" height="420">
				<TR>
				<TD>
		<TABLE id="dataTable" border="0" height="420" >
		</TABLE>
			</TD>
			</TR>
		</TABLE>
		</form>
	</BODY>
</html>
<SCRIPT type=text/javascript> 
//parent.rightFootFrame.window.showTable();	

// ��ȡ��ǰѡ������
function ischeckBoxSelect(class_id){
	alert(class_id);
//var checkBoxValue=parent.rightTopFrame.window.getCheckboxValue();
//var radioValue=parent.rightTopFrame.window.getRadioValue();
 getLoginNo(class_id);
 }
function getLoginNo(class_id){
  var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K084/K084_getLoginNoList.jsp","aa");
	packet.data.add("class_id",class_id);
	core.ajax.sendPacket(packet,doProcessNo,false);
	packet=null;
}

//getLoginNo�Ļص�����
function doProcessNo(packet){
   	var loginNoList = packet.data.findValueByName("nodes");
   	alert(loginNoList);
   	var flag = "1,1";
    insertTable(loginNoList,flag);
    var num=loginNoList.length;
    //setGroupLoginNoNum(parent.frameleft.tree,num);

}
function setGroupLoginNoNum(tree,num){
	//alert(tree.getSelectedItemId()+tree.getSelectedItemText());
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
//��̬��������Ա�����
function insertTable(dataArr,flag){
	var dataTable = document.getElementById("dataTable");
	clearRow(dataTable);
	//dataTable.setAttribute("height",420);
	var rowObj = dataTable.insertRow();
	var m=0;
	var cellObj2;
	var strArr=new Array();
	if(flag!=""){
		strArr=flag.split(",");
		}
	for(var i = 0; i <dataArr.length; i++ ){
		m = i%2;
		if(i == 0 || m == 0){
			cellObj2 = rowObj.insertCell();
			alert("dataArr[i][0]"+dataArr[i][0]);
			cellObj2.innerHTML+= "<input type='checkbox' checked='checked' isgroup='true'  name='loginNo' value='"+dataArr[i][0]+"'/>"+dataArr[i][0]+""+dataArr[i][1]+"<br/>";	
      cellObj2.setAttribute("vAlign","top");
      cellObj2.setAttribute("width",100);
      cellObj2.setAttribute("class","title_zi"); 
      cellObj2.setAttribute("height",420);
		}else{			
			cellObj2.innerHTML+= "<input type='checkbox' checked='checked' isgroup='true'   name='loginNo' value='"+dataArr[i][0]+"'/>"+dataArr[i][0]+""+dataArr[i][1]+"<br/>";	
      cellObj2.setAttribute("vAlign","top");
      cellObj2.setAttribute("width",100);
        cellObj2.setAttribute("class","title_zi");
      cellObj2.setAttribute("height",420);
		}
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
        //alert(str   +   "...��Ҫ�ҵ����ֲ����ڡ�\n   \n����������ҳ���еĹؼ����ٴβ��ң�");     
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
           // alert("loginNo:"+loginNo+"el[i].value"+el[i].value);
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
    for (var i = 0; i < len; i++) {
        if ((el[i].type == "checkbox") && (el[i].name == name)) {
            el[i].checked = true;
           // el[i].flag="true";
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
//	alert("����");
	parent.rightFootFrame.window.hiddenTable();
	}
if(radioValue=='self'){
  parent.rightFootFrame.window.showTable();
	//alert("��ʾ");
	}
}
 //�ж�һ���ַ����Ƿ��������г���
function isStr(str,strArr){
	if(strArr!=null&&strArr!=''){
		for(var j=0;j<strArr.length;j++){
		//	alert("strArr[j] "+strArr[j]);
     		if(str==strArr[j]){
     			return true;
     		}
		}
	}
	return false;
}
//��ȡ����֮������ID
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
//��ȡ����ȡ��ID
function getGroupCheckboxValue()
{
	var checkbox =document.all('loginNo');
	var val = [];
	var len = checkbox.length;
	if(len=='undefined'||len==undefined){
		//alert(len);
	 if (!checkbox.checked&&checkbox.isgroup=='true')
	 {
			//alert(checkbox.value);
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
	rdShowMessageDialog("�Բ�����ѡ������Ӧ�Ĺ���",1);
	return;
	}
var unCheckValue=getUnCheckboxValue();
var groupCheckValue=getGroupCheckboxValue();
	if(unCheckValue==''&&groupCheckValue==''){
	rdShowMessageDialog("�Բ�����û�жԸ����Ա�����޸�",1);
	return;
}else{
	saveLoginNo(parent.frameleft.window.tree.getSelectedItemId(),unCheckValue,groupCheckValue);
	}
//	alert("����δѡ��"+unCheckValue);
//	alert("����ȡ����"+groupCheckValue);

}
function saveLoginNo(selectedItemId,unCheckValue,groupCheckValue){
// ���������һ������ת���������������
  var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K280/k2801/k280_saveLoginNo.jsp","aa");
	packet.data.add("selectedItemId",selectedItemId);
	packet.data.add("unCheckValue",""+unCheckValue);
	packet.data.add("groupCheckValue",""+groupCheckValue);
	core.ajax.sendPacket(packet,doProcessLoginNo,false);
	packet=null;
}

//getLoginNo�Ļص�����
function doProcessLoginNo(packet){
   	var retCode = packet.data.findValueByName("retCode");
   	if(retCode="000000"){
       ischeckBoxSelect(parent.frameleft.window.tree.getSelectedItemId());
       rdShowMessageDialog("\u5904\u7406\u6210\u529f",2);
    return;
		} else {
			rdShowMessageDialog("\u5904\u7406\u5931\u8d25",0);
			return false;
		}
}
//�˳�����
function cancel(){
	if(rdShowConfirmDialog('��ȷ���˳���')==1){
		window.top.close();
		}
	
}
function showCheckItemWin(){
	var height = 150;
	var width = 400;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no";
	window.open("k280_selectCheckOrUnCheckWin.jsp", "��Χѡ��", winParam);
}
function memberMsgWin(){
	var height = 300;
	var width = 400;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no";
	window.open("k280_showLoginNoInfoWin.jsp", "�鿴��Ա��Ϣ", winParam);
}
</SCRIPT>