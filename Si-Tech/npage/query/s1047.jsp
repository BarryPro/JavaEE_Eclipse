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
		String opCode = "1047";
		String opName = "统付历史查询";
		
%>
<HTML>
<HEAD>
<script language="JavaScript">
<!--	








function check_HidPwd()
{
  if(document.frm.phoneNo.value=="")
  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneNo.focus();
     return false;
  }
  

  if( document.frm.phoneNo.value.length != 11 )
  {
     rdShowMessageDialog("服务号码只能是11位!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
	            
	
}

 function docheck()
{
	
  if(document.frm.contractno.value=="")
  {
      rdShowMessageDialog("请输入支付帐号!");
     	document.frm.contractno.focus();
     	return false;
  }
  if(document.frm.yearmonth.value=="")
  {
      rdShowMessageDialog("请输入统付年月!");
     	document.frm.yearmonth.focus();
     	return false;
  }
 
  
   document.frm.action="s1047_2.jsp?phoneNo="+document.frm.phoneNo.value+"&contractno="+document.frm.contractno.value+"&yearmonth="+document.frm.yearmonth.value;
   document.frm.query.disabled=true;
   document.frm.submit();
} 


  function doclear() {
 		frm.reset();
 }






-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">请输入查询条件</div>
		</div>
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">手机号码</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      </td>
      <td class="blue">*支付帐号</td>
      <td> 
        <input type="text" name="contractno" size="20" maxlength="20"  >
      </td>
       <td class="blue">*统付年月</td>
      <td> 
        <input type="text" name="yearmonth" size="20" maxlength="20"  >
      </td>
      
    </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="docheck()" >
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