<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 质检计划查询-》选择考评内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K310";
	String opName = "选择考评内容";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

//String retType = WtcUtil.repNull(request.getParameter("retType"));
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
if(object_id == null || object_id.equals("")){
	String sqlGetObjectId = "select ";
	object_id = "01";
}
String sqlStr = "SELECT t1.name, t1.source_id, to_char(t1.weight), t1.auto_get, t1.formula, t1.contect_id,t1.object_id, t2.object_name " +
                "FROM dqccheckcontect t1,dqcobject t2 " +
                "WHERE trim(t1.object_id) = trim(t2.object_id) AND t1.bak1='Y' AND t2.bak1='Y'";
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="10">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>

<html>
<head>
<title>考评内容</title>
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

/**
  *
  *打开添加考评内容窗口
  *
  */
function add_qc_content(){
var object_id = document.getElementById("object_id").value;
window.open('K230_add_qc_content.jsp?object_id=' + object_id,
            '',
            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
}

/**
  *
  *打开修改评测内容窗口
  *
  */
function update_qc_content(){

var radios = document.getElementsByName("check_content");
var check_content = "";
for(var i = 0; i < radios.length; i++){
	if(radios[i].checked){
		check_content = radios[i].value;
	}
}
alert(check_content);

window.open('K230_update_qc_content.jsp?content_id=' + check_content,
            '',
            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
}

/**
  *
  *删除考评内容
  *
  */
function delete_qc_content(){
	if(rdShowConfirmDialog("确认删除当前考评内容么？") == 1){
		delQcContent();
	}
}


/*对返回值进行处理*/
function doProcessDelQcContent(packet){
	//alert("Begin call doProcessDelQcContent()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="delQcObject"){
		if(retCode=="000000"){
			alert("成功删除评测内容");
			var radios = document.getElementsByName("check_content");
			for(var i = 0; i < radios.length; i++){
				if(radios[i].checked){
					var trobj = radios[i].parentElement.parentElement;
					trobj.parentElement.removeChild(trobj);
				}
			}
		}else{
			alert("删除评测内容失败!");
			return false;
		}
	}

}

/**
  *
  *删除选定考评内容
  *
  */
function delQcContent(){
	var radios = document.getElementsByName("check_content");
	var check_content = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			check_content = radios[i].value;
		}
	}

	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_delete_qc_content.jsp","请稍后...");
	chkPacket.data.add("retType","delQcObject");
	chkPacket.data.add("content_id", check_content);
	core.ajax.sendPacket(chkPacket, doProcessDelQcContent, true);
	chkPacket =null;
}

/**
  *
  *选中当前考评内容，刷新考评项帧
  *
  */
function getCheckItem(i){
	document.getElementById("tmpValue").value=i;
}


function getCheckedValue(){
	var tmpVal = document.getElementById("tmpValue").value;
	if(""==tmpVal||tmpVal==undefined){
		similarMSNPop("请先选择考评内容！");
		return false;
	}
	var queryName= document.getElementById("queryName"+tmpVal).value;
	var queryId=document.getElementById("queryId"+tmpVal).value;
	var objectId=document.getElementById("objectId"+tmpVal).value;
	var objectName=document.getElementById("objectName"+tmpVal).value;
	var pdoc = window.dialogArguments;  
  	pdoc.getElementById("OBJECT_ID").value=objectId;
	pdoc.getElementById("OBJECT_GETNAME").value=objectName;
	pdoc.getElementById("CONTENT_name").value=queryName;
	pdoc.getElementById("CONTENT_ID").value=queryId;
  
	document.getElementById("tmpValue").value="";
	window.close();

}

//取消选中考评内容
function cancelCheckedValue(){
	var pdoc = window.dialogArguments;  
	pdoc.getElementById("CONTENT_name").value="";
	pdoc.getElementById("CONTENT_ID").value="";
	window.close();
}
</script>

</head>

<body>
<form  name="formbar">
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
    	<div class="title"></div>
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="blue">选择</td>
        <td class="blue">被检对象类别</td>
        <td class="blue">考评内容名称</td>
        <td class="blue">考评内容来源</td>
        <td class="blue">权重</td>
        <td class="blue">是否自动获取</td>
        <td class="blue">公式</td>
      </tr>
	<input type="hidden" name="tmpValue" value=""/>
      <%
      if(queryList != null && queryList.length >= 0){
      	for(int i = 0; i< queryList.length; i++){%>
      <tr>
        <td class="blue"><input type="radio" name="check_content" onclick="getCheckItem('<%=i%>');" value="<%=queryList[i][5]%>"/></td>
        <td class="blue"><%=queryList[i][7]%>&nbsp;</td>
        <td class="blue"><%=queryList[i][0]%>&nbsp;</td>
        <td class="blue">
    	<%if(queryList[i][1].equals("0")){
    	  	out.println("通话记录");	
    	  }else if(queryList[i][1].equals("1")){
    	  	out.println("工单记录");
    	  }else if(queryList[i][1].equals("2")){
    	  	out.println("质检结果");
    	  }else if(queryList[i][1].equals("3")){
    	  	out.println("统计数据");
    	  }
    	%>&nbsp;        
        </td>
        <td class="blue"><%=queryList[i][2]%>&nbsp;</td>
        <td class="blue"><%if(queryList[i][3].equals("Y")){out.println("是");}else{out.println("否");}%>&nbsp;</td>
        <td class="blue"><%=queryList[i][4]%>&nbsp;</td>
        <input type="hidden" name="queryName<%=i%>" value="<%=queryList[i][0]%>">
	    <input type="hidden" name="queryId<%=i%>" value="<%=queryList[i][5]%>">
	    <input type="hidden" name="objectId<%=i%>" value="<%=queryList[i][6]%>">
	    <input type="hidden" name="objectName<%=i%>" value="<%=queryList[i][7]%>">
      </tr>
      <%
      }
      	}%>
      </table>
    </div>
    <br/>
    </td>
  </tr>
</table>

</FORM>
<br/>       
<table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" name="submit1" type="button" value="确定" onclick="getCheckedValue()">
        	<input class="b_foot" name="reset1" type="button"  onclick="cancelCheckedValue();" value="取消">

        </td>
       </tr>
 </table>
 
 <br/>
 <br/>
</BODY>
</HTML>