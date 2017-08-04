<%
  /*
   * 功能: FTP配置
　 * 版本: 1.0.0
　 * 日期: 2009/03/14
　 * 作者: fangyuan
　 * 版权: sitech
   * update: liujied 客服调试
   * 1.规范样式调整
   * 2.添加opCode和opName
   * 3.修改了传递到ftp_upd.jsp和ftp_add.jsp的winParam参数
   * 4.删除弹出框的消息将"考评内容"修改为"配置内容"
　 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

/*---------------获得FTP内容列表开始-------------------*/
String sqlStr = "select t.ftp_ip,t.ftp_port,nvl(t.ftp_user,' '),t.ftp_dir,to_char(t.create_time,'yyyy-mm-dd HH:MM:SS'),nvl(t.FTP_PASSWD,' ') "+" from dcallftpservercfg t order by t.create_time desc";

String opCode="K103";
String opName="录音服务器配置";
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
/*---------------获得FTP内容列表结束-------------------*/
%>

<html>
<head>
<title>FTP配置</title>
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

//全局变量保存页面值
var g_values="";

/**
  *
  *打开添加考评内容窗口
  *
  */
function add_qc_content(){
	
	var time     = new Date();
	//var winParam = 'dialogWidth=800px;dialogHeight=330px';
        var winParam = 'dialogWidth=600px;dialogHeight=400px';
	window.showModalDialog('ftp_add.jsp?time=' + time , window, winParam);	
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
		rdShowMessageDialog('请选择要修改的内容',1);
		return false;
	}
	var time     = new Date();
	//var winParam = 'dialogWidth=800px;dialogHeight=330px';
        var winParam = 'dialogWidth=600px;dialogHeight=400px';                   
	window.showModalDialog('ftp_upd.jsp?time=' + time + '&params='+g_values, window, winParam);	
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
		rdShowMessageDialog('请选择要删除的内容',1);
		return false;
	}
	if(rdShowConfirmDialog("确认删除当前配置么？") == 1){
		delQcContent();
	}
}


/*对返回值进行处理*/
function doProcessDelQcContent(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="000000"){
		//rdShowMessageDialog('成功删除配置信息',2);
		var radios = document.getElementsByName("check_content");
		for(var i = 0; i < radios.length; i++){
			if(radios[i].checked){
				var trobj = radios[i].parentElement.parentElement;
				trobj.parentElement.removeChild(trobj);
			}
		}
	}else{
		rdShowMessageDialog('删除配置信息失败!',0);
		return false;
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
	//alert(g_values);
	var arr = g_values.split(',');
	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K098/ftpconfig/ftp_doDel.jsp","请稍后...");
     var ip = arr[0];
     var port = arr[1];
     var panfu = arr[3];
     chkPacket.data.add("ip",ip);
     chkPacket.data.add("port",port);
     chkPacket.data.add("panfu",panfu);
	core.ajax.sendPacket(chkPacket, doProcessDelQcContent, false);
	chkPacket =null;
	//alert("End call delQcContent()....");
}

/**
  *
  *选中当前内容，刷新页面传值变量
  *
  */
function getCheckItem(v){
	//alert("v----->" + v);
	g_values = v;
}

</script>
</head>

<body>

<form  name="formbar">
 <%@ include file="/npage/include/header.jsp"%>
<!--<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top"> -->
    <div id="Operation_Table">
    	<div class="title"><div id="title_zi">FTP配置</div></div>
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <th align="center" width="8%" class="blue">选择</th>
        <th align="center" width="16%" class="blue">FTP服务器地址(IP)</th>
        <th align="center" width="16%" class="blue">FTP服务器端口</th>
        <th align="center" width="16%" class="blue">用户名</th>
        <th align="center" width="16%" class="blue">映射盘符</th>      
      </tr>
      <%
      if(queryList != null && queryList.length > 0){
      	for(int i = 0; i< queryList.length; i++){%>
      <tr>
        <td align="center" class="blue"><input type="radio" name="check_content" onclick="getCheckItem(this.value);" value="<%=queryList[i][0]%>,<%=queryList[i][1]%>,<%=queryList[i][2]%>,<%=queryList[i][3]%>,<%=queryList[i][5]%>"/></td>
        <td align="center" class="blue"><%=queryList[i][0]%>&nbsp;</td>
        <td align="center" class="blue"><%=queryList[i][1]%>&nbsp;</td>
        <td align="center" class="blue"><%=queryList[i][2]%>&nbsp;</td>
        <td align="center" class="blue"><%=queryList[i][3]%>&nbsp;</td>
      
      </tr>
      <%
      	}
      }else{
      %>
       <!--tr><td align="center" class="blue" colspan="5"><font color="orange">当前记录为空！</font></td></tr-->	
      <% }%>
      </table> 
      
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td id="footer"  align="right">
	<input type="button" name="btn_add" value="添加" class="b_foot" onclick="add_qc_content()"/>
	<input type="button" name="btn_update" value="修改" class="b_foot" onclick="update_qc_content()"/>
	<input type="button" name="btn_delete" value="删除" class="b_foot" onclick="delete_qc_content()"/>
</td>
</tr>
</table>
</div>

</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>
