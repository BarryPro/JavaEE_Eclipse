<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
    
  String custIdArr  = request.getParameter("custIdArr").trim();
  String custNameArr  = request.getParameter("custNameArr").trim();
  
  String [] idArr = custIdArr.split(",");
  String [] nameArr = custNameArr.split(",");
  
  System.out.println("custIdArr=="+custIdArr);
  System.out.println("custNameArr=="+custNameArr);
  
  int size = idArr.length;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
	<title>客户信息</title>
	<script language="javascript">
		function returnCustInfo(custId,custName){
			window.returnValue = custId;
			window.close();
		}
	</script>
</head>
<body>
	<div id="operation">
		<form name="frm1">
		<%@ include file="/npage/include/header_pop.jsp" %>
		<div id="operation_table">
			<div class="list">
				<table >
					<tr>
						<th>&nbsp;</th>
						<th>客户ID</th>
						<th>客户名称</th>
					</tr>	
				<%
					for(int i=0; i<size; i++){
				%>
					<tr>
						<td><input type="radio" name="radio1" onClick="returnCustInfo('<%=idArr[i]%>','<%=nameArr[i]%>')" ></td>
						<td><%=idArr[i]%></td>
						<td><%=nameArr[i]%></td>
					</tr>
				<%
					}
				%>
				</table>
			</div>
		</div>
		<div id="operation_button">
			<input name="" type="button" class="b_foot" value="取消" onclick="closeDivWin()"/>
		</div>
		<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>
</div>
</body>
</html>

