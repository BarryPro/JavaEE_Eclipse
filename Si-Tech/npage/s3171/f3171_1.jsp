<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-18 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");		
	
	String workNo = (String)session.getAttribute("workNo");	
	String loginPass  = (String)session.getAttribute("password");
%>

<html>
<head>
<title><%=opName%></title>
<script language=javascript>
	
	function fsubmit1() //提交
	{
		getAfterPrompt();
		document.all.idCard.v_must="";
		document.all.idCard.v_name="";
		document.all.idCard.v_type="";
		if(!check(document.form1)) return false;
		
		if(document.all.contractPay.value==document.all.contractPay2.value){
			rdShowMessageDialog('支付帐号和被支付帐号不能相同,请重新输入!');
			return false;
		}	
		
		if(!forDate(document.all.beginDate)) return false;		
		
		if(!forDate(document.all.endDate)) return false;		
		
		if(parseInt(document.form1.beginDate.value) > parseInt(document.form1.endDate.value))
		{
			rdShowMessageDialog("结束日期应大于开始日期!",0);
			return false;
		}	
		document.all.bSubmit1.disabled=true;//huangrong add for 	防止二次确认 申告：hrbd 关于一点支付3171模块出现两次重复被支付账号的故障处理申告   2011-7-28 13:58
		document.form1.action="f3171_submit.jsp";  
		document.form1.submit();
	}
	
	//检测:只能输入数字
	function isKeyNumberdot(ifdot) 
	{       
	    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
		if(ifdot==0)
			if(s_keycode>=48 && s_keycode<=57)
				return true;
			else 
				return false;
	    else
	    {
			if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
			{
			      return true;
			}
			else if(s_keycode==45)
			{
			    rdShowMessageDialog('不允许输入负值,请重新输入!');
			    return false;
			}
			else
				  return false;
	    }       
	}	
	//检测end
	
	
	/************************** 调用公共界面，查询支付帐户   begin *******************/
	function queryAccount()
	{		
		document.all.idCard.v_must="1";
		document.all.idCard.v_name="证件号码";
		document.all.idCard.v_type="idcard";
		var pageTitle = "支付帐户信息";
		var fieldName = "帐号|帐户名称|";
		var sqlStr = "";
	    	var selType = "S";    //'S'单选；'M'多选
	    	var retQuence = "2|0|1|";
	    	var retToField = "contractPay|accountName|";		    	
	    	if(pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));	
	 
	}
	
	function pubSimpSelAccount(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{	    
	    var path = "f3171_account_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType+"&idCard="+document.all.idCard.value;
	    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	    return true;
	}
	
	function getvalueAccount(retInfo)
	{
	    var retToField = "contractPay|accountName|";
	    if(retInfo ==undefined)      
	    {   return false;   }
	
			var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");	        
	    }    			
	}
	// 调用公共界面，查询支付帐户   end 
	
	
	onload=function()
	{
		
	}

	//---------------------------获取rpc返回的用户信息--------------------------------
	function doProcess(myPacket)
	{
		var errCode    = myPacket.data.findValueByName("errCode");
		var retMessage = myPacket.data.findValueByName("errMsg");//声明返回的信息		
		var retFlag    = myPacket.data.findValueByName("retFlag");	
		
 		self.status="";
		//操作成功
		
		if (errCode==000000)
		{
				var num = myPacket.data.findValueByName("num");
				if(num=="0"){
					rdShowMessageDialog("该帐户不符合条件！请重新输入！",0);	
				}
				else{
					rdShowMessageDialog("验证成功！",2);	
					if(retFlag=="1"){
						document.all.checkButt2.disabled=false;
					}
					else if(retFlag=="2"){
						document.all.bSubmit1.disabled=false;
					}
				}
		}
		
		//-----如果返回错误代码-----
		if(errCode!=000000)
		{
			rdShowMessageDialog(retMessage,0);	
		}		
	}
	
	function changePay(){
		document.all.checkButt2.disabled=true;
		document.all.bSubmit1.disabled=true;
	}
	
	function changePay2(){
		document.all.bSubmit1.disabled=true;
	}
	
	
	/************************** 调用公共界面，查询被支付帐户信息   begin *******************/
	function queryAccount2()
	{	    	    
		document.all.idCard.v_must="1";
		document.all.idCard.v_name="证件号码";
		document.all.idCard.v_type="idcard";	
		var pageTitle = "被支付帐户信息";
		var fieldName = "帐号|帐户名称|";
		var sqlStr = "";
		    var selType = "S";    //'S'单选；'M'多选
		    var retQuence = "2|0|1|";
		    var retToField = "contractPay2|accountName2|";
		    var contractPay2 = document.form1.contractPay2.value;	
		    if(pubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		  //}
	}

	function pubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{	    
	    var path = "f3171_account2_sel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType+"&idCard="+document.all.idCard.value;
	
	    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
		return true;
	}
	
	function getvaluecust(retInfo)
	{
	    var retToField = "contractPay2|accountName2|";
	    if(retInfo ==undefined)      
	    {   return false;   }
	
			var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");	        
	    }
	}
	//调用公共界面，查询被支付帐户信息   end 
	
	
	function cancelAccount1() //清除支付帐户信息
	{
		document.all.contractPay.value = "";
		document.all.contractPay1.value = "";
		document.all.accountAttr.value = "";
		document.all.levelNum.value = "";
		document.all.ECID.value = "";
		document.all.contractPay2.value = "";
		document.all.queryButt.disabled = false;
		document.all.queryButt.style.cursor = "hand";
		document.all.queryAccountMsgButt.disabled = true;
		document.all.queryAccountMsgButt.style.cursor = "";					
	}
	
	function cancelAccount2() //清除被支付帐号
	{
		if (document.all.contractPay2.value != "")
		{
			document.all.contractPay2.value = "";
		}		
	}
	
	function changeFlag(){
		if(document.all.allFlag.value=="1"){
			document.all.line_111.style.display="none";
			document.all.cycleMoney.value="0";
		}
		else{
			document.all.line_111.style.display="";
			document.all.cycleMoney.value="";
		}
	}
	
	function checkAccount(){
		if(!forNonNegInt(document.all.contractPay)){
			return false;
		}
		var contractPay=document.all.contractPay.value;
		var myPacket = new AJAXPacket("f3171_account_rpc.jsp","正在验证帐户信息，请稍候......");		
		myPacket.data.add("contractPay",contractPay);	
		core.ajax.sendPacket(myPacket);
		delete(myPacket);myPacket=null;
	}
	
	function checkAccount2(){
		if(!forNonNegInt(document.all.contractPay2)){
			return false;
		}
		var contractPay2=document.all.contractPay2.value;
		var myPacket = new AJAXPacket("f3171_account_rpc2.jsp","正在验证帐户信息，请稍候......");		
		myPacket.data.add("contractPay2",contractPay2);	
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	
	
</script>
</head> 
<body>
<form name="form1" method="post" action="">
	<input type="hidden" name="workNo" value="<%=workNo%>">
	<input type="hidden" name="loginPass" value="<%=loginPass%>">	
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>	
     	<TABLE  id="mainOne" cellspacing="0">
          <TBODY>
          	<TR id="line_1"> 
			<TD class="blue">证件号码</TD>
	            	<TD colspan="3">
	              		<input type="text"  v_must="1"  name="idCard" maxlength="18">&nbsp;&nbsp;
	              		<input type="button"  style="cursor:hand" class="b_text" name="queryButt"  value="查询支付帐户" onClick="queryAccount()">
	              		&nbsp;&nbsp;
	              		<input type="button" name="queryButt2" class="b_text" value="查询被支付帐户" onClick="queryAccount2()" >	              	
	            	</TD>
	        </TR>
        	<TR id="line_1"> 
			<TD   class="blue">支付帐号</TD>
	            	<TD colspan="3" >
		              	<input type="text"  v_type="0_9"  v_must="1" v_minlength="11" v_maxlength="14"  name="contractPay" maxlength="14" onchange="changePay()">&nbsp;<font class="orange">*</font>
		              	<input type="button"  style="cursor:hand" name="checkButt" class="b_text" value="验证" onClick="checkAccount()">
		              	<input type="hidden" name="accountName">
	            	</TD>	                       	              
          	</TR>
     
          	 <TR id="line_1"> 
				<TD class="blue" >被支付帐号</TD>
				<TD colspan=3 >
					<input type="text"   v_type="0_9"  v_must="1" v_minlength="11" v_maxlength="14"   name="contractPay2" maxlength="14" onchange="changePay2()">&nbsp;<font class="orange">*</font>
					<input type="button"  style="cursor:hand" name="checkButt2"  class="b_text" value="验证" onClick="checkAccount2()" disabled >
					<input type="hidden" name="accountName2">
				</TD>  	              
            </TR>  
            
           <TR  id="line_1"> 		  
             <TD  class="blue"  >支付顺序</TD>
	            <TD colspan=3 >
	            <input type="text"  v_type="int"  v_must="1" v_minlength="1" v_maxlength="10" v_name="支付顺序"  name="payOrder" maxlength="10">&nbsp;<font color="orange">*</font>
	              	(支付顺序不允许重复，如想修改支付顺序，请在支付关系<br>
	              	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	              	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;建立后使用"账户关系维护"功能进行修改)
	            </TD> 
	          </TR>           
         	
            <TR id="line_1"> 		
		     	<TD   class="blue">全额标志</TD>
	            	<TD  colspan=3>	              	
		            	<select name="allFlag" onchange="changeFlag()">	            		
		              		<option value="0">定额交费</option>
		              		<option value="1">全额交费</option>
		              	</select>&nbsp;
		              	<font class="orange">*</font>
	            	</TD>
	          </TR> 
	         <TR id="line_111">    	              
	            		<TD  class="blue">定额金额</TD>
	            		<TD  colspan=3>  
	            			<input type="text"  v_type="money"  v_must="1" v_minlength="1" v_maxlength="14"  name="cycleMoney" maxlength="14">
	            			<font class="orange">*</font>
	           		 </TD>
	         </TR>	         
	         <TR id="line_1"> 
				<TD class="blue">开始日期</TD>
		           	<TD>
		              		<input type="text" v_type="date" name="beginDate" v_format="yyyymmdd" maxlength="8">&nbsp;(格式:yyyymmdd)&nbsp;
		              		<font class="orange">*</font>            	
		            	</TD> 			
			    	<TD class="blue">结束日期</TD>
	            		<TD>
	              			<input type="text"  v_type="date" name="endDate" v_format="yyyymmdd" maxlength="8">&nbsp;(格式:yyyymmdd)&nbsp;
	              			<font class="orange">*</font>  
	            		</TD> 		            	              
	         </TR>
          </TBODY>
          
        </TABLE> 
	<TABLE cellspacing="0" >
		<TR>
		       <TD id="footer"> 
		        	<input name="bSubmit1" style="cursor:hand" class="b_foot" type="button" value="确认" onClick="fsubmit1()" disabled >
		         	&nbsp;
		         	<input name="cancel" style="cursor:hand" class="b_foot" type="button" value="重置"  onClick="javascript:window.location.reload();">
		         	&nbsp; 
		         	<input name="" style="cursor:hand" class="b_foot" type="button" value="关闭" onClick="removeCurrentTab()">
		         	&nbsp; 		         	     	         	   
			</TD>
		</TR>
	</TABLE>	
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
