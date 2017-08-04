<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%	 
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	  	String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	  	String[][] resultlist = new String[][]{};
		System.out.println("phoneNo= " + phoneNo);
		String sqlStr= "select a.login_accept,b.offer_id,b.offer_name "+
		               "from product_offer_instance a, product_offer b,dcustmsg c "+
		               "where a.eff_date>sysdate "+
		               "and a.offer_id = b.offer_id  "+
		               "and a.serv_id = c.id_no "+
		               "and a.offer_id in(select substr(paravalue,0,length(paravalue)-1) from SORDERSERVERCFG where paraname = '可选套餐的代码串') "+
		               "and c.phone_no = '"+phoneNo+"' ";  
	    System.out.println("sqlStr====="+sqlStr);     
	        	
		try {
		%>
		
            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
				<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" /> 
		<%
      		System.out.println("retCode======"+retCode);
      		System.out.println("retMsg======"+retMsg);
      		if("000000".equals(retCode) && result.length>0){
        	    resultlist   = result;   
        	}

		}
		catch(Exception e)
		{
	    	System.out.println("# return from f9998info.jsp -> Call Service sPubSelect Failed !");
            e.printStackTrace();	
		}
	%>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script type=text/javascript>
	function resend()
	{
		var phoneno = <%=phoneNo%>;
		var check = document.getElementsByName("check");
		var table = document.getElementById("tabList");
		var seq_list = '';
		var offerid_list = '';
		var flag = false;
		for (var i=0; i<check.length; i++)
		{
		  	if(check[i].checked = true)
		  	{
		  		flag = true;
		  		seq_list = seq_list+table.rows [i+1].cells[0].innerText+'|';
		  		offerid_list = offerid_list+table.rows [i+1].cells[1].innerText+'|';
		  	}
		}	
		
		if(!flag)
		{
			rdShowMessageDialog("请选择冲正资费！");
			return false;
		}
		
 		var packet1 = new AJAXPacket("fd194Cfm.jsp","请稍后...");
 		packet1.data.add("seq",seq_list);
 		packet1.data.add("phoneNo",phoneno);
 		packet1.data.add("offerId",offerid_list);
		core.ajax.sendPacket(packet1,doresend,true);
		packet1 =null;
	}
	
	function doresend(packet)
	{
		var retCode = packet.data.findValueByName("retCode"); 
    	var retMessage = packet.data.findValueByName("retMsg");	
		if(retCode=="000000")
		{  
			rdShowMessageDialog("冲正成功",2);
		}
		else
		{
			retMessage = retCode + ":" + retMessage ;
			rdShowMessageDialog(retMessage,0);
			return false;
    	}
		location = location;
 	}
 	
 	function checkAll()
	{
	  var e = document.getElementsByName("checkall");
	  var aa = document.getElementsByName("check");
	  for (var i=0; i<aa.length; i++)
	  {
	  	aa[i].checked = e[0].checked;
	  }
	   
	}

</script>
</head>
<body >
<form name="form1" method="post" action="">	
	<div id="Operation_Table">	
		<table id="tabList" cellspacing=0 >		
			<tr align="center">	
				<th>流水</th>	
				<th>资费代码</th>			
				<th>礼品名称</th>
				<th>全选&nbsp;<input type=checkbox name="checkall" onclick="checkAll()"></th>
			</tr>
			<%	
			for(int i = 0; i < resultlist.length; i++)
			{
			%>			
			<tr align="center">			
				<td width="30%" nowrap><%=resultlist[i][0].trim()%>&nbsp;</td>	
				<td width="30%" nowrap><%=resultlist[i][1].trim()%>&nbsp;</td>
				<td width="30%" nowrap><%=resultlist[i][2].trim()%>&nbsp;</td>
				<td width="10%" nowrap>
					<input type=checkbox name="check">
				</td>
			</tr>
			<%
			}
			%>	
			<tr>
				<td colspan="4" align="center" id="foot">
					&nbsp;
					<input name="commit" id="commit" type="button" class="b_foot"   value="确认" onClick="resend()">
					&nbsp;
					<input name="reset" type="reset" class="b_foot" value="清除" >
					&nbsp;
					<input class="b_foot" name=back onClick="parent.removeCurrentTab()" type=button value="关闭">
					&nbsp;
				</td>
			</tr>	
		</table>		
	</div>   
<script language="javascript" type="text/javascript">
jQuery(
	function (){
	window.parent.UnLoad();
});
</script>	
</form>
</body>
</html>