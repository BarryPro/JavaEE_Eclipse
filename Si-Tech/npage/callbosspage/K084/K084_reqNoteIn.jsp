<%
  /*
   * ����: һ��֪ͨ����
�� * �汾: 1.0
�� * ����: 2008/11/6
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>


<html>
<head>

<title>һ��֪ͨ����</title>
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
    	 	<th>���͹���</th>
    	  <th>��Ϣ���</th>
        <th>����ʱ��</th>
        <th>��Ϣ����</th>        
       </tr>
		</table>
			</dt>
		</dl>
</div>
</form>
</body>
</html>

