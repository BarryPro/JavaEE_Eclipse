  
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ page import="com.sitech.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%
  String opCode = request.getParameter("opCode");
  
	String opName="�����ֻ�����";
	
	 
%>

<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�����Դ��ѯ</title>


<script language="javascript" type="text/javascript">

	function enterParent(){
		window.returnValue=$("#phoneNum").val();
		window.close();
	}
	
</SCRIPT>
</head>
<body  style="overflow-y:auto; overflow-x:hidden;">
<form method=post name="pubService">	

<%@ include file="/npage/include/header_pop.jsp" %>

<div style="width:100%">
<div class="title" >
 <div id="title_zi">С����ѯ</div>	
</div>
<table>
	<tr>
		<td class="Blue" width="20%">�ֻ�����</td>
		<td width="25%">
			<input id="phoneNum" name="phoneNum" maxlength="11" value=""/>
		</td>
		
	</tr>
	<tr><td id="footer" colspan="2">
			<input  type="button" class="b_footr" value="ȷ��" onclick="enterParent()"/>
		</td>
		</tr>
</table>
</div>


<%@ include file="/npage/include/footer_pop.jsp" %>  
</form>
</body>
</html>

