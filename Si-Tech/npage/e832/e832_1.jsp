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

    String opCode="e832";
	String opName="集团产品转账";	
	String phoneNo = (String)request.getParameter("activePhone");
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
<body>
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "e832" >
	<input type="hidden" name="opname" value = "集团产品转账" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">集团产品转账</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >
				证件号码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="zjhm" value="" >
			</td>
			<td class="blue" >
				集团编号 <input type="text" name="jtbh" value=""  >
			</td>
		</tr>
		<tr >
			 
			<td class="blue" >
				智能网编号&nbsp;&nbsp;<input type="text" name="znwbh" value="" >
			</td>
			<td class="blue" >
				客户ID&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="khid" value=""  >
			</td>
		</tr>
		 
		 
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="查询" id="cz" onclick="docfm()" >
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
		/*var beginYm = document.all.beginYm.value;
		var objSel = document.getElementById("selOp");
		var tjtj1= objSel.options(objSel.selectedIndex).text;
		var endYm = document.all.endYm.value;
		if(beginYm=="")
		{
			rdShowMessageDialog("请输入统计查询开始时间!");
			return false;
		}
		else if(document.all.endYm.value=="")
		{
			rdShowMessageDialog("请输入统计查询结束时间!");
			return false;
		}	
		else
		{
			var actions = "d123_2.jsp?tjtj1="+tjtj1;
			document.all.frm.action=actions;
			document.all.frm.submit();
			
		}*/
		var zjhm=document.all.zjhm.value;
		var jtbh=document.all.jtbh.value;
		var znwbh=document.all.znwbh.value;
		var khid=document.all.khid.value;
		if(zjhm=="" &&jtbh=="" &&znwbh=="" &&khid=="")
		{
			rdShowMessageDialog("请输入查询条件!");
			return false;
		}
		else
		{
			var actions = "e832_2.jsp?zjhm="+zjhm+"&jtbh="+jtbh+"&znwbh="+znwbh+"&khid="+khid;
			document.all.frm.action=actions;
			document.all.frm.submit();
		}
		
		
	}

 

</script>
 
 