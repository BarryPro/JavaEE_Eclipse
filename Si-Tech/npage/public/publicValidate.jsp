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
<%
    String tilteName = WtcUtil.repNull(request.getParameter("titleName"));
    String validateVal = request.getParameter("valideVal")==null?"0":request.getParameter("valideVal");

    String opName = "公共验证页面";
    String opCode = WtcUtil.repNull(request.getParameter("opCode"));
    %>
    <script language="javaScript">
    if("q046"=="<%=opCode%>"){
    	window.returnValue = "1";   
    	window.close();
    }
    </script>
    <%
    String orgCode =(String)session.getAttribute("orgCode");
    String loginNo = (String)session.getAttribute("workNo");
    String noPass = (String)session.getAttribute("password");
    String regionCode = orgCode.substring(0,2);
    boolean isKd = false;
    System.out.println("gaopengSeeLogM058===opCode="+opCode);
    if("m058".equals(opCode)){
    %>
    <wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="2"  retcode="errCodeGetPhone" retmsg="errMsgGetPhone">
			<wtc:param  value="0"/>
			<wtc:param  value="01"/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=loginNo%>"/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=activePhone%>"/>
	  </wtc:service>
  	<wtc:array id="list" scope="end"/>
    <%
    	System.out.println("gaopengSeeLogM058===errCodeGetPhone="+errCodeGetPhone);
    	if("000000".equals(errCodeGetPhone) && list.length >0){
				
				String cmfLogin = list[0][1];
				if(!"".equals(cmfLogin)){
					/*说明输入的是宽带对应的手机号码*/
					activePhone = activePhone;
				}else{
					activePhone = list[0][0];
				}
				isKd = true;
				System.out.println("==gaopengSeeLogM058= isKd =22222=="+isKd);
				System.out.println("==gaopengSeeLogM058= activePhone =22222=="+activePhone);
			}
		}
    String randomPhoneMsgOpcodeSql = "select function_code from sRanDomConTrol";
    System.out.println("gaopengSeeLogPubC==========randomPhoneMsgOpcodeSql=="+randomPhoneMsgOpcodeSql);
		String pubGetChannelSql = "select count(1)"
		+" from dchngroupmsg t, dloginmsg t2"
		+" where 1 = 1"
		+" and t.class_code in (select a.class_code"
		+" from schnclassinfo a, schnclassmsg b"
		+" where parent_class_code = '7'"
		+" and a.class_code = b.class_code)"
		+" and t.group_id = t2.group_id"
		+" and t.is_active = 'Y'"
		+" and t2.login_no = '"+loginNo+"'";
		/*1220不区分，全是随机密码验证*/
		String channelHide = "FALSE";
		
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />


    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=orgCode%>" retcode="rpmCode" retmsg="rpmMsg" outnum="1">			
	    <wtc:param value="<%=randomPhoneMsgOpcodeSql%>"/>	
		</wtc:service>
		<wtc:array id="rpmResult" scope="end"/>
<%
	if("1220".equals(opCode)){
		System.out.println("gaopengSeeLog=============channelHide===1220");
%>			
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=orgCode%>" retcode="channelCode" retmsg="channelMsg" outnum="1">			
	    <wtc:param value="<%=pubGetChannelSql%>"/>	
		</wtc:service>
		<wtc:array id="channelResult" scope="end"/>
<%
	if(channelResult.length > 0 && "000000".equals(channelCode)){
		if(!"0".equals(channelResult[0][0])){
			channelHide = "TRUE";
			System.out.println("gaopengSeeLog=============channelHide="+channelHide);
		}
	}
	System.out.println("gaopengSeeLog=============channelHide==="+channelHide);
}

System.out.println("gaopengSeeLog=============channelHide==="+channelHide);
	String  inputParsm [] = new String[17];
	inputParsm[0] = sysAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = noPass;
	inputParsm[5] = activePhone;
	inputParsm[6] = "";
	inputParsm[7] = "查询密码验证配置";
	
	String vFlag = "";
	String vPwdValiMod = "";
	

%>	    
	<wtc:service name="sPwsValiCfgQry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodePws" retmsg="retMsgPws" outnum="3">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
		</wtc:service>
		<wtc:array id="infoRetPws"   scope="end"/>
<%
	if("000000".equals(retCodePws) && infoRetPws.length > 0){
		vFlag = infoRetPws[0][0];
		vPwdValiMod = infoRetPws[0][1];
	}else if("m26303".equals(retCodePws)){
		vFlag = "N";
	}else{
		
	}
	System.out.println("gaopengSeeLog1451===========vFlag==="+vFlag+"---vPwdValiMod="+vPwdValiMod);


/*
 *  hejwa 2015年7月16日14:49:43
 *  关于实名登记业务增加随机验证码验证功能的函
 *
 *  1）如果客户姓名中包含“临时”、“代办”、“校园卡”，并且手机号码的运行状态不是pp，
 *  则只支持随机码验证。其他情况，只支持服务密码验证。
 */
 String m058_sPwdAuthChk_flag = "";
 
if("m058".equals(opCode)){
	String  inputParsm1 [] = new String[8];
	inputParsm1[0] = sysAccept;
	inputParsm1[1] = "01";
	inputParsm1[2] = opCode;
	inputParsm1[3] = loginNo;
	inputParsm1[4] = noPass;
	inputParsm1[5] = activePhone;
	inputParsm1[6] = "";
	inputParsm1[7] = "查询密码验证配置";
	
%>

	<wtc:service name="sPwdAuthChk" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCodePws" retmsg="retMsgPws" outnum="1">
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
		<wtc:param value="<%=inputParsm1[5]%>"/>
		<wtc:param value="<%=inputParsm1[6]%>"/>
		<wtc:param value="<%=inputParsm1[7]%>"/>
		</wtc:service>
	  <wtc:array id="svr_restlt"   scope="end"/>

<%
	if(svr_restlt.length>0){
		m058_sPwdAuthChk_flag = svr_restlt[0][0];
	}
}

System.out.println("--------------m058_sPwdAuthChk_flag-------------->"+m058_sPwdAuthChk_flag);
%>					
<html>
<head> 
<title><%=tilteName%></title>
</head>
<script language="javaScript">
		onload = function()
		{
			
			ChgType();
		}
		
	 function doProcess(packet)
	 {
        var retType = packet.data.findValueByName("retType");
        var flag = packet.data.findValueByName("flag");
        var retMsg = packet.data.findValueByName("retMsg"); //yuanqs add 100823 密码验证改造
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
	            	window.returnValue = flag;   
	            	window.close();
          		}
	         }
	            
	        else {
	        	   rdShowMessageDialog(retMsg,1); //yuanqs add 100823 密码验证改造
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
		if(document.all.user_passwd.value.length < 6 && document.all.validateType.value == 0)
		{
			rdShowMessageDialog("密码不能少于6位！");
			document.all.user_passwd.focus();
			return false;
		}
		    var getInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/chkUserStatus.jsp","正在进行用户有效性验证,请稍候...");

        getInfoPacket.data.add("retType" ,     "chkUserStatus"  );
        getInfoPacket.data.add("verifyType" ,  document.all.validateType.value);
        getInfoPacket.data.add("verifyVal" ,   obj.value);
        getInfoPacket.data.add("validateVal" , "<%=validateVal%>");
        getInfoPacket.data.add("opCode" ,  "<%=opCode%>");
        getInfoPacket.data.add("phoneNo" ,  "<%=activePhone%>");
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
				 		usePwdTr.style.display='';
				 		IccidTr.style.display='none';
				 		randomPwdTr.style.display='none';
				 		user_passwd.select();
				 	}
				 	else if(validate_type=="1")
				 	    {
				 				usePwdTr.style.display='none';
				 				IccidTr.style.display='';
				 				randomPwdTr.style.display='none';
				 				idCardNo.select();
				 		}else if(validate_type=="3"){
				 			window.returnValue = "1";   
		    			window.close();	
				 		}
				 	else if(validate_type=="2")
				 	 {
				 	    var getRandomMsgPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/getRandomMsg.jsp","正在获得短信随机码,请稍候...");
                        getRandomMsgPacket.data.add("opCode" ,  "<%=opCode%>");
                        getRandomMsgPacket.data.add("phoneNo" ,  "<%=activePhone%>");
                        core.ajax.sendPacket(getRandomMsgPacket, doAfterGetRandomMsg);
                		getRandomMsgPacket =null;
                		
				 				usePwdTr.style.display='none';
				 				IccidTr.style.display='none';
				 				randomPwdTr.style.display='';
				 				randomPwd.select();
				 		}else{
				 			rdShowMessageDialog("获取验证方式失败！");
				 			
				 			window.returnValue = "0";   
		    			window.close();
				 		}
			}
		}
		
		function doAfterGetRandomMsg(packet){
		    var retCode = packet.data.findValueByName("retCode");
		    if(retCode == '000000'){
		        rdShowMessageDialog("短信验证码已发送，10分钟内有效！");
		    } else {
		        rdShowMessageDialog("短信验证码发送失败！" + retCode);
		    }
		}
</script>
<body>
<form name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi"><%=tilteName%></div></div>
   <table  cellspacing="0">
   	  <tr>
   	   	<td class="blue">服务号码</td>
				<td class="blue" colspan="3"><%=activePhone%></td>		
			</tr>
   	  <tr>
   	   	<td class="blue">验证类型</td>
   	   	<td class="blue">
   		  	<select name="validateType" id="validateType" onChange="ChgType()" size="1" >
   		  	<%if("N".equals(vFlag)){
   		  	
   		  	
   		  	if("m058".equals(opCode)){
   		  		/*如果是宽带号码进入的 只有密码*/
   		  		if(isKd){
   		  			%>
   		  			<option value="0">用户密码</option>
   		  			<%
   		  			
   		  		}
   		  		else if("1".equals(m058_sPwdAuthChk_flag)){
   		  	%>
   		  		<option value="0">用户密码</option>
   		  		<option value="2">短信随机密码</option>
   		  	<%	
   		  		}else{
   		  	%>
   		  		<option value="0">用户密码</option>
   		  	<%
   		  		}
   		  	}else{
   		  	%>
   		  		
   		  	
				  <%
				  /*不是1220的 支持密码验证*/
				  if(!"1220".equals(opCode)){%>
				  	<option value="0">用户密码</option>
				  <%}%>
					<%
					System.out.println("gaopengSeeLog==========rpmCode=="+rpmCode);
					    if ("000000".equals(rpmCode)){
					        for (int i = 0; i < rpmResult.length; i++){
					            if (opCode.equals(rpmResult[i][0])){
					%>            	  	<option value="2">短信随机密码</option>
					<%          }
					        }
					    }
			    }
			    }
					%>
					
				  <%
				  /*2015/06/03 10:10:33 gaopeng 如果查询为Y则走新规则*/
				  if("Y".equals(vFlag)){
				  %>
				  	<%if("0".equals(vPwdValiMod)){%>
				  		<option value="0">用户密码</option>
				  	<%}%>
				  	<%if("1".equals(vPwdValiMod)){%>
				  		<option value="2">短信随机密码</option>
				  	<%}%>
				  	<%if("2".equals(vPwdValiMod)){%>
				  		<option value="0">用户密码</option>
				  		<option value="2">短信随机密码</option>
				  	<%}%>
				  	<%if("3".equals(vPwdValiMod)){%>
				  		<option value="3">不验证</option>
				  	<%}%>
				  	
				  <%}%>	
					</select>
				</td>
			<tr id="usePwdTr">	
				<td class="blue">用户密码</td>
				<td class="blue">			
				<!--<input type="password" name="user_passwd" v_type="0_9" onKeyPress="return isKeyNumberdot(0)" id="user_passwd" v_must="1" onBlur="checkElement(this)" pwdlength="6" maxlength="6"  onkeyDown="if(event.keyCode==13)doCheck(document.all.user_passwd)" > -->
					 <jsp:include page="/npage/common/pwd_9.jsp">
              <jsp:param name="width1" value=""  />
	            <jsp:param name="width2" value=""  />
	            <jsp:param name="pname" value="user_passwd"  />
	            <jsp:param name="pwd" value="<%=123456%>"  />
           </jsp:include>
					 	<input name="ChkPwdBtn" type="button" class="b_text" onClick="doCheck(document.all.user_passwd)"value="验证">
           	<font class="orange">*</font>
				</td>
			</tr>
			<tr id="IccidTr">
				<td class="blue">身份证号</td>
				<td class="blue">			
				<!--<input type="text" name="idCardNo" id="idCardNo" v_must="1"  v_type="idcard" onBlur="checkElement(this)" maxlength="18" onkeyDown="if(event.keyCode==13)doCheck(document.all.user_passwd)" > 	-->
					 <jsp:include page="/npage/common/pwd_9.jsp">
              <jsp:param name="width1" value=""  />
	            <jsp:param name="width2" value=""  />
	            <jsp:param name="pname" value="idCardNo"  />
	            <jsp:param name="pwd" value="<%=123456%>"  />
           </jsp:include>
					 	<input name="ChkPwdBtn" type="button" class="b_text" onClick="doCheck(document.all.idCardNo)" value="验证">
           	<font class="orange">*</font>
				</td>
			</tr>
			<tr id="randomPwdTr">
				<td class="blue">随机密码</td>
				<td class="blue">			
				<!--<input type="password" name="randomPwd" id="randomPwd" v_must="1" v_type="0_9" onKeyPress="return isKeyNumberdot(0)"  pwdlength="6" onBlur="checkElement(this)" maxlength="6" onkeyDown="if(event.keyCode==13)doCheck(document.all.user_passwd)" > 	-->
					 <jsp:include page="/npage/common/pwd_9.jsp">
              <jsp:param name="width1" value=""  />
	            <jsp:param name="width2" value=""  />
	            <jsp:param name="pname" value="randomPwd"  />
	            <jsp:param name="pwd" value="<%=123456%>"  />
           </jsp:include>
					 	<input name="ChkPwdBtn" type="button" class="b_text" onClick="doCheck(document.all.randomPwd)" value="验证">
           	<font class="orange">*</font>
				</td>
			</tr>
   </table>
   <!--由于在密码小键盘不需要注意事项提醒，故把引入头尾文件样式写死-->
  </DIV>
</DIV>
 <!--由于在密码小键盘不需要注意事项提醒，故把引入头尾文件样式写死-->
<%@ include file="/npage/common/pwd_comm.jsp" %>
 </form>
</body>
</html>
