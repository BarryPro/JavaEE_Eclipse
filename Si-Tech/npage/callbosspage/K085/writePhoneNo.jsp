<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

  <%
	String msg= request.getParameter("msg");
	
	String HtmlContent="";
	if("����������ź���".equals(msg)){
	HtmlContent="<tbody><tr><td>�������</td><td><input type='text' id='phone_no'/></td></tr></tbody>";
	}
	
	%>
<html>
	<head>
			<title>���ŷ�����<%=msg%></title>
	</head>
	<body>
		<div id="Operation_Table">
		<div class="title">
				<div id="title_zi"><%=msg%></div>
				
		</div>
    <table cellspacing="0" id="mytable">
    	
    	<%
    	
    	
     if ("��ͨ������ڳ�;".equals(msg)){
    		 out.println("<tbody><tr><td>������ڳ�;����ʡ��ʡ�᳤;����</td></tr><tr><td><input type='text' id='citycode'/></td></tr></tbody>");
    		}		
    	else if ("���������ڳ�;".equals(msg)){
    		 out.println("<tbody><tr><td>ԭ������ڳ�;����ʡ��ʡ�᳤;����</td></tr><tr><td><input type='text' id='citycode1'/></td></tr><tr><td>���������ڳ�;����ʡ��ʡ�᳤;����</td></tr><tr><td><input type='text' id='citycode2'/></td></tr></tbody>");
    		}	
    	else if ("ȡ��������ڳ�;".equals(msg)){
    		 out.println("<tbody><tr><td>������ڳ�;����ʡ��ʡ�᳤;����</td></tr><tr><td><input type='text' id='citycode'/></td></tr></tbody>");
    		}	
    		
    	%>
    	
	  </table>
	<table>
		<tr>
			<td>
				<div id="Operation_Table">
					<input name="close" type="button" class="b_foot" 
						id="send" value="�·�" onClick="send();">
					<input name="close" type="button" class="b_foot" 
						id="clswindow" value="�ر�" onClick="window.close()">
				</div>
				</td>
			</tr>
</table>
<script type="text/javascript">
	
	
		function send(){
			var content="";//����ָ��

    	if ("��ͨ������ڳ�;"=="<%=msg%>"){
    		  content='dxct'+ document.getElementById('citycode').value;
    			}		
    	else if ("���������ڳ�;"=="<%=msg%>"){
    		 content='BGDXCT'+ document.getElementById('citycode1').value+'#'+document.getElementById('citycode2').value;
    				}	
    	else if ("ȡ��������ڳ�;"=="<%=msg%>"){
    		  content='qxdxct'+ document.getElementById('citycode').value;
    			}	
			var parentWindow = window.dialogArguments;
			parentWindow.SendDi(content,"<%=msg%>");
			window.close();
		}
</script>
</body>
</html>