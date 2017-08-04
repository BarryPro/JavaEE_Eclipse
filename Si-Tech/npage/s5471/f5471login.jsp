<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.1.8
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
<html>
<head>
<title>对资费套餐包月操作</title>
<%
	
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    
%>


</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
  	var phoneNo = "<%=phoneNo%>";
  	if(phoneNo==null||phoneNo=="")
  		removeCurrentTab();
    //document.all.srv_no.focus();
    var opCode = "<%=opCode%>";
    if(opCode=="5471"){
    	document.all.opFlag[0].checked=true;	
    }
  }

 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }


//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  //if(!check(frm)) return false; 
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    	frm.action="f5471_confAdd.jsp";
	    	document.all.opCode.value="5471";
	    	document.all.op_flag.value="A";
	    	document.all.opName.value="增加资费套餐包月费";
	    	
	  }else if(opFlag=="two")
	  {   
	    	frm.action="f5471_confAlt.jsp";
	    	document.all.opCode.value="5471";
	    	document.all.op_flag.value="U";
	    	document.all.opName.value="修改资费套餐包月费";
	  }
	  else if(opFlag=="three")
	  {   
	    	frm.action="f5471_confDlt.jsp";
	    	document.all.opCode.value="5471";
	    	document.all.op_flag.value="D";
	    	document.all.opName.value="删除资费套餐包月费";
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
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
	  <TR> 
		<TD class="blue">操作类型</TD>
		<TD>
			<input type="radio" name="opFlag" value="one" checked >增加&nbsp;&nbsp;			
			<input type="radio" name="opFlag" value="two" >修改&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="three" >删除
		</TD>
         </TR>    
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type="hidden" name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
      
 <input type="hidden" name="opCode" value="<%=opCode%>" >
 <input name="op_flag" type="hidden"  id="op_flag" >  
<input type="hidden" name="opName" value="<%=opName%>" >
 <%@ include file="/npage/include/footer_simple.jsp" %>        
   </form>
   
</body>
</html>
