<%
  /*
   * 功能: FTP配置添加页面
　 * 版本: 1.0.0
　 * 日期: 2009/03/14
　 * 作者: fangyua
　 * 版权: sitech
   * update:liujied 客服调试
   * 1.规范样式调整
   * 2.修改山西字样
　 */ 
%>
<%

	String opName = "修改FTP信息";
	String params =(String)request.getParameter("params"); 
	String[] temp = params.split(",");
	String ip = temp[0];
	String port = temp[1];
	String username = temp[2];
	String panfu = temp[3];
	 String psd="";
	 /*add by yinzx 20091002*/
	if (temp.length==5)
	{
	  psd = temp[4];
	} 

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

<!--{--> <!--javaScript-->
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
	var content_id = packet.data.findValueByName("content_id");
	if(retCode=="000000"){
		rdShowMessageDialog('修改内容成功',2);
		window.dialogArguments.location.reload(); 
		window.opener = null;
		window.close();
		
	}else{
		rdShowMessageDialog('修改内容失败',0);
		return false;
	}
}


/**
  *
  *修改FTP内容
  *
  */
function submitQcContent()
{
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
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K098/ftpconfig/ftp_doUpd.jsp","请稍后...");
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
<!--{--> <!-- 注释掉原来部分 -->
<!--
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	  <div id="Operation_Title"><B><%=opName%></B></div> 
        <div id="Operation_Table">
        <div class="title"><div class="title.zi">更新ftp服务器</div></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          
      <tr>
      	<td width="16%" class="blue">FTP服务器地址(IP)</td>
        <td width="34%">
 		<input id="ip" name="ip" maxlength="25" readonly=true/><font class="orange">*</font>
        </td>
         <td width=16% class="blue">用户名</td>
         <td width="34%">
		<input id="username" name="username" value="" />
         </td>      
      </tr>
      <tr>
        <td width=16% class="blue">FTP服务器端口</td>
        <td width="34%">
        <input id="port" name="port" maxlength="25" readonly=true/><font class="orange">*</font>
        </td> 
	  <td width=16% class="blue">密码</td>
        <td width="34%" colspan=''> 
        	<input type="password" id="passwd" name="passwd" size="10" maxlength="20" value=""/>
        </td>      
      </tr>
      <tr>
         <td width=16% class="blue">映射盘符</td>
         <td width="34%" colspan="">
		<input id="panfu" name="panfu" maxlength="10" readonly=true /><font class="orange"/>*</font>
         </td>  
          <td width=16% class="blue">&nbsp;</td>
        <td width="34%">&nbsp;</td>
      </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="footer"  align=center>
            <input class="b_foot" name="submit" type="button" value="确认" onclick="submitQcContent()">
        	
        	<input class="b_foot" name="reset1" type="button"  onclick="clearValue();return false;" value="清除">
             <input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭">
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
 -->

<!--}-->
<!--{--> <!--新写的部分-->
<div id="Operation_Table">
		<div class="title"><div id="title_zi">修改FTP配置</div></div>
		<table>
                  <tr>
      	            <td width="16%" class="blue">FTP服务器地址(IP)</td>
                    <td>
 		      <input id="ip" name="ip" maxlength="25" readonly=true/><font class="orange">*</font>
                    </td>
                                    
                    <td width=16% class="blue">用户名</td>
                    <td>
		      <input id="username" name="username" value="" />
                    </td>      
                  </tr>
                  <tr>
                    <td width=16% class="blue">FTP服务器端口</td>
                    <td>
                      <input id="port" name="port" maxlength="25" readonly=true/><font class="orange">*</font>
                    </td> 
	            <td width=16% class="blue">密码</td>
                    <td >
        	      <input type="password" id="passwd" name="passwd" size="10" maxlength="20" value=""/>
                    </td>      
                  </tr>
                  <tr>
                    <td width=16% class="blue">映射盘符</td>
                    <td width="34%" colspan="">
		      <input id="panfu" name="panfu" maxlength="10" readonly=true /><font class="orange"/>*</font>
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

<script>
	var ip = '<%=ip%>';
	var port = '<%=port%>';
	var username = '<%=username%>';
	var panfu = '<%=panfu%>';
	var psd = '<%=psd%>';
	document.getElementById('ip').value = ip;
	document.getElementById('port').value = port;
	document.getElementById('username').value = username;
	document.getElementById('passwd').value = psd;
	document.getElementById('panfu').value = panfu;		
</script>
</html>




