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
		msg="����һ��";
	}else if("2".equals(flag)){
		msg_code="KTFCJQ";
		msg="�ǳ�����";
	}else if("3".equals(flag)){
		msg_code = "QXLCYJ";
		msg = "ȡ������һ��";
	}else if("4".equals(flag)){
		msg_code = "QXFCJQ";
		msg = "ȡ���ǳ�����";
	}
	String[][] regionArr={
													{"0451","������"},
													{"0452","�������"},
													{"0453","ĵ����"},
													{"0454","��ľ˹"},
													{"0455","�绯"},
													{"0456","�ں�"},
													{"0457","���˰���"},
													{"0458","����"},
													{"0459","����"},
													{"0464","��̨��"},
													{"0467","����"},
													{"0468","�׸�"},
													{"0469","˫Ѽɽ"}
												};
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
						id="send" value="�·�" onClick="send();">
					<input name="close" type="button" class="b_foot" 
						id="clswindow" value="�ر�" onClick="window.close()">
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