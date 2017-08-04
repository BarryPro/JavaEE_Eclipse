<%
  /*
   * 功能: 添加被检对象页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K230";
	//String opName = "添加被检对象";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>添加质检对象类别</title>
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

/*对返回值进行处理*/
function doProcessAddQcObject(packet)
{
	//alert("Begin call doProcessAddQcObject()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var object_id = packet.data.findValueByName("object_id");
	if(retType=="submitQcObject"){
		if(retCode=="000000"){
			var parWin = window.dialogArguments;
			parWin.tree.insertNewItem('0', object_id,document.getElementById("object_name").value, 0, 0, 0, 0, 'SELECT');
			rdShowMessageDialog('添加被检对象信息成功！',1);
			
		}else{
			rdShowMessageDialog('添加被检对象信息失败！',0);
			return false;
		}
	}
	//window.opener = null;
	//window.close();
	//alert("End call doProcessAddQcObject()......");
}

/**
  *
  *添加被检对象
  *
  */
function submitQcObject()
{
	//alert("Begin call submitQcObject()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_object.jsp","请稍后...");
    var object_name = document.getElementById("object_name").value;
    var object_type = document.getElementById("object_type").value;
    //var modify_flag = document.getElementById("modify_flag").value;
    var note        = document.getElementById("note").value;
	
	//校验
	if(object_name == ''){
		rdShowMessageDialog('没有输入被检对象类别名称！', 0);
		return false;
	}
	
    chkPacket.data.add("retType","submitQcObject");
    chkPacket.data.add("object_name", object_name);
    chkPacket.data.add("object_type", object_type);
    //chkPacket.data.add("modify_flag", modify_flag);
    chkPacket.data.add("create_login_no", "<%=(String)session.getAttribute("kfWorkNo")%>");
    chkPacket.data.add("note", note);

    core.ajax.sendPacket(chkPacket,doProcessAddQcObject,true);
	chkPacket =null;
	//alert("End call submitQcObject()....");
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
	<div id="Operation_Title"><B>添加被检对象</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
         <td width=16% class="blue">被检对象类别名称</td>
         <td width="34%">
         	<input id="object_name" maxlength="25" size="25" v_must="1" v_type="string" onBlur="checkElement(this)"><font class="orange">*</font>
         </td>
        <td width=16% class="blue">质检对象类别</td>
        <td width="34%"> 
        	<select name="object_type" id="object_type">
            	<option value="0">前台/后台在线支持人员</option>
            	<option value="1">综援人员</option>
            	<option value="2">质检人员</option>
            </select>
        </td>
      </tr>
      <tr>
         <td width=16% class="blue">总分可调整</td>
         <td width="34%">
         	<select name="modify_flag">
         		<option value="Y">是</option>
         		<option value="N">否</option>
         	</select>
         </td>
        <td width=16% class="blue">描述</td>
        <td width="34%"> 
        <input id="note" name="note" maxlength="250">
        </td>
      </tr>      


      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="确认" onclick="submitQcObject()">
        	<input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
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

<script>
function grpClose(){
window.opener = null;
window.close();
}
</script>
 



