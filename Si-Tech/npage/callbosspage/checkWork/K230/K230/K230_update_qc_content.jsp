<%
  /*
   * 功能: 更新考评内容页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String content_id = WtcUtil.repNull(request.getParameter("content_id"));
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String sqlStr = "select name, source_id, to_number(weight), auto_get, note, formula, bak1 from dqccheckcontect where trim(contect_id) = '" + content_id + "'";

System.out.println("#######################################");
System.out.println(sqlStr);
System.out.println("object_id:"+object_id);
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
<title>修改考评内容</title>
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

//判断是否是数字
function isNumber(ee){
	if(!ee) return false;
  if(isNaN(ee)){
  	rdShowMessageDialog('权重必须为数字', 0);
  	document.getElementById("weight").value="";
  	document.getElementById("weight").focus();
  }
  if(ee<=0){
  	rdShowMessageDialog('权重必须大于零', 0);
  	document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }
  var tmpPos = ee.lastIndexOf('.');
  var subWeightLength = ee.substr(tmpPos).length;
  if(subWeightLength>3){
    rdShowMessageDialog('权重最多只能有两个小数位！', 0);
    document.getElementById("weight").value="";
    document.getElementById("weight").focus();
  }	
  return true;
}

/*对返回值进行处理*/
function doProcessUpdateQcContent(packet){
	//alert("Begin call doProcessUpdateQcContent()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");
	if(retType=="updateQcContent"){
		if(retCode=="000000"){
			rdShowMessageDialog('成功修改考评内容',2);
			updateTable();
		}else{
			rdShowMessageDialog('修改考评内容失败',0);
		}
	}
	//alert("End call doProcessUpdateQcContent()......");
}

/**
  *
  *将考评内容插入到父页面的表格之中
  *
  */
function updateTable(){
	//alert("Begin call updateTable()......");
	var content_name   = document.getElementById("content_name").value;
	var source_id      = document.getElementById("source_id").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;
	
	var parWin = window.dialogArguments;
	var radios = parWin.document.getElementsByName("check_content");
	var checkContent = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			checkContent = radios[i];
		}
	}

	var source_name;
	if(source_id == '0'){
		source_name = '通话记录';
	}
	if(source_id == '1'){
		source_name = '工单记录';
	}
	if(source_id == '2'){
		source_name = '质检结果';
	}
	if(source_id == '3'){
		source_name = '统计数据';
	}

	var auto_get_name;
	if(auto_get == 'Y'){
		auto_get_name = '是';
	}
	if(auto_get == 'N'){
		auto_get_name = '否';
	}

	checkContent.parentElement.parentElement.childNodes[1].innerHTML = content_name;
	checkContent.parentElement.parentElement.childNodes[2].innerHTML = source_name;
	checkContent.parentElement.parentElement.childNodes[3].innerHTML = weight;
	checkContent.parentElement.parentElement.childNodes[4].innerHTML = auto_get_name;
	checkContent.parentElement.parentElement.childNodes[5].innerHTML = formula;

	//alert("End call updateTable()......");
}

/**
  *
  *修改考评内容
  *
  */
function updateQcContent(){
	//alert("Begin call updateQcContent()....");

	var content_name = document.getElementById("content_name").value;
    var note = document.getElementById("note").value;
    var formula = document.getElementById("formula").value;
	//校验
	if(content_name == ''){
		rdShowMessageDialog('没有输入考评内容名称！', 0);
		return false;
	}
	if(formula == ''){
		rdShowMessageDialog('没有输入考评内容计算公式！', 0);
		return false;
	}

    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_update_qc_content.jsp","请稍后...");

	var content_id     ="<%=content_id%>";
    var object_id      = document.getElementById("object_id").value;
    var source_id      = document.getElementById("source_id").value;
    var content_name   = document.getElementById("content_name").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;
    var note           = document.getElementById("note").value;

    var update_login_no = "01";

    chkPacket.data.add("retType","updateQcContent");
    chkPacket.data.add("content_id", content_id);
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("source_id", source_id);
    chkPacket.data.add("content_name", content_name);
    chkPacket.data.add("weight", weight);
    chkPacket.data.add("auto_get", auto_get);
    chkPacket.data.add("formula", formula.split("+").join("%2B"));
    chkPacket.data.add("note", note);
    chkPacket.data.add("update_login_no", "<%=(String)session.getAttribute("kfWorkNo")%>");


    core.ajax.sendPacket(chkPacket,doProcessUpdateQcContent,true);
	chkPacket =null;
	//alert("End call updateQcContent()....");
}


/**
  *校验计算公式
  */
function verify(){
	/*
	var formula = document.getElementById("formula").value;
	if(formula == ''){
		rdShowMessageDialog('计算公式为空，无法校验！', 0);
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

<input type="hidden" name="object_id" id="object_id" value='<%=object_id%>'/>
<input type="hidden" name="crete_login_no" id="crete_login_no" value="N"/>

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>修改考评内容</B></div>

    <div id="Operation_Table">
    <div class="title"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">

      <tr>
      	<td width="16%" class="blue">编号</td>
        <td width="34%">
		<input id="contect_id" value="自动生成" readonly>
        </td>

        <td width=16% class="blue">名称</td>
        <td width="34%">
        <input id="content_name" name="content_name" value="<%=queryList[0][0]%>" v_must="1" v_type="string" onBlur="checkElement(this)" ><font class="orange">*</font>
        </td>

        <td width=16% class="blue">考评内容来源</td>
        <td width="34%">
	 	    <select name="source_id" id="source_id">
	 		<option value="0" <%if("0".equals(queryList[0][1].trim())){out.print("selected");}%>>通话记录</option>
	 		<option value="1" <%if("1".equals(queryList[0][1].trim())){out.print("selected");}%> >工单记录</option>
	 		<option value="2" <%if("2".equals(queryList[0][1].trim())){out.print("selected");}%> >质检结果</option>
	 		<option value="3" <%if("3".equals(queryList[0][1].trim())){out.print("selected");}%> >统计数据</option>
        	</select>
        </td>
      </tr>

      <tr>

         <td width=16% class="blue">自动获取被检记录</td>
         <td width="34%">
	 	    <select name="auto_get" id="auto_get">
	 		<option value="Y" <%if("Y".equals(queryList[0][3].trim())){out.print("selected");}%>>是</option>
	 		<option value="N" <%if("N".equals(queryList[0][3].trim())){out.print("selected");}%> >否</option>
        	</select>
         </td>

        <td width=16% class="blue">权重</td>
        <td width="34%" colspan='3'>
			<input id="weight" name="weight" value="<%=(queryList[0][2].startsWith(".")?("0"+queryList[0][2]):queryList[0][2])%>" size="8" maxlength="8" v_must="1" v_type="string" onBlur="checkElement(this);isNumber(this.value);"/><font class="orange"/>*</font>
        </td>

        

      </tr>
      
	  <tr>
         <td width=16% class="blue">计算公式</td>
         <td width="34%" colspan="5">
			<input id="formula" name="formula" value="<%=queryList[0][5]%>" v_must="1" v_type="string" onBlur="checkElement(this)"><font class="orange">*</font>
        	<input type="button" name="confirmBtn" value="校验" onClick="verify();"/>
         </td>

      </tr>
      
      <tr>
         <td width=16% class="blue">描述</td>
         <td width="34%" colspan="5">
		<input id="note" name="note"  size="50" value="<%=queryList[0][4]%>" />
         </td>

      </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" name="submit" type="button" value="确认" onclick="updateQcContent()">
        	<input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
       		<!--input class="b_foot" name="back" type="button" onclick="updateTable();" value="updateTable"  -->
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




