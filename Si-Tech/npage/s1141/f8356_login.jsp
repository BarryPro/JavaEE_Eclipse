<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:购G3上网卡，赠通信费  8356
   * 版本: 1.0
   * 日期: 2009/11/3
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>购G3上网卡</title>
<%
    String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
    String workNoFromSession=(String)session.getAttribute("workNo");			//操作工号
	String phoneNo=(String)request.getParameter("activePhone");					//手机号码
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
%>


  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
  onload=function()
  {
		opchange();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性

  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f8356_1.jsp";
	    	document.all.opCode.value="8356";
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDailog("请输入业务流水！");
	    	return;
	    }
	    	frm.action="f8357_1.jsp";
	    	document.all.opCode.value="8357";
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
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<TR> 
		<TD class="blue">操作类型</TD>
		<TD>
			
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>冲正
		</TD>
			<input type="hidden" name="opCode" >
	</TR> 
            
	<tr> 
		<td class="blue">手机号码</td>
		<td nowrap> 
			<input class="InputGrey" readOnly type="text" size="12" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0">
			<font color="orange">*</font>
		</td>
	</tr>
	<TR style="display:none" id="backaccept_id"> 
		<TD class="blue">业务流水</TD>
		<TD>
			<input class="button" type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
		</TD>
	</TR> 
            
	<tr> 
		<td colspan="2" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
 </table>
   <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>
