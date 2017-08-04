<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%request.setCharacterEncoding("gbk");%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%
		String opName ="黑龙江BOSS-信息提示";
    /*得到输入参数*/
%> 
<%
String CGI_PATH = "";

//从公共配置文件中读取配置信息，此信息被多sever共享
CGI_PATH = SystemUtils.getConfig("CGI_PATH");
//如果不以"/"格式结束,加上"/"
if (!CGI_PATH.endsWith("/")) {
CGI_PATH = CGI_PATH + "/";
}
%>
<%

String[] paths=CGI_PATH.split("/"); 
CGI_PATH="";
for(int i=0;i<paths.length-1;i++)
{
CGI_PATH+=paths[i]+"/";
} 
System.out.println("CGI_PATH=========================================="+CGI_PATH);    

String fileName = request.getParameter("accept");
String fileLines = request.getParameter("findS");

%>

	
<script language="javascript">
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
				str.data = copytext+"</br></r></n>";   
				trans.setTransferData("text/unicode",str,copytext.length*2);   
				var clipid = Components.interfaces.nsIClipboard;   
				if (!clip)   
					return false;   
				clip.setData(trans,null,clipid.kGlobalClipboard);   
			}   
			alert("复制成功！")
	}
	function getParentMsg(){
		window.close();
	}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>黑龙江BOSS-信息提示</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY  onunload="getParentMsg()">
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">操作信息</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td>
			<span id="">
				操作流水：<%=fileName%>
			</td>
		</tr>
		<tr>
			<td>
			<span id="errorMsgSpan">
			您提交的数据为<font class="red"><%=fileLines%></font>条,系统正在后台处理中，<font class="red"><b>系统处理速度约为每10分钟2000条，请稍后查询并确认执行结果!</b></font>
			</td>
		</tr>
		
		<tr><td>
			<div align="center">
				
				<input type="button" name="close" class="b_foot" value="关闭" onClick="getParentMsg();">
			</div>
		</td></tr>
	</span>
	
	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
