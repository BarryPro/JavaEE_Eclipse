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
<title>投诉退费统计查询</title>
<%
  //String opCode="8379";
 //String opName="赠送预存款";

    String opCode="zg88";
	String opName="积分计算规则管理";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
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
<body>
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "zg88" >
	<input type="hidden" name="opname" value = "积分计算规则管理" >
	<%@ include file="/npage/include/header.jsp" %>
  
<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">积分计算规则管理</div>
</div>	 
	
	<table cellspacing="0" id="tabList">
			<tr> 
			  <td class="blue">手机号码</td>
				<td class="blue">	
					<input type="text" name="phone_no" maxlength="14">
				</td>            
			</tr> 
			  
		<tr >
			<td align=center colspan=4><input type=button class="b_foot" name="check2" value="查询" id="cz" onclick="docfm()" >
			<!--
			<input type=button class="b_foot" value="生成报表" onclick="printTable(tabList)" >
			-->
			
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
		//var ThirdClass_new = 
		var phone_no = document.all.phone_no.value;
		//var beizhu = document.all.beizhu.value;
		if(phone_no=="")
		{
			rdShowMessageDialog("请输入手机号码!");
			return false;
		}	
		/*
		else if(beizhu=="")
		{
			rdShowMessageDialog("请输入备注信息");
			return false;
		}*/
		else
		{
			var actions = "zg88_qry.jsp";
			document.all.frm.action=actions;
			document.all.frm.submit();
		}
	}
          
 

</script>
 
 