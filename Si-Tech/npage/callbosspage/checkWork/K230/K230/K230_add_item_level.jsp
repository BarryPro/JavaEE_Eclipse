<%

  /*

   * ����: ��ӿ�����ȼ�

�� * �汾: 1.0.0

�� * ����: 2008/11/05

�� * ����: mixh

�� * ��Ȩ: sitech

   * update:

�� */

%>

<%@page contentType="text/html;charset=GBK"%>



<%

String object_id = request.getParameter("object_id");

if(object_id == null){

	object_id = "01";

}



String content_id = request.getParameter("content_id");

if(content_id == null){

	content_id = "02";

}



String item_id = request.getParameter("item_id");

if(item_id == null){

	item_id = "0";

}

%>



<html>

<head>

<title>��ӿ�����ȼ�</title>

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

function doProcessAddItemLevel(packet)

{

	//alert("Begin call doProcessAddItemLevel()......");

	var retType = packet.data.findValueByName("retType");

	var retCode = packet.data.findValueByName("retCode");

	var retMsg = packet.data.findValueByName("retMsg");

	var content_id = packet.data.findValueByName("content_id");

	if(retType=="submitItemLevel"){

		if(retCode=="000000"){

			window.opener.location.reload();

			if(rdShowConfirmDialog("��ӿ�����ȼ��ɹ����Ƿ�������",2) != 1){

					window.opener = null;

					window.close();

			}

			

			

		}else{

			rdShowMessageDialog('��ӿ�����ȼ�ʧ��',0);

		}

	}

	//alert("End call doProcessAddItemLevel()......");

}



/**

  *

  *��ӿ�����ȼ�

  *

  */

function submitItemLevel()

{

	//alert("Begin call submitItemLevel()....");

    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_item_level.jsp","���Ժ�...");



    var level_name      = document.getElementById("level_name").value;

    var score           = document.getElementById("score").value;

    var is_def_level    = document.getElementById("is_def_level").value;

    var note            = document.getElementById("note").value;

    var item_id         = document.getElementById("item_id").value;

    var content_id      = document.getElementById("content_id").value;

    var object_id       = document.getElementById("object_id").value;

    var crete_login_no  = "01";

    

    /*У��*/

    if(level_name == ''){

    	rdShowMessageDialog('�����뿼����ȼ����ƣ�',0);

    	return false;

    }

    if(score == ''){

    	rdShowMessageDialog('�����뿼����ȼ��÷֣�',0);

    	return false;

    }    



    chkPacket.data.add("retType","submitItemLevel");

    chkPacket.data.add("level_name", level_name);

    chkPacket.data.add("score", score);

    chkPacket.data.add("is_def_level", is_def_level);

    chkPacket.data.add("note", note);

    

	chkPacket.data.add("item_id", item_id);

	chkPacket.data.add("content_id", content_id);    

	chkPacket.data.add("object_id", object_id);    

    

    chkPacket.data.add("crete_login_no", crete_login_no);





    core.ajax.sendPacket(chkPacket,doProcessAddItemLevel,false);

	chkPacket =null;

	//alert("End call submitItemLevel()....");

}



function refreshParWin(){

	window.opener.location.reload();

}



</script>



</head>

<body>



<form  name="formbar">

<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>

<input type="hidden" name="content_id" id="content_id" value="<%=content_id%>"/>

<input type="hidden" name="item_id" id="item_id" value="<%=item_id%>"/>



<div id="Main">

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">

  <tr>

    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>

	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">

	<div id="Operation_Title"><B>��ӿ�����ȼ�</B></div>

    <div id="Operation_Table">

    <div class="title"></div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">



      <tr>

      	<td width="10%" class="blue">���</td>

        <td width="20%">

		<input id="" value="�Զ�����" disabled/>

        </td>

         <td width="10%" class="blue">����</td>

         <td width="20%">

		 <input id="level_name" maxlength="25" value="" v_must="1" v_type="string" onBlur="checkElement(this)">&nbsp;<font class="orange">*</font>

         </td>



      	<td width="10%" class="blue">�÷�</td>

        <td width="20%">

		<input id="score" name="score" maxlength="8" value="" v_must="1" v_type="string" onBlur="checkElement(this)"/>&nbsp;<font class="orange">*</font>

        </td>

      </tr>



      <tr>

        <td width="10%" class="blue">Ĭ�ϵȼ�</td>

        <td width="20%">

	 	    <select name="is_def_level" id="is_def_level">

	 		<option value="Y">��</option>

	 		<option value="N">��</option>

        	</select>

        </td>

        <td width="10%" class="blue">����</td>

        <td width="20%" colspan="3">

        <input id="note" name="note" maxlength="250" value=""/>

        </td>

      </tr>

      <tr>



      </tr>

      </table>



      <table width="100%" border="0" cellpadding="0" cellspacing="0">

        <tr>

          <td id="footer"  align=center>

            <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="submitItemLevel()">

        	<input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="���">

       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="�ر�"  >

       		<!--input class="b_foot" name="back" type="button" onclick="refreshParWin();" value="ˢ�¸�����"/-->

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









