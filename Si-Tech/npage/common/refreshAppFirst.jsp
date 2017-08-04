<%
  /*
   * 功能:刷新权限Application页面,新增一个密码输入框，输入成功则可以进行下一步操作。
   * 版本: 1.0
   * 日期: 2014/11/13 14:12:32
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>

<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 

%>




<html>
<head>
	<title>刷新application</title>
	<script language="javascript">
		function gotoNextj(){
			var passWordC = document.f1.passWordC.value;
			if(passWordC.length == 0){
				alert("请输入密码！");
				return false;
			}
			
			
			document.all.f1.submit();
			
		}
		/*密码加密方法*/
		function gotoENC(){
			var passWordB = document.f1.passWordB.value;
			if(passWordB.length == 0){
				alert("请输入加密前密码！");
				return false;
			}
			var path = "/npage/common/refreshAppEnc.jsp?passWordC="+passWordB;
			var encPass = window.showModalDialog("/npage/s4000/Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
			document.all.passWordE.value = encPass;
		}
		
	
	</script>
	</head>
<body>
	<form action="/npage/common/refreshApp.jsp" method="post" name="f1">
	<table align="center">
		<tr align="center">
			<td >密码</td>
			<td ><input type="password" name="passWordC" value=""/>&nbsp;&nbsp;
					<input type="button" name="subBtn" value="确定" onclick="gotoNextj();"/>
			</td>	
		</tr>
		<tr>
			<td >加密前密码</td>
			<td ><input type="password" name="passWordB" value=""/>&nbsp;&nbsp;
					<input type="button" name="subBtn2" value="加密" onclick="gotoENC();"/>
			</td>	
			<td >加密后密码</td>
			<td ><input type="text" name="passWordE" value=""/>
			</td>	
		</tr>
	</table>
</form>
</body>


</html>
