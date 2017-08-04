<%
   /*
   * 功能: 新增失败原因
   * 版本: 1.0.0
   * 日期: 
   * 作者: 
   * 版权: sitech
   * update: liujied 0716 客服调试  
   * 1.将页面标题改为新增失败原因
   * 2.将样式规范
   * 3.添加验证错误类型功能
   * 4.当没有验证时,无法提交数据(置灰),只有通过验证
   *   才可以提交数据
   * 5.每个错误类型与错误名称是一一对应的关系，用户无法增加数据库中已有的错误类型
   */	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<html>
<head>
<title>新增失败原因</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

</head>
<body>


<form name="formbar" method="post" action="insertList.jsp" target="frameright">
<div id="Operation_Table">
		<div class="title"><div id="title_zi">新增失败原因</div></div>
		<table>
		  <tr>
  		    <td class="blue">错误类型</td>
  		    <td width="70%">
  		      <input id="code" name="code" size="20" maxlength="6" type="text" value="">
                        <input class = "b_text" name ="check" type="button" id="check" onclick="submitErrorKindCheck()" size='5' maxlength='5' value="验证">
	  	      </td>
		    </tr>
		  <tr>
  				<td class="blue">错误名称</td>
  				<td width="70%">
                                  <input id="name" name="name" size="20" type="text" maxlength="40"  value="">
	  			  </td>
			        </tr>
		  
		  <tr >
  		    <td colspan="2" align="center" id="footer">
   		      <input name="btn_internalcall" type="button" class="b_text" id="btn_internalcall" value="提交" onClick="submitInputCheck()" disabled=true>
   			<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()">
   			  <input name="close" type="button" class="b_text" id="close" value="取消" onClick="closeWin()">
  			  </td>
			</tr>
		      </table>
	            </div>
                  </form>
                  </body>
                    </html>

<script>

//数据插入
function callSwich()
{
  var packet = new AJAXPacket("../../../npage/callbosspage/failReason/insert.jsp",
                              "正在处理,请稍后...");
  packet.data.add("code",window.formbar.code.value);
  packet.data.add("name",window.formbar.name.value);
  core.ajax.sendPacket(packet,doProcessNavcomring,false);
  packet =null;
}  
  //公共处理回调
function doProcessNavcomring(packet)	 
	 {
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    	if(retCode=="000000"){
	    		rdShowMessageDialog("处理成功!",'2');
          window.opener.location.href=window.opener.location.href;
          window.close();
	    	}else{
	    		rdShowMessageDialog("处理失败!");
	    		return false;
	    	}
	 }

function doProcessChecking(packet)	 
	 {
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    	if(retCode=="000000"){
                     rdShowMessageDialog("验证成功!",'2');
                     //使提交按钮可用
                     document.getElementById("btn_internalcall").disabled=false;
                     
	    	}else{
                     rdShowMessageDialog("验证失败!");
                     return false;
	    	}
	 }
	 
function submitInputCheck(){
   if( document.formbar.code.value == ""){
    	   showTip(document.formbar.code,"错误类型不能为空"); 
    	   formbar.code.focus(); 	
    	 return false;
    }
    if(isNaN(document.formbar.code.value)){
    		showTip(document.formbar.code,"错误类型只能是数字"); 
    	   formbar.code.focus(); 	
    	   return false;
    	}
     if(document.formbar.name.value == ""){
		     showTip(document.formbar.name,"错误名称不能为空"); 
    	   formbar.name.focus(); 	
    	   return false;
    }


callSwich();
    	
}

function submitErrorKindCheck(){
   if( document.formbar.code.value == ""){
    	   showTip(document.formbar.code,"错误类型不能为空"); 
    	   formbar.code.focus(); 	
    	 return false;
    }
    if(isNaN(document.formbar.code.value)){
    		showTip(document.formbar.code,"错误类型只能是数字"); 
    	   formbar.code.focus(); 	
    	   return false;
    	}
ErrorKindSend();
}

function ErrorKindSend()
{
  
  var packet = new AJAXPacket("check.jsp", "正在验证,请稍后...");
  packet.data.add("check",window.formbar.code.value);
 
  core.ajax.sendPacket(packet,doProcessChecking,false);
 
  packet =null;
}
function closeWin()
{
  window.close();
}

// 清除表单记录
function cleanValue(){
document.getElementById("code").value="";	
document.getElementById("name").value="";	

}

</script>






