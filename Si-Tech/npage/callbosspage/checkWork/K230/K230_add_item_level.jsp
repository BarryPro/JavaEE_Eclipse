<%
  /*
   * 功能: 添加考评项等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@page contentType="text/html;charset=GBK"%>
<!--zhengjiang 20091004 add-->
<%@ include file="/npage/include/public_title_ajax.jsp" %>
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

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";
%>
<%
/*zhengjiang 20091004 add start zengzq modify 增加取最低分 2091031*/
	String currentCountNum = "0";
	String currLowScore = "0";
	//if(!"0".equals(item_id)){
		String currentCountSql = "select to_char(high_score),to_char(low_score) from dqccheckitem where "
				+" item_id= :item_id "
				+" and object_id= :object_id "
				+" and contect_id= :content_id ";//查询当前考评项对应的分数上限
	myParams = "item_id="+item_id+",object_id="+object_id+",content_id="+content_id;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=currentCountSql%>"/>
		<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="currentCountList" scope="end"/>
<%
		
		if(currentCountList.length>0){
			currentCountNum = currentCountList[0][0];
			currLowScore = currentCountList[0][1];
		}
	//}	
	/*zhengjiang 20091004 add end*/
%>
<%
/*zengzq add 20091020 进行添加等级判断，不能重复*/
		String getScoreSql = "select to_char(low_score),to_char(score) from dqcckectitemlevel where "
				+" item_id=:item_id "
				+" and object_id=:object_id "
				+" and content_id=:content_id ";//查询最高分和最低分
	myParams = "item_id="+item_id+",object_id="+object_id+",content_id="+content_id;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:param value="<%=getScoreSql%>"/>
				<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="getScoreList" scope="end"/>
		
<html>
<head>
<title>添加考评项等级</title>
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

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script>
function grpClose(){
window.opener = null;
window.close();
}
//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
	
	var tid = e[i].id;
  if(e[i].type!="select-one"&&e[i].type=="text"){
  	if(!(document.getElementById(tid).disabled)&&!(document.getElementById(tid).readOnly)){
	  	e[i].value="";
	  }
	}
	if(e[i].type=="select-one"){
		document.getElementById(e[i].id).options[0].selected = true;
	}
 }
}
/*对返回值进行处理*/
function doProcessAddItemLevel(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");
	if(retType=="submitItemLevel"){
		if(retCode=="000000"){
			window.opener.location.reload();
			/*
			if(rdShowConfirmDialog("添加考评项等级成功，是否继续添加",2) != 1){
					window.opener = null;
					window.close();
			}
			*/
			similarMSNPop("添加考评项等级成功！");
                        //window.opener = null;
                        //window.close();
                        setTimeout("grpClose()",2500);
			
		}else{
			similarMSNPop("添加考评项等级失败！");
		}
	}
}

/**
  *
  *添加考评项等级
  *
  */
function submitItemLevel(){
//zengzq start 20091020 将考评等级数据保存到一个二维数组，用于进行分值校验
var getScoreList = new Array();
<%
if(getScoreList!=null && getScoreList.length>0){
  for(int i = 0; i < getScoreList.length; i++){
%>
    var tmpArr = new Array();
<%
			for(int j = 0; j < getScoreList[i].length; j++){%>
				tmpArr[<%=j%>] = '<%=getScoreList[i][j]%>';
<%
			}
%>
		getScoreList[<%=i%>] = tmpArr;
<%
	}
}
%>
//zengzq end 20091020 将考评等级数据保存到一个二维数组，用于进行分值校验

    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_add_item_level.jsp","请稍后...");
    var level_name      = document.getElementById("level_name").value;
    var low_score       = document.getElementById("low_score").value;
    var score           = document.getElementById("score").value;
    var is_def_level    = document.getElementById("is_def_level").value;
    var note            = document.getElementById("note").value;
    var item_id         = document.getElementById("item_id").value;
    var content_id      = document.getElementById("content_id").value;
    var object_id       = document.getElementById("object_id").value;
    var crete_login_no  = "<%=(String)session.getAttribute("kfWorkNo")%>";
    
    /*校验*/
    if(level_name == ''){
    	similarMSNPop("请输入考评项等级名称！");
    	return false;
    }
    
		//added by tangsong 20100409 验证名称
		var flag = checkElement(document.all("level_name"));
		if (!flag) {
			similarMSNPop("输入值非法！");
			return false;
		}
    
    if(low_score == ''){
    	similarMSNPop("请输入考评项等级最低分！");
    	return false;
    }
    if(score == ''){
    	similarMSNPop("请输入考评项等级最高分！");
    	return false;
    } 
    
   //updated by tangsong 20100525 去掉最高分和最低分限制
   /*
		var currentCountNum = '<%=currentCountNum%>';
		var currLowScore = '<%=currLowScore%>';
		if(parseInt(low_score)<parseInt(currLowScore)){
				similarMSNPop("最低分超出了考评项的分数下限！");
				return false;
		}
		if(parseInt(score)>parseInt(currentCountNum)){
				similarMSNPop("最高分超出了考评项的分数上限！");
				return false;
		}	
		*/
		//zhengjiang 20091004 end
		if(parseInt(low_score)>parseInt(score)){
    		similarMSNPop("最低分不能大于最高分！");
    		return false;
    }   
		
//zengzq add 20091020 start 判断分数不能在不同分数段重复出现		
		var l_score;
		var h_score;
		var judge = 1;
/*	guoz 20100203 分数段可以输入相交情况		
if(getScoreList!="undefined" && getScoreList.length>0){		
	
		for(var i=0;i<getScoreList.length; i++){
				l_score = getScoreList[i][0];
				h_score = getScoreList[i][1];
				if(parseFloat(low_score)>=parseFloat(l_score)&&parseFloat(low_score)<=parseFloat(h_score)){
					judge = 0;
					similarMSNPop("最低分在已定义分数段中存在，请重新输入！");
					return false;
				}
				if(parseFloat(score)>=parseFloat(l_score)&&parseFloat(score)<=parseFloat(h_score)){
					judge = 0;
					similarMSNPop("最高分在已定义分数段中存在，请重新输入！");
					return false;
				}
		}
}
*/
//zengzq add 20091020 finished 
    chkPacket.data.add("retType","submitItemLevel");
    chkPacket.data.add("level_name", level_name);
    chkPacket.data.add("low_score", low_score);
    chkPacket.data.add("score", score);
    chkPacket.data.add("is_def_level", is_def_level);
    chkPacket.data.add("note", note);
		chkPacket.data.add("item_id", item_id);
		chkPacket.data.add("content_id", content_id);    
		chkPacket.data.add("object_id", object_id);    
    chkPacket.data.add("crete_login_no", crete_login_no);
    core.ajax.sendPacket(chkPacket,doProcessAddItemLevel,true);
		chkPacket =null;
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
	<td valign="top">
	<div id="Operation_Title"><B>添加考评项等级</B></div>
    <div id="Operation_Table" style="width: 100%;"><!-- guozw20090828 -->
    <div class="title"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">

      <tr>
      	<td width="10%" class="blue">编号</td>
        <td width="20%">
		<input id="level_id" value="自动生成" readOnly/>
        </td>
         <td width="10%" class="blue">名称</td>
         <td width="20%">
		 <input id="level_name" maxlength="25" value="" v_must="1" v_type="string" onBlur="checkElement(this)">&nbsp;<font class="orange">*</font>
         </td>

      	<td width="10%" class="blue">最低分</td>
        <td width="20%">
       <!--zhengjiang 20091005 得分添加整数限制onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"--> 	
		<input id="low_score" name="low_score" maxlength="8" value="" v_must="1" v_type="string" onkeyup="value=value.replace(/[^-?\d+$]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)"/>&nbsp;<font class="orange">*</font>
        </td>
      </tr>

      <tr>
        <td width="10%" class="blue">默认等级</td>
        <td width="20%">
	 	    <select name="is_def_level" id="is_def_level">
			 		<option value="Y" selected>是</option>
			 		<option value="N">否</option>
        </select>
        </td>
        <td width="10%" class="blue">描述</td>
        <td width="20%" >
        <input id="note" name="note" maxlength="250" value=""/>
        </td>
        <td width="10%" class="blue">最高分</td>
        <td width="20%">
       <!--zhengjiang 20091005 得分添加整数限制onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"--> 	
		<input id="score" name="score" maxlength="8" value="" v_must="1" v_type="string" onkeyup="value=value.replace(/[^-?\d+$]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" onBlur="checkElement(this)"/>&nbsp;<font class="orange">*</font>
        </td>
      </tr>
      <tr>

      </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" name="submit" type="button" value="确认" onclick="submitItemLevel()">
        	<!--input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="清除"-->
					<input class="b_foot" name="reset1" type="button"  onclick="clearValue();return false;" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
       		<!--input class="b_foot" name="back" type="button" onclick="refreshParWin();" value="刷新父窗口"/-->
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