<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%request.setCharacterEncoding("gbk");%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%
		String opName ="������BOSS-��Ϣ��ʾ";
    /*�õ��������*/
%> 
<%
String CGI_PATH = "";

//�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
CGI_PATH = SystemUtils.getConfig("CGI_PATH");
//�������"/"��ʽ����,����"/"
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
					alert("��������ܾ���\n�����������ַ������'about:config'���س�\nȻ�� 'signed.applets.codebase_principal_support'����Ϊ'true'");   
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
			alert("���Ƴɹ���")
	}
	function getParentMsg(){
		window.close();
	}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-��Ϣ��ʾ</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY  onunload="getParentMsg()">
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td>
			<span id="">
				������ˮ��<%=fileName%>
			</td>
		</tr>
		<tr>
			<td>
			<span id="errorMsgSpan">
			���ύ������Ϊ<font class="red"><%=fileLines%></font>��,ϵͳ���ں�̨�����У�<font class="red"><b>ϵͳ�����ٶ�ԼΪÿ10����2000�������Ժ��ѯ��ȷ��ִ�н��!</b></font>
			</td>
		</tr>
		
		<tr><td>
			<div align="center">
				
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="getParentMsg();">
			</div>
		</td></tr>
	</span>
	
	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
