<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>全球通签约送礼</title>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName= (String)request.getParameter("opName");
    if(activePhone==null){
    	
    	activePhone=request.getParameter("activePhone");
    } 
    String workNoFromSession=(String)session.getAttribute("workNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

%>


  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
    if("<%=opCode%>" == "2284"){
        document.all.opFlag[1].checked = true;
        opchange();
    }else{
        document.all.opFlag[0].checked = true;
        opchange();
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
 //alert("document.all.cus_pass.value==="+document.all.cus_pass.value);
 
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f2283_1.jsp";
	    	document.all.opcode.value="2283";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("请输入业务流水！");
	    	return;
	    }
	   
	    	frm.action="f2284_1.jsp";
	    	document.all.opcode.value="2284";
	    	
	  }
	}
  }
	    
	
 
  frm.submit();	
  return true;
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true) 
	{
	  	
	  	document.all.backaccept_id.style.display = "none";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  	
	  }

}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
    <%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>

</div>

      <table cellspacing="0">
	  <TR> 
	          <TD class="blue" width="25%">操作类型</TD>
              <TD colspan=3>
        		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
        		<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
	          </TD>
		      
		      
		      </TD>
		      <input type="hidden" name="opcode" >
         </TR>    
         <tr> 
            <td class=blue nowrap> 
              <div align="left">手机号码</div>
            </td>
            <td nowrap colspan="3"> 
            <div align="left"> 
                <input class="InputGrey" readOnly type="text" size="12" name="srv_no" id="srv_no" value="<%=activePhone%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
                <font class="orange">*</font></div>
            </td>
         </tr>
         <tr style="display:none" id="backaccept_id"> 
	          <TD class="blue">业务流水</TD>
              <TD colspan="3">
    			<input type="text" name="backaccept" v_must=1 >
    			<font class="orange">*</font>
	          </TD>
	       </tr>
         <tr id="footer"> 
            <td colspan="4" > 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
           </td>
        </tr>
      </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>
