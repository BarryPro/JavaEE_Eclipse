<%
  /*
   * 功能: 呼出
　 * 版本: 1.1.0
　 * 日期: 
　 * 作者: 
　 * 版权: 
   * update: libin 修改服务号码验证，服务号码只能为数字，其他不需要校验
　 */
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<%@page contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
<title>呼出软键盘</title>
<style>
body
{
	margin:0;
	padding:0;
	font:12px Verdana, Arial, Helvetica, sans-serif,"宋体"，"黑体";
	line-height:1.8em;
	text-align:left;
	color:#003399;
	background-color: #eef2f7;
}
.outBorder table
{
	table-layout:fixed;
	border-collapse:collapse;
	border-spacing:0;
}
.outBorder .rightDiv table th
{
	font-weight:normal;
	text-align:left;
	width:100px;
}
.outBorder
{
	border:1px solid #555;
	width:400px;
	height:1%;
	font-size:12px;
}
.outBorder .leftDiv
{
	width:174px;
	float:left;
	padding-bottom:14px;
	padding-right:14px;
	background:#f5f5f5;
	border-right:1px solid #999;
}
.outBorder .rightDiv
{
	width:208px;
	float:right;
	padding-top:40px;
}
.outBorder .leftDiv  td
{
	padding:14px 0 0 14px;
}
.outBorder .leftDiv  td img
{
	cursor:pointer;
}
.outBorder .rightDiv td
{
	text-align:left;
	padding:10px 0; 
}
</style>
<script type="text/javascript">
function smallKeyboard()
{
	var hang_up=document.getElementById("hangUp");
	var clean_up=document.getElementById("cleanUp");
	var call_out=document.getElementById("callOut");
	var num_01=document.getElementById("number_1");
	var num_02=document.getElementById("number_2");
	var num_03=document.getElementById("number_3");
	var num_04=document.getElementById("number_4");
	var num_05=document.getElementById("number_5");
	var num_06=document.getElementById("number_6");
	var num_07=document.getElementById("number_7");
	var num_08=document.getElementById("number_8");
	var num_09=document.getElementById("number_9");
	var num_00=document.getElementById("number_0");
	var asterisk_num=document.getElementById("asterisk");
	var well_num=document.getElementById("well");
	//edit by hanjc 20090305 begin
	var callOutNum=document.getElementById("callOutNum");
	var call_on_num=document.getElementById("callOnNum");
	var chk_department=document.getElementById("chkDepartment");
	var btn_submit=document.getElementById("btnSubmit");
	var btn_cancel=document.getElementById("btnCancel");
	var arr_num;
	/**callOutNum.onfocus=function()
	{
		callOutNum.value="";
		arr_num="";
		}
		*/
	//arr_num=callOutNum.value;
	num_01.onclick=function()
	{
      arr_num=callOutNum.value;
       if(arr_num.length<12){
		  arr_num=arr_num+"1";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_02.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"2";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_03.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"3";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_04.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"4";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_05.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"5";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_06.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"6";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_07.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"7";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_08.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"8";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_09.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"9";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	num_00.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"0";
		  callOutNum.value=arr_num;
	    }
	    document.getElementById("callOutNum").focus();
		}
	asterisk_num.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"*";
		  callOutNum.value=arr_num;
	    }
		}
	well_num.onclick=function()
	{
      arr_num=callOutNum.value;		
       if(arr_num.length<12){
		  arr_num=arr_num+"#";
		  callOutNum.value=arr_num;
	    }
		}
//edit by hanjc 20090305 end
}
window.onload=function(){
	smallKeyboard();
	document.getElementById("callOutNum").focus();
}

function checkIt(){
	if(!document.getElementById("out_phone").value == ""){
		//alert("呼出号码不为空!");
		document.getElementById("callOutNum").value = document.getElementById("out_phone").value;
		//alert("要呼出的号码是 ："+document.getElementById("out_phone").value);
	}
	var phoneNo=document.getElementById("callOutNum").value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("外呼号码不能为空,请重新输入!",1);
		document.getElementById("callOutNum").focus();
		return false;
	}else if(!(/^(\d)+$/.test(phoneNo))){
		
		rdShowMessageDialog("只能输入数字,请重新输入!",1);
		document.getElementById("callOutNum").value="";
		document.getElementById("callOutNum").focus();
		return false;
	}
}
function trim(s) {
	 return s.replace( /\s*$/, "");

	 }
function callOut(){
  
	if(!document.getElementById("out_phone").value == ""){
		//alert("呼出号码不为空!");
		document.getElementById("callOutNum").value = document.getElementById("out_phone").value;
		//alert("要呼出的号码是 ："+document.getElementById("out_phone").value);
	}
	var phoneNo1=document.getElementById("callOutNum").value;
	var phoneNo=trim(phoneNo1);
	if(phoneNo=="")
	{
		rdShowMessageDialog("外呼号码不能为空,请重新输入!",1);
		document.getElementById("callOutNum").focus();
		return false;
	}else if(!(/^(\d)+$/.test(phoneNo))){
		
		rdShowMessageDialog("只能输入数字,请重新输入!",1);
		document.getElementById("callOutNum").value="";
		document.getElementById("callOutNum").focus();
		return false;
	}
/*****begin****符号好吗注释掉其他校验  by libin 2009-03-16
	}else{
		var valid=false;
		var valid1 = /[1]{1}\d{10}/.test(phoneNo);
		var valid2 = /^(0[\d]{2,3})?\d{6,8}$/.test(phoneNo);
		    valid = valid1|valid2;
		if(!valid){
			rdShowMessageDialog("服务号码不正确,请重新输入!",1);
			document.getElementById("callOutNum").value="";
			document.getElementById("callOutNum").focus();
			return false;	
		}	
	}
******end*****/
  //chengh 在被呼叫手机未能响时，座席能挂机释放
  window.opener.buttonType("K025");
	//window.opener.cCcommonTool.setCaller(document.getElementById("caller_phone").value);
	//window.opener.cCcommonTool.setCalled(document.getElementById("callOutNum").value);
window.opener.callOutcaller=document.getElementById("caller_phone").value;
window.opener.callOutcalled=document.getElementById("callOutNum").value;
	var ret = window.opener.cCcommonTool.CallOutEx();
	// add by fangyuan 增加操作成功后的状态与按钮明暗控制
		  //lijin 090311
	  //window.opener.inFlag=1;
	  //tancf 20090315呼出成功后明暗关系
		//window.opener.buttonType("K025");
    window.opener.cCcommonTool.setOp_code("K025");
	if(ret ==0){

	}
	window.close();
}
	
function callCancel(){
	window.close();
}

function hangup(){

}

function cleanUp(){
	document.getElementById("callOutNum").value = "";
	//fengliang 新增 20081217
	smallKeyboard();
}
//xiaofh090805 添加呼出号码默认为上一次主叫号码
/*window.onload=function()
	{
 
 
 if(window.opener.cCcommonTool.getCalled() != "" && (window.opener.cCcommonTool.getCalled().indexOf('10086')==0 ||window.opener.cCcommonTool.getCalled().indexOf('12580')==4))
	 {	 
		document.getElementById("callOutNum").value=window.opener.cCcommonTool.getCaller();
	 }
 
	}*/
 
</script>
</head>
<body onkeyDown="if(event.keyCode==13)callOut()">
<div class="outBorder" style="margin: 0;padding: 0;width: 100%;height: 100%;">
<div class="leftDiv">

<table>
	<tr>
		<td><img src="images/ico_10.gif" alt="挂断" id="hangUp"
			onclick="hangup()" /></td>
		<td><img src="images/ico_11.gif" alt="清空" id="cleanUp "
			onclick="cleanUp()" /></td>
		<td><img src="images/ico_12.gif" alt="呼出" id="callOut"
			onclick="callOut()" /></td>
	</tr>
	<tr>
		<td><img src="images/ico_01.gif" height="35"  width="35" alt="1" id="number_1" /></td>
		<td><img src="images/ico_02.gif" height="35"  width="35" alt="2" id="number_2" /></td>
		<td><img src="images/ico_03.gif" height="35"  width="35" alt="3" id="number_3" /></td>
	</tr>
	<tr>
		<td><img src="images/ico_04.gif" height="35"  width="35" alt="3" id="number_4" /></td>
		<td><img src="images/ico_05.gif" height="35"  width="35" alt="4" id="number_5" /></td>
		<td><img src="images/ico_06.gif" height="35"  width="35" alt="5" id="number_6" /></td>
	</tr>
	<tr>
		<td><img src="images/ico_07.gif" height="35"  width="35" alt="7" id="number_7" /></td>
		<td><img src="images/ico_08.gif" height="35"  width="35" alt="8" id="number_8" /></td>
		<td><img src="images/ico_09.gif" height="35"  width="35" alt="9" id="number_9" /></td>
	</tr>
	<tr>
		<td><img src="images/ico_13.gif" height="35"  width="35" alt="*" id="asterisk" /></td>
		<td><img src="images/ico_00.gif" height="35"  width="35" alt="0" id="number_0" /></td>
		<td><img src="images/ico_14.gif" height="35"  width="35" alt="#" id="well" /></td>
	</tr>
</table>
</div>
<div class="rightDiv">
<table>
	<tr>
		<td nowrap>呼出号码:</td>
		<td><input name="" type="text" size="13" id="callOutNum"
			maxlength="15" onchange="checkIt()" /></td>
	</tr>
	<tr>
		<%String sqlStr = "SELECT caller_call_out_phone FROM dCallerCalloutPhone where OUTFLAG = 'Y'";
		  /*midify by guozw 20091114 公共查询服务替换*/
		 String myParams="";
		 String org_code = (String)session.getAttribute("orgCode");
		 String regionCode = org_code.substring(0,2);
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:param value="<%=sqlStr%>" />
		</wtc:service>
		<wtc:array id="rows" scope="end" />
		<td nowrap>职能部门:</td>
		<td><select name="out_phone" id="out_phone" style="width: 100px;"/>
			<option value="">- 请选择 -</option>
			<%for (int i = 0; i < rows.length; i++) {%>
			<option value="<%=rows[i][0]%>"><%=rows[i][0]%></option>
			<%}%>
		</select></td>
	</tr>

	<tr>
		<%String sqlTemp = "SELECT caller_call_out_phone FROM dCallerCalloutPhone WHERE OUTFLAG = 'N'";
		%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
			<wtc:param value="<%=sqlTemp%>" />
		</wtc:service>
		<wtc:array id="rows" scope="end" />
		<td nowrap>主叫号码:</td>
		<td><select name="caller_phone" id="caller_phone" style="width: 100px;"/>
			<%for (int i = 0; i < rows.length; i++) {
			%>
			<option value="<%=rows[i][0]%>"><%=rows[i][0]%></option>
			<%}%>
		</select></td>
	</tr>
	<tr>
		<td colspan="2">
		<input name="" class="b_foot" type="button"
			value="确认" id="btnSubmit" onClick="callOut()" /> 
		<input name=""
			class="b_foot" type="button" value="取消" id="btnCancel"
			onClick="callCancel()" /></td>
	</tr>
</table>
</div>
</div>
</body>
</html>
