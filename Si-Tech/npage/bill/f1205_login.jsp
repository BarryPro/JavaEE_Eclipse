<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<head>
<title>哈尔滨畅听套餐</title>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = "哈尔滨畅听套餐";
  
	activePhone = request.getParameter("activePhone");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
    //document.all.srv_no.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  //controlButt(subButton);//延时控制按钮的可用性
  if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    frm.action="f1205Main.jsp";
	  }else if(opFlag=="two")
	  {
	    frm.action="f1206Main.jsp";
	  }else if(opFlag=="three")
	  {
	    frm.action="f1207Main.jsp";
	  }else if(opFlag == "four")
	  {
		frm.action="f1200Main.jsp";
	  }else if(opFlag == "five")
	  {
		  frm.action = "f1198Main.jsp";
	  }
	}
  }
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">哈尔滨畅听套餐</div>
		</div>
		     
      <table cellspacing="0">        
	      <tr> 
	          <td class="blue">操作类型</td>
              <td colspan="2">
			       <input type="radio" name="opFlag" value="one" checked>申请&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="two" >冲正&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="three" >取消&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="four" >续签&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="five" >续签冲正 					
	          </td>
	        
         </tr>
         <tr> 
            <td class="blue">手机号码</td>
            <td>                
                <input Class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" value="<%=activePhone%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">               
            </td>
            <td  class="blue" style="display:none"> 
                <div align="left">用户密码</div>
            </td>                     
			    <input type="hidden" Class="InputGrey" name="cus_pass" size="20" maxlength="8"> 		    				
         </tr>       
         <tr> 
            <td colspan="3"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">&nbsp;&nbsp;&nbsp;                 
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
      </table>
     
 	<input type="hidden" name="returnPage" value="f1205_login.jsp?activePhone=<%=activePhone%>"
    <%@ include file="/npage/include/footer_simple.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
   </form>
</body>
</html>
