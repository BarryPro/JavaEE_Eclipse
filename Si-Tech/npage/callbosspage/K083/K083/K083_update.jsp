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
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String item_id = WtcUtil.repNull(request.getParameter("item_id"));
String parentItem_id = WtcUtil.repNull(request.getParameter("parentItem_id"));
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String content_id = WtcUtil.repNull(request.getParameter("content_id"));

String sqlStr = "select msg_mod_id,msg_mod_par_id,msg_mod_name,msg_leaf_flag,is_del from DMESSAGEMODEL "
+" where is_del != 'Y' and msg_mod_id =:item_id ";
myParams = "item_id="+item_id ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<html>
<head>
<title>���¶��ŷ���</title>
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


/*�Է���ֵ���д���*/
function doProcessupdateQcItem(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var object_id = packet.data.findValueByName("object_id");
	if(retType=="updateQcItem"){
		if(retCode=="000000"){
			rdShowMessageDialog('���¶��ŷ���ɹ�', 2);
			var parWin = window.dialogArguments;
			parWin.tree.setItemText("<%=item_id%>",document.getElementById("item_name").value,document.getElementById("item_name").value);
			
		}else{
			rdShowMessageDialog('���¶��ŷ���ʧ��', 0);
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

    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K083/K083_do_update.jsp","���Ժ�...");
    var object_id       = document.getElementById("object_id").value;
    var contect_id      = document.getElementById("contect_id").value;
    var is_leaf         = document.getElementById("is_leaf").value;
    var item_name       = document.getElementById("item_name").value;
	if( item_name== ''){
		rdShowMessageDialog('û������������ƣ�', 0);
		return false;
	}
   
    chkPacket.data.add("retType","updateQcItem");
    chkPacket.data.add("item_id", "<%=item_id%>");
    chkPacket.data.add("is_leaf", is_leaf);
    chkPacket.data.add("item_name", item_name);
    chkPacket.data.add("create_login_no", "aaaa");

    core.ajax.sendPacket(chkPacket,doProcessupdateQcItem,true);
	chkPacket =null;
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
	<div id="Operation_Title"><B><font face="Arial"></font>���¶��ŷ���</B></div>
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
			<input id="item_name" value="<%=queryList[0][2]%>" v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
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
 




