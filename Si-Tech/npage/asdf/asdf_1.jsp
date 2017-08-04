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

    String opCode="g088";
	String opName="集团交费通知短信配置";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
 
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
	
  String[] inParas2 = new String[1];
 
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
	<div id="title_zi">集团交费通知短信配置</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" colspan=2 >
				集团编码：<input type="text" name="unitid" value="" >
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
		/*var unitid = document.all.unitid.value;
		var myPacket = new AJAXPacket("getUnifInfo.jsp?unitid="+unitid,"正在查询，请稍候......");
		core.ajax.sendPacket(myPacket);
		myPacket = null;*/
		var unitid = document.frm.unitid.value;
		var actions = "asdf_2.jsp?unitid="+unitid;
			//alert("actions is "+actions);
		document.all.frm.action=actions;
		document.all.frm.submit();
	}
	function doProcess(packet)
	{
		var flag = packet.data.findValueByName("flag");
		var unitName = packet.data.findValueByName("unitName");
		document.getElementById("kfname").value=unitName;
		//alert("flag is "+flag);
	}

</script>
 
 