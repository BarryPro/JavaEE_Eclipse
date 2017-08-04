<%
  /*
   * 功能: 考评内容列表页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K230";
	String opName = "考评内容列表";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
/*---------------获得默认object_id开始-------------------*/
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String sqlGetObjectId = "";
/*midify by guozw 20091114 公共查询服务替换  将regionCode设置为默认值00 防止session未取到 20100303*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode ="00";

if(orgCode != null && !"".equals(orgCode)){
		regionCode = orgCode.substring(0,2);
}


if(object_id == null || object_id.equals("")){
	sqlGetObjectId = "select to_char(min(object_id)) from dqcobject";

%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlGetObjectId%>"/>
</wtc:service>
<wtc:array id="object_ids" scope="end"/>
<%

	object_id = object_ids[0][0];
} //end_of_if
/*---------------object_id赋值-------------------*/
%>

<%
/*---------------获得考评内容列表开始-------------------*/
String sqlStr = "select name, source_id, to_char(weight), auto_get, formula, contect_id " +
                "from dqccheckcontect where object_id = :object_id and bak1='Y' order by contect_id";
String myParams = "object_id="+object_id ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
/*---------------获得考评内容列表结束-------------------*/

String hasContentNum = "0";
int tmpNum = queryList.length;
if(tmpNum>0){
	hasContentNum = "1";
}
//out.print(hasContentNum);
%>

<html>
<head>
<title>考评内容</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>


<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>


<script>
/*zhengjiang 20091004 add*/
var tempNum = '<%=tmpNum%>';
/**
  *
  *打开添加考评内容窗口
  *
  */
function add_qc_content(){
var object_id = document.getElementById("object_id").value;
	/*
	window.open('K230_add_qc_content.jsp?object_id=' + object_id,
	            '',
	            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
	*/
	/*zhengjiang 20091004 start*/
	if('0'==tempNum){
			var time     = new Date();
			var winParam = 'dialogWidth=800px;dialogHeight=330px';
			window.showModalDialog('K230_add_qc_content.jsp?time=' + time + '&object_id=' + object_id, window, winParam);
			tempNum += 1;
	}else{
		parent.top.similarMSNPop("只能添加一条考评内容！");
		return false;
	}
	/*zhengjiang 20091004 end*/	
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
	if(undefined==check_content||''==check_content){
		parent.top.similarMSNPop("请选择要修改的考评内容！");
		return false;
		}
	
	/*
	window.open('K230_update_qc_content.jsp?content_id=' + check_content+'&object_id='+'<%=object_id%>',
	            '',
	            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
	*/
	var time     = new Date();
	var winParam = 'dialogWidth=800px;dialogHeight=330px';
	window.showModalDialog('K230_update_qc_content.jsp?time=' + time + '&content_id=' + check_content+'&object_id='+'<%=object_id%>', window, winParam);	
}

/**
  *
  *删除考评内容
  *
  */
function delete_qc_content(){
	var radios = document.getElementsByName("check_content");
	var check_content = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			check_content = radios[i].value;
		}
	}
	if(undefined==check_content||''==check_content){
		parent.top.similarMSNPop("请选择要删除的考评内容！");
		return false;
	}
	//var itemNum = window.parent.frames.mainFrame.document.getElementById("itemNum").value;
	var itemNum=window.parent.frames.mainFrame.tree.getSubItems('0').length;
	if(!(itemNum==undefined)&&itemNum>0){
			window.parent.top.similarMSNPop("该考评内容下有考评项，不能删除！");
			return false;
		}
	if(rdShowConfirmDialog("确认删除当前考评内容么？") == 1){
		delQcContent();
		//zhengjiang 20091004 add
		tempNum = tempNum-1;
	}
}


/*对返回值进行处理*/
function doProcessDelQcContent(packet){
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="delQcObject"){
		if(retCode=="000000"){
			parent.top.similarMSNPop("成功删除评测内容！");
			var radios = document.getElementsByName("check_content");
			for(var i = 0; i < radios.length; i++){
				if(radios[i].checked){
					var trobj = radios[i].parentElement.parentElement;
					trobj.parentElement.removeChild(trobj);
				}
			}
		}else{
			parent.top.similarMSNPop("删除评测内容失败！");
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
	//alert("Begin call delQcContent()....");
	var radios = document.getElementsByName("check_content");
	var check_content = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			check_content = radios[i].value;
		}
	}
	//alert(check_content);

	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_delete_qc_content.jsp","请稍后...");
	chkPacket.data.add("retType","delQcObject");
	chkPacket.data.add("content_id", check_content);
	chkPacket.data.add("object_id", '<%=object_id%>');
	core.ajax.sendPacket(chkPacket, doProcessDelQcContent, true);
	chkPacket =null;
	//alert("End call delQcContent()....");
}

/**
  *
  *选中当前考评内容，刷新考评项帧
  *
  */
function getCheckItem(content_id){
	//alert("content_id----->" + content_id);
	var object_id = document.getElementById("object_id").value;
	//alert("object_id----->" + object_id);
	window.parent.frames['mainFrame'].location.href = "./K230_qc_item_tree.jsp?content_id=" + content_id +"&object_id=" + object_id;
}

</script>

</head>

<body>
<form  name="formbar">
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>

<input type="hidden" name="hasContentNum" id="hasContentNum" value="<%=hasContentNum%>"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td width="60%">&nbsp;</td>
  <td width="40%" align="right">
	<input type="button" name="btn_add" value="添加" class="b_text" onclick="add_qc_content()"/>
	<input type="button" name="btn_update" value="修改" class="b_text" onclick="update_qc_content()"/>
	<input type="button" name="btn_delete" value="删除" class="b_text" onclick="delete_qc_content()"/>
</td>
</tr>
</table>

<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="16%" class="blue">选择</td>
        <td width="16%" class="blue">名称</td>
        <td width="16%" class="blue">考评内容来源</td>
        <td width="16%" class="blue">权重</td>
        <td width="16%" class="blue">是否自动获取</td>
        <td width="16%" class="blue">公式</td>
      </tr>

      <%
      if(queryList != null && queryList.length >= 0){
      	for(int i = 0; i< queryList.length; i++){%>
      <tr>
        <td class="blue"><input type="radio" name="check_content" onclick="getCheckItem(this.value);" value="<%=queryList[i][5]%>"/></td>
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
        <td class="blue"><%=(queryList[i][2].startsWith(".")?("0"+queryList[i][2]):queryList[i][2])%>&nbsp; </td>
        <td class="blue"><%if(queryList[i][3].equals("Y")){out.println("是");}else{out.println("否");}%>&nbsp;</td>
        <td class="blue"><%=queryList[i][4]%>&nbsp;</td>
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
</BODY>
</HTML>