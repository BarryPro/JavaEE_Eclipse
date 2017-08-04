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

		String opCode = "g165";
		String opName = "报损发票录入";
		String workno = (String)session.getAttribute("workNo");
%>
  


<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	var invoice_id = document.frm.invoice_id.value;
	var invoice_no=document.frm.invoice_no.value;
	var loss_type=document.frm.loss_type.value;
	var loss_reason=document.frm.loss_reason.value;
	
	/*xl add 发票类型*/
	var fplx=document.frm.fplx.value;
	 //alert("test fplx is "+fplx);
	if(document.frm.invoice_id.value=="")  {
     rdShowMessageDialog("请输入发票代码!");
     document.frm.invoice_id.value = "";
     document.frm.invoice_id.focus();
     return false;
  }
  
	
	if(document.frm.invoice_no.value=="")  {
     rdShowMessageDialog("请输入报损发票号码!");
     document.frm.invoice_no.value = "";
     document.frm.invoice_no.focus();
     return false;
  }
  
  
  if(document.frm.loss_reason.value=="")  {
     rdShowMessageDialog("请输入报损原因!");
     document.frm.loss_reason.value = "";
     document.frm.loss_reason.focus();
     return false;
  }
  document.frm.submit();

	            
}

 
 function doclear() {
 		frm.reset();
 }

 </script> 
 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY>
<form  method="post" name="frm" action="g165_2.jsp">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">报损发票录入</div>
		</div> 

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">录入方式</td>
        <td> 
          <input name="busyType2" type="radio"  value="1" checked>营业员报损发票 
		</td>
      &nbsp;&nbsp;
		<td class="blue" width="15%">发票类型</td>
        <td> 
          <select name="fplx">
				<option value="1">移动发票</option>
				<option value="2">铁通发票</option>
		  </select> 
		</td>

    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="left" class="blue" width="15%">发票代码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="invoice_id"  maxlength="6" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">报损发票号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="invoice_no" maxlength="10" onKeyPress="return isKeyNumberdot(0)"><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">报损类型:&nbsp;&nbsp;&nbsp;
         <select name="loss_type" >
          	<option value="1">报损</option> 
          	<option value="2">补打</option>                  
          </select><font color="#FF0000">*</font>
      </td>      
    </tr>
    <tr>
    	<td align="left" class="blue" width="15%">报损原因：
        <input class="button" type="text" id="loss_reason" name="loss_reason" maxlength="200" ><font color="#FF0000">*</font>
      </td>
      <td align="left" class="blue" width="15%">&nbsp;&nbsp;&nbsp;      
      </td>
      <td align="left" class="blue" width="15%">&nbsp;&nbsp;&nbsp;      
      </td>      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="确认" onclick="commit()" >
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

