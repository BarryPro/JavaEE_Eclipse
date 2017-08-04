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
<title>集团信用等级调整</title>
<%
  //String opCode="8379";
 //String opName="赠送预存款";

    String opCode="g090";
	String opName="集团信用等级调整";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
 
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
	
  String[] inParas2 = new String[1];
  inParas2[0]="select region_code,region_name from sregioncode ";
%>
<!--    routerKey="region" routerValue="<%=regionCode%>" -->
 
	<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=inParas2[0]%>"/>
	</wtc:service>
	<wtc:array id="SpecResult" scope="end" /> 
 
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
	<div id="title_zi">集团信用等级调整</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		 
		<tr >
			<td class="blue" colspan=2>
				集团编码<input type="text" name="unit_id" value="" maxlength=11 onKeyPress="return isKeyNumberdot(0)"> 
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
		 
	  var unit_id = document.all.unit_id.value;
		if(unit_id=="")
		{
			rdShowMessageDialog("请输入集团编码");
			return false;
		}	
		var actions = "g090_2.jsp?unit_id="+unit_id;
		document.all.frm.action=actions;
		document.all.frm.submit();
			
		 
		
		
	}

 

</script>
 
 