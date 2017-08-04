<%
  /*
   * 功能: FTP配置添加页面
　 * 版本: 1.0.0
　 * 日期: 2009/03/14
　 * 作者: fangyua
　 * 版权: sitech
   * update:liujied 客服调试
   * 1.规范样式调整
   * 
　 */
%>
<%
	String opName = "添加FTP信息";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@page contentType="text/html;charset=GBK"%>
<html>
<head>
<title><%=opName%></title>
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
<!--{--> <!-- javaScript -->
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
  if(e[i].type!="select-one"&&e[i].type=="text"&&tid!=""){
  	if(!(document.getElementById(tid).disabled)&&!(document.getElementById(tid).readOnly)){
	  	e[i].value="";
	  }
	}
	if(e[i].type=="select-one"&&tid!=""){
		document.getElementById(tid).options[0].selected = true;
	}
 }
}



/*对返回值进行处理*/
function doProcessAddQcContent(packet)
{

	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var content_id = packet.data.findValueByName("content_id");

	if(retCode=="000000"){
		insertTable();
		//window.dialogArguments.location.reload(); 
		if(rdShowConfirmDialog("添加FTP信息成功，是否继续添加",2) != 1){
			//window.dialogArguments.location.reload(); 
			window.opener = null;
			window.close();
		}
	}else{
		rdShowMessageDialog('添加FTP信息失败',0);
		return false;
	}
	//alert("End call doProcessAddQcContent()......");
}

/**
  *
  *将FTP内容插入到父页面的表格之中
  *
  */
function insertTable(){

     var ip = document.getElementById("ip").value;
     var port = document.getElementById("port").value;
     var username = document.getElementById("username").value;
     var passwd = document.getElementById("passwd").value;
     var panfu = document.getElementById("panfu").value
	//alert('username= '+username+' '+typeof(username));
	var parWin = window.dialogArguments;
	var table  =  parWin.document.getElementById("contentTable");
	var tr = table.insertRow();
	var v = ip+','+port+','+username+','+panfu+','+passwd;
	tr.className = "blue";
	tr.align="center";
	tr.insertCell().innerHTML = '<input type="radio" name="check_content" onclick="getCheckItem(this.value)" value="'+v+'"/>';
	tr.insertCell().innerHTML = ip;
	tr.insertCell().innerHTML = port;
	var temp = '&nbsp;';
	if(username==''){
		tr.insertCell().innerHTML = temp;
	}else{
		tr.insertCell().innerHTML = username;
	}
	tr.insertCell().innerHTML = panfu;
	//tr.insertCell().innerHTML = getTime();
}

function isIP(strIP) {
//if (isNull(strIP)) return false;
var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/g //匹配IP地址的正则表达式
if(re.test(strIP))
{
if( RegExp.$1 <256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256) return true;
}
return false;
}


/**
  *
  *添加考评内容
  *
  */
function submitQcContent()
{
	//alert("Begin call submitQcContent()....");
    var ip = document.getElementById("ip").value;
    var port = document.getElementById("port").value;
    var panfu = document.getElementById("panfu").value;
	//校验
	if(ip == ''){
		//rdShowMessageDialog('请输入FTP服务器地址信息！', 1);
		document.getElementById("ip").focus();
		return false;
	}
	if(port == ''){
		//rdShowMessageDialog('请输入FTP服务器端口信息！', 1);
		document.getElementById("port").focus();
		return false;
	}
	if(panfu == ''){
		//rdShowMessageDialog('请输入盘符信息！', 1);
		document.getElementById("panfu").focus();
		return false;
	}
	if(!isIP(ip)){
		rdShowMessageDialog('ip地址不合法！', 1);
		document.getElementById("ip").focus();
		return false;
	}
	
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K098/ftpconfig/ftp_doAdd.jsp","请稍后...");
    var ip = document.getElementById("ip").value;
    var port = document.getElementById("port").value;
    var username = document.getElementById("username").value;
    var passwd = document.getElementById("passwd").value;
    var panfu = document.getElementById("panfu").value
    chkPacket.data.add("ip",ip);
    chkPacket.data.add("port",port);
    chkPacket.data.add("username",username);
    chkPacket.data.add("passwd",passwd);
    chkPacket.data.add("panfu",panfu);
    
    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,false);
    chkPacket =null;
}

</script>
<!--}-->
</head>
<body>

<form  name="formbar">
<!--{新增部分-->
<div id="Operation_Table">
		<div class="title"><div id="title_zi">添加FTP配置</div></div>
		<table>
                  <tr>
      	            <td width="16%" class="blue">FTP服务器地址(IP)</td>
                    <td width="34%">
 		      <input id="ip" name="ip" maxlength="25" v_must="1" v_type="string" onBlur="checkElement(this)" /><font class="orange">*</font>
                    </td>
                    <td width=16% class="blue">用户名</td>
                    <td width="34%">
		      <input id="username" name="username" value="" />
                    </td>      
                  </tr>
                  
                  <tr>
                    <td width=16% class="blue">FTP服务器端口</td>
                    <td width="34%">
                      <input id="port" name="port" maxlength="25" v_must="1" v_type="string" onBlur="checkElement(this)" onkeyup="value=value.replace(/[^\d]/g,'')"/><font class="orange">*</font>
                    </td> 
	            <td width=16% class="blue">密码</td>
                    <td width="34%" colspan=''> 
        	      <input type="password" id="passwd" name="passwd" size="10" maxlength="20" value=""/>
                    </td>      
                  </tr>

                  <tr>
                    <td width=16% class="blue">映射盘符</td>
                    <td width="34%" colspan="">
		      <input id="panfu" name="panfu" maxlength="10" v_must="1" v_type="string" onBlur="checkElement(this)" /><font class="orange"/>*</font>
                  </td>  
                  <td width=16% class="blue">&nbsp;</td>
                  <td width="34%">&nbsp;</td>
                  </tr>

                    
<tr>
  <td id="footer"  align=center colspan="4">
    <input class="b_foot" name="submit" type="button" value="确认" onclick="submitQcContent()">
    
    <input class="b_foot" name="reset1" type="button"  onclick="clearValue();return false;" value="清除">
    <input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭">
  </td>
</tr>
    </table>
</div>
<!--}-->

</form>


</body>

</html>




