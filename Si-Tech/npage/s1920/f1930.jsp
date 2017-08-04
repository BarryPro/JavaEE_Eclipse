<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.14
 模块:统一查询退订
********************/
%>
<%
/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2004-01-31
* revised : 2004-01-31
*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=gbk"%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>统一查询退订</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("activePhone");
    
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String login_passwd = (String)session.getAttribute("password");
	String ip_address = (String)session.getAttribute("ipAddr");
	String accountType = (String)session.getAttribute("accountType");
	String regionCode = (String)session.getAttribute("regCode");
		
%>
 	
<script language=javascript>

<!--
//定义应用全局的变量
var SUCC_CODE	= "0";   		//自己应用程序定义
var ERROR_CODE  = "1";			//自己应用程序定义
var YE_SUCC_CODE = "000000";		//根据营业系统定义而修改
var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头

onload=function()
{		
	getUserInfo();
}

//---------1------RPC处理函数------------------
function doProcess(packet){
	//使用RPC的时候,以下三个变量作为标准使用.
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	self.status="";
	if(verifyType=="phoneno"){
		if( parseInt(error_code) == 0 ){
			var custname= packet.data.findValueByName("custname");
			var runcode= packet.data.findValueByName("runcode");
			var brand=packet.data.findValueByName("brand");
			document.all.value201.value=blurring(custname);
			document.all.runname.value=runcode;
			document.form1.qryPage.disabled=false;
		}
		else{
			rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
			return false;
		}
	}
	
}


/**
 ** 模糊化客户姓名
 ** 规则：
 ** 两个字 第二个字 *
 ** 三个字 后两个字 *
 ** 四个字 前两个正常 后两个 **
 ** 四个字以上，前两个字正常，其他字 **
 ** hejwa 2017/3/20 星期一 10:02:45 
 **/
function blurring(custName){
	var ret_S = "";
	if(custName.length==2){
		ret_S = custName.substring(0,1)+"*";
	}
	
	if(custName.length==3){
		ret_S = custName.substring(0,1)+"**";
	}
	
	if(custName.length==4){
		ret_S = custName.substring(0,2)+"**";
	}
	
	if(custName.length>4){
		ret_S = custName.substring(0,2)+"******";
	}
	
	return ret_S;
}

//验证及提交函数
function doCfm()
{ 
	if(!check(document.form1))
	{
		document.form1.phoneNo.value = "";
		return false;
	}
	form1.action="f1930_info.jsp";
	form1.submit();
}

function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
        TempChar= InString.substring (Count, Count+1);
        if (RefString.indexOf (TempChar, 0)==-1)  
        return (false);
}
return (true);
}

function getUserInfo()
{
		
		if(document.form1.phoneNo.value.length<11 || isNumberString(document.form1.phoneNo.value,"1234567890")!=1) {
			rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
			document.form1.phoneNo.focus();
			return false;
		}
		else if (parseInt(document.form1.phoneNo.value.substring(0,2),10)!=15 &&parseInt(document.form1.phoneNo.value.substring(0,2),10)!=18 &&parseInt(document.form1.phoneNo.value.substring(0,2),10)!=14 && (parseInt(document.form1.phoneNo.value.substring(0,3),10)<134 || parseInt(document.form1.phoneNo.value.substring(0,3),10)>139)){
			rdShowMessageDialog("请输入134-139,或15,14,18开头的手机号码!!");
			document.form1.phoneNo.focus();
			return false;
		}
	
	  var myPacket = new AJAXPacket("f1920_rpc_check.jsp","正在确认，请稍候......");
	
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("phoneno",document.form1.phoneNo.value);
		    	    
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;	  	
	  		
	}
 
//-->
</script>
</head>
<body>
<form name="form1" method="POST">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

    <table cellspacing="0">
    <tr> 
      <td class="blue"><div>手机号码</div></td>
      <td colspan="3"> 
        <input type="text" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" maxlength="11" onKeyDown="if(event.keyCode==13)document.all.accountpassword.focus()" onKeyPress="return isKeyNumberdot(0)" readOnly>
      </td>
    </tr>                        
    <tr> 
      <td class="blue"><div>用户姓名</div></td>
      <td>
        <input type="hidden" class="InputGrey" readonly name="code201" value="201">
        <input type="text"  class="InputGrey" readonly name="value201" value="">
      </td>
      <td class="blue"><div>运行状态</div></td>
      <td>
        <input type="text" class="InputGrey" readonly name="runname" value="">
      </td>
    </tr> 
 	 <tr>
    	<td colspan="4" id="footer">
      	<div align="center">
          <input class="b_foot" type=button name=qryPage value="查询" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}" disabled>
          <input class="b_foot" type=button name=back value="清除" onClick="form1.reset()">
		  <input class="b_foot" type=button name=qryPage1 value="关闭" onClick="removeCurrentTab()">
        </div>
      </td>
    </tr>
  </table>
 
  <input name="org_code" type="hidden" value="<%=org_code%>">
  <input name="work_no" type="hidden" value="<%=work_no%>">
  <input name="login_passwd" type="hidden" value="<%=login_passwd%>">
  <input name="ip_address" type="hidden" value="<%=ip_address%>">
  <input name="loginName" type="hidden" value="<%=loginName%>">
    <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
