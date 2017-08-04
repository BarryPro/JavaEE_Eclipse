<%
/*
 * 功能: TD固话自备机TAC校验
 * 版本: 1.0
 * 日期: 2012/9/3 11:05:33
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body >
		<form  name="frm" action="" method="POST" >
			<input type="hidden" id="hdOpCode" name	="hdOpCode"	value= "<%=opCode%>">
			<input type="hidden" id="hdOpName" name	="hdOpName"	value= "<%=opName%>">
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">

				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				<table>
					<tr>
						<th align="center">IMEI码:</th>
						<td colspan='3'>
							<input type="text" id="txtIno" name="txtIno" 
								v_must="1"  v_type="int" />	
							<font color="red">*</font>
						</td>			
					</tr>			
				</table>

				<table>
					<tr> 
						<td  id="footer">
							<input class="b_foot" type="button" name=btnCfm value="确认"
								onClick="doCfm();">
							<input class="b_foot" type="button" name=btnClr value="清除"
								onClick="clrFrm();">
							<input class="b_foot" type="button" name=btnCls value="关闭"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>	
			</div>
		</form>
	</body>
	<script type="text/javascript">		
		function clrFrm()
		{
			document.all.txtIno.value="";	
		}
		
		function doCfm()
		{
				//document.all.txtIno.disabled=true;
				document.all.btnCfm.disabled=true;
				
				/*界面跳转*/
				document.frm.action="fG067Cfm.jsp";
				document.frm.submit();
		}
	</script>
</html>
