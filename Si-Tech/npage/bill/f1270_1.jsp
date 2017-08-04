<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19,因为是二级tab,而且不需要在这里验证密码,所以精简代码
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1270";
	String opName = "主资费变更";
%>
<html>
<head>
<title>主资费变更</title>
<script language="javascript">
	<!--
	function pageSubmit(p){
		document.all.pw_favor.value=1 ; //对密码优惠赋值
		form1.action="f1270_2.jsp";
		form1.submit();
	}
	-->
</script>
</head>

<body>
	<form action="" method=post name="form1">
     <%@ include file="/npage/include/header.jsp" %>
       <TABLE>
		 <TR>
			  <TD class="blue">服务号码</TD>
			  <TD>
			  	<input readonly class="InputGrey" name="i1"  v_type="mobphone" value="<%=activePhone%>">
			  </TD>
		 </TR>
			 
		<TR>
			 <TD id="footer" colspan=3>
				  <input class="b_foot" name=sure  type=button value=确认 onclick="if(check(form1))  pageSubmit('1');" >
				  <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=关闭>
			 </TD>
		</TR>
        <%@ include file="/npage/include/footer_simple.jsp" %> 	 
	 </TABLE>	
		<input type="hidden" name="pw_favor" value="1">
		<input type="hidden" name="iOpCode" value="1270">
		<input type="hidden" name="iAddStr" value="">
		<input type="hidden" name="activePhone" value="<%=activePhone%>">
 	</form>
</body>
</html>

