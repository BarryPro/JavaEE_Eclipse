<%
  /**
   * 功能: 质检权限管理->质检计划管理->质检计划查询
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K310";
	String opName = "考评计划查询";
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%!
    String beginTime;
    String endTime;
    public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>质检计划查询</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<style>
		img{
				cursor:hand;
		}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<style>
.content_02
{
	font-size:12px;
}
#tabtit_ts
{
	height:23px;
	padding:0px 0 0 12px;
	margin-left:50px;
}
#tabtit_ts ul
{
	height:23px;
	position:absolute;
}
#tabtit_ts ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit_ts .normaltab
{
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit_ts .hovertab
{
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}
</style>

<script>

/*对返回值进行处理*/
function doProcessAddQcContent(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");
	if(retType=="submitQcContent"){
		if(retCode=="000000"){
			alert("成功添加考评内容");
			insertTable(content_id);

		}else{
			alert("添加考评内容失败!");
			return false;
		}
	}
}

/**
  *
  *将考评内容插入到父页面的表格之中
  *
  */
function insertTable(content_id){

	var content_name   = document.getElementById("content_name").value;
	var source_id   = document.getElementById("source_id").value;
    var weight         = document.getElementById("weight").value;
    var auto_get       = document.getElementById("auto_get").value;
    var formula        = document.getElementById("formula").value;

	var table = window.opener.document.getElementById("contentTable");
	var tr = table.insertRow();
	tr.insertCell().innerHTML = "<input type='radio' name='check_content' value='"+content_id+"'/>";
	tr.insertCell().innerHTML = content_name;
	tr.insertCell().innerHTML = source_id;
	tr.insertCell().innerHTML = weight;
	tr.insertCell().innerHTML = auto_get;
	tr.insertCell().innerHTML = formula;
}

/**
  *
  *添加考评内容
  *
  */
function submitQcContent(){

	 if( document.sitechform.beginTime.value == ""){
    	  showTip(document.sitechform.beginTime,"开始日期不能为空！请重新选择后输入");
        sitechform.beginTime.focus();
    }
	else if(document.sitechform.endTime.value == ""){
		showTip(document.sitechform.endTime,"结束日期不能为空！请重新选择后输入");
		sitechform.endTime.focus();
    }
  else if(document.sitechform.endTime.value<=document.sitechform.beginTime.value){
		 showTip(document.sitechform.endTime,"结束时间必须大于开始时间");
    sitechform.endTime.focus();
    }
   else {
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    doSubmit();

    }
}

function doSubmit(){

with(document.forms[0]){
		target="frameCheckNo";
		action="K310_query_total.jsp";
		submit();


		target="frameCheckContent";
		action="K310_query_detail.jsp";
		submit();

	}
}



function g(o){
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=2;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='hovertab';
}


/**
  *选择被检对象类别
  */
function getObjectTree(){
	 	var height = 140;
		var width = 350;
		var top = screen.availHeight/2 - height/2;
		var left=screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	    var dialogParam = 'dialogWidth=350px;dialogHeight=350px';
		var time = new Date();
	    window.showModalDialog("../../../../npage/callbosspage/checkWork/K310/K310_lqc_object_tree.jsp?time=" + time, window.document,dialogParam);
}

/**
  *选择考评内容
  */
function getContentTree()
{
	 	var height = 450;
		var width = 700;
		var top = screen.availHeight/2 - height/2;
		var left=screen.availWidth/2 - width/2;
		var time = new Date();
		var dialogParam = 'dialogWidth=700px;dialogHeight=400px';
	    window.showModalDialog("../../../../npage/callbosspage/checkWork/K310/K310_qc_content_list.jsp?time=" + time, window.document, dialogParam);
}


//zengzq add for 重置 start
//清除表单记录
function clearValue(){
		var e = document.forms[0].elements;
		for(var i=0; i<e.length; i++){
				if(e[i].type == "select-one" || e[i].type == "text" || e[i].type == "hidden"){
						if(e[i].id == "beginTime"){
					  		e[i].value = '<%=getCurrDateStr("00:00:00")%>';
					  }else if(e[i].id == "endTime"){
					  		e[i].value = '<%=getCurrDateStr("23:59:59")%>';
					  }else{
					  		if(e[i].id == "CHECK_TYPE"){
					  				e[i].value = '1';
					  		}else if(e[i].id == "CHECK_KIND"){
					  				e[i].value = '1';
					  		}else if(e[i].id == "GROUP_FLAG"){
					  				e[i].value = '0';
					  		}else if(e[i].id == "CHECK_CLASS"){
					  				e[i].value = '0';
					  		}else if(e[i].name != "myaction"){
					  				e[i].value = "";
					  		}					  		
					  }
				}else if(e[i].type == "checkbox"){
						e[i].checked = false;
				}
		}
}
//zengzq add for 重置 end
//自动考评只对应于个人 added by liujied 20090929
function check_kind_change(param)
{
    //alert("param:"+param);
    if(param == "CHECK_KIND")
    {
        var check_kind = document.getElementById(param).value;
        if(check_kind == 0)
        {
            //alert("action invoke!");
            document.getElementById("GROUP_FLAG").value = 0;
        }
    }
    if(param == "GROUP_FLAG")
    {
        var group_flag = document.getElementById(param).value;
        if(group_flag == 1)
        {
            //alert("check kind change to 1 !");
            document.getElementById("CHECK_KIND").value = 1;
        }
    }
}

</script>

</head>
<body>
<form  name="sitechform" id="sitechform">

<input type="hidden" name="sqlFilter" value="">
<input type="hidden" name="myaction" value="doLoad">
<!--
<div id="Main">
<table width="120%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>查询质检计划</B></div>
-->	
    <div id="Operation_Table" style="width: 100%;">
    <div class="title"><div id="title_zi">质检计划管理</div></div>
    <table  border="0" cellpadding="0" cellspacing="0">
    <tr>
    	<td width=8% class="blue">起始日期</td>
        <td width="20%">
	 	    <input id="beginTime" name ="beginTime" type="text"  value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onClick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);">
		    <img onClick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">

        </td>
        <td width="8%" class="blue">考评内容</td>
        <td width="18%">
			<input type="hidden" name="CONTENT_ID" id="CONTENT_ID" /><!--updated by tangsong 增加注释，以消除空格
			--><input type="text" name="CONTENT_name" id="CONTENT_name" disabled/>
			<img onClick="getContentTree();" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        </td>
        <td width="8%" class="blue">考评类别</td>
        <td width="10%">
					<select name="CHECK_TYPE" id="CHECK_TYPE">
	 				<option value="0">实时质检</option>
	 				<option value="1" selected >事后质检</option>
        	</select>
        </td>
      </tr>
    	  <tr>
    	  	<td width=8% class="blue">截止日期</td>
        <td width="20%">
	 	    <input id="endTime" name ="endTime" type="text"   value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>" onClick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
		    <img onClick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        </td>
      	<td width="8%" class="blue">被检对象类别</td>
        <td width="18%">
			<input type="hidden" name="OBJECT_ID" id="OBJECT_ID"/><!--updated by tangsong 增加注释，以消除空格
			--><input type="text" name="OBJECT_GETNAME" id="OBJECT_GETNAME" disabled />
			<img onClick="getObjectTree();" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        </td>

					<td width="8%" class="blue">考评方式</td>
        <td width="10%">
					<select name="CHECK_KIND" id="CHECK_KIND" onchange="check_kind_change('CHECK_KIND');">
	 				<option value="0">自动分派</option>
	 				<option value="1" selected >人工指定</option>
        	</select>
        </td>

    	</tr>
      	 <tr>
      	<td width="8%" class="blue">计划层次</td>
        <td width="18%">
        	<select name="GROUP_FLAG" id="GROUP_FLAG" onchange="check_kind_change('GROUP_FLAG')">
	 				<option value="0">个人</option>
	 				<option value="1">团队</option>
        	</select>

        </td>
         <td width=8% class="blue">计划类别</td>
        <td width="20%">
	 	    <select name="CHECK_CLASS" id="CHECK_CLASS">
	 				<option value="0">评语评分</option>
	 				<option value="1">评语</option>
	 				<option value="2">评分</option>
        	</select>
        </td>
        	<td width="8%" class="blue">质检员</td>
        <td width="10%">
						<input type="text" name="CHECK_LOGIN_NO" size="12">
        </td>
      	</tr>

      <tr>
    	<td width="8%" class="blue">被检工号</td>
        <td width="18%">
						<input type="text" name="LOGIN_NO" size="18">

        </td>
    	  <td width="8%" class="blue">计划ID号</td>
        <td width="20%">
						<input type="text" name="PLAN_ID" size="18">

        </td>
         <td width="8%" class="blue">标题</td>
        <td width="10%">

						<input type="text" name="PLAN_NAME" size="12">
        </td>
    </tr>
    </table>
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" id="parSubmit" name="submit1" type="button" value="查询" onClick="submitQcContent()">
        	<input class="b_foot" name="reset1" type="button"  value="重置" onClick="clearValue(); return false;" >

        </td>
       </tr>
     </table>
</div>
<div class="content_02">
	<!--updated by tangsong 20100824 将tabtit修改为tabtit-ts。安徽样式的tabtit有背景图片，导致标签无效果-->
	<div id="tabtit_ts" width="100%">
		<ul>
			<li id="tb_1" class="hovertab" onClick="HoverLi(1);">总计划</li>
			<li id="tb_2" class="normaltab" onClick="HoverLi(2);">计划明细</li>
		</ul>
	</div>
	<div  class="dis" id="tbc_01">
	  <iframe name="frameCheckNo" src="K310_query_total.jsp" FRAMEBORDER="0" SCROLLING="no" style="height:360px; width:100%;"></iframe>
	</div>
	<div class="undis" id="tbc_02">
		 <iframe name="frameCheckContent" src="K310_query_detail.jsp"  FRAMEBORDER="0" SCROLLING="no" style="height:360px; width:100%;" ></iframe>
	</div>
</div>

    
<!--	
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
-->
</form>

</body>
</html>

