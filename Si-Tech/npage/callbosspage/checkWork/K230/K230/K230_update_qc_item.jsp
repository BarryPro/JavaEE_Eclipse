<%
  /*
   * ����: ���¿�����ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K230";
	String opName = "���¿�����";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String item_id = WtcUtil.repNull(request.getParameter("item_id"));
String parentItem_id = WtcUtil.repNull(request.getParameter("parentItem_id"));
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String content_id = WtcUtil.repNull(request.getParameter("content_id"));

String sqlStr = "select item_name, to_number(weight), to_number(low_score), to_number(high_score), note, formula, bak2, is_scored " + 
                "from dqccheckitem where trim(item_id) = '" + item_id + "' and trim(object_id)='"+object_id+"' and trim(contect_id)='"+content_id+"'";

System.out.println("#######################################");
System.out.println(sqlStr);
System.out.println("#######################################");
%>

<wtc:service name="s151Select" outnum="8">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
System.out.println(queryList[0].length);
%>
<html>
<head>
<title>���¿�����</title>
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
function isNumber(e){
	if(!e) return false;
  if(isNaN(e)){
  	rdShowMessageDialog('Ȩ�ر���Ϊ����', 0);
  	document.getElementById("weight").value="";
  	document.getElementById("weight").focus();
  }
  if(e<=0){
  	rdShowMessageDialog('Ȩ�ر��������', 0);
  	document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }
  
  var tmpPos = e.lastIndexOf('.');
  var subWeightLength = e.substr(tmpPos).length;
  if(subWeightLength>3){
    rdShowMessageDialog('Ȩ�����ֻ��������С��λ��', 0);
    document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }	
  return true;
}

/*�Է���ֵ���д���*/
function doProcessupdateQcItem(packet)
{
	//alert("Begin call doProcessupdateQcItem()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var object_id = packet.data.findValueByName("object_id");
	if(retType=="updateQcItem"){
		if(retCode=="000000"){
			rdShowMessageDialog('���¿�����ɹ�', 2);
			var parWin = window.dialogArguments;
			parWin.tree.setItemText("<%=item_id%>",document.getElementById("item_name").value,document.getElementById("item_name").value);
			
		}else{
			rdShowMessageDialog('���¿�����ʧ��', 0);
			return false;
		}
	}
	//alert("End call doProcessupdateQcItem()......");
}

/**
  *
  *��ӱ���������
  *
  */
function updateQcItem()
{
	//alert("Begin call updateQcItem()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_update_qc_item.jsp","���Ժ�...");
    var object_id       = document.getElementById("object_id").value;
    var contect_id      = document.getElementById("contect_id").value;
    var is_leaf         = document.getElementById("is_leaf").value;
    var item_name       = document.getElementById("item_name").value;
    var low_score       = document.getElementById("low_score").value;
    var high_score      = document.getElementById("high_score").value;
    var weight          = document.getElementById("weight").value;
    var formula         = document.getElementById("formula").value; 
    var note            = document.getElementById("note").value;
    //var is_scored       = document.getElementById("isScore").value;
    var isDefault       = document.getElementById("isDefault").value;
    
    if(weight == ''){
		rdShowMessageDialog('û�����뿼����Ȩ�أ�', 0);
		return false;
	}
	if( low_score== ''){
		rdShowMessageDialog('û�����뿼������ͷ֣�', 0);
		return false;
	}
	if( high_score== ''){
		rdShowMessageDialog('û�����뿼������߷֣�', 0);
		return false;
	}
	if( item_name== ''){
		rdShowMessageDialog('û�����뿼�������ƣ�', 0);
		return false;
	}
	if(formula == ''&&(document.getElementById("forId").style.display!="none")){
		rdShowMessageDialog('û�����뿼������㹫ʽ��', 0);
		return false;
	}
    
    chkPacket.data.add("retType","updateQcItem");
    chkPacket.data.add("item_id", "<%=item_id%>");
    chkPacket.data.add("is_leaf", is_leaf);
    chkPacket.data.add("item_name", item_name);
    chkPacket.data.add("low_score", low_score);
    chkPacket.data.add("high_score", high_score);
    chkPacket.data.add("weight", weight);
    //chkPacket.data.add("formula", formula);
    chkPacket.data.add("formula", formula.split("+").join("%2B"));
    chkPacket.data.add("note", note);
     chkPacket.data.add("isDefault", isDefault);
    chkPacket.data.add("create_login_no", "aaaa");

    core.ajax.sendPacket(chkPacket,doProcessupdateQcItem,true);
	chkPacket =null;
	//alert("End call updateQcItem()....");
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
<input type="hidden" name="current_node_id" id="current_node_id" value="<%=request.getParameter("current_node_id")%>"/>
<input type="hidden" name="object_id" id="object_id" value="01"/>
<input type="hidden" name="contect_id" id="contect_id" value="01"/>
<input type="hidden" name="is_leaf" id="content_id" value="N"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial"></font>���¿�����</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      
      <tr>
      	<td width=16% class="blue">�ϲ�ڵ���</td>
        <td width="34%"> 
        	<input id="object_type" maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date"   value='<%=parentItem_id%>' disabled/>
        </td>
        <td width=16% class="blue">���</td>
        <td width="34%">
			<input id="object_name" value="ϵͳ�Զ�����" disabled/>
        </td>                 
      </tr>
      
      <tr>
      	<td width="16%" class="blue">�ڵ����</td>
        <td width="34%">
         	<select name="nodeType" disabled>
         		<option value="1">ͬ��ڵ�</option>
         		<option value="2">�ӽ��</option>
        	</select>
        </td>
        <td width=16% class="blue">����</td>
        <td width="34%">
			<input id="item_name" value="<%=queryList[0][0]%>" v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
        </td>             
      </tr>
    	
      <tr>
        <td width=16% class="blue">�Ƿ�������</td>
        <td width="34%">
	 	    <select name="isScore" id="isScore" disabled>
	 		<option value="1" <%if("1".equals(queryList[0][7].trim())){out.print("selected");}%>>��</option>
	 		<option value="0" <%if("0".equals(queryList[0][7].trim())){out.print("selected");}%>>��</option>
        	</select>    
        </td>        
        
        <td width=16% class="blue">�Ƿ�Ĭ����</td>
        <td width="34%">
         	<select name="isDefault" id="isDefault">
         		<option value="1" <%if("1".equals(queryList[0][6].trim())){out.print("selected");}%>>��</option>
         		<option value="0" <%if("0".equals(queryList[0][6].trim())){out.print("selected");}%>>��</option>
        	</select>         	
        </td>
      </tr>
      <tr>
         <td width=16% class="blue">��ͷ�</td>
         <td width="34%">
		<input id="low_score" value="<%=queryList[0][2]%>"  v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
         </td>
        <td width=16% class="blue">��߷�</td>
        <td width="34%"> 
        <input id="high_score" value="<%=queryList[0][3]%>"  v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
        </td>
      </tr>
      <tr>
        <td width=16% class="blue">Ȩ��</td>
        <td width="34%"> 
        	
        <input id="weight" name="weight" value="<%=(queryList[0][1].startsWith(".")?("0"+queryList[0][1]):queryList[0][1])%>" v_must="1" v_type="string" onBlur="checkElement(this);isNumber(this.value);" ><font class="orange">*</font>
        </td>
        <td width=16% class="blue">����</td>
        <td width="34%"> 
        <input id="note" name="note" value="<%=queryList[0][4]%>"><font class="orange"></font>
        </td>
      </tr>
      
      <tr id='forId' style='<%if("1".equals(queryList[0][7].trim())){out.print("display:none");}%>'>
         <td width=16% class="blue">���㹫ʽ</td>
         <td width="34%">
		 <input id="formula" name="formula" value="<%=queryList[0][5]%>"  v_must="1" v_type="string" onBlur="checkElement(this)"><font class="orange">*</font>
         <input type="button" name="confirmBtn" value="У��" onClick="verify();"/>
         </td>
        <td width=16% class="blue"></td>
        <td width="34%"> 
        </td>
      </tr>                                      
			

      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="updateQcItem()">
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
 



