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

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%@ page import="java.util.ArrayList" %>
<html>
<%
String opCode 	= WtcUtil.repStr(request.getParameter("opCode"), "");
String opName 	= WtcUtil.repStr(request.getParameter("opName"), "");
String regCode 	= (String)session.getAttribute("regCode");

%>	
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
function doQryCheck()
{
	var objIdIccId	=document.getElementById("idIccId");
	var objUnitId		=document.getElementById("unitId");
	var objCustId=document.getElementById("custId");
	
	if ( ""==objIdIccId.value && ""==objUnitId.value && ""==objCustId.value )
	{
		rdShowMessageDialog("必须输入查询条件！",0);
		return "-1";
	}
}	

function doQuery()
{
	if ("-1"==doQryCheck() )
	{
		return false;
	}
	document.frm.action = "fE665List.jsp";
	document.frm.submit();
}

/*集团客户密码校验*/
function checkPwd()
{
	var unitCustPwd	=	document.all.unitCustPwd;
	var custId			= document.getElementById("custId");
	var regCode			='<%=regCode%>';
	if (""==unitCustPwd.value)
	{
		rdShowMessageDialog("必须输入密码！" , 0);
		return false;
	}
	if (""==custId.value)
	{
		rdShowMessageDialog("客户ID不能为空" , 0);
		return false;
	}
	var packetCheckPwd= new AJAXPacket("<%=request.getContextPath()%>"
		+"/npage/se665/fE665ChkPwd.jsp" , "正在校验客户密码......");
	packetCheckPwd.data.add("unitCustPwd" , unitCustPwd.value);
	packetCheckPwd.data.add("custId" 			, custId.value);
	packetCheckPwd.data.add("regCode" 		, regCode);
	core.ajax.sendPacket(packetCheckPwd 	, checkRst,true);
	packetCheckPwd=null;
}

function checkRst(packet)
{
	var retCode 	=packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
	var retResult	=packet.data.findValueByName("retResult");
	var objPwdFlag=document.getElementById("pwFlag");

	if ("000000"!=retCode)
	{
		rdShowMessageDialog("密码校验失败，请联系系统管理员");
		objPwdFlag.value="1";
		return false;
	}
	else
	{
		if ("false"==retResult)
		{
			rdShowMessageDialog("密码错误！",0);
			objPwdFlag.value="1";	
			return false;
		}
		else
		{
			rdShowMessageDialog("客户密码校验通过！",1);
			document.getElementById("e665Qry").disabled=false;
			objPwdFlag.value="0";	
		}
	}
}
function doRst()
{
	document.getElementById("e665Qry").disabled=true;
	document.getElementById("custId").value="";
	document.getElementById("idIccId").value="";
	document.getElementById("unitId").value="";
	document.getElementById("unitName").value="";
	document.all.unitCustPwd.value="";
	document.getElementById("custId").readOnly=false;
	document.getElementById("idIccId").readOnly=false;
	document.getElementById("unitId").readOnly=false;
	document.getElementById("unitName").readOnly=false;	
	document.all.unitCustPwd.readOnly=false;
}

function doSelUnit()
{	
	if ("-1"==doQryCheck() )
	{
		return false;
	}
	var objIdIccId	=document.getElementById("idIccId");
	var objUnitId		=document.getElementById("unitId");
	var objUnitName	=document.getElementById("unitName");
	var objCustId		=document.getElementById("custId");
	var regCode			='<%=regCode%>';
	var tableHeads		="证件号码|集团客户ID|集团客户名称|集团编号|"
		+"集团名称|归属组织"
	if ( ""==objIdIccId.value && ""==objUnitId.value 
		&& ""==objUnitName.value
		&& ""==objCustId.value )
	{
		rdShowMessageDialog("必须输入查询条件！",0);
		return false;
	}
	var path			="<%=request.getContextPath()%>/npage/se665/fE665CustSel.jsp"
		+"?idIccId="		+objIdIccId.value
		+"&regCode="		+regCode
		+"&unitId="			+objUnitId.value
		+"&custId="			+objCustId.value
		+"&tableHeads="	+tableHeads;

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

function getCustInfo(custInfo)
{
	var custArrs	=custInfo.split("|");
	var objIdIccId	=document.getElementById("idIccId");
	var objUnitId		=document.getElementById("unitId");
	var objUnitName	=document.getElementById("unitName");
	var objCustId		=document.getElementById("custId");
	
	objIdIccId.value=custArrs[0];
	objUnitId.value=custArrs[3];
	objUnitName.value=custArrs[2];
	objCustId.value=custArrs[1];
	
	objIdIccId.readOnly=true;
	objUnitId.readOnly=true;
	objUnitName.readOnly=true;
	objCustId.readOnly=true;
}
</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="pwFlag" id="pwFlag" value="1">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi"><%=opName%></div>
</div>
<!--
证件号码，集团客户ID，集团编码和集团客户名称，支持单个查询和组合查询，要校验集团客户密码！
-->
<table cellspacing="0">
	<tr>
		<td class="blue">证件号码</td>
		<td>
			<input type="text" name = "idIccId" id = "idIccId">
			<input type="button" class="b_text" name="" value="查询"
				onclick = "doSelUnit()">
			<font class='orange'>*</font>
		</td>
		<td class="blue">集团客户ID</td>
		<td>
			<input type="text" name = "custId" id = "custId">
			<font class='orange'>*</font>
		</td>
		<td class="blue">集团编号</td>
		<td>
			<input type="text" name = "unitId" id = "unitId">
			<font class='orange'>*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">集团客户名称</td>
		<td>
			<input type="text" name = "unitName" id = "unitName">
			<font class='orange'>*</font>
		</td>
		<td class="blue">集团客户密码</td>
		<td colspan="3">
      <jsp:include page="/npage/common/pwd_1.jsp">
	      <jsp:param name="width1"	value="16%"  />
	      <jsp:param name="width2" 	value="34%"  />
	      <jsp:param name="pname" 	value="unitCustPwd"  />
	      <jsp:param name="pwd" 		value="<%=123%>"  />
      </jsp:include>	
			<input type="button" class="b_text" name="" value="校验"
				onclick = "checkPwd()">
				<font class='orange'>*</font>
		</td>
	</tr>	
	<tr>
		<td colspan="6" id="footer">
			<input class="b_foot" type=button 
				name="e665Qry" id = "e665Qry" value="下一步" 
				onClick="doQuery();" disabled >
			<input class="b_foot" type=button 
				name="e665Rst" id = "e665Rst" value="重置" 
				onClick="doRst();"  >
			<input class="b_foot" type=button name="closeB" value="关闭" 
				onClick="parent.removeTab('<%=opCode%>')">
		</td>
	</tr>
</table>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>


