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
   
%>
 
 
<HEAD>
<HTML><HEAD><TITLE>帐号查询</TITLE>
<script LANGUAGE="JavaScript">
	window.returnValue="";
	function selAccount()
	{	
		  window.returnValue="1";
		  document.getElementById("type_id").value="1";
		  document.frm.busyType2.checked=false;
		  document.getElementById("cfm_id").focus();
		  //window.close();
	}
	function selAccount2()
	{	
		  window.returnValue="2";
		  document.getElementById("type_id").value="2";
		  document.frm.busyType1.checked=false;
		  document.getElementById("cfm_id").focus();
		  //window.close();
	}
	function getAccount()
	{
		window.returnValue=document.getElementById("type_id").value;
		window.close();
	}
</script>
<TITLE>营销信息查询</TITLE>
</head>

<BODY>
<form  name="frm" method="post" action="">      
  <%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">打印操作选择</div>
			</div>
      <TABLE cellSpacing="0">
        <TBODY>
         
		  <tr align="center">
	          <td><input name="busyType1" type="radio" value="1" onClick="selAccount()"  onKeyDown="if(event.keyCode==13) selAccount();" checked>打印发票</td>
              <td><input name="busyType2" type="radio" value="2" onClick="selAccount2()"  onKeyDown="if(event.keyCode==13) selAccount2();">打印收据</td>
          </tr>	
         </TBODY>
	    </TABLE>
 
   <table cellspacing="0">
   <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" id="cfm_id" name="Button" value="确定" onKeyDown="if(event.keyCode==13) getAccount();"  onClick="getAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
      </td>
    </tr>
   <input type="hidden" id="type_id">
 	</table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>