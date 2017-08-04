<%
/********************
 version v2.0
开发商: si-tech
baixf 20080309 061@2008 需求：完善经分系统营销管理平台目标客户群提取及互动接口功能的需求
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
 <%
 	String opCode = "1302";
	String opName="账号缴费";
    String i_count = WtcUtil.repNull(request.getParameter("i_count"));//开具过专票的只能打收据不能开发票
	System.out.println("ffffffffffffffffffffffffff i_count is "+i_count);
	String regionCode= (String)session.getAttribute("regCode");
	regionCode="11";
%>
 
 
<HEAD>
<HTML><HEAD><TITLE>帐号查询</TITLE>
<script LANGUAGE="JavaScript">
	//window.returnValue="";
	function selAccount()
	{	
		  //alert("1???");
		  window.returnValue="1";
		  document.getElementById("type_id").value="1";
		  document.frm.busyType2.checked=false;
		  document.frm.busyType3.checked=false;
		  document.getElementById("cfm_id").focus();
		  document.frm.busyType1.checked=true;
		  //window.close();	
	}
	function selAccount2()
	{	
          //alert("2???");
		  window.returnValue="2";
		  document.getElementById("type_id").value="2";
		  document.frm.busyType1.checked=false;
		  document.frm.busyType3.checked=false;
		  document.getElementById("cfm_id").focus();
		  document.frm.busyType2.checked=true;
		  //window.close();
	}
	function selAccount3()
	{	
		  if("<%=regionCode%>"=="11"||"<%=regionCode%>"=="08")
		  {
			  window.returnValue="3";
			  document.getElementById("type_id").value="3";
			  document.frm.busyType1.checked=false;
			  document.frm.busyType2.checked=false;
			  document.getElementById("cfm_id").focus();
		  }
		  else
		  {
			  rdShowMessageDialog("不在首批试点地市中，暂时不允许打印电子发票功能!");
			  //只让打印发票
			 // alert("3???");
			  selAccount();
		  }	
		  
		  //window.close();
	}
	function getAccount()
	{
		window.returnValue=document.getElementById("type_id").value;
		//alert("window.returnValue is "+window.returnValue);
		window.close();
	}
	function inits(i)
	{
		//alert("init i is "+i);
		if(i>0)
		{
			document.getElementById("type_id").value="2";
		}
		else
		{
			document.getElementById("type_id").value="1";
		}
	}
	function doback(i)
	{
		if(i>0)
		{
			window.returnValue="2";
			window.close();
		}	
		else
		{
			window.returnValue="";
			window.close();
		}
	}
</script>
<TITLE>营销信息查询</TITLE>
</head>

<BODY onload="inits('<%=i_count%>')">
<form  name="frm" method="post" action="">      
  <%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">打印操作选择</div>
			</div>
      <TABLE cellSpacing="0">
        <TBODY>
         <%
			if(Integer.parseInt(i_count)>0)
			{
				%>
				<tr align="center">
				  <td><input name="busyType1" type="radio" value="1" onClick="selAccount()"  onKeyDown="if(event.keyCode==13) selAccount();" disabled>打印发票</td>	
				  <td><input name="busyType2" type="radio" value="2" checked onClick="selAccount2()"  onKeyDown="if(event.keyCode==13) selAccount2();">打印收据</td>
				  <td><input name="busyType3" type="radio" value="3"   onClick="selAccount3()"  onKeyDown="if(event.keyCode==13) selAccount3();">打印电子发票1</td>
			    </tr>	
				<%
			}
			else
			{
				%>
				<tr align="center">
				  <td><input name="busyType1" type="radio" value="1" onClick="selAccount()"  onKeyDown="if(event.keyCode==13) selAccount();" checked>打印发票</td>
				  <td><input name="busyType2" type="radio" value="2" onClick="selAccount2()"  onKeyDown="if(event.keyCode==13) selAccount2();">打印收据</td>
				  <td><input name="busyType3" type="radio" value="3"   onClick="selAccount3()"  onKeyDown="if(event.keyCode==13) selAccount3();">打印电子发票</td>
			  </tr>	
				<%
			}
		 %>
		  
         </TBODY>
	    </TABLE>
 
   <table cellspacing="0">
   <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" id="cfm_id" name="Button" value="确定" onKeyDown="if(event.keyCode==13) getAccount();"  onClick="getAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="doback('<%=i_count%>')">
      </td>
    </tr>
   <input type="hidden" id="type_id">
 	</table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>