<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-20
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@page contentType="text/html;charset=gb2312"%>
<%

	String[][] result = new String[][]{};
	 
String regionCode = (String)session.getAttribute("regCode");
	
	String region_code = request.getParameter("region_code");
	String mode_code = request.getParameter("mode_code");
	String login_accept = request.getParameter("login_accept");
	
	
	String sqlStr1="";
	sqlStr1 ="select MODE_CODE, ADD_MODE, ERR_CODE, ERR_MSG, to_char(OP_TIME,'yyyy-mm-dd'), NOTE " + 
	" from sProdRelaErrMsg where login_accept = " + login_accept +
	" and region_code = '" + region_code + "'";
	//retList1 = impl.sPubSelect("6",sqlStr1,"region",regionCode);
	%>
	
		<wtc:pubselect name="sPubSelect" outnum="6" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>	
	
	<%
	String[][] retListString1 = result_t;
%>

<html>
<head>
<title>依赖关系失败记录</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
	
<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>

<table id="tab1" cellspacing="0">
	<tr >
		<th height="26" align="center">
			产品代码
		</th>
		<th align="center">
			目标产品代码
		</th>
		<th align="center">
			失败原因
		</th>
	</tr>
</table>
<table  cellspacing="0">
	<tr>
		<td id="footer">
				<div align="center">
			      <input type="button" name="back" onClick="doClose();" value=" 关闭 " class="b_foot">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="region_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="region_name" value="<%=retListString1[i][1]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][3]%>';
		<%}%>
	
	function doClose()
	{
		
		window.close();
	}
</script>