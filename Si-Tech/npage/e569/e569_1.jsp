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

    String opCode="e569";
	String opName="投诉退费统计查询";	
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
 	<input type="hidden" name="opcode" value = "e569" >
	<input type="hidden" name="opname" value = "投诉退费统计查询" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">投诉退费统计查询</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >
				统计开始时间：<input type="text" name="beginYm" value="" maxlength=8>(YYYYMMDD)
			</td>
			<td class="blue" >
				统计结束时间：<input type="text" name="endYm" value="" maxlength=8>(YYYYMMDD)
			</td>
		</tr>
		<tr >
			<td class="blue" colspan=2>
				统&nbsp;计&nbsp;条&nbsp;件:&nbsp;&nbsp;&nbsp;<select id="selOp" name="tjtj">
					<option value="1">手机视频（流媒体）</option>
					<option value="2">MDO</option>
					<option value="3">手机导航网络版</option>
					<option value="4">手机游戏</option>
				</select>
			</td>
			 
		</tr> 
		 
		<tr >
			<td align=center colspan=2><input type=button class="b_foot" name="check2" value="统计" id="cz" onclick="docfm()" >
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
		var beginYm = document.all.beginYm.value;
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
			var actions = "e569_2.jsp?tjtj1="+tjtj1;
			document.all.frm.action=actions;
			document.all.frm.submit();
			
		}
		
		
	}

 

</script>
 
 