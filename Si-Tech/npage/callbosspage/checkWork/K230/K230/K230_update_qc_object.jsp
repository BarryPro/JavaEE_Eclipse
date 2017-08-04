<%
  /*
   * 功能: 更新被检对象页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K230";
	String opName = "更新被检对象页面";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
/*************************获取修改的被质检对象详细信息开始*************************/
String object_id = request.getParameter("selectedItemId");
System.out.println(object_id);

String sqlStr = "select object_id, object_name, object_type, note, modify_flag " +
                "from dqcobject where trim(object_id) = '" + object_id + "'";
System.out.println(sqlStr);
%>
<wtc:service name="s151Select" outnum="7">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="5" scope="end"/>
<%
/*************************获取修改的被质检对象详细信息结束*************************/
%>


<html>
<head>
<title>更新被检对象信息</title>
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
function doProcessUpdateQcObject(packet)
{
	//alert("Begin call doProcessUpdateQcObject()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="updateQcObject"){
		if(retCode=="000000"){
			//设置节点名称
			var parWin = window.dialogArguments;
            parWin.tree.setItemText("<%=request.getParameter("selectedItemId")%>",document.getElementById("object_name").value);
			rdShowMessageDialog('被检对象信息更新成功！',1);
			
		}else{
			rdShowMessageDialog('被检对象信息更新失败！',0);
			return false;
		}
	}
	//alert("End call doProcessUpdateQcObject()......");
}

/**
  *
  *更新被检对象类别
  *
  */
function updateQcObject()
{
	//alert("Begin call updateQcObject()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_update_object.jsp","请稍后...");
    var object_id   = document.getElementById("object_id").value;
    var object_name = document.getElementById("object_name").value;
    var object_type = document.getElementById("object_type").value;
    var modify_flag = document.getElementById("modify_flag").value;
    var note        = document.getElementById("note").value;
    
    //校验
    if(object_name == ""){
    	rdShowMessageDialog('请出入被检对象名称！',0);
    	return false;
    }
    
    chkPacket.data.add("retType","updateQcObject");
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("object_name", object_name);
    chkPacket.data.add("object_type", object_type);
    chkPacket.data.add("modify_flag", modify_flag);
    chkPacket.data.add("note", note); 
    chkPacket.data.add("update_login_no", "<%=(String)session.getAttribute("kfWorkNo")%>");

    core.ajax.sendPacket(chkPacket,doProcessUpdateQcObject,false);
	chkPacket =null;
	//alert("End call updateQcObject()....");
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
	<div id="Operation_Title"><B><font face="Arial">1100</font>更新被检对象信息<%=request.getParameter("selectedItemId")%></B></div>
    <div id="Operation_Table">
    <div class="title"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
         <td width=16% class="blue">被检对象名称</td>
         <td width="34%">
         	<input type="hidden" name="object_id" id="object_id" value="<%=resultList[0][0]%>"/>
         	<input id="object_name" maxlength="25" size="25" value="<%=resultList[0][1]%>" v_must="1" v_type="string" onBlur="checkElement(this)"/>
         	<font class="orange">*</font>
         </td>
        <td width=16% class="blue">被检对象类别</td>
        <td width="34%">
        	<select name="object_type" id="object_type">
            	<option value="0" <%if(resultList[0][2].trim().equals("0")){out.println("selected");}%>>前台/后台在线支持人员</option>
            	<option value="1" <%if(resultList[0][2].trim().equals("1")){out.println("selected");}%>>综援人员</option>
            	<option value="2" <%if(resultList[0][2].trim().equals("2")){out.println("selected");}%>>质检人员</option>
            </select>        
        </td>
      </tr>
      
      <tr>
         <td width=16% class="blue">总分可调整</td>
         <td width="34%">
         	<select name="modify_flag">
         		<option value="Y" <%if(resultList[0][4].trim().equals("Y")){out.println("selected");}%>>是</option>
         		<option value="N" <%if(resultList[0][4].trim().equals("N")){out.println("selected");}%>>否</option>
         	</select>
         </td>
        <td width=16% class="blue">备注</td>
        <td width="34%">
        <input id="note" maxlength="250" size="25" value="<%=resultList[0][3]%>"/>
        </td>
      </tr>      


      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" name="submit" type="button" value="确认" onclick="updateQcObject()">
        	<input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
            <input type="reset" name="Reset" value="Reset" style="display='none'">
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




