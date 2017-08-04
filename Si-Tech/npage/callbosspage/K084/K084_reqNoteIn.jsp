<%
  /*
   * 功能: 一般通知发送
　 * 版本: 1.0
　 * 日期: 2008/11/6
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>


<html>
<head>

<title>一般通知发送</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body style="overflow-x:scroll;overflow-y:scroll">
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<dl id="contentArea">
			<dt class="on">
				
			<table cellspacing="0" cellpadding="0">
    	 <tr>
    	 	<th>发送工号</th>
    	  <th>消息类别</th>
        <th>发送时间</th>
        <th>消息内容</th>        
       </tr>
		</table>
			</dt>
		</dl>
</div>
</form>
</body>
</html>

