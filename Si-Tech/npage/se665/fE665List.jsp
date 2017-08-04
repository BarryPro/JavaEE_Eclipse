<%
/***************************************
***	version v1.0
***	开发商: si-tech
***	作	者：zhangyan
***	日	期：2012/2/29 15:48:50
***************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<%
String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
String opName = WtcUtil.repStr(request.getParameter("opName"), "");
String regCode= WtcUtil.repNull((String)session.getAttribute("regCode"));
String workNo	= WtcUtil.repNull((String)session.getAttribute("workNo"));
String unitId	= request.getParameter("unitId");

ArrayList arr 			= (ArrayList)session.getAttribute("allArr");
String[][] baseInfo = (String[][])arr.get(0);
String disCode			= baseInfo[0][16].substring(2,4);
%>
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
var selOpType="1";/*操作类型全局变量操作类型1：新增，2：修改，3：解除*/

function getBankCode()
{

		var tableHeads		="银行代码|银行名称";
		var path			="<%=request.getContextPath()%>"
			+"/npage/se665/fE665BankCodeSel.jsp"
			+"?tableHeads="	+tableHeads
			+"&bankName="		+document.getElementById("bankName").value
			+"&disCode="		+document.getElementById("disCode").value;
		var retInfo = window.open(path,"newwindow",
			"height=450, "
			+"width=800,"
			+"top=50,"
			+"left=200,"
			+"scrollbars=yes, "
			+"resizable=no,"
			+"location=no, "
			+"status=yes");
}

function getPostBankCode()
{  
		var tableHeads		="银行代码|银行名称";
		var path			="<%=request.getContextPath()%>"
			+"/npage/se665/fE665PostBankCodeSel.jsp"
			+"?tableHeads="	+tableHeads
			+"&postBankName="+document.getElementById("postBankName").value;
		var retInfo = window.open(path,"newwindow",
			"height=450, "
			+"width=800,"
			+"top=50,"
			+"left=200,"
			+"scrollbars=yes, "
			+"resizable=no,"
			+"location=no, "
			+"status=yes");
}

function getBankInfo(bankInfo)
{
	var bankArrs	=bankInfo.split("|");
	var objBankCode	=document.getElementById("bankCode");
	var objBankName		=document.getElementById("bankName");
	
	objBankCode.value=bankArrs[0];
	objBankName.value=bankArrs[1];
}

function getPostBankInfo(bankInfo)
{
	var bankArrs	=bankInfo.split("|");
	var objPostBankCode	=document.getElementById("postBankCode");
	var objPostBankName		=document.getElementById("postBankName");
	
	objPostBankCode.value=bankArrs[0];
	objPostBankName.value=bankArrs[1];
}

function chgOpType()
{
	var objOpType=document.frm.opType;

	for (var i=0; i<objOpType.length; i++)
	{
		if (objOpType[i].checked)
		{
			selOpType=objOpType[i].value;
		}
	}
	
	var payCode				=document.getElementById("payCode");
	var payCodeText		=document.getElementById("payCodeText");
	var bankInfo			=document.getElementById("bankInfo");
	var accountNo			=document.getElementById("accountNo");
	var bankCode			=document.getElementById("bankCode");
	var bankName			=document.getElementById("bankName");
	var postBankCode	=document.getElementById("postBankCode");
	var postBankName	=document.getElementById("postBankName");
	accountNo.value		="";
	bankCode.value		="";
	bankName.value		="";
	postBankCode.value="";
	postBankName.value="";
	
	if("1"==selOpType)/*新增*/
	{
		payCode.value="5";
		payCodeText.options[1].selected="true";
		bankInfo.style.display="";
		accountNo.style.display="";
		bankCode.style.display="";
		bankName.style.display="";
		postBankCode.style.display="";
		postBankName.style.display="";
	}
	else 	if("2"==selOpType)/*修改*/
	{
		payCode.value="5";
		payCodeText.options[1].selected="true";
		bankInfo.style.display="";
		accountNo.style.display="";
		bankCode.style.display="";
		bankName.style.display="";
		postBankCode.style.display="";
		postBankName.style.display="";
	}
	
	else 	if("3"==selOpType)/*删除*/
	{
		payCode.value="0";
		payCodeText.options[0].selected="true";
		bankInfo.style.display="none";
		accountNo.style.display="none";
		bankCode.style.display="none";
		bankName.style.display="none";
		postBankCode.style.display="none";
		postBankName.style.display="none";
	}
	
}
function doBack()
{
	document.frm.action="fE665Qry.jsp";
	document.frm.submit();
}
function doCfm()
{
	var objUnitInfo		=document.all.unitInfo;
	var grpIdNo				="";
	var contractNo		="";
	var unitInfoFlag 	="1";
	for (var i=0; i<objUnitInfo.length; i++)
	{
		if (objUnitInfo[i].checked)
		{
			unitInfoFlag="0";
			grpIdNo		+=objUnitInfo[i].value.split("|")[0]+"|";
			contractNo+=objUnitInfo[i].value.split("|")[1]+"|";
		}
	}
	
	if ("0"!=unitInfoFlag)
	{
		rdShowMessageDialog("必须选择集团产品信息！",0);
		return false;
	}
	
	/*校验*/
	var accountNo			=document.getElementById("accountNo");
	var bankCode			=document.getElementById("bankCode");
	var bankName			=document.getElementById("bankName");
	var postBankCode	=document.getElementById("postBankCode");
	var postBankName	=document.getElementById("postBankName");
	if("1"==selOpType)/*新增*/
	{
		if (""==accountNo.value)
		{
			rdShowMessageDialog("银行帐号必须填写！",0);
			return false;
		}
		if (""==bankCode.value)
		{
			rdShowMessageDialog("银行代码必须选择！",0);
			return false;
		}
		if (""==postBankCode.value)
		{
			rdShowMessageDialog("局方银行代码必须选择！",0);
			return false;
		}
	}	
	else 	if("2"==selOpType)/*修改*/
	{
		if (""==accountNo.value)
		{
			rdShowMessageDialog("银行帐号必须填写！",0);
			return false;
		}
		if (""==bankCode.value)
		{
			rdShowMessageDialog("银行代码必须选择！",0);
			return false;
		}
		if (""==postBankCode.value)
		{
			rdShowMessageDialog("局方银行代码必须选择！",0);
			return false;
		}
	}
	/*调用服务*/
	document.frm.action="fE665Cfm.jsp?opType="+selOpType
		+"&grpIdNo="+grpIdNo
		+"&contractNo="+contractNo;
	document.frm.submit();
}
</script>
</head>
<wtc:service 	name="s5082ListEXC" outnum			="20" 
	retcode		="errcode1" 		retmsg			="errmsg1" 
	routerKey	="region" 			routerValue	="<%=regCode%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="<%=opCode%>" />
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="" />
	<wtc:param value="<%=unitId%>" />
</wtc:service>
<wtc:array id="result3" start="0" length="20" scope="end"/>
<body>
<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="regCode" id="regCode" value="<%=regCode%>">
<input type="hidden" name="disCode" id="disCode" value="<%=disCode%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">集团产品信息</div>
</div>
<table cellspacing="0">
	<tr>
		<th class="blue">选择</td>
		<th class="blue">集团产品ID</td>
		<th class="blue">产品类型</td>
		<th class="blue">产品账户</td>
		<th class="blue">产品状态</td>
		<th class="blue">产品号码</td>
		<th class="blue">开户时间</td>
		<th class="blue">产品名称</td>
	</tr>
	
	<%
		for ( int i=0; i<result3.length ; i++ )
		{
			%>
			<tr>
				<td align="center">
					<input type="checkbox" id="unitInfo" name="unitInfo" 
					value="<%=(result3[i][1]+"|"+result3[i][8])%>">
				</td>
				<td align="center"><%=result3[i][1]	%></td>
				<td align="center"><%=result3[i][9]	%></td>
				<td align="center"><%=result3[i][8]	%></td>
				<td align="center"><%=result3[i][5]	%></td>
				<td align="center"><%=result3[i][2]	%></td>
				<td align="center"><%=result3[i][7]	%></td>
				<td align="center"><%=result3[i][10]%></td>
			</tr>
		<%}
	%>
</table>
<br>
<div class="title">
	<div name="title_zi" id="title_zi">操作类型选择</div>
</div>
<table cellspacing="0">
	<tr>
		<td align = "center">操作类型</td>
		<td align = "center" colspan="2">
			<input type="radio" name="opType" value="1" checked 
				onclick="chgOpType();">
				新增
		</td>
		<td align = "center" colspan="2">
			<input type="radio" name="opType" value="2"
				onclick="chgOpType();">
				修改
		</td>
		<td align = "center" colspan="2">
			<input type="radio" name="opType" value="3"
				onclick="chgOpType();">
				解除
		</td>
	</tr>
</table>
<br>
<div class="title">
	<div name="title_zi" id="title_zi">填写托收信息</div>
</div>
<table>
	<tr>
		<td align = "center">付款方式</td>
		<td colspan="5">		
			<select name = "payCodeText" id = "payCodeText" disabled>
				<option value="">0-->现金</option>
				<option value="" selected >5-->托收</option>
			<select>	
			<input type="hidden" id="payCode" name="payCode" value="5" >
		</td>
	</tr>
	<tr id="bankInfo">
		<td align = "center">银行帐号</td>
		<td >
			<input type="text" id="accountNo" name="accountNo" 
				maxlength="30" size="30">
			<font color = "orange">*</font>
		</td>
			
		<td align = "center">银行代码</td>
		<td align = "left">
			<input type="text" id="bankCode" name="bankCode" size=10 readonly>
			<input type="text" id="bankName" name="bankName" size=25
				onkeyup="if(event.keyCode==13)getBankCode();"  >		
			<font color = "orange">*</font>		  
		  <input name=bankCodeQuery type=button class="b_text" 
		  	id="bankCodeQuery" style="cursor:hand" 
		  	onClick="getBankCode()" value="查询">
		</td>
		<td align = "center">局方银行代码</td>
		<td align = "left">
			<input type=text id="postBankCode" name=postBankCode size=10 readonly>
			<input type=text id="postBankName" name=postBankName size=25 
				onkeyup="if(event.keyCode==13)getPostBankCode();">		
			<font color = "orange">*</font>
		  <input type=button name=bankCodeQuery id="bankCodeQuery"
		  	class="b_text" style="cursor:hand" 
		  	onClick="getPostBankCode()" value="查询">			
		</td>
	</tr>
	<tr>
		<td colspan="6" id="footer">
			<input type="checkbox" id="unitInfo" name="unitInfo" 
					value="" style="display:none">
			<input class="b_foot" type=button name="query" value="确认" 
				onclick="doCfm();">
			<input class="b_foot" type=button name="back" value="返回" 
				onclick="doBack();">
			<input class="b_foot" type=button name="closeB" value="关闭" 
				onClick="removeCurrentTab();">
		</td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
