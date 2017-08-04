<%
/*
 * 功能: 购机入网-让利计划
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN"
	"http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");	
String workNo=(String)session.getAttribute("workNo");
String regCode=(String)session.getAttribute("regCode");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	<script language="javascript">
		/*************************初始化*****************************/
		$(function() 
		{
			$('#opCode').val('<%=opCode%>');
			$('#opName').val('<%=opName%>');
			var opCode = '<%=opCode%>';
			
			// 设置选中的业务
			if(opCode == 'e720') 
			{
				$('input[name="opFlag"][value="two"]').attr("checked","checked");
				$('#backaccept_id').css('display','block');
			}
			else if(opCode == 'e721') 
			{
				$('input[name="opFlag"][value="two"]').attr("checked","checked");
				$('#backaccept_id').css('display','block');
			}
			
			//注册单选的事件
		    $('input[name="opFlag"]').click(function() 
		    {
				var value = $(this).val();
					$('#backaccept_id').css('display','block');
					$('#opCode').val('e721');
					$('#opName').val('购机入网-让利计划冲正');
				
		    });
		    
			/*************************提交按钮注册事件*****************************/
			$('#submit_btn').click(function() 
			{
					submit_click();
			});
			/*************************清除按钮注册事件*****************************/
			$('#reset_btn').click(function() 
			{
					$('#backaccept').val('');
			});
		});
		
		/*************************提交按钮事件执行体*****************************/
		function submit_click() 
		{
			var value = $('input[name="opFlag"][checked]').val();
			 if( value == 'two' ) 
			{
				document.getElementById("backaccept").value
					=document.getElementById("backaccept").value.trim();
				frm.action="fE721Main.jsp";
			}
			frm.submit();	
			return true;
		}
	</script>
</head>
<body>
<form name="frm" method="POST">
 	<input type="hidden" name="opCode" id="opCode" >
	<input type="hidden" name="opName" id="opName" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			
			<input type="radio" name="opFlag" value="two" checked>冲正
		</td>
	</tr>    
	<tr> 
		<td class="blue">手机号码 </td>
		<td> 
			<input type="text" size="12" name="activePhone" id="activePhone" 
				class="InputGrey" value="<%=activePhone%>" readonly >
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:block" id="backaccept_id"> 
		<td class="blue">业务流水</td>
		<td colspan="3">
			<input class="button" type="text" name="backaccept" id="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>    
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" id="submit_btn" value="确认" index="2">    
			<input class="b_foot" type=button name=back id="reset_btn" value="清除">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
