<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%request.setCharacterEncoding("gbk");%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
		String opName ="黑龙江BOSS-错误提示";
    /*得到输入参数*/
%> 	
<script language="javascript">
	$(document).ready(function(){
		var errorMsg = opener.errorMsgStr;
		$("#errorMsgSpan").text(errorMsg);
	});
	function copyErrorMsg(){
		var errorMsg = $("#errorMsgSpan").text();
		copyToClipboard(errorMsg);
	}
	
	function copyToClipboard(txt) {   
			if(window.clipboardData) {   
				window.clipboardData.clearData();   
				window.clipboardData.setData("Text", txt);   
			} else if(navigator.userAgent.indexOf("Opera") != -1) {   
				window.location = txt;   
			} else if (window.netscape) {   
				try {   
					netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");   
				} catch (e) {   
					alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将 'signed.applets.codebase_principal_support'设置为'true'");   
				}   
				var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);   
				if (!clip)   
					return;   
				var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);   
				if (!trans)   
					return;   
				trans.addDataFlavor('text/unicode');   
				var str = new Object();   
				var len = new Object();   
				var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);   
				var copytext = txt;   
				str.data = copytext;   
				trans.setTransferData("text/unicode",str,copytext.length*2);   
				var clipid = Components.interfaces.nsIClipboard;   
				if (!clip)   
					return false;   
				clip.setData(trans,null,clipid.kGlobalClipboard);   
			}   
			rdShowMessageDialog("复制成功！",2);
	}
	function getParentMsg(){
		var openerHref = opener.location.href;
		/* 有的可能不叫做opCode 需要判断 */
		var opCodeStr = "";
		if(openerHref.indexOf("opCode=") != "-1"){
			opCodeStr = openerHref.substring(openerHref.indexOf("opCode=") + 7);
			opCodeStr = opCodeStr.substring(0,opCodeStr.indexOf("&"));
			opener.parent.removeTab(opCodeStr);
		}else{
			opener.parent.removeCurrentTab();
		}
		window.close();
	}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-错误提示</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY  onunload="getParentMsg()">
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">对不起，系统出错，请停止业务办理并与管理员联系</div>
	</div>
	<table cellspacing="0">
		<tr><td>
			<span id="errorMsgSpan">
		</td></tr>
		<tr><td>
			<div align="center">
				<input type="button" name="query" class="b_foot_long" value="复制错误信息" onclick="copyErrorMsg()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="getParentMsg();">
			</div>
		</td></tr>
	</span>
	
	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
