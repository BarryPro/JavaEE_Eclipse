<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 预存赠固话，话费可分享 7671
   * 版本: 1.0
   * 日期: 2010/4/7
   * 作者: sunaj
   * 版权: si-tech
   * update:  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>预存赠固话，话费可分享</title>
<%
    //String opCode="7671";
	//String opName="预存赠固话，话费可分享";
	
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String PhoneHead = phoneNo.substring(0, 3);
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>
  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

onload=function()
{
  	var opCode = "<%=opCode%>";
  	if(opCode=="7671")
  	{
		
		opchange();		
  	}
  	if(opCode=="7672")
  	{
		
		opchange();			
  	}
}

//============weigp
function check147SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("check147SuperTD.jsp","正在进行校验，请稍候......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
function check157SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("check157SuperTD.jsp","正在进行校验，请稍候......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
var flagTD = "true";
function getResult(packet){
	var result=packet.data.findValueByName("result");
	if("false"==result){
		//rdShowMessageDialog("147号段只有TD公话号码才能办理该业务！");
		//return false;
		flagTD = "false";
	}else{
		flagTD = "true";
	}
}
//============

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//延时控制按钮的可用性
	var phoneHead = <%=PhoneHead%>;
  	
  //==================weigp

  
  		if(phoneHead == '147'){
  			check147SuperTD("<%=phoneNo%>");
  			if(flagTD == "false"){
  			rdShowMessageDialog("147号段只有TD公话号码才能办理该业务！");
  			return false;
 				}
  		}
  		if(phoneHead == '157'){
  			check157SuperTD("<%=phoneNo%>");
  			if(flagTD == "false"){
  			rdShowMessageDialog("157号段只有TD公话号码才能办理该业务！");
  			return false;
 				}
  		}
 		else
      	{
				rdShowMessageDialog("只有157号段TD公话号码和147号段TD公话号码才能办理该业务！");
  			return false;
      	}  
  
  //====================
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one")
			{
				frm.action="f7671_1.jsp";
				document.all.opcode.value="7671";
			
			}else if(opFlag=="two")
			{
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("请输入业务流水！",1)
					return;
				}
				frm.action="f7672_1.jsp";
				document.all.opcode.value="7672";
			}
		}
  }
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange()
{
	 
	  	document.all.backaccept_id.style.display = "";
	
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked >冲正
		</td>
	</tr>    
	<tr> 
		<td class="blue">手机号码 </td>
		<td> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">业务流水</td>
		<td colspan="3">
			<input class="button" type="text" name="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>    
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
