<%@ page contentType= "text/html;charset=gb2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
    
  String custIdArr  = request.getParameter("custIdArr").trim();
  String custNameArr  = request.getParameter("custNameArr").trim();
  String opName = request.getParameter("opName");
  String custName = request.getParameter("custName");
  String custIccid = request.getParameter("custIccid");
  String custCtime = request.getParameter("custCtime");
  
  String [] idArr = custIdArr.split(",");
  String [] nameArr = custNameArr.split(",");
  
  String [] cIccidArr = custIccid.split(",");
  String [] cTimeArr = custCtime.split(",");
  
  
  System.out.println("custIdArr=="+custIdArr);
  System.out.println("custNameArr=="+custNameArr);
  
  int size = idArr.length;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
	<title>客户信息</title>
	<script language="javascript">
		function returnCustInfo(custId,custName){
			opener.openCustMain(custId,custName,'',custName);
			window.close();
		}
		
		
		
		
	</script>
</head>
<body>
		<form name="frm1">
		<%@ include file="/npage/include/header_pop.jsp" %>
		    <div class="title">
	<div id="title_zi">查询结果</div>
</div>
				<table cellspacing=0>
					<tr>
						<th>&nbsp;</th>
						<th>客户ID</th>
						<th>客户名称</th>
						<th>身份证号</th>
						<th>创建时间</th>
					</tr>	
				<%
					for(int i=0; i<size; i++){
				%>
					<tr>
						<td><input type="radio" name="radio1" onClick="returnCustInfo('<%=idArr[i]%>','<%=nameArr[i]%>')" ></td>
						<td><%=idArr[i]%></td>
						<td><%=nameArr[i]%></td>
						<td><%=cIccidArr[i]%></td>
						<td><%=cTimeArr[i]%></td>
					</tr>
				<%
					}
				%>
				</table>
<table cellspacing=0>
    <tr id="footer">
        <td>
			<input name="" type="button" class="b_foot" value="取消" onclick="window.close()"/>
        </td>
    </tr>
</table>
		<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>
</div>
</body>
</html>

