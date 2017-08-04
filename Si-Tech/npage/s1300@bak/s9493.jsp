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
		String opCode = "9493";
		String opName = "发票信息查询";

%>
<HTML>
<HEAD>
<script language="JavaScript">

function commit(){
	
	if(document.frm.login_accept.value=="")  {
     rdShowMessageDialog("请输入流水!");
     document.frm.login_accept.value = "";
     document.frm.login_accept.focus();
     return false;
  }
  /*	
  if(document.frm.phoneNo.value=="")  {
     rdShowMessageDialog("请输入服务号码!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  
  if(document.frm.phoneNo.value.length != 11)  {
     rdShowMessageDialog("服务号码长度不够!");
     document.frm.phoneNo.value = "";
     document.frm.phoneNo.focus();
     return false;
  }
  */
  if(document.frm.print_time.value=="")  {
     rdShowMessageDialog("请输入打印年月!");
     document.frm.print_time.value = "";
     document.frm.print_time.focus();
     return false;
  }  
  
  if(document.frm.print_time.value.length !=6 )  {
     rdShowMessageDialog("打印年月长度不够!");
     document.frm.print_time.value = "";
     document.frm.print_time.focus();
     return false;
  }  
  /*
  if(document.frm.check_num.value=="")  {
     rdShowMessageDialog("请输入防伪码!");
     document.frm.check_num.value = "";
     document.frm.check_num.focus();
     return false;
  }  
  
  if(document.frm.check_num.value.length !=4 )  {
     rdShowMessageDialog("防伪码长度不够!");
     document.frm.check_num.value = "";
     document.frm.check_num.focus();
     return false;
  }  
  */
	document.frm.submit();
	            
}

 function sel1() {
 		window.location.href='s9493.jsp';
 }

 function sel2(){
    window.location.href='s9493_3.jsp';
 }
 
 function sel3(){
    window.location.href='s9493_4.jsp';
 }
 function sel6(){
    window.location.href='s9493_6.jsp';
 }
 function doclear() {
 		frm.reset();
 }


 </script> 
 
<title>黑龙江BOSS-发票信息查询和录入</title>
</head>
<BODY>
<form action="s9493_query.jsp" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">发票信息查询和录入</div>
		</div>

  <table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">查询方式</td>
        <td colspan="4"> 
          <input name="busyType1" type="radio" onClick="sel1()" value="1" checked>按流水查询 
          <input name="busyType21" type="radio" onClick="sel2()" value="2"> 按发票号码查询
          <input name="busyType22" type="radio" onClick="sel3()" value="3"> 录入发票号码和发票代码 
          <input name="busyType23" type="radio" onClick="sel6()" value="4"> 营业员发票删除
      </td>
      
    </tr>
  </table>

  
  <table cellspacing="0">
    <tr>
    	<td align="center" class="blue" width="15%">流水:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="login_accept" size="20" maxlength="20" onKeyPress="return isKeyNumberdot(0)">
      </td>
	  <!--
      <td align="center" class="blue" width="15%">服务号码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="phoneNo" size="11" maxlength="11" onKeyPress="return isKeyNumberdot(0)">
      </td>
      <td align="center" class="blue" width="15%">防伪码:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="check_num" size="4" maxlength="4" onKeyPress="return isKeyNumberdot(0)">
      </td>
	  -->
      <td align="center" class="blue" width="15%">打印年月:&nbsp;&nbsp;&nbsp;
        <input class="button" type="text" name="print_time" size="6" maxlength="6" onKeyPress="return isKeyNumberdot(0)"> &nbsp;(格式:YYYYMM)
      </td>
      
    </tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
              <input type="button" name="query" class="b_foot" value="查询" onclick="commit()" >
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
