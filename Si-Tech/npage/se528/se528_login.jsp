<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 自备机合约计划
   * 版本: 1.0
   * 日期: 2012/1/4
   * 作者: liujian
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
  String workNo=(String)session.getAttribute("workNo");
  String regionCode=(String)session.getAttribute("regCode");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	<script language="javascript">
			/*************************初始化*****************************/
			$(function() {
				$('#opCode').val('<%=opCode%>');
				$('#opName').val('<%=opName%>');
				var opCode = '<%=opCode%>';
				// 设置选中的业务
				if(opCode == 'e528') {
					$('input[name="opFlag"][value="two"]').attr("checked","checked");
					$('#backaccept_id').css('display','block');
			  	  	   $('#opCode').val('e529');
			  	  	   $('#opName').val('自备机合约计划冲正');
				}else if(opCode == 'e529') {
					$('input[name="opFlag"][value="two"]').attr("checked","checked");
					$('#backaccept_id').css('display','block');
			  	  	   $('#opCode').val('e529');
			  	  	   $('#opName').val('自备机合约计划冲正');
				}
				
				//注册单选的事件
			    $('input[name="opFlag"]').click(function() {
			  		var value = $(this).val();
			  	    if(value != "one") {
			  	  	   $('#backaccept_id').css('display','block');
			  	  	   $('#opCode').val('e529');
			  	  	   $('#opName').val('自备机合约计划冲正');
			  	    }else {
			  	  	   $('#backaccept_id').css('display','none');
			  	  	   $('#opCode').val('e528');
			  	  	   $('#opName').val('自备机合约计划');
			  	    }
			    });
			    
				/*************************提交按钮注册事件*****************************/
				$('#submit_btn').click(function() {
						submit_click();
				})
				/*************************清除按钮注册事件*****************************/
				$('#reset_btn').click(function() {
						$('#backaccept').val('');
				})
			})
			
			/*************************提交按钮事件执行体*****************************/
			function submit_click() {
					var value = $('input[name="opFlag"][checked]').val();
					// 不同的值会调用不同的服务
					if( value == 'one' ) {
						//申请
						frm.action="se528.jsp";
					}else if( value == 'two' ) {
						//冲正
						frm.action="se529.jsp";
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
			
			<input type="radio" name="opFlag" value="two" >冲正
		</td>
	</tr>    
	<tr> 
		<td class="blue">手机号码 </td>
		<td> 
			<input type="text" size="12" name="activePhone" id="activePhone" value="<%=activePhone%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
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
