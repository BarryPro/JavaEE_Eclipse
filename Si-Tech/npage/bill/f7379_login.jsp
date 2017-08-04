<%
/********************
 version v2.0
 开发商: si-tech
 update sunaj at 2009.4.30
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
<title>预存优惠购卡营销案</title>
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
    if(opCode=="7382"){
    	document.all.opFlag[1].checked=true;	
    }
    opchange();
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
	    	frm.action="f7379_1.jsp";
	    	document.all.opcode.value="7379";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("请输入业务流水！");
	    	return;
	    }
	    	frm.action="f7382_1.jsp";
	    	document.all.opcode.value="7382";
	    	
	  }
	}
  }
  
  frm.submit();	
  return true;
}
function opchange(){
	
	  	document.all.backaccept_id.style.display = "";

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
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正
		</TD>
		      <input type="hidden" name="opcode" >
         </TR>    
         <tr> 
            <td class="blue"> 
              <div align="left">手机号码</div>
            </td>
            <td> 
            <div align="left"> 
                <input class="InputGrey"  type="text" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
            </td>
         </tr>
         <TR style="display:none" id="backaccept_id"> 
	          <TD class="blue">业务流水</TD>
              <TD>
			<input type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
	          </TD>
         </TR>    
         <TR> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
  
 <input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
 <%@ include file="/npage/include/footer_simple.jsp" %>        
   </form>
   
</body>
</html>
