<%
  /*
   * ����: Ԥ������Ž���������������ҳ��
�� * �汾: 1.0.0
�� * ����: 2009/01/15
�� * ����: fengliang
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K083";
	String opName = "Ԥ�������";
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

/*---------------���ҳ�洫�ݲ�����ʼ-------------------*/
String object_id      = WtcUtil.repNull(request.getParameter("object_id"));
String content_id     = WtcUtil.repNull(request.getParameter("content_id"));
String father_node_id = WtcUtil.repNull(request.getParameter("father_node_id"));
String current_node_id= WtcUtil.repNull(request.getParameter("current_node_id"));
/*---------------���ҳ�洫�ݲ�������-------------------*/
String tmpSelect = "";
String tmp = "";
if("0".equals(current_node_id)){
	tmpSelect = "disabled";
	tmp = "selected";
	father_node_id="0";
}
%>
<%
	String tmpSql = "select is_scored from dqccheckitem where item_id=:current_node_id ";
	myParams = "current_node_id="+current_node_id ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=tmpSql%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="tmpList" scope="end"/>
<%
		String tmpVal = "";
		if(tmpList.length>0){
	  tmpVal = tmpList[0][0];
		System.out.println("tmpVal:"+tmpVal);
		}
%>
	
	
<html>
<head>
<title>��ӿ�����</title>
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


//�������¼
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
	
	var tid = e[i].id;
  if(e[i].type!="select-one"&&e[i].type=="text"&&tid!=""){
  	if(!(document.getElementById(tid).disabled)&&!(document.getElementById(tid).readOnly)){
	  	e[i].value="";
	  }
	}
	if(e[i].type=="select-one"&&tid!=""){
		document.getElementById(e[i].id).options[0].selected = true;
	}
 }
}


/*�Է���ֵ���д���*/
function doProcessAddQcItem(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var item_id = packet.data.findValueByName("item_id");
	if(retType=="submitQcItem" && retCode == "000000"){
			var parWin          = window.dialogArguments;
			
			var itemName        = document.getElementById("item_name").value;		    
			var parent_item_id  = document.getElementById("parent_item_id").value;
			var nodeType        = document.getElementById("nodeType").value;
			var father_node_id  = document.getElementById("father_node_id").value;
			var current_node_id = document.getElementById("current_node_id").value;
			if(nodeType == 1){
				parent_item_id = father_node_id;
			}
			if(nodeType == 2){
				parent_item_id = current_node_id;
			}
			
			if(parent_item_id!=0){
	      parWin.tree.setUserData(parent_item_id,"isleaf",'N');
	    }
			parWin.tree.insertNewItem(parent_item_id, item_id, itemName, 0, 0, 0, 0, 'SELECT');
       
			if(rdShowConfirmDialog("��Ӷ��ŷ��࣬�Ƿ�������",2) != 1){
				window.close();
			}	
		}else{
			rdShowMessageDialog('��Ӷ��ŷ���',0);
			return false;
		}

}


function submitQcItem()
{
    var item_name       = document.getElementById("item_name").value;
	if( item_name== ''){
		rdShowMessageDialog('û��������ŷ��࣡', 0);
		return false;
	}
	

	
    var chkPacket       = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K083/K083_add_do.jsp","���Ժ�...");

    var parent_item_id  = document.getElementById("parent_item_id").value;
    var object_id       = document.getElementById("object_id").value;
    var content_id      = document.getElementById("content_id").value;
    var is_leaf         = document.getElementById("is_leaf").value;
    chkPacket.data.add("retType","submitQcItem");
    chkPacket.data.add("parent_item_id", parent_item_id);
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("contect_id", content_id);
    chkPacket.data.add("is_leaf", is_leaf);
    chkPacket.data.add("item_name", item_name);
    
    core.ajax.sendPacket(chkPacket,doProcessAddQcItem,true);
		chkPacket =null;
}

/**
  *
  *�ı�ڵ������涯����
  */
function changeNodeType(nodeType){
	var parent_item_id  = document.getElementById("parent_item_id");
	var father_node_id  = document.getElementById("father_node_id").value;
	var current_node_id = document.getElementById("current_node_id").value;
	if(nodeType == 1){
		parent_item_id.value = father_node_id;
	}
	if(nodeType == 2){
		parent_item_id.value = current_node_id;
	}	
}




</script>

</head>
<body>

<form  name="formbar">
<input type="hidden" name="father_node_id" id="father_node_id" value="<%=father_node_id%>"/>
<input type="hidden" name="current_node_id" id="current_node_id" value="<%=current_node_id%>"/>
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<input type="hidden" name="contect_id" id="content_id" value="<%=content_id%>"/>
<input type="hidden" name="is_leaf" id="is_leaf" value="Y"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>����µĶ��ŷ���</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	
      <tr>
      	<td width=16% class="blue">�ϲ�ڵ���</td>
        <td width="34%"> 
        <input name="parent_item_id" id="parent_item_id" value="<%=father_node_id%>" size="8" disabled/>
        </td>
        
         <td width=16% class="blue">���</td>
         <td width="34%">
		<input id="item_id" value="ϵͳ�Զ�����" disabled/>
         </td>        
      </tr>
      
      <tr>
      	<td width="16%" class="blue">�ڵ����</td>
        <td width="34%">
         	<select name="nodeType" onchange="changeNodeType(this.value)"  <%=tmpSelect%> <%if("1".equals(tmpVal.trim())){out.print("disabled");}%> >
         		<option value="1">ͬ��ڵ�</option>
         		<option value="2" <%=tmp%> >�ӽ��</option>
        	</select>
        </td>
              	
         <td width=16% class="blue">����</td>
         <td width="34%">
		<input id="item_name" value="" v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
         </td>
      </tr>      
      
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="submitQcItem()">
       		<input class="b_foot" name="reset1" type="button"  onclick="clearValue();return false;" value="���">
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
 




