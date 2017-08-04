<%
/********************
 version v2.0
 开发商: si-tech
 update sunaj at 2009.9.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>TD修改IMEI绑定关系</title>
<%
	
    String opCode = "7634";
    String opName = "TD修改IMEI绑定关系";
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode");    
%>		
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>

function controlButt(subButton)
{
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	if(document.frm.srv_no.value.substring(0, 3)!='157'&&document.frm.srv_no.value.substring(0, 3)!='184' && document.frm.srv_no.value.substring(0, 3)!='451' && document.frm.srv_no.value.substring(0, 3)!='045' && document.frm.srv_no.value.substring(0, 3)!='046' && document.frm.srv_no.value.substring(0, 3)!='147')
	{
		rdShowMessageDialog("只有451、045、046号段和147、157、184部分号段的用户才能办理该业务！");
  		return false;
  	}
	if(isNaN(document.frm.srv_no.value.trim()))
	{
		 rdShowMessageDialog("手机号码请输入数字!");
		 return false;
	}
	if(document.frm.srv_no.value.trim().length>=0 && document.frm.srv_no.value.trim().length !=11)
	{
	   rdShowMessageDialog("手机号码位数不正确，请重新输入!");
	   document.frm.srv_no.value="";
	   document.frm.srv_no.focus();
	   return false;
	}
	// add by wanglm 20101119 判断147 话段的电话号是否为 TD固话 start
	if(document.frm.srv_no.value.substring(0,3) =='147'){
	   	var packet = new AJAXPacket("/npage/bill/check147SuperTD.jsp","正在验证，请稍后。。。");
	    packet.data.add("phoneNo",document.frm.srv_no.value);
	    core.ajax.sendPacket(packet,doPro);
	    packet =null;
	}
	// add by gaopeng 20120917 判断157 话段的电话号是否为 TD固话 start
	if(document.frm.srv_no.value.substring(0,3) =='157'){
	   	var packet = new AJAXPacket("/npage/bill/check157SuperTD.jsp","正在验证，请稍后。。。");
	    packet.data.add("phoneNo",document.frm.srv_no.value);
	    core.ajax.sendPacket(packet,doPro);
	    packet =null;
	}
	// add by gaopeng 2014/12/12 17:26:41 判断184 话段的电话号是否为 TD固话 start
	if(document.frm.srv_no.value.substring(0,3) =='184'){
	   	var packet = new AJAXPacket("/npage/bill/check184SuperTD.jsp","正在验证，请稍后。。。");
	    packet.data.add("phoneNo",document.frm.srv_no.value);
	    core.ajax.sendPacket(packet,doPro);
	    packet =null;
	}
	else{
	    document.frm.action="f7634_2.jsp"
	    frm.submit();
	    document.frm.confirm.disabled=true;
	    return true;	
	}
  	//controlButt(subButton); //延时控制按钮的可用性
}
  function doPro(packet){
		var result = packet.data.findValueByName("result");
		if(result == "false"){
			rdShowMessageDialog("手机号码不是TD固话号码!");
			document.frm.srv_no.value="";
	        document.frm.srv_no.focus();
			return false;
		}
		document.frm.action="f7634_2.jsp"
	    frm.submit();
	    document.frm.confirm.disabled=true;
	    return true;
	}
	// add by wanglm 20101119 判断147 话段的电话号是否为 TD固话 end
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
		<td class="blue">手机号码</td>
		<td>
			<input type="text" name="srv_no" id="srv_no"  maxlength="11" v_type="mobphone" v_must=1 index="0">
			<font color="orange">*</font>
		</td>
	</tr>  
	<tr> 
		<td colspan="4" id="footer"> 
		<div align="center"> 
			<input class="b_foot" type="button" name="confirm" value="确定" onClick="doCfm(this);">   
			<input class="b_foot" type="button" name="back" value="清除" onClick="frm.reset();">
			<input class="b_foot" type="button" name="qryP" value="关闭" onClick="removeCurrentTab();">
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