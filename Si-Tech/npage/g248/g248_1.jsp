<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>手工充值卡充值</title>
<%
    //String opCode="8379";
	//String opName="赠送预存款";

    String opCode="g248";
	String opName="手工充值卡充值";	
	String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
 
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();

 
%>
 		
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body  >
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "g248" >
	<input type="hidden" name="opname" value = "手工充值卡充值" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">手工充值卡充值</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >卡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号 <input type="text" name="kahao"> 
	 &nbsp;&nbsp;&nbsp;
			 密&nbsp;&nbsp;&nbsp;&nbsp;码 <input type="password" name="kamima"    maxlength="18">
			 &nbsp;&nbsp;&nbsp;
			 面&nbsp;&nbsp;&nbsp;&nbsp;值 <input type="text" name="kamianzhi">
			 &nbsp;&nbsp;&nbsp;
			 手机号码 <input type="text" name="phoneNo" maxlength="11">
			 </td>
		</tr>
		 
		 
		<tr>
			<td align=center><input type=button class="b_foot" name="check2" value="充值" id="cz" onclick="docfm()" >
			 
			
			<input type=reset class="b_foot" value="重置" >
			</td>
		<tr>
		</tr>
		
	</table>
</div>
 
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
	function docfm()
	{
		if(document.all.kamima.value=="" ||document.all.kahao.value==""||document.all.kamianzhi.value=="")
		{
			rdShowMessageDialog("请输入充值卡号、卡面值和充值卡密码!");
			return false;
		}
		else if(document.all.phoneNo.value=="")
		{
			rdShowMessageDialog("请输入充值的手机号码!");
			return false;
		}
		else
		{
			var	prtFlag = rdShowConfirmDialog("是否确定充值？");
			if (prtFlag==1)
			{
				var actions = "g248_2.jsp?phoneNo="+document.all.phoneNo.value+"&cardNo="+document.all.kahao.value+"&kmm="+document.all.kamima.value+"&kmz="+document.all.kamianzhi.value;
				document.all.frm.action=actions;
				document.all.frm.submit();
			}
			
		}
		
	}
 
</script>
 
 