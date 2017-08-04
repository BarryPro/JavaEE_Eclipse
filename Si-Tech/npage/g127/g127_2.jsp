<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode =""; //"d223";
	String opName = "";//"退费统计";
 	String[][] result = new String[][]{}; 
 
	 
	String tfhm = request.getParameter("tfhm");
 
	 
	String inParas[] = new String[2];
//  String phoneNo = request.getParameter("phoneNo");
    
	inParas[0] ="select to_char(b.account_id), b.user_name,to_char(a.owe_fee) from dconmsg a,dgrpusermsg b  where a.contract_no=b.account_id  and b.cust_id in ( select cust_id from dgrpcustmsg where unit_id=:unit_id)";
	inParas[1] ="unit_id="+tfhm ;
	 
%> 
<wtc:service name="TlsPubSelBoss" retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="3">
    <wtc:param value="<%=inParas[0]%>"/> 
    <wtc:param value="<%=inParas[1]%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQ test inParas[0] is "+inParas[0]+" and inParas[1] is "+inParas[1]);
if(ret_val==null||ret_val.length==0)
{
%> 
<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">集团客户欠费情况查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
		<td>查询无结果</td>
	</tr>
	<tr>
<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g127_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
		</table>
	<% 
}
else
{
	%><HEAD><TITLE>集团客户欠费情况查询</TITLE>
	<style> 
  .black_overlay{  display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.8;  opacity:.80;  filter: alpha(opacity=80);  }  .white_content {  display: none;  position: absolute;  top: 25%;  left: 25%;  width: 50%;  height: 50%;  padding: 16px;  border: 16px solid transparent;  background-color: transparent;  z-index:1002;  overflow: auto;  }  
</style>
</HEAD>

<body>
<!--
<DIV><img class='hideEl' src='jia.gif'   style='cursor:hand' width='15' height='15' onclick="show()">&nbsp;&nbsp;<img class='hideEl' src='jian.gif'   style='cursor:hand' width='15' height='15' onclick="hide()"></DIV>
-->
<FORM method=post name="frm1507_2">
	<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">集团客户欠费情况查询</div>
	</div>
	<table cellspacing="0" id="tabList">
	<tr>
	    <th nowrap>产品帐号</th>
		<th nowrap>产品名称</th>
		<th nowrap>欠费</th>
		<th nowrap>操作</th>
	 
	<tr>
	<%
		  for(int y=0;y<ret_val.length;y++)
		  { 
	%>
			<tr>
	<%    	    for(int j=0;j<ret_val[0].length;j++)
				{
	%>
				  <td height="25" nowrap>&nbsp;<%= ret_val[y][j]%>&nbsp;
				  </td>
				  
	<%	        }
	%>		<td><input class="b_foot" type="button" value="缴费" onclick="addTab('<%=ret_val[y][0]%>')"></td>	 
			</tr>
	<%	   }
	%>
		<td align="center" id="footer" colspan="8">
			 
		&nbsp; <input class="b_foot" name=back onClick="window.location='g127_1.jsp'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
<div id="light" class="white_content"> 
 
	<input class="b_foot" type="button" value="缴费成功" onclick="confirm()">
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input class="b_foot" type="button" value="关闭" onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
  
</div> 
<div id="fade" class="black_overlay">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html><%
}
		 
%>	 
 
<script language="javascript">
	function addTab(uid){
		//var i= Integer.parseInt(session.getAttribute("table_state"));
		//alert(1);
		//var win=parent.addTab(true,'d340','集团缴费','../s1300/s1300_group.jsp);
		//parent.removeTab("d340");
		/*var   win=   window.open( " ",   "d340");   
		alert(win);
		if(win != null && !win.closed) 
		{
			alert("1");
			parent.removeTab("d340");
		}*/
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';


		win=parent.addTab(true,'d340','集团缴费','../s1300/s1300_group.jsp?account_id=');
		parent.removeTab("d340");
		win=parent.addTab(true,'d340','集团缴费','../s1300/s1300_group.jsp?account_id='+uid);
		win.reload();
		
	}
	function confirm()
	{
		//var myPacket = new AJAXPacket("g127_do.jsp?contract_no="+"<%=tfhm%>","正在查询客户，请稍候......");
		//core.ajax.sendPacket(myPacket);
		//myPacket=null;
		window.location.reload();

	}
	function doProcess(packet)
	{
		//var num = packet.data.findValueByName("num");
	}
</script> 	
 

