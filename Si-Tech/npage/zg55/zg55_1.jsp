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
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zg55";
		String opName = "老版集团发票打印";
 	
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	








function check_HidPwd()
{
  if(document.frm.phoneno.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneno.focus();
     return false;
  }
  

  if( document.frm.phoneno.value!="" && document.frm.phoneno.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneno.value = "";
     document.frm.phoneno.focus();
     return false;
  }
	            
	
}

 function docheck()
 {
	 if (document.mainForm.tem1.value.length == 0) {
      rdShowMessageDialog("集团名称不能为空，请重新输入 !!")
      document.mainForm.tem1.focus();
      return false;
	   }
	   
	 else  if (document.mainForm.tem8.value.length == 0) {
		  rdShowMessageDialog("合计金额不能为空，请重新输入 !!")
		  document.mainForm.tem8.focus();
		  return false;
	   }
	   //xl add
	  else  if (document.mainForm.seq_num.value.length == 0) {
		  rdShowMessageDialog("发票序列号不能为空，请重新输入 !!")
		  document.mainForm.seq_num.focus();
		  return false;
	   }
	   else
	  {
		   //document.mainForm.action="../zg44/zg44_2.jsp";
		   document.mainForm.action="zg55_2.jsp";
		   document.mainForm.submit(); 
	   }	
	   
 } 
 
 


 
 
  function doclear() {
 		frm.reset();
 }

 
-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="mainForm"  >
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请输入集团发票打印信息</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">集团名称</td>
      <td> 
       <input class="button" value="" type="text" name="tem1" maxlength="40">
      </td>
      <td class="blue">移动台号</td>
      <td> 
        <input class="button" type="text" value="" name="tem2" onKeyPress="return isKeyNumberdot(0)">
      </td>
     </tr>
	 
	 <tr> 
      <td class="blue" width="15%">协议号码</td>
      <td> 
       <input class="button" type="text" value="" name="tem3" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td class="blue">支票号码</td>
      <td> 
       <input class="button" type="text" value="" name="tem4" onKeyPress="return isKeyNumberdot(0)">
      </td>
     </tr> 
	 
	 <tr> 
      <td class="blue" width="15%">发票序列号</td>
      <td> 
       <input class="button" type="text" value="" name="seq_num" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td class="blue">合计金额</td>
      <td> 
       <input class="button" type="text" value="" name="tem8" onKeyPress="return isKeyNumberdot(2)">
      </td>
     </tr> 
	 
	  <tr> 
		  <td class="blue" width="15%">项目1</td>
		  <td colspan=4> 
		  <input class="button" type="text" value="" size="83" name="tem5">
		  </td>
	  </tr> 
	  <tr>
		  <td class="blue" width="15%">项目2</td>
		  <td colspan=4> 
		   <input class="button" type="text" value="" size="83" name="tem6">
		  </td>
	  </tr>
	  <tr>
		  <td class="blue" width="15%">项目3</td>
		  <td colspan=4> 
		   <input class="button" type="text" value="" size="83" name="tem7">
		  </td>
	  </tr>
	  <tr>
		  <td class="blue" width="15%">备注</td>
		  <td colspan=4> 
		   <input class="button" type="text" value="" size="83" name="tem9">
		  </td>
	  </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="打印" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%> 
</form>
 </BODY>
</HTML>