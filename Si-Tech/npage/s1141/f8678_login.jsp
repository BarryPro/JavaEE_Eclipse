<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2008.11.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  request.setCharacterEncoding("GBK");
%>
	
<head>
<title>积分换G3上网本</title>
<%
  activePhone=(String)request.getParameter("activePhone"); 
	  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  //String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  //ArrayList agentCodeArr = co.spubqry32("2",sql);
%>

<script language=javascript>
	
  onload=function()
  {
     opchange();
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
	   if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowConfirmDialog("请输入业务流水！");
	    	return;
	    }
	    	frm.action="f8679_1.jsp";
	    	document.all.opcode.value="8679";
	    	
	  }
	}
  }
 
  frm.submit();	
  return true;
}
function opchange(){
	 
	  	document.all.backaccept_id.style.display = "inline";
	  	document.getElementById("backaccept").readOnly=false;
	  

}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		
      <table cellspacing="0">
	  	  <tr> 
	          <td class="blue">操作类型</td>
              <td>
				  
		          <input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正
	          </td>	          
		          <input type="hidden" name="opcode">		      		      
          </tr>           
          <tr> 
              <td class="blue">手机号码</td>
              <td> 
                  <input type="text" size="12" Class="InputGrey" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  maxlength="11" index="0" value="<%=activePhone%>" readOnly>
              </td>            		  			  	     
          </tr>
          <tr class="blue" style="display:block" id="backaccept_id"> 
	          <td class="blue">业务流水</td>
              <td>
			      <input type="text" name="backaccept" v_must=1 size="12" maxlength="11" readOnly>
			      <font color="orange">*</font>
	          </td>	 	 	          
       
         </tr>   
      </table>
      <table cellspacing="0">
         <tr> 
            <td align="center" id="footer"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type="button" name=back value="清除" onClick="backaccept.value=''">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
             </td>
         </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
   </form>
   
</body>
</html>
