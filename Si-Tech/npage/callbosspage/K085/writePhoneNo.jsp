<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

  <%
	String msg= request.getParameter("msg");
	
	String HtmlContent="";
	if("设置亲情短信号码".equals(msg)){
	HtmlContent="<tbody><tr><td>亲情号码</td><td><input type='text' id='phone_no'/></td></tr></tbody>";
	}
	
	%>
<html>
	<head>
			<title>短信分流—<%=msg%></title>
	</head>
	<body>
		<div id="Operation_Table">
		<div class="title">
				<div id="title_zi"><%=msg%></div>
				
		</div>
    <table cellspacing="0" id="mytable">
    	
    	<%
    	
    	
     if ("开通定向国内长途".equals(msg)){
    		 out.println("<tbody><tr><td>定向国内长途申请省份省会长途区号</td></tr><tr><td><input type='text' id='citycode'/></td></tr></tbody>");
    		}		
    	else if ("变更定向国内长途".equals(msg)){
    		 out.println("<tbody><tr><td>原定向国内长途申请省份省会长途区号</td></tr><tr><td><input type='text' id='citycode1'/></td></tr><tr><td>变更后定向国内长途申请省份省会长途区号</td></tr><tr><td><input type='text' id='citycode2'/></td></tr></tbody>");
    		}	
    	else if ("取消定向国内长途".equals(msg)){
    		 out.println("<tbody><tr><td>定向国内长途申请省份省会长途区号</td></tr><tr><td><input type='text' id='citycode'/></td></tr></tbody>");
    		}	
    		
    	%>
    	
	  </table>
	<table>
		<tr>
			<td>
				<div id="Operation_Table">
					<input name="close" type="button" class="b_foot" 
						id="send" value="下发" onClick="send();">
					<input name="close" type="button" class="b_foot" 
						id="clswindow" value="关闭" onClick="window.close()">
				</div>
				</td>
			</tr>
</table>
<script type="text/javascript">
	
	
		function send(){
			var content="";//发送指令

    	if ("开通定向国内长途"=="<%=msg%>"){
    		  content='dxct'+ document.getElementById('citycode').value;
    			}		
    	else if ("变更定向国内长途"=="<%=msg%>"){
    		 content='BGDXCT'+ document.getElementById('citycode1').value+'#'+document.getElementById('citycode2').value;
    				}	
    	else if ("取消定向国内长途"=="<%=msg%>"){
    		  content='qxdxct'+ document.getElementById('citycode').value;
    			}	
			var parentWindow = window.dialogArguments;
			parentWindow.SendDi(content,"<%=msg%>");
			window.close();
		}
</script>
</body>
</html>