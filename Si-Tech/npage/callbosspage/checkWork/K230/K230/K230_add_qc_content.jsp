<%
  /*
   * ����: ��ӿ�������ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@page contentType="text/html;charset=GBK"%>
<html>
<head>
<title>��ӿ�������</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script>


function grpClose(){
window.opener = null;
window.close();
}


//�ж��Ƿ�������
function isNumber(ee){
	if(!ee) return false;
  if(isNaN(ee)){
  	rdShowMessageDialog('Ȩ�ر���Ϊ����', 0);
  	document.getElementById("weight").value="";
  	document.getElementById("weight").focus();
  }
  if(ee<=0){
  	rdShowMessageDialog('Ȩ�ر��������', 0);
  	document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }
  var tmpPos = ee.lastIndexOf('.');
  var subWeightLength = ee.substr(tmpPos).length;
  if(subWeightLength>3){
    rdShowMessageDialog('Ȩ�����ֻ��������С��λ��', 0);
    document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }	
  return true;
}


/*�Է���ֵ���д���*/
function doProcessAddQcContent(packet)
{
	//alert("Begin call doProcessAddQcContent()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");
	if(retType=="submitQcContent"){
		if(retCode=="000000"){
			
			insertTable(content_id);
			if(rdShowConfirmDialog("��ӿ������ݳɹ����Ƿ�������",2) != 1){
					window.opener = null;
					window.close();
			}

		}else{
			rdShowMessageDialog('��ӿ�������ʧ��',0);
			return false;
		}
	}
	//alert("End call doProcessAddQcContent()......");
}

/**
  *
  *���������ݲ��뵽��ҳ��ı��֮��
  *
  */
function insertTable(content_id){

	var content_name   = document.getElementById("content_name").value;
	var source_id      = document.getElementById("source_id").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;
	var source_content;
	var auto_get_val;
	if("0"==source_id){
		source_content = "ͨ����¼";
	} else if("1"==source_id){
		source_content = "������¼";
	} else if("2"==source_id){
		source_content = "�ʼ���";
	} else if("3"==source_id){
		source_content = "ͳ������";
	}
	if("Y"==auto_get){
		auto_get_val = "��";
	} else{
		auto_get_val = "��";
	}
	
	var parWin = window.dialogArguments;
	var table  =  parWin.document.getElementById("contentTable");
	var tr     = table.insertRow();
	tr.className = "blue";
	tr.insertCell().innerHTML = "<input type='radio' name='check_content' value='"+content_id+"' onClick='getCheckItem(this.value)'/>"
	tr.insertCell().innerHTML = content_name;
	tr.insertCell().innerHTML = source_content;
	tr.insertCell().innerHTML = weight;
	tr.insertCell().innerHTML = auto_get_val;
	tr.insertCell().innerHTML = formula;
}

/**
  *
  *��ӿ�������
  *
  */
function submitQcContent()
{
	//alert("Begin call submitQcContent()....");
	var content_name = document.getElementById("content_name").value;
    var note = document.getElementById("note").value;
    var formula = document.getElementById("formula").value;
	//У��
	if(content_name == ''){
		rdShowMessageDialog('û�����뿼���������ƣ�', 0);
		return false;
	}
	if(formula == ''){
		rdShowMessageDialog('û�����뿼�����ݼ��㹫ʽ��', 0);
		return false;
	}
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_qc_content.jsp","���Ժ�...");

    var object_id      = document.getElementById("object_id").value;
    var source_id      = document.getElementById("source_id").value;
    var content_name   = document.getElementById("content_name").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;
    var note           = document.getElementById("note").value;
    var crete_login_no = "01";

    //alert(formula.replace("/+/g","%20"));
    //alert(formula.split("+").join("%2B"));


    chkPacket.data.add("retType","submitQcContent");
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("source_id", source_id);
    chkPacket.data.add("content_name", content_name);
    chkPacket.data.add("weight", weight);
    chkPacket.data.add("auto_get", auto_get);
    chkPacket.data.add("formula", formula.split("+").join("%2B"));
    chkPacket.data.add("note", note);
    chkPacket.data.add("crete_login_no", crete_login_no);


    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,false);
	chkPacket =null;
	//alert("End call submitQcContent()....");
}


/**
  *У����㹫ʽ
  */
function verify(){
	/*
	var formula = document.getElementById("formula").value;
	if(formula == ''){
		rdShowMessageDialog('���㹫ʽΪ�գ��޷�У�飡', 0);
		return false;
	}
	*/
	var time =new Date();
	var formula = document.getElementById('formula').value;
	window.showModalDialog("K230_verify_formula.jsp?time=" + time+"&formula="+formula.split("+").join("%2B"),"","");
}


</script>

</head>
<body>

<form  name="formbar">

<input type="hidden" name="object_id" id="object_id" value="<%=request.getParameter("object_id")%>"/>
<input type="hidden" name="crete_login_no" id="crete_login_no" value="N"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>��ӿ�������</B></div>
    <div id="Operation_Table">
    <div class="title"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">

      <tr>
      	<td width="16%" class="blue">���</td>
        <td width="34%">
		<input id="contect_id" value="�Զ�����" readonly>
        </td>
        
        <td width=16% class="blue">����</td>
        <td width="34%">
        <input id="content_name" name="content_name" maxlength="25" v_must="1" v_type="string" onBlur="checkElement(this)" /><font class="orange">*</font>
        </td>        

        <td width=16% class="blue">����������Դ</td>
        <td width="34%">
	 	    <select name="source_id" id="source_id">
	 		<option value="0">ͨ����¼</option>
	 		<option value="1">������¼</option>
	 		<option value="2">�ʼ���</option>
	 		<option value="3">ͳ������</option>
        	</select>
        </td>
      </tr>

      <tr>
         <td width=16% class="blue">�Զ���ȡ�����¼</td>
         <td width="34%">
	 	    <select name="auto_get" id="auto_get">
	 		<option value="Y">��</option>
	 		<option value="N">��</option>
        	</select>
         </td>
         
        <td width=16% class="blue">Ȩ��</td>
        <td width="34%" colspan='3'> 
        	<input id="weight" name="weight" size="8" maxlength="8" v_must="1" v_type="string" onBlur="checkElement(this);isNumber(this.value);"/><font class="orange"/>*</font>
        </td>    
      </tr>
      <tr>
         <td width=16% class="blue">���㹫ʽ</td>
         <td width="34%" colspan="5">
			<input id="formula " name="formula" maxlength="100" v_must="1" v_type="string" onBlur="checkElement(this)" /><font class="orange"/>*</font>
        	<input type="button" name="confirmBtn" value="У��" onClick="verify();"/>
         </td>

      </tr>
      <tr>
         <td width=16% class="blue">����</td>
         <td width="34%" colspan="5">
			<input id="note " name="note" size="50" maxlength="250" value="" />
         </td>
      </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="submitQcContent()">
        	<input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="���">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="�ر�"  >
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




