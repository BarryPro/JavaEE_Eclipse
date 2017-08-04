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
 	String opCode = "1310";
	String opName="账号缴费冲正";
    String s_old_status = WtcUtil.repNull(request.getParameter("s_old_status"));
	//原发票状态 0-未开具 1-纸质 2-自助终端 6-预占 e-电子发票 r-收据 z-专票
	String regionCode= (String)session.getAttribute("regCode");
	//regionCode="11";
%>
 
 
<HEAD>
<HTML><HEAD><TITLE>帐号查询</TITLE>
<script LANGUAGE="JavaScript">
	window.returnValue="";
	function selAccount()//打印发票的 如果原开具的是电子的 只能是电子的 不允许做纸质的
	{	
		  if("<%=s_old_status%>"=="e")
		  {
			  rdShowMessageDialog("原开具发票为电子发票,冲正时只能开具红字电子发票!");
			  document.frm.busyType1.checked=false;
			  selAccount3();
		  }
		  else
		  {
			  window.returnValue="1";
			  document.getElementById("type_id").value="1";
		//	  document.frm.busyType2.checked=false;
			  document.frm.busyType3.checked=false;
			  document.getElementById("cfm_id").focus();
			  //window.close();
		  }	
		  
	}
	
	function selAccount3()//打印电子的 如果原是纸质的 只能做纸质的 不能开电子的
	{	
		  //地市校验
		  if("<%=regionCode%>"=="11"||"<%=regionCode%>"=="08")
		  {
			 
			  if("<%=s_old_status%>"!="e")
			  {
				  rdShowMessageDialog("原开具发票非电子发票,冲正时也不允许开具红字电子发票!");
				  document.frm.busyType3.checked=false;
				  selAccount();
			  }
			  else
			  {
				  window.returnValue="3";
				  document.getElementById("type_id").value="3";
				  document.frm.busyType1.checked=false;
	 
				  document.getElementById("cfm_id").focus();
			 
			  }	
			  /*
			  window.returnValue="3";
			  document.getElementById("type_id").value="3";
			  document.frm.busyType1.checked=false;
			  document.getElementById("cfm_id").focus();
			  */
		  }
		  else
		  {
			  rdShowMessageDialog("不在首批试点地市中，暂时不允许打印电子发票功能!");
			  //只让打印收据
			  //selAccount();
			  document.frm.busyType3.checked=false;
			  return false;
		  }	
		  
		  
	}
	function getAccount()
	{
		window.returnValue=document.getElementById("type_id").value;
		window.close();
	}
	function doback()
	{
		window.returnValue="";
		window.close();
	}
	function init()
	{
		//alert("test is "+"<%=s_old_status%>");
		if("<%=s_old_status%>"=="e")
		{
			document.frm.busyType3.checked=true;
			selAccount3();
		}
		else
		{
			document.frm.busyType1.checked=true;
			selAccount();
		}
	}
</script>
<TITLE>营销信息查询</TITLE>
</head>

<BODY onload="init()">
<form  name="frm" method="post" action="">      
  <%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">打印操作选择</div>
			</div>
      <TABLE cellSpacing="0">
        <TBODY>
         
		  <tr align="center">
	          <td><input name="busyType1" type="radio" value="1" onClick="selAccount()"  onKeyDown="if(event.keyCode==13) selAccount();">打印发票</td>
           
			  <td><input name="busyType3" type="radio" value="3" onClick="selAccount3()"  onKeyDown="if(event.keyCode==13) selAccount3();">打印电子发票</td>
          </tr>	
         </TBODY>
	    </TABLE>
 
   <table cellspacing="0">
   <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" id="cfm_id" name="Button" value="确定" onKeyDown="if(event.keyCode==13) getAccount();"  onClick="getAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="doback()">
      </td>
    </tr>
   <input type="hidden" id="type_id" value="1">
 	</table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>