<%
   /*
   * 功能: 公共验证页面	
　 * 版本: v3.0
　 * 日期: 2008/04/06
　 * 作者: ranlf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/njs/jquery/interface.js"></script>
<script type="text/javascript" language="javascript" src="<%= request.getContextPath() %>/njs/si/base_kf.js"></script>
<script type="text/javascript" language="javascript" src="<%= request.getContextPath() %>/njs/si/ajax_kf.js"></script>

<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/sitechcallcenter.js"></script>
<%
    String tilteName = WtcUtil.repNull(request.getParameter("titleName"));
    String validateVal = request.getParameter("valideVal")==null?"000":request.getParameter("valideVal");
		
    String opName = "公共验证页面";
    String opCode = WtcUtil.repNull(request.getParameter("opCode"));
    String orgCode =(String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);    
    
    if(tilteName==null||tilteName.equals("")) tilteName = "密码验证";
    String opeFlag = WtcUtil.repNull(request.getParameter("opeFlag"));
    
    System.out.println("-----------------opeFlag------------------"+opeFlag);
    System.out.println("-----------------activePhone--------------"+activePhone);
    String  checkedStr1 = "";
    String  checkedStr2 = "";
    if(!opeFlag.equals("1")){
    	checkedStr1 = "";
    	checkedStr2 = "checked";
    }else{
    	checkedStr1 = "checked";
    	checkedStr2 = "";
    }
%>
<html>
<head>
<title><%=tilteName%></title>
</head>

<body>
<form name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi"><%=tilteName%></div></div>
   <table  cellspacing="0">
   	  <tr>
   	   	<td class="blue">服务号码</td>
				<td class="blue" colspan="3"><input type="text"  id="cPhoneNo" value="<%=activePhone%>" >
					<input type="hidden" id="custIdHit" name="custIdHit" value="">
					</td>		
				
			</tr>
					<tr id="checkTypetr">
						<td class="blue" colspan="3">
							本机验证<input type="radio" name="checkType" value="0" <%=checkedStr1%> onclick="checkMode(this.value);">
							它机验证<input type="radio" name="checkType" value="1" <%=checkedStr2%> onclick="checkMode(this.value);">
						</td>
					</tr>
					
   	  <tr>
   	   	<td class="blue">验证类型</td>
   	   	<td class="blue">
   		  	<select name="validateType" id="validateType" onChange="ChgType()" size="1" >
				  	<option value="0">手机号码</option>
				  	<option value="1">身份证号</option>
				  	<option value="2">合同号码</option>
					</select>
					&nbsp;&nbsp;&nbsp;
					<span id="userPhone">
					<input name="ChkPwdBtn" type="button" class="b_text" onClick="submitConfig()"value="验证">
				</span>
				</td>
		 
			<tr id="IccidTr">
				<td class="blue">身份证号</td>
				<td class="blue">			
				<!--<input type="text" name="idCardNo" id="idCardNo" v_must="1"  v_type="idcard" onBlur="checkElement(this)" maxlength="18" onkeyDown="if(event.keyCode==13)doCheck(document.all.user_passwd)" > 	-->
					 <jsp:include page="/npage/common/pwd_1.jsp">
              <jsp:param name="width1" value=""  />
	            <jsp:param name="width2" value=""  />
	            <jsp:param name="pname" value="idCardNo"  />
	            <jsp:param name="pwd" value="<%=123456%>"  />
           </jsp:include>
					 	<input name="ChkPwdBtn" type="button" class="b_text" onClick="doCheck(document.all.idCardNo)" value="验证">
           	<font class="orange">*</font>
				</td>
			</tr>
			<tr id="pactNoTr">
				<td class="blue">合同号码</td>
				<td class="blue">			
				<!--<input type="password" name="randomPwd" id="randomPwd" v_must="1" v_type="0_9" onKeyPress="return isKeyNumberdot(0)"  pwdlength="6" onBlur="checkElement(this)" maxlength="6" onkeyDown="if(event.keyCode==13)doCheck(document.all.user_passwd)" > 	-->
					 <jsp:include page="/npage/common/pwd_1.jsp">
              <jsp:param name="width1" value=""  />
	            <jsp:param name="width2" value=""  />
	            <jsp:param name="pname" value="pactNo"  />
	            <jsp:param name="pwd" value=""  />
           </jsp:include>
					 	<input name="ChkPwdBtn" type="button" class="b_text" onClick="" value="验证">
           	<font class="orange">*</font>
				</td>
			</tr>
   </table>
   <!--由于在密码小键盘不需要注意事项提醒，故把引入头尾文件样式写死-->
  </DIV>
</DIV>
 <!--由于在密码小键盘不需要注意事项提醒，故把引入头尾文件样式写死-->
 <input type="hidden" id="hiPhoneNo" name="hiPhoneNo">
<%@ include file="/npage/common/pwd_comm.jsp" %>
 </form>
</body>



<script language="javaScript">
	var windowOpener = window.dialogArguments;
	var retCode='';//增加标识，0－外呼密码验证，1－呼入密码验证
		onload = function()
		{
			ChgType();
		}
	getCaller();	
	function getCaller(){
		var ret;
		
		
		if(windowOpener.outCallFlag==1)
		{
			if(windowOpener.cCcommonTool.getCalled() != "" && (windowOpener.cCcommonTool.getCalled().indexOf('10086')==0 ||windowOpener.cCcommonTool.getCalled().indexOf('12580')==4||windowOpener.cCcommonTool.getCalled().indexOf('12597')==0)){
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCaller();
				document.getElementById("hiPhoneNo").value= windowOpener.cCcommonTool.getCaller();
			}
			else{
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCalled();
				document.getElementById("hiPhoneNo").value= windowOpener.cCcommonTool.getCalled();
			}
	 
			retCode='0';
		}
		else
		{
			if(windowOpener.cCcommonTool.getCalled() != "" && (windowOpener.cCcommonTool.getCalled().indexOf('10086')==0 ||windowOpener.cCcommonTool.getCalled().indexOf('12580')==4||windowOpener.cCcommonTool.getCalled().indexOf('12597')==0)){
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCaller();
				document.getElementById("hiPhoneNo").value= windowOpener.cCcommonTool.getCaller();
			}
			else{
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCalled();
				document.getElementById("hiPhoneNo").value= windowOpener.cCcommonTool.getCalled();
			}
		  retCode='1';
		}
		
	<%if(activePhone.equals("")||activePhone==null){%>	
	<%}else{%>
		if(windowOpener.outCallFlag==1){
			retCode='0';
		}else{
			retCode='1';
		}
		
		//if(document.getElementById("cPhoneNo").value.trim()==""||document.getElementById("cPhoneNo").value.trim().indexOf("custid")!=-1){
		if(true){
		<%
		String phoneNoh = "";
		
		
		if(activePhone.indexOf("custid")!=-1){
			String selSql = "select phone_no from dcustmsg  where cust_id = '"+activePhone.substring(6,activePhone.length())+"'";
			%>
			
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=selSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
	 
	<%
		if(result_t.length>0&&result_t[0][0]!=null){
			phoneNoh = result_t[0][0];
		}			
		%>
		if(document.getElementById("hiPhoneNo").value.trim()=="<%=phoneNoh%>".trim()){//本机验证选中
			document.all.checkType[0].checked=true;
		}else{//他机验证选中
			document.all.checkType[1].checked=true;
		}
		document.getElementById("cPhoneNo").value = "<%=phoneNoh%>";	
		document.getElementById("hiPhoneNo").value= "<%=phoneNoh%>";
		<%
	}else{
		
		if(!opeFlag.equals("1")){
	%>
		if(document.getElementById("hiPhoneNo").value.trim()=="<%=activePhone%>".trim()){//本机验证选中
			document.all.checkType[0].checked=true;
		}else{//他机验证选中
			document.all.checkType[1].checked=true;
		}
		
		document.getElementById("cPhoneNo").value = "<%=activePhone%>";	
		document.getElementById("hiPhoneNo").value= "<%=activePhone%>";
	<%}else{
		%>
		if(document.getElementById("hiPhoneNo").value.trim()== windowOpener.document.getElementById("acceptPhoneNo").value.trim()){//本机验证选中
			document.all.checkType[0].checked=true;
		}else{//他机验证选中
			document.all.checkType[1].checked=true;
		}
		
		document.getElementById("cPhoneNo").value = windowOpener.document.getElementById("acceptPhoneNo").value;
		document.getElementById("hiPhoneNo").value= windowOpener.document.getElementById("acceptPhoneNo").value;
		<%}
		
	}
  %>
}else{
	document.getElementById("hiPhoneNo").value = document.getElementById("cPhoneNo").value;
	}
	
	
<%}%>


}
	
	
	function checkMode(checkValue)
{
if(checkValue==0)
{
document.getElementById("cPhoneNo").readOnly = true; 
	if(windowOpener.outCallFlag==1)
	{
		if(windowOpener.cCcommonTool.getCalled() != "" && (windowOpener.cCcommonTool.getCalled().indexOf('10086')==0 ||windowOpener.cCcommonTool.getCalled().indexOf('12580')==4||windowOpener.cCcommonTool.getCalled().indexOf('12597')==0)){
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCaller();
			}
			else{
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCalled();
			}
	}
	else
	{
		if(windowOpener.cCcommonTool.getCalled() != "" && (windowOpener.cCcommonTool.getCalled().indexOf('10086')==0 ||windowOpener.cCcommonTool.getCalled().indexOf('12580')==4||windowOpener.cCcommonTool.getCalled().indexOf('12597')==0)){
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCaller();
			}
			else{
				document.getElementById("cPhoneNo").value= windowOpener.cCcommonTool.getCalled();
			}
	}
}	
	if(checkValue==1)
	{
		document.getElementById("cPhoneNo").readOnly = false; 
			<%
				if(!opeFlag.equals("1")){
					String phoneNoh1 = "";
					if(activePhone.indexOf("custid")!=-1){
						String selSql1 = "select phone_no from dcustmsg  where cust_id = '"+activePhone.substring(6,activePhone.length())+"'";
						%>
				 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			  	 <wtc:sql><%=selSql1%></wtc:sql>
			 	  </wtc:pubselect>
				 <wtc:array id="result_t1" scope="end"/>
				<%
					if(result_t1.length>0&&result_t1[0][0]!=null){
						phoneNoh1 = result_t1[0][0];
					}			
			%>
				document.getElementById("cPhoneNo").value = ("<%=phoneNoh1%>");	
			<%}else{
				%>
				document.getElementById("cPhoneNo").value = ("<%=activePhone%>");	
				<%
				}
			}else{
				%>
				document.getElementById("cPhoneNo").value = (windowOpener.document.getElementById("acceptPhoneNo").value);
				<%}
		  %>
	}
}

	
	 function doProcess(packet)
	 {
        var retType = packet.data.findValueByName("retType");
        var retCode = packet.data.findValueByName("retCode");
        
        if(retType=="chkUserStatus")
        {   	
        	var flag = packet.data.findValueByName("flag"); //用于判断伊春的密码是不是过于简单的标志
        	var passFlag = packet.data.findValueByName("passFlag");
	        if(flag=="1")
	        {
	        		if(passFlag=="1"){
	        			rdShowMessageDialog("业务规定：简单密码不允许办理业务，请修改后再办理!");
		            window.returnValue = "2";   
		            window.close();	        
		            return false;			
	        		}
							else{
								//将这个手机号验证信息放到session里面    	
		            window.returnValue = flag;   
		            window.close();
	          	}
	         }
	            
	        else{
	        	   //将这个手机号验证信息放到session里面
	        	   rdShowMessageDialog("用户密码错误，验证失败",1);
	        }
	        return true;
      }  
	 }


   function doCheck(obj)
	 { 	
	 			var passFlag = "0" //用于判断伊春的密码是不是过于简单的标志
    		//为伊春增加密码限制增加
      	if("09"=="<%=regionCode%>")
      	{ 
      		if(document.form1.user_passwd.value=="000000"||document.form1.user_passwd.value=="111111"
      		 ||document.form1.user_passwd.value=="222222"||document.form1.user_passwd.value=="333333"
      		 ||document.form1.user_passwd.value=="444444"||document.form1.user_passwd.value=="555555"
      		 ||document.form1.user_passwd.value=="666666"||document.form1.user_passwd.value=="777777"
      		 ||document.form1.user_passwd.value=="888888"||document.form1.user_passwd.value=="999999"
      		 ||document.form1.user_passwd.value=="123456")
      		 {
      		 	passFlag="1";
      		 }
      	}	 	
      	
      var caller= document.getElementById("cPhoneNo").value.trim();
			if(caller==""){
				rdShowMessageDialog("手机号不能为空！");
				document.getElementById("cPhoneNo").focus();
				return false;
			}	
			var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
			if(caller.search(patrn)==-1){
				rdShowMessageDialog("手机号格式不正确！");
				document.getElementById("cPhoneNo").focus();
				document.getElementById("cPhoneNo").value="";
				return false;
			}
			
			if(caller.indexOf("0")==0){
				caller = caller.substring(1,caller.length);
			}
			
      	windowOpener.document.getElementById("telNo_oth").value = document.all.hiPhoneNo.value;
		    var getInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/chkUserStatus.jsp","正在进行用户有效性验证,请稍候...");

        getInfoPacket.data.add("retType" ,     "chkUserStatus"  );
        getInfoPacket.data.add("verifyType" ,  document.all.validateType.value);
        getInfoPacket.data.add("verifyVal" ,   obj.value);
        getInfoPacket.data.add("validateVal" , "<%=validateVal%>");
        getInfoPacket.data.add("phoneNo" ,  document.getElementById("hiPhoneNo").value);
        getInfoPacket.data.add("passFlag" ,  passFlag);
        core.ajax.sendPacket(getInfoPacket);
		    getInfoPacket =null;
		
	}
		
		function ChgType()
		{
			 var validate_type = document.form1.validateType.value;
			 with(document.form1){
				 	if(validate_type=="0")
				 	{
				 		userPhone.style.display='';
				 		
				 		checkTypetr.style.display='';
				 		IccidTr.style.display='none';
				 		pactNoTr.style.display='none';
				 		document.getElementById("cPhoneNo").readOnly=false;
				 	}
				 	else if(validate_type=="1")
				 	    {
				 	    	userPhone.style.display='none';
						 		IccidTr.style.display='';
						 		pactNoTr.style.display='none';
						 		checkTypetr.style.display='none';
						 		document.getElementById("cPhoneNo").readOnly=true;
				 		}
				 	else
				 	 {
				 	 			userPhone.style.display='none';
						 		IccidTr.style.display='none';
						 		pactNoTr.style.display='';
						 		checkTypetr.style.display='none';
						 		document.getElementById("cPhoneNo").readOnly=false;
				 		}
			}
			
		}
 function ajaxGetCustId(phoneNo){
 	
 	var packet = new AJAXPacket("getCustIdh.jsp");
			packet.data.add("phoneNo" ,phoneNo);
			core.ajax.sendPacket(packet,doAjaxGetCustId);
			packet =null;
			return document.all.custIdHit.value;
 }
function doAjaxGetCustId(packet){
	document.all.custIdHit.value = packet.data.findValueByName("custId");	
}		
		function submitConfig(){
			//alert("进入验证函数submitConfig");
			var returnvalue="";
			
			var caller= document.getElementById("cPhoneNo").value.trim();
			if(caller==""){
				rdShowMessageDialog("手机号不能为空！");
				document.getElementById("cPhoneNo").focus();
				return false;
			}	
			var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
			if(caller.search(patrn)==-1){
				rdShowMessageDialog("手机号格式不正确！");
				document.getElementById("cPhoneNo").focus();
				document.getElementById("cPhoneNo").value="";
				return false;
			}
			
			
			if(caller.indexOf("0")==0){
				caller = caller.substring(1,caller.length);
			}
      windowOpener.document.getElementById("telNo_ps").value = "<%=activePhone%>";
      ajaxGetCustId(document.all.cPhoneNo.value);
      windowOpener.document.getElementById("telId_oth").value = document.all.custIdHit.value;
      windowOpener.document.getElementById("telNo_oth").value = document.all.cPhoneNo.value;
			var updflag=updateVerify();
			//alert("updflag|"+updflag+"\nretCode|"+retCode);
			if(updflag!=false && retCode!=''){
				
				//ivr数据入库 type = 2 by fangyuan 20090429
			  windowOpener.handleIVRData('3');
				windowOpener.cCcommonTool.checkPassword(caller);
				window.returnValue = "kf_ivr";   //转入ivr流程 关闭验证页面
		    window.close();
			}
		}
		
	function updateVerify(){
		//alert("updateVerify");
		 
			var len = document.getElementsByName("checkType").length;
	//type=0是本机验证；type=1是他机验证。
	var type=0;
	for(var i=0;i<len;i++){
		if(document.getElementsByName("checkType")[i].checked){
			type = document.getElementsByName("checkType")[i].value;
			//全局变量checkPwdType记录密码验证方式 定义见sitechcallcenter.js by fangyuan 20090427
			windowOpener.checkPwdType = type;
		}
	}
	
	
	windowOpener.document.getElementById("verifyTypec").value = type;
	
		var mycotactId = windowOpener.document.getElementById("contactId").value;
		if(mycotactId.length==0){
			return false;
		}else{
		  var urlStrl='<%=request.getContextPath()%>/npage/callbosspage/K086/updatePhoneCheck.jsp?type='+type+'&contactId='+mycotactId;
		  //alert("urlStrl|"+urlStrl);
			asyncGetText(urlStrl,doUpdate);  
			return true;
		}
}	

function doUpdate(packet){
	/*
	var retCode2 = packet.data.findValueByName("retCode");
	if(retCode2=='000000'){
	}
	*/
}
</script>


</html>
