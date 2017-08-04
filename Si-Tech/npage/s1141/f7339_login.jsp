<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-23 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>手机证券类业务营销</title>
<%
   String opCode = (String)request.getParameter("opCode");
   String opName = (String)request.getParameter("opName");
%>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
onload=function()
{
	document.all.srv_no.focus();
}

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	  controlButt(subButton);//延时控制按钮的可用性
	  if(!check(frm)) return false; 
	  frm.action="f7339_1.jsp";	
	  if(document.all.saleType.value==""){
	  	rdShowMessageDialog("请选择业务种类！");
	  	return false;
	  }
	  document.all.opcode.value=document.all.saleType.value.substring(0,4);
	  frm.submit();	
	  return true;
}
</script>
</head>
<body>	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<div class="title">
			<div id="title_zi"><%=opName%></div>
	</div>   	
 	<input type="hidden" name="opcode" >
 	<table cellspacing="0">       
		<tr> 
			<td width="16%"  nowrap class="blue">手机号码 </td>           
			<td nowrap  >              
				<input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey">
				<font class="orange">*</font>
			</td>           
		</tr>
		<tr> 
			<td width="16%"  nowrap class="blue">业务种类 </td>		
			<td colspan="3">
				<select name="saleType" >
					<option value=""> ---请选择--- </option>
					<option value="7339->手机证券">手机证券</option>
					<option value="7361->投资通">投资通</option>
					<option value="7362->同花顺">同花顺</option>		
				</select>
			</td>
		</tr>	  
   	</table>
	<table cellspacing="0">  
		<tr> 
		<td id="footer"> 		
			<input  class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input  class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input  class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">		
		</td>
	</tr>
	</table>
	 <%@ include file="/npage/include/footer.jsp" %>      
   </form>
</body>
</html>