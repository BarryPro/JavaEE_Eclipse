<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String flag= request.getParameter("flag");
	String msg_code="";
	String msg = "";
	if("1".equals(flag)){
		msg_code="KTLCYJ";
		msg="两城一家";
	}else if("2".equals(flag)){
		msg_code="KTFCJQ";
		msg="非常假期";
	}else if("3".equals(flag)){
		msg_code = "QXLCYJ";
		msg = "取消两城一家";
	}else if("4".equals(flag)){
		msg_code = "QXFCJQ";
		msg = "取消非常假期";
	}
	String[][] regionArr={
													{"0451","哈尔滨"},
													{"0452","齐齐哈尔"},
													{"0453","牡丹江"},
													{"0454","佳木斯"},
													{"0455","绥化"},
													{"0456","黑河"},
													{"0457","大兴安岭"},
													{"0458","伊春"},
													{"0459","大庆"},
													{"0464","七台河"},
													{"0467","鸡西"},
													{"0468","鹤岗"},
													{"0469","双鸭山"}
												};
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
    <table cellspacing="0">
    	<% for(int i=0;i<regionArr.length;i++){
    		out.println("<tr><td>");
    		out.println("<input type='radio' id='linkmsg' name='linkmsg' onclick='doSetValue(this)' value='"+msg_code+regionArr[i][0]+"'/>"+regionArr[i][1]+"("+regionArr[i][0]+")");
    		out.println("</td></tr>");
    	}
    	%>
    </tr>
    
	</table>
	<table>
		<tr>
			<td>
				<div id="Operation_Table">
					<input name="close" type="button" class="b_foot" 
						id="send" value="下发" onClick="send();">
					<input name="close" type="button" class="b_foot" 
						id="clswindow" value="关闭" onClick="window.close()">
					<input type="hidden" value="" id="code" name="code"/>
				</div>
				</td>
			</tr>
</table>
<script type="text/javascript">
		function doSetValue(obj){
			document.all.code.value= obj.value;
		}
		function send(){
			
			var content = document.getElementById('code').value;
			var parentWindow = window.dialogArguments;
			parentWindow.SendDi(content,"<%=msg%>");
			window.close();
		}
</script>
</body>
</html>