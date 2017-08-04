<%
  /*
   * 功能: 欢乐家庭
   * 版本: 1.0
   * 日期: 20110428
   * 作者: wanglma 
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>欢乐家庭</title>
<%
	
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    //String[][] favInfo=(String[][])session.getAttribute("favInfo");
	//boolean workNoFlag=false;
	//if(workNo.substring(0,1).equals("k"))
	//	workNoFlag=true;
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

onload=function()
{
  	var opCode = "<%=opCode%>";
  	if(opCode=="d570")
  	{
		document.all.opFlag[0].checked=true;
		opchange();		
  	}
  	if(opCode=="d571")
  	{
		document.all.opFlag[1].checked=true;  
		opchange();			
  	}
  	if(opCode=="d572")
  	{
		document.all.opFlag[2].checked=true;
		opchange();			
  	}
  	if(opCode=="d573")
  	{
		document.all.opFlag[3].checked=true;  
		opchange();			
  	}
  	if(opCode=="d574")
  	{
		document.all.opFlag[4].checked=true;  
		opchange();			
  	}
}

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	//controlButt(subButton);			//延时控制按钮的可用性
	subButton.disabled = true;
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one") { //建立
		  	document.all.opCode.value = "d570";
		  	document.all.opName.value = "建立欢乐家庭";
				frm.action="fd570_main.jsp";
			} else if(opFlag=="two") { //冲正
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("请输入业务流水！",1)
					subButton.disabled = false;
					return;
				}
				frm.action="fd571_main.jsp";
				document.all.opCode.value="d571";
			}
			else if(opFlag=="three") { //加入
				if($("#member_no").val() == "" ){
					rdShowMessageDialog("成员号码不能为空！");
					return;
				}
				if($("#cus_pass").val() == "" ){
					rdShowMessageDialog("成员号码密码不能为空！");
					return;
				}
				frm.action="fd572_main.jsp";
				document.all.opCode.value="d572";
			}
			else if(opFlag=="four") { //退出
				if($("#exitPhone").val() == "" ){
					rdShowMessageDialog("号码不能为空！");
					return;
				}
				frm.action="fd573_main.jsp";
				document.all.opCode.value="d573";
			}else if(opFlag=="five") { //取消
				frm.action="fd574_main.jsp";
				document.all.opCode.value="d574";
			}
		}
  }
	frm.submit();	
	return true;
}

function opchange() {
	if(document.all.opFlag[0].checked==true) {
		$("#confirm").attr("disabled",false);
		$("#opCode").val("d570");
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.comboTypeDiv.style.display = "";
	  	//document.all.tdPhoneDiv.style.display = "";
	  	//document.all.gsmPhoneDiv.style.display = "";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	  	comboTypeChange();
	} else if(document.all.opFlag[1].checked==true) {
		$("#confirm").attr("disabled",false);
		$("#opCode").val("d571");
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	} else if(document.all.opFlag[2].checked==true) {
		$("#confirm").attr("disabled",true); 
		$("#opCode").val("d572");
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "";
	} else if(document.all.opFlag[3].checked==true) {
		$("#confirm").attr("disabled",true);
		$("#opCode").val("d573");
		fd573_checkPhone();
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	} else if(document.all.opFlag[4].checked==true) {
		$("#confirm").attr("disabled",false);
		$("#opCode").val("d574");
	  	document.all.comboTypeDiv.style.display = "none";
	  	//document.all.tdPhoneDiv.style.display = "none";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.exitShow.style.display = "none";
	  	document.all.member_no_tr.style.display = "none";
	}
}

function comboTypeChange() {
	var obj = document.getElementById("comboType");
	if (obj.value == "B") {
	  	document.all.comboTypeDiv.style.display = "";
	  	//document.all.tdPhoneDiv.style.display = "";
	  	//document.all.gsmPhoneDiv.style.display = "";
	} else {
	  	document.all.comboTypeDiv.style.display = "";
	  	//document.all.tdPhoneDiv.style.display = "";
	  	//document.all.gsmPhoneDiv.style.display = "none";
	}
}

function checkPassWord(){
    //验证密码 是否正确
    var passWord = "";
    var phoneNo = "";
    if($("#opCode").val() == "d572"){
    	passWord = $("#cus_pass").val();
    	phoneNo = $("#member_no").val();
    }
   	var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行号码校验，请稍候......");
    checkPwd_Packet.data.add("custType", "01"); //01:手机号码 02 客户密码校验 03帐户密码校验
    checkPwd_Packet.data.add("phoneNo", phoneNo); //移动号码,客户id,帐户id
    checkPwd_Packet.data.add("custPaswd",passWord);//用户/客户/帐户密码
    checkPwd_Packet.data.add("idType", ""); //en 密码为密文，其它情况 密码为明文
    checkPwd_Packet.data.add("idNum", ""); //传空
    checkPwd_Packet.data.add("loginNo", "<%=workNo%>"); //工号
    core.ajax.sendPacket(checkPwd_Packet,doMsg);
    checkPwd_Packet = null;
}

function doMsg(packet){
  	var retCode=packet.data.findValueByName("retResult");
  	var retMsg=packet.data.findValueByName("msg");
  	if(retCode == "000000"){
  		 $("#confirm").attr("disabled",false);	
  	}else{
  	   	rdShowMessageDialog("密码不匹配，请重新输入！");
  	   	$("#cus_pass").val("");
  	   	$("#cus_pass").focus();
  	   	$("#confirm").attr("disabled",true);
  	}
}
function fd573_checkPhone(){
	var packet = new AJAXPacket("fd573_ajaxCheckPhone.jsp","正在进行号码校验，请稍候......");
  	packet.data.add("phoneNo", $("#activePhone").val());
  	core.ajax.sendPacket(packet,doCheckPhone);
    packet = null;
}
function doCheckPhone(packet){
  	var retCode=packet.data.findValueByName("retCode");
  	var retMsg=packet.data.findValueByName("retMsg");
  	var flag=packet.data.findValueByName("flag");
  	document.all.exitShow.style.display = "";
  	$("#flag").val(flag);
  	if(retCode == "000000" && flag == "0"){//成员
  	   	$("#exitTd").html("家长号码");
  	   	$("#confirm").attr("disabled",false);
  	}else if(retCode == "000000" && flag == "1"){//家长
  		$("#exitTd").html("成员号码");
  		$("#confirm").attr("disabled",false);
  	}else if(retCode == "000000" && flag == "2"){//其它群组
  		rdShowMessageDialog("此号码不在欢乐家庭群组，或欢乐家庭资费已预约结束，不可办理此业务！");
  		$("#confirm").attr("disabled",true);
  	   	return;
  	}else{
  	   	rdShowMessageDialog("错误代码："+retCode+"   "+"错误信息："+retMsg);
  	   	return;
  	}
}

</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="">
 	<input type="hidden" name="opName" id="opName" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="15%">操作类型</td>
		<td colspan="3" >
			<input type="radio" name="opFlag" value="one" onclick="opchange()">建立欢乐家庭&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()">欢乐家庭冲正&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="three" onclick="opchange()">加入欢乐家庭&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="four" onclick="opchange()">退出欢乐家庭&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="five" onclick="opchange()">解散欢乐家庭&nbsp;&nbsp;
		</td>
	</tr>    
	<tr> 
		<td class="blue" width="15%">电话号码</td>
		<td colspan="3"> 
			<input type="text" size="12" name="activePhone" value="<%=activePhone%>" id="activePhone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
			<font color="orange">*</font>
		</td>
	</tr>
	
		  <tr id="exitShow" name="exitShow" style="display:none">
		     	
               <td  class="blue"   width="10%" id="exitTd"> 
                  成员号码
                </td>
		     	<td colspan="3">
                  <input type="text" size="12" name="exitPhone"  id="exitPhone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0"  />
                  <font color="orange">*</font>
               </td>
           </tr>
	
	<tr id="member_no_tr" name="member_no_tr" style="display:none" > 
            <td class="blue" width="15%"> 
              <div align="left">成员号码</div>
            </td>
			<td width="20%"> 
                <input class="button"  type="text" name="member_no"  id="member_no" v_minlength=1 v_maxlength=12 size="11" maxlength=11 v_type="string" v_must=1 index="0" >
                <font color="orange">*</font>
            </td>
			<td  class="blue"   width="10%"> 
              <div align="left">密码</div>
            </td>
         
           <TD id="">
			     <!--<input type="password" class="button" name="cus_pass" id="cus_pass" size="11" maxlength="8" style='none' > 		    -->
		         <input name="cus_pass" id="cus_pass" type="password" onKeyPress="return isKeyNumberdot(0)"   maxlength="6" onFocus="showNumberDialog(document.all.cus_pass)"  pwdlength="6" />
		         <input type="button" class="b_text" value="校验" onclick="checkPassWord()" />
			     <font color="orange">*</font>
		      </TD>
     </tr>
     
     
	<tr style="display:none" id="comboTypeDiv">
		<td class="blue">
			套餐类型
		</td>
		<td>
			<select name="comboType" id="comboType" onchange="comboTypeChange()">
				<option value="A">欢乐家庭A款套餐</option>
				<option value="B">欢乐家庭B款套餐</option>
				<option value="C">欢乐家庭C款套餐</option>
			</select>
		</td>
	</tr>
	<tr style="display:none" id="tdPhoneDiv">
		<td class="blue">副用户TD固话号码</td>
		<td>
			<input type="text" size="12" value="" name="tdPhone" id="tdPhone" v_minlength=1 v_maxlength=16 v_must=1 maxlength="11" />
			<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="gsmPhoneDiv"> 
		<td class="blue">副用户手机号码</td>
		<td>
			<input type="text" size="12" value="" name="gsmPhone" id="gsmPhone" v_minlength=1 v_maxlength=16 v_must=1 maxlength="11" />
			<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">业务流水</td>
		<td>
			<input class="button" type="text" name="backaccept" v_must=1  />
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="confirm" id="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <input type="hidden" id="flag" name="flag" value=""/>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
