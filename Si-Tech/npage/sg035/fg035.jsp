<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
version v1.0
开发商: si-tech
ningtn 2012-8-21 18:42:36
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String workNo = (String)session.getAttribute("workNo");
  	String password = (String)session.getAttribute("password");
 		String regionCode= (String)session.getAttribute("regCode");
 		
%>

<html>
<head>
	<title>银行信用卡分期付款配置</title>
	<script language="javascript">
		function nextStep(){
			var checkVal = $("input[@name='opFlag'][@checked]").val();
			if(checkVal == "1"){
				form1.action = "fg035_add.jsp";
				form1.submit();
			}else if(checkVal == "2"){
				form1.action = "fg035_del.jsp";
				form1.submit();
			}
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">银行信用卡分期付款配置</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="15%">操作类型</td>
			<td>
				<input type="radio" value="1" name="opFlag" checked="checked"/>
				增加
				<input type="radio" value="2" name="opFlag" />
				删除
			</td>
			</td>
		</tr>
	</table>

	<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" type="button" class="b_foot" index="2" 
			 onClick="nextStep(this)" value="下一步"/>
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<!-- 隐藏表单部分，为下一页面传参用 -->
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
	<input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
	
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

