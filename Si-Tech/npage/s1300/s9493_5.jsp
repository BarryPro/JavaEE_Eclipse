<%
/********************
 version v2.0
开发商: si-tech
*
*liuxmc
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode = "d667";
		String opName = "发票信息查询";

%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
	if(document.frm.Invoice_number.value=="")  {
     rdShowMessageDialog("请输入发票号码!");
     document.frm.Invoice_number.value = "";
     document.frm.Invoice_number.focus();
     return false;
  }
  
  if(document.frm.Invoice_number.value.length < 8)  {
     rdShowMessageDialog("发票号码长度不够!");
     document.frm.Invoice_number.value = "";
     document.frm.Invoice_number.focus();
     return false;
  }
	
  if(document.frm.Invoice_code.value=="")  {
     rdShowMessageDialog("请输入发票代码!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  
  if(document.frm.Invoice_code.value.length < 12)  {
     rdShowMessageDialog("发票代码长度不够!");
     document.frm.Invoice_code.value = "";
     document.frm.Invoice_code.focus();
     return false;
  }
  
	document.frm.submit();
	            
}

 function doclear() {
 		frm.reset();
 }


 </script> 
 
<title>黑龙江BOSS-发票信息修改</title>
</head>
<BODY>
<form action="s9493_update.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">发票信息修改</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
          <input name="busyType22" type="radio" checked="checked" value="3" > 发票信息修改
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr colspan = 3>
    	<td align="left" class="blue"  >发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_number" size="10" maxlength="10" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue"  >发票代码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_code" size="14" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="left" class="blue"  >流水:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="Invoice_login" size="14" maxlength="14" onKeyPress="return isKeyNumberdot(0)">
      </td>
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="修改" onclick="commit()" >
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

