<%
  /*
   * ����:ˢ��Ȩ��Applicationҳ��,����һ���������������ɹ�����Խ�����һ��������
   * �汾: 1.0
   * ����: 2014/11/13 14:12:32
   * ����: gaopeng
   * ��Ȩ: si-tech
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
	<title>ˢ��application</title>
	<script language="javascript">
		function gotoNextj(){
			var passWordC = document.f1.passWordC.value;
			if(passWordC.length == 0){
				alert("���������룡");
				return false;
			}
			
			
			document.all.f1.submit();
			
		}
		/*������ܷ���*/
		function gotoENC(){
			var passWordB = document.f1.passWordB.value;
			if(passWordB.length == 0){
				alert("���������ǰ���룡");
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
			<td >����</td>
			<td ><input type="password" name="passWordC" value=""/>&nbsp;&nbsp;
					<input type="button" name="subBtn" value="ȷ��" onclick="gotoNextj();"/>
			</td>	
		</tr>
		<tr>
			<td >����ǰ����</td>
			<td ><input type="password" name="passWordB" value=""/>&nbsp;&nbsp;
					<input type="button" name="subBtn2" value="����" onclick="gotoENC();"/>
			</td>	
			<td >���ܺ�����</td>
			<td ><input type="text" name="passWordE" value=""/>
			</td>	
		</tr>
	</table>
</form>
</body>


</html>
