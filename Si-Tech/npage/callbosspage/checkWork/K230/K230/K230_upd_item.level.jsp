<%

  /*

   * ����: �޸Ŀ�����ȼ�

�� * �汾: 1.0.0

�� * ����: 2008/11/05

�� * ����: mixh

�� * ��Ȩ: sitech

   * update:

�� */

%>

<%

	String opCode = "K230";

	String opName = "�޸Ŀ�����ȼ�";

%>

<%@ page contentType= "text/html;charset=GBK" %>

<%@ include file="/npage/include/public_title_name.jsp" %>



<%

String serialno = request.getParameter("serialno");

String sqlStr = "select level_name, to_number(score), is_def_level, note from dqcckectitemlevel where serialno = '" + serialno + "'";

System.out.println("#######################################");

System.out.println(sqlStr);

System.out.println("#######################################");



%>



<wtc:service name="s151Select" outnum="6">

<wtc:param value="<%=sqlStr%>"/>

</wtc:service>

<wtc:array id="queryList" scope="end"/>



<html>

<head>

<title>�޸Ŀ�����ȼ�</title>

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

function doProcessUpdItemLevel(packet)

{

	//alert("Begin call doProcessUpdItemLevel()......");

	var retType = packet.data.findValueByName("retType");

	var retCode = packet.data.findValueByName("retCode");

	var retMsg = packet.data.findValueByName("retMsg");

	var content_id = packet.data.findValueByName("content_id");

	if(retType=="updItemLevel"){

		if(retCode=="000000"){

			rdShowMessageDialog('������ȼ��޸ĳɹ���',2);

			window.opener.location.reload();

		}else{

		}

	}

	//alert("End call doProcessUpdItemLevel()......");

}



/**

  *

  *�޸Ŀ�����ȼ�

  *

  */

function updItemLevel()

{

	//alert("Begin call updItemLevel()....");

    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_upd_item_level.jsp","���Ժ�...");



    var level_name      = document.getElementById("level_name").value;

    var score           = document.getElementById("score").value;

    var is_def_level    = document.getElementById("is_def_level").value;

    var note            = document.getElementById("note").value;

    var update_login_no = "01";

    

    /*У��*/

    if(level_name == ''){

    	rdShowMessageDialog('�����뿼����ȼ����ƣ�',0);

    	return false;

    }

    if(score == ''){

    	rdShowMessageDialog('�����뿼����ȼ��÷֣�',0);

    	return false;

    }    



    chkPacket.data.add("retType","updItemLevel");

    chkPacket.data.add("serialno", <%=serialno%>);

    chkPacket.data.add("level_name", level_name);

    chkPacket.data.add("score", score);

    chkPacket.data.add("is_def_level", is_def_level);

    chkPacket.data.add("note", note);   

    

    chkPacket.data.add("update_login_no", update_login_no);





    core.ajax.sendPacket(chkPacket, doProcessUpdItemLevel, false);

	chkPacket =null;

	//alert("End call updItemLevel()....");

}



/**

  *������

  */

function refreshParWin(){

	window.opener.location.reload();

}



</script>



</head>

<body>



<form  name="formbar">

<div id="Main">

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">

  <tr>

    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>

	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">

	<div id="Operation_Title"><B>�޸Ŀ�����ȼ�</B></div>

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

		 <input id="level_name" maxlength="25" value="<%=queryList[0][0]%>" v_must="1" v_type="string" onBlur="checkElement(this)">&nbsp;<font class="orange">*</font>

         </td>



      	<td width="10%" class="blue">�÷�</td>

        <td width="20%">

		<input id="score" name="score" maxlength="8" value="<%=queryList[0][1]%>" v_must="1" v_type="string" onBlur="checkElement(this)"/>&nbsp;<font class="orange">*</font>

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

        <input id="note" name="note" maxlength="250" value="<%=queryList[0][3]%>"/>

        </td>

      </tr>

      <tr>



      </tr>

      </table>



      <table width="100%" border="0" cellpadding="0" cellspacing="0">

        <tr>

          <td id="footer"  align=center>

            <input class="b_foot" name="submit" type="button" value="ȷ��" onclick="updItemLevel()">

        	<!--<input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="���">-->

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









