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
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "i092";
		String opName = "强制预拆";
 
	 
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

 function doclear() {
 		frm.reset();
 }

   function docheck3()
   {
	   //var s_paytype =  document.all.rpt_type[document.all.rpt_type.selectedIndex].value;
	   var s_phone = document.all.phone_no.value;
	   if(s_phone=="")
	   {
		   rdShowMessageDialog("请输入手机号码");
		   return false;
	   }
	   else
	   {
		   document.frm.action = "i092_1_qry.jsp?s_phone="+s_phone;
		   document.frm.submit();	
	   }	
	   
	   
   }
 
    
   function sel1()
   {
			window.location.href='i092_1.jsp';
   }
   function sel2()
   {
		   window.location.href='i092_2.jsp';
   }
   function sel3()
   {
		   window.location.href='i092_3.jsp';
   }
   function sel4()
   {
		   window.location.href='i092_4.jsp';
   }
  
-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
	<table cellspacing="0">
      <tbody> 
      <tr> 
        <td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
          <input name="busyType4" type="radio" onClick="sel1()" value="1" checked>按手机号码查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel2()" value="2">按地市查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel3()" value="3">文件导入
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <input name="busyType4" type="radio" onClick="sel4()" value="4">文件处理结果查询
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  
		</td>
     </tr>
    </tbody>
  </table>
	
	<div class="title">
			<div id="title_zi">请输入查询条件</div>
		</div>
	<table cellspacing="0">
    

	<tr>
		<td class="blue" align="right">
			请输入手机号码
		</td>
		<td colspan="3">
			<input type="text" name="phone_no" maxlength="11" onKeyPress="return isKeyNumberdot(0)">
		</td>
	</tr>
	 


  </table> 


  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <input type="button" name="query" class="b_foot" value="查询" onclick="docheck3()" >
       
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %> 
</form>
 </BODY>
</HTML>