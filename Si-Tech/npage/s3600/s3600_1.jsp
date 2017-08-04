<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.23
 模块: BOSS侧VPMN集团开户
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../include/remark.htm" %>


<%
	
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	
	String[] inParams = new String[2];
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	int iDate = Integer.parseInt(dateStr);
	String addDate = Integer.toString(iDate+1);
	String Date100 = Integer.toString(iDate+1000000);
	
	String regCode = (String)session.getAttribute("regCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass  = (String)session.getAttribute("password");
	String Department = (String)session.getAttribute("orgCode");
	
	String regionCode = Department.substring(0,2);
	String districtCode = Department.substring(2,4);
	String townCode = Department.substring(4,7);
	String GroupId = (String)session.getAttribute("groupId");
	String group_id = "";/* add by daixy 20081127,group_id来自dCustDoc中的org_id */
	String OrgId = (String)session.getAttribute("orgId");
	String sm_code = "va";
	String powerRight= (String)session.getAttribute("powerRight");
	
	String sqlStr = "";
	String[][] result = new String[][]{};

%>
<HEAD>
	<TITLE>BOSS侧VPMN集团用户开户</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

onload=function()
{
	document.all.checkPayTR.style.display="none";
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
	self.status="";
	if(retType == "UserId")
	{
		if(retCode == "000000")
		{
			var retUserId = packet.data.findValueByName("retnewId");
			document.frm.grp_id.value = retUserId;
			document.frm.reset1.disabled = false;
			document.frm.grpQuery.disabled = true;
			document.frm.grp_name.focus();
		}
		else
		{
			rdShowMessageDialog("没有得到用户ID,请重新获取！");
			return false;
		}
		//得到集团用户编号的时候，得到集团代码
	}
	//---------------------------------------
	if(retType == "GrpCustInfo") //用户开户时客户信息查询
	{
		var retname = packet.data.findValueByName("retname");
		if(retCode=="000000")
		{
			document.frm.cust_name.value = retname;
			document.frm.unit_id.focus();
		}
		else
		{
			retMessage = retMessage + "[errorCode1:" + retCode + "]";
			rdShowMessageDialog(retMessage,0);
			return false;
		}
	}
	if(retType == "AccountId") //得到帐户ID
	{
		//alert();
		if(retCode == "000000")
		{
			var retnewId = packet.data.findValueByName("retnewId");
			document.frm.account_id.value = retnewId;
			document.frm.accountQuery.disabled = true;
			document.frm.user_passwd.focus();
		}
		else
		{
			rdShowMessageDialog("没有得到帐户ID,请重新获取！");
		}
	}
	//---------------------------------------
	if(retType == "UnitInfo")
	{
		//集团信息查询
		var retname = packet.data.findValueByName("retname");
		if(retCode=="000000")
		{
			document.frm.unit_name.value = retname;
			//document.frm.contract_name.focus();
		}
		else
		{
			retMessage = retMessage + "[errorCode1:" + retCode + "]";
			rdShowMessageDialog(retMessage,0);
			return false;
		}
	}
	//---------------------------------------
	if(retType == "checkPwd") //集团客户密码校
	{
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false")
			{
				rdShowMessageDialog(retMessage);
				frm.custPwd.value = "";
				frm.custPwd.focus();
				return false;
			}
			else
			{
				rdShowMessageDialog("客户密码校验成功！",2);
				document.frm.sure.disabled = false;
			}
		}
		else
		{
			rdShowMessageDialog(retMessage,2);
			return false;
		}
	}

	//---------------------------------------
	if(retType == "ProdAttr")
	{
		if(retCode == "000000")
		{
			var retnums = packet.data.findValueByName("retnums");
			var retname = packet.data.findValueByName("retname");

			if (retnums == 1)
			{ //只有一个产品属性的时候，不需要用户选择
				document.frm.product_attr.value = retname;
				document.frm.ProdAttrQuery.disabled = true;
			}
			else if (retnums > 1)
			{
				document.frm.product_attr.value = "";
				document.frm.ProdAttrQuery.disabled = false;
			}
		}
		else
		{
			rdShowMessageDialog("查询产品属性出错,请重新获取！");
			return false;
		}
	}
	//取流水
	if(retType == "getSysAccept")
	{
		if(retCode == "000000")
		{
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1)
			{
				page = "s3600_2.jsp";
						frm.action=page;
						frm.method="post";
						frm.submit();
			}
			else return false;
		}
		else
		{
			rdShowMessageDialog("查询流水出错,请重新获取！");
			return false;
		}
	}
	if(retType == "getCheckInfo")
	{   //得到支票信息
		var obj = "checkShow";
		if(retCode=="000000")
		{
			var bankCode = packet.data.findValueByName("bankCode");
			var bankName = packet.data.findValueByName("bankName");
			var checkPrePay = packet.data.findValueByName("checkPrePay");
			if(checkPrePay == "0.00")
			{
				frm.bankCode.value = "";
				frm.bankName.value = "";
				frm.checkNo.focus();
				document.all(obj).style.display = "none";
				rdShowMessageDialog("该支票的帐户余额为0！");
			}
			else
			{
					document.all(obj).style.display = "";
					frm.bankCode.value = bankCode;
					frm.bankName.value = bankName;
					frm.checkPrePay.value = checkPrePay;
			}
		}
		else
		{
			frm.checkNo.value = "";
			frm.bankCode.value = "";
			frm.bankName.value = "";
			document.all(obj).style.display = "none";
			frm.checkNo.focus();
			retMessage = retMessage + "[errorCode9:" + retCode + "]";
			rdShowMessageDialog(retMessage,0);
			return false;
		}
	}
}

function check_HidPwd()
{
	var cust_id = document.all.cust_id.value;
	var Pwd1 = document.all.custPwd.value;
	var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("CUST_ID",cust_id);
	checkPwd_Packet.data.add("inPwd",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

function getAccountId()
{
	//得到帐户ID
	var getAccountId_Packet = new AJAXPacket("../innet/f1100_getId.jsp","正在获得帐户ID，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet=null;
}

function getUserId()
{
	//得到集团用户ID，和个人用户ID一致
	var getUserId_Packet = new AJAXPacket("../innet/f1100_getId.jsp","正在获得用户ID，请稍候......");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("retType","UserId");
	getUserId_Packet.data.add("idType","1");
	getUserId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet=null;
}

//调用公共界面，进行集团帐户选择
function getInfo_Acct()
{
	var pageTitle = "集团帐户选择";
	var fieldName = "集团用户ID|集团用户名称|产品名称|集团帐号|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "4|0|1|2|3|";
	var retToField = "tmp1|tmp2|tmp3|account_id|"; //这里只需要返回帐号
	var cust_id = document.frm.cust_id.value;

	if(document.frm.cust_id.value == "")
	{
		rdShowMessageDialog("请先选择集团客户，才能进行集团帐户查询！",0);
		document.frm.iccid.focus();
	return false;
	}

	if(PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "<%=request.getContextPath()%>/npage/s3432/fpubcustacct_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&cust_id=" + document.all.cust_id.value;

	retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	document.frm.accountQuery.disabled = false;

	return true;
}

function getvalueacct(retInfo)
{
	var retToField = "tmp1|tmp2|tmp3|account_id|";;
	if(retInfo ==undefined)
	{
		return false;
	}

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

//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
	var pageTitle = "集团客户选择";
	var fieldName = "证件号码|客户ID|客户名称|集团ID|集团名称|归属地|联系人姓名|集团联系地址|集团联系电话|归属组织|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
/** add by daixy 20081127,group_id来自dCustDoc中的org_id 
**	var retQuence = "9|0|1|2|3|4|5|6|7|8|";
**	var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|";
**/
var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";
var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|group_id|";
	
	var cust_id = document.frm.cust_id.value;

	if(document.frm.iccid.value == "" &&
	document.frm.cust_id.value == "" &&
	document.frm.unit_id.value == "")
	{
		rdShowMessageDialog("请输入身份证号、客户ID或集团ID进行查询！",0);
		document.frm.iccid.focus();
		return false;
	}

	if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
	{
		frm.cust_id.value = "";
		rdShowMessageDialog("必须是数字！",0);
		return false;
	}

	if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
	{
		frm.unit_id.value = "";
		rdShowMessageDialog("必须是数字！",0);
		return false;
	}

	if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "f3600_cust_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
	path = path + "&cust_id=" + document.all.cust_id.value;
	path = path + "&unit_id=" + document.all.unit_id.value;

	retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	/** add by daixy 20081127,group_id来自dCustDoc中的org_id 
	** var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|";
	**/	
	var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|group_id|";
	
	if(retInfo ==undefined)
	{
		return false;
	}

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
	document.all.grp_name.value = document.all.unit_name.value;
}

//根据客户ID查询客户信息
function getInfo_CustId()
{
	var cust_id = document.frm.cust_id.value;

	//根据客户ID得到相关信息
	if(document.frm.cust_id.value == "")
	{
		rdShowMessageDialog("请输入客户ID！",0);
		return false;
	}
	if(forNonNegInt(frm.cust_id) == false)
	{
		frm.cust_id.value = "";
		rdShowMessageDialog("客户ID必须是数字！",0);
		return false;
	}

	var getInfoPacket = new AJAXPacket("f1902_Infoqry.jsp","正在获得集团客户信息，请稍候......");
	var cust_id = document.frm.cust_id.value;
	getInfoPacket.data.add("region_code","<%=regionCode%>");
	getInfoPacket.data.add("retType","GrpCustInfo");
	getInfoPacket.data.add("cust_id",cust_id);
	core.ajax.sendPacket(getInfoPacket);
	getInfoPacket=null;
}

//根据客户ID查询客户信息
function getInfo_UnitId()
{
	var cust_id = document.frm.cust_id.value;
	var unit_id = document.frm.unit_id.value;

	//根据客户ID得到相关信息
	if(document.frm.cust_id.value == "")
	{
		rdShowMessageDialog("请首先输入集团客户ID！",0);
		return false;
	}
	if(forNonNegInt(frm.cust_id) == false)
	{
		frm.cust_id.value = "";
		rdShowMessageDialog("集团客户ID必须是数字！",0);
		return false;
	}
	if(document.frm.unit_id.value == "")
	{
		rdShowMessageDialog("请首先输入集团ID！",0);
		return false;
	}
	if(forNonNegInt(frm.unit_id) == false)
	{
		frm.unit_id.value = "";
		rdShowMessageDialog("集团ID必须是数字！",0);
		return false;
	}

	var getInfoPacket = new AJAXPacket("f1902_Infoqry.jsp","正在获得集团客户信息，请稍候......");
	var cust_id = document.frm.cust_id.value;
	getInfoPacket.data.add("region_code","<%=regionCode%>");
	getInfoPacket.data.add("retType","UnitInfo");
	getInfoPacket.data.add("cust_id",cust_id);
	getInfoPacket.data.add("unit_id",unit_id);
	core.ajax.sendPacket(getInfoPacket);
	getInfoPacket=null;
}

//查询产品属性
function query_prodAttr()
{
	var sm_code = document.frm.sm_code.options[document.frm.sm_code.selectedIndex].value;

	if(document.frm.sm_code.value == "")
	{
		return false;
	}

	var getInfoPacket = new AJAXPacket("fpubprodattr_qry.jsp","正在查询产品属性代码，请稍候......");
	getInfoPacket.data.add("retType","ProdAttr");
	getInfoPacket.data.add("sm_code",sm_code);
	core.ajax.sendPacket(getInfoPacket);
	getInfoPacket=null;
}

//调用公共界面，进行产品属性选择
function getInfo_ProdAttr()
{
	var pageTitle = "产品属性选择";
	var fieldName = "产品属性代码|产品属性|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "1|0|";
	var retToField = "product_attr|";

	//首先判断是否已经选择了服务品牌
	if(document.frm.sm_code.value == "")
	{
		rdShowMessageDialog("请首先选择服务品牌！",0);
		return false;
	}

	if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

//查询支票号码
function getBankCode()
{
	//调用公共js得到银行代码
	if((frm.checkNo.value).trim() == "")
	{
		rdShowMessageDialog("请输入支票号码！",0);
		frm.checkNo.focus();
		return false;
	}
	var getCheckInfo_Packet = new AJAXPacket("getBankCode.jsp","正在获得支票相关信息，请稍候......");
	getCheckInfo_Packet.data.add("retType","getCheckInfo");
	getCheckInfo_Packet.data.add("checkNo",document.frm.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet=null;
}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "<%=request.getContextPath()%>/npage/s3432/fpubprodattr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value;

	retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAttr(retInfo)
{
	var retToField = "product_attr|";
	if(retInfo ==undefined)
	{
		return false;
	}

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
	document.frm.product_code.value = "";
	document.frm.product_append.value = "";
}

//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
	var pageTitle = "集团产品选择";
	var fieldName = "产品代码|产品名称|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "2|0|1|";
	var retToField = "product_code|product_name|";

	//首先判断是否已经选择了服务品牌
	if(document.frm.sm_code.value == "")
	{
		rdShowMessageDialog("请首先选择服务品牌！",0);
		return false;
	}
	//首先判断是否已经选择了产品属性
	if(document.frm.product_attr.value == "")
	{
		rdShowMessageDialog("请首先选择产品属性！",0);
		return false;
	}

	if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "<%=request.getContextPath()%>/npage/s3432/fpubprod_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value;
	path = path + "&product_attr=" + document.all.product_attr.value;

	retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalue(retInfo)
{
	var retToField = "product_code|product_name|";
	if(retInfo ==undefined)
	{   return false;   }

	document.all.product_code.value = retInfo;
	document.frm.product_append.value = "";
}

//集团附加产品选择
function getInfo_ProdAppend()
{
	var pageTitle = "集团附加产品选择";
	var fieldName = "产品代码|产品名称|";
	var sqlStr = "";
	var selType = "M";    //'S'单选；'M'多选
	var retQuence = "2|0|1|";
	var retToField = "product_append|product_name|";
	var product_code = document.frm.product_code.value;

	//首先判断是否已经选择了服务品牌
	if(document.frm.sm_code.value == "")
	{
		rdShowMessageDialog("请首先选择服务品牌！",0);
		return false;
	}
	//首先判断是否已经选择了产品属性
	if(document.frm.product_attr.value == "")
	{
		rdShowMessageDialog("请首先选择产品属性！",0);
		return false;
	}
	//首先判断是否已经申请了集团主产品
	if(document.frm.product_code.value == "")
	{
		rdShowMessageDialog("请首先选择集团主产品！",0);
		return false;
	}

	if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var product_code = document.all.product_code.value;
	var chPos = product_code.indexOf("|");
	product_code = product_code.substring(0,chPos);
	var path = "<%=request.getContextPath()%>/npage/s3432/fpubprodappend_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType;
	path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value;
	path = path + "&product_code=" + product_code;

	retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAppend(retInfo)
{
	var retToField = "product_append|product_name|";
	if(retInfo ==undefined)
	{   return false;   }

	document.all.product_append.value = retInfo;
}

function checkPwd(obj1,obj2)
{
	//密码一致性校验,明码校
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1 != pwd2)
	{
		var message = "'" + obj1.v_name + "'和'" + obj2.v_name + "'不一致，请重新输入！";
		rdShowMessageDialog(message,0);
		if(obj1.type != "hidden")
		{   obj1.value = "";    }
		if(obj2.type != "hidden")
		{   obj2.value = "";    }
		obj1.focus();
		return false;
	}
	return true;
}


//产品属性变更事件
function changeProdAttr()
{
	document.frm.product_code.value = "";
	document.frm.product_append.value = "";
}

//产品变更事件
function changeProduct()
{
	document.frm.product_append.value = "";
}

function refMain()
{
	getAfterPrompt();
	var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.

	//说明:检测分成两类,一类是数据是否是空,另一类是数据是否合法.
	if(check(frm))
	{
		
		if(  document.frm.product_code.value == "" )
		{
			rdShowMessageDialog("集团主产品必须选择!");
			return false;
		}
		if(  document.frm.grp_name.value == "" )
		{
			rdShowMessageDialog("集团名称:"+document.frm.grp_name.value+",必须输入!!");
			document.frm.grp_name.select();
			return false;
		}
		if(  document.frm.grp_id.value == "" )
		{
			rdShowMessageDialog("集团代码必须输入!!");
			document.frm.grp_id.select();
			return false;
		}
		//2.转换业务起始日期和业务结束日期的YYYYMMDD---->YYYY-MM-DD
		checkFlag = isValidYYYYMMDD(document.frm.srv_start.value);
		if(checkFlag < 0)
		{
			rdShowMessageDialog("业务起始日期:"+document.frm.srv_start.value+",日期不合法!!");
			document.frm.srv_start.select();
			return false;
		}
		checkFlag = isValidYYYYMMDD(document.frm.srv_stop.value);
		if(checkFlag < 0)
		{
			rdShowMessageDialog("业务结束日期:"+document.frm.srv_stop.value+",日期不合法!!");
			document.frm.srv_stop.select();
			return false;
		}
		//业务起始日期和业务结束日期的时间比?
		checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
		if( checkFlag == 1 )
		{
			rdShowMessageDialog("业务结束日期应该大于业务起始日期!!");
			document.frm.srv_stop.select();
			return false;
		}
		//进行密码校
		if((document.all.user_passwd.value).trim().length>0)
		{
			if(document.all.user_passwd.value.length!=6)
			{
				rdShowMessageDialog("客户密码长度有误！");
				document.all.user_passwd.focus();
				return false;
			}
			if(checkPwd(document.frm.user_passwd,document.frm.account_passwd)==false)
			return false;
		}
		if(  document.frm.mainRate.value == "" )
		{
			rdShowMessageDialog("集团主费率必须输入!!");
			document.frm.mainRate.focus();
			return false;
		}
		//判
		if (parseFloat(document.frm.should_handfee.value)==0)
		{
			document.frm.real_handfee.value="0.00";
		}
		if (parseFloat(document.frm.should_handfee.value)<parseFloat(document.frm.real_handfee.value))
		{
			rdShowMessageDialog("实收手续费应小于应收手续费");
			return false;
		}
		//由于参数太多，需要通过form的post传输,因此,需要将传输的内容复制到隐含域中. yl.
		document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
		document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
		document.frm.sysnote.value = "BOSS侧VPMN集团用户开户";
		document.frm.tonote.value = "BOSS侧VPMN集团用户开户";
		getSysAccept()
	}
}
function changeDateFormat(sDate)
{
		year = sDate.substring(0,4);
		month= sDate.substring(4,6);
		day= sDate.substring(6,8);
		
		return year+"-"+month+"-"+day;
	
}
function dateCompare(sDate1,sDate2){
	
	if(sDate1>sDate2)	//sDate1 早于 sDate2
		return 1;
	if(sDate1==sDate2)	//sDate1、sDate2 为同一天
		return 0;
	return -1;		//sDate1 晚于 sDate2
}
function isValidYYYYMMDD(sDateTime)
{
	//时间格式为：YYYYMMDD
	var sTmp = "";
	var iYear = 0;
	var iMonth = 0;
	var iDay = 0;
	var iHour = 0;
	var iMinute = 0;
	var iSecond = 0;
	  
	if ( (sDateTime.length > 8 ) || (sDateTime.length < 8) )
	{
		return -1;
	}
	  
	sTmp = sDateTime.substring(0,4);
	if (isNaN(sTmp))
	{
	  return -5;
	}
	iYear = parseInt(sTmp, 10);
	  
	sTmp = sDateTime.substring(4,6);
	if (isNaN(sTmp))
	{
	   return -6;
	}
	iMonth = parseInt(sTmp, 10);
	 
	sTmp = sDateTime.substring(6,8);
	if (isNaN(sTmp))
	{
	   return -6;
	}
	iDay = parseInt(sTmp, 10); 
	
	if (iYear < 1900)
	{
	  	rdShowMessageDialog("年应大于1900年");
	   	return -11;
	}
	
	if (iMonth < 1 || iMonth > 12)
	{
	   	rdShowMessageDialog("月应在1到12之间");
	   	return -12;
	}
	
	if ((iMonth == 1)||(iMonth == 3)||(iMonth == 5)||(iMonth == 7)||(iMonth == 8)||(iMonth == 10)||(iMonth == 12))
	{
	   	if (iDay > 31) return -13;
	}
	else if (iMonth == 2)
	{
	   if (iDay > 29) return -14;
	    if (iDay == 29)
	    {
	     	 //判断是否是闰年
	      	if (!((iYear % 4 == 0) && ((iYear % 100 != 0) || (iYear % 400 == 0))))
	      	{
	       		return -15;
	      	}
	    }
	}
	else
	{
	   	if (iDay > 30) return -16;
	}
	  
	return 0;
}

//打印相关
	 function printInfo(printType)
	 { 
		var retInfo = "";
		var temp="";
		for(i=0;i<document.frm.optionalRate.options.length;i++){
			if (document.frm.optionalRate.options[i].selected==true)
			{
				temp+=document.all.optionalRate.options[i].text+",";
			}
		}
		
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		
		cust_info+="客户姓名："+document.frm.cust_name.value+"|";
		cust_info+="证件号码："+document.frm.iccid.value+"|";
	
    	opr_info+="集团用户编号："+document.frm.grp_userno.value+"|";
    	opr_info+="付费方式："+document.frm.payType.options[document.frm.payType.selectedIndex].text+"|";
    	opr_info+="服务品牌：BOSS侧VPMN"+"|";
    	opr_info+="集团主费率："+document.frm.mainRate.options[document.frm.mainRate.selectedIndex].text+"|";	  
    	opr_info+="集团可选费率："+temp+"|";
    	opr_info+="业务类型：BOSSVPMN集团用户开户"+"|";
    	opr_info+="流水："+document.frm.login_accept.value+"|";
    	
    	note_info1+="备注："+document.all.tonote.value+" "+document.all.simBell.value+"|";
    	
    	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
	 }

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="print";                                      // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
   var sysAccept=document.frm.login_accept.value              // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="<%=opCode%>";                                  //操作代码
   var phoneNo="";                                            //客户电话

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

//取流水
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;
}

//选择支付方式
function changePayType()
{
	if (document.all.checkPayTR.style.display=="")
	{
		document.all.checkPayTR.style.display="none";
	}
	else
	{
		document.all.checkPayTR.style.display="";
	}
}
</script>
<BODY>
<FORM action="" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	<input type="hidden" id=hidPwd name="hidPwd" v_name="原始密码">
	<input type="hidden" name="chgsrv_start" value="">
	<input type="hidden" name="chgsrv_stop"  value="">
	<input type="hidden" name="product_level"  value="1">
	<input type="hidden" name="product_name"  value="">
	<input type="hidden" name="belong_code"  value="">
	<input type="hidden" name="prod_appendname"  value="">
	<input type="hidden" name="tfFlag" value="n">
	<input type="hidden" name="chgpkg_day"   value="">
	<input type="hidden" name="TCustId"  value="">
	<input type="hidden" name="unit_name"  value="">
	<input type="hidden" name="tmp1"  value="">
	<input type="hidden" name="tmp2"  value="">
	<input type="hidden" name="tmp3"  value="">
	<input type="hidden" name="org_id"  value="<%=OrgId%>">
<!--add by daixy 20081127,group_id来自dCustDoc中的org_id
	<input type="hidden" name="group_id"  value="<%=GroupId%>">
-->
	<input type="hidden" name="group_id"  value="<%=group_id%>">
	<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号 -->
	<input type="hidden" name="bill_type"  value="0"> <!-- 出帐周期 -->
	<input type="hidden" name="product_prices"  value="">
	<input type="hidden" name="product_type"  value=" ">
	<input type="hidden" name="service_code"  value=" ">
	<input type="hidden" name="service_attr"  value=" ">
	<input type="hidden" name="pay_no"  value="">
	<input type="hidden" name="op_code"  value="3600">
	<input type="hidden" name="OrgCode"  value="<%=org_code%>">
	<input type="hidden" name="region_code"  value="<%=regionCode%>">
	<input type="hidden" name="district_code"  value="<%=districtCode%>">
	<input type="hidden" name="town_code"  value="<%=townCode%>">
	<input type="hidden" name="WorkNo"   value="<%=workno%>">
	<input type="hidden" name="NoPass"   value="<%=nopass%>">
	<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
	
		<TABLE  cellSpacing="0">
			<TR>
				<TD class="blue">
					<div align="left">身份证号</div>
				</TD>
				<TD>
					<input name=iccid id="iccid" maxlength="18" v_type="string" v_must=1 index="1">
					<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=查询>
					<font color="orange">*</font>
				</TD>
				<TD class="blue">集团客户ID</TD>
				<TD>
					<input type="text" name="cust_id" maxlength="10" v_type="0_9" v_must=1 index="2">
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">
					<div align="left">集团ID</div>
				</TD>
				<TD>
					<input name=unit_id id="unit_id"  v_type="0_9" v_must=1 index="3">
					<font color="orange">*</font>
				</TD>
				<TD class="blue">集团客户名称</TD>
				<TD>
					<input class="InputGrey" name="cust_name"  readonly v_must=1 v_type=string  size="40" index="4">
				<font color="orange">*</font> </TD>
			</TR>
			<TR>
				<TD class="blue">集团客户密码</TD>
				<TD>
					<jsp:include page="/npage/common/pwd_1.jsp">
						<jsp:param name="width1" value="16%"  />
						<jsp:param name="width2" value="34%"  />
						<jsp:param name="pname" value="custPwd"  />
						<jsp:param name="pwd" value=""  />
					</jsp:include>
					<input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=校验>
					<font color="orange">*</font>
				</TD>
				<TD class="blue">集团所在省区号</TD>
				<TD>
					<input class="InputGrey" type="text" name="province" 
	<%
					try
					{
					sqlStr = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
					//retArray = callView.sPubSelect("1",sqlStr);
	%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
					<wtc:sql><%=sqlStr%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="resultTemp" scope="end" />
	<%
					if(resultTemp.length>0)
						result = resultTemp;
					int recordNum = result.length;
					for(int i=0;i<recordNum;i++){
						out.println("value='" + result[i][0] + "'");
					}
					}catch(Exception e){
						
					}
	%>
					readonly v_must=1 v_type="0_9" index="11"> <font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">服务品牌</TD>
				<TD>
					<select name="sm_code" id="sm_code" v_must=1 v_type="string" index="10">
						<option value='<%=sm_code%>'>BOSS侧VPMN</option>
						<font color="orange">*</font>
					</select>
				</TD>
				<TD class="blue">产品属性</TD>
				<TD>
					<input class="InputGrey" type="text" name="product_attr"  readonly  onChange="changeProdAttr()" v_must=1 v_type="string">
					<input name="ProdAttrQuery" type="button" id="ProdAttrQuery"  class="b_text" onMouseUp="getInfo_ProdAttr();" onKeyUp="if(event.keyCode==13)getInfo_ProdAttr();" value="选择">
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">集团主产品</TD>
				<TD>
					<input class="InputGrey" type="text" name="product_code"  readonly onChange="changeProduct()" v_must=1 v_type="string">
					<input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="选择">
					<font color="orange">*</font>
				</TD>
				<TD class="blue">集团附加产品</TD>
				<TD>
					<input class="InputGrey" type="text" name="product_append"  readonly v_must=0 v_type="string">
					<input name="ProdAppendQuery" type="button"  disabled id="ProdAppendQuery"  class="b_text" onMouseUp="getInfo_ProdAppend();" onKeyUp="if(event.keyCode==13)getInfo_ProdAppend();" value="选择">
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">集团用户ID</TD>
				<TD>
					<input name="grp_id" type="text" class="InputGrey"  readonly v_type="0_9" v_must=1>
					<input name="grpQuery" type="button" id="grpQuery"  class="b_text" onclick="getUserId();" value="获取">
					<font color="orange">*</font>
				</TD>
				<TD class="blue">用户名称</TD>
				<TD>
					<input name="grp_name" type="text"  v_must=1 v_maxlength=60 v_type="string">
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">帐户ID</TD>
				<TD>
					<input name="account_id" type="text" class="InputGrey"  readonly v_type="0_9" v_must=1>
					<input name="accountQuery" type="button" class="b_text" id="accountQuery" onclick="getAccountId();"  value="获取" >
					<!--<input name="accountSelect" type="button" class="button" id="accountSelect" onMouseUp="getInfo_Acct();" onKeyUp="if(event.keyCode==13)getInfo_Acct();" value="选择" >-->
					<font color="orange">*</font>
				</TD>
				<TD class="blue">集团用户编号(计费编号)</TD>
				<TD>
					<input name="grp_userno" type="text"  v_type="string" maxlength="4" v_must=1>
					<font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<jsp:include page="/npage/common/pwd_pvalue.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="user_passwd"  />
					<jsp:param name="pcname" value="account_passwd"  />
					<jsp:param name="pvalue" value="111111"/>
				</jsp:include>
			</TR>
			<TR> 
	            <TD class="blue">联系人姓名</TD>
	            <TD> 
	              <input name="contact" type="text" readOnly class="InputGrey" id="contact"  v_must=0 v_type="string" index="14">
	            </TD>
	            <TD class="blue">集团联系电话</TD>
	            <TD> 
	              <input name="telephone" type="text" readOnly class="InputGrey" id="telephone" onKeyPress="return isKeyNumberdot(0)"  v_must=0 v_type="string">
	            </TD>
          </TR>
          <TR> 
            <TD class="blue">集团联系地址</TD>
            <TD colspan=3> 
              <input name="address" type="text" class="InputGrey" id="address" readOnly v_must=0 v_type="string" index="15">
            </TD>
          </TR>
			<TR>
				<TD class="blue">业务起始日期</TD>
				<TD>
					<input name="srv_start" type="text" class="InputGrey" id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>"  v_must=1 v_type="date" > <font color="orange">*</font>
				</TD>
				<TD class="blue">业务结束日期</TD>
				<TD>
					<input name="srv_stop" type="text" class="InputGrey" id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="<%=Date100%>"  v_must=1 v_type="date" readonly> <font color="orange">*</font>
				</TD>
			</TR>
			<TR>
				<TD class="blue">信用度</TD>
				<TD><input name="credit_value" type="text"  value="1000" id="credit_value"  v_must=0 v_type="string"> <font color="orange">*</font>
				</TD>
				<TD class="blue">信用等级</TD>
				<TD><input name="credit_code" type="text"  id="credit_code3" value="0"  v_must=0 v_type="string" > <font color="orange">*</font> </TD>
			</TR>
				<TR>
		<%
					try{
						sqlStr = "select hand_fee from sSmCode where function_Code ='3600'";
						//retArray = callView.sPubSelect("1",sqlStr);
		%>
						<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
						<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="resultTemp" scope="end" />
		<%
						if(resultTemp.length>0)
							result = resultTemp;
						if (resultTemp.length==0){
							result = new String[1][1];
							result[0][0]="0.00";
						}
					}
					catch(Exception e){
						System.out.println("手续费出错!");
					}
		%>
					<TD class="blue">应收手续费</TD>
					<TD>
						<input class="InputGrey" name="should_handfee" id="should_handfee" value="<%=result[0][0]%>" readonly>
					</TD>
					<TD class="blue">实收手续费</TD>
					<TD>
						<input name="real_handfee" id="real_handfee" value="" >
					</TD>
				</TR>
				<TR>
					<TD class="blue">集团主费率</TD>
					<TD>
						<select name="mainRate" id="mainRate" v_must=1 v_type="string" index="10">
							<%
							try
							{
								sqlStr = "select mode_code,mode_code || '->' || mode_name"
								+"  from sBillModeCode"
								+" where region_code = substr('" +org_code+"',1,2)"
								+"   and mode_type = 'VpM0' "
								+" and stop_time>=sysdate and power_Right<="+powerRight+"";
								
								inParams[0] = "select mode_code,mode_code || '->' || mode_name"
								+"  from sBillModeCode"
								+" where region_code = substr(:org_code,1,2)"
								+"   and mode_type = 'VpM0' "
								+" and stop_time>=sysdate and power_Right<=:powerRight";
								inParams[1] = "org_code="+org_code+",powerRight="+powerRight;
								System.out.println(sqlStr);
								//retArray = callView.sPubSelect("2",sqlStr);
							%>
								<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode3" retmsg="retMsg3" outnum="2">			
								<wtc:param value="<%=inParams[0]%>"/>	
								<wtc:param value="<%=inParams[1]%>"/>	
								</wtc:service>	
								<wtc:array id="resultTemp"  scope="end"/>
							<%	
								result = resultTemp;
							}
							catch(Exception e){
								System.out.println("取集团主费率信息出错!");
							}
							if (result != null && result.length>0)
							{
								System.out.println("result.length"+result.length);
								for(int i=0; i < result.length; i ++)
								{
									out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
								}
							}
							%>
						</select>
						<font color="orange">*</font>
					</TD>
					<TD class="blue">集团可选费率</TD>
					<TD>
						<select name="optionalRate" id="optionalRate" size="5" MULTIPLE="TRUE" v_must=0 v_type="string" v_name="集团可选费率：" index="10">
		<%
							try
							{
								sqlStr = "select mode_code,mode_code || '->' || mode_name"
								+"  from sBillModeCode"
								+" where region_code = substr('" +org_code+"',1,2)"
								+"   and mode_type = 'VpA0'"
								+" and stop_time>=sysdate and power_Right<="+powerRight+"";
								
								inParams[0] = "select mode_code,mode_code || '->' || mode_name"
								+"  from sBillModeCode"
								+" where region_code = substr(:org_code,1,2)"
								+"   and mode_type = 'VpA0'"
								+" and stop_time>=sysdate and power_Right<=:powerRight";
								inParams[1] = "org_code="+org_code+",powerRight="+powerRight;
								//retArray = callView.sPubSelect("2",sqlStr);
		%>
								<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode4" retmsg="retMsg4" outnum="2">			
								<wtc:param value="<%=inParams[0]%>"/>	
								<wtc:param value="<%=inParams[1]%>"/>	
								</wtc:service>	
								<wtc:array id="resultTemp"  scope="end"/>
		<%
								result = resultTemp;
							}
							catch(Exception e)
							{
								System.out.println("取集团可选费率信息出错!");
							}
							if (result != null && result.length>0)
							{
								System.out.println("result.length"+result.length);
								for(int i=0; i < result.length; i ++)
								{
									out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
								}
							}
		%>
						</select>
					</TD>
				</tr>
				<tr >
					<TD class="blue">付款方式</TD>
					<TD colspan="3">
						<select name='payType' onchange='changePayType()'>
							<option value='1'>现金</option>
							<option value='2'>支票</option>
						</select>
						<font color="orange">*</font>
					</TD>
				</TR>
				<TBODY>
					<TR id='checkPayTR'>
						<TD class="blue">
							<div align="left">支票号码</div>
						</TD>
						<TD>
							<input v_must=0  v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
							<font color="orange">*</font>
							<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=查询>
						</TD>
						<TD class="blue">
							<div align="left">银行代码</div>
						</TD>
						<TD>
							<input name=bankCode size=12 class="InputGrey" maxlength="12" readonly>
							<input name=bankName size=20 class="InputGrey" readonly>
						</TD>
					</TR>
				</TBODY>
			<TBODY>
				<TR id='checkShow' style='display:none'>
					<TD class="blue">
						<div align="left">支票交款</div>
					</TD>
					<TD>
						<input v_must=0  v_type=money v_account=subentry name="checkPay" value="0.00" maxlength=15 onkeyup="getpreFee()" index="51">
						<font color="orange">*</font> </TD>
					<TD class="blue">
						<div align="left">支票余额</div>
					</TD>
					<TD>
						<input class="InputGrey" name="checkPrePay" value=0.00 readonly>
					</TD>
				</TR>
			</TBODY>
			</TABLE>
			<TABLE cellSpacing="0">
				<TR style="display:none">
					<TD class="blue">系统备注</TD>
					<TD>
						<input class="InputGrey" name="sysnote"  readonly>
					</TD>
				</TR>
				<TR style="display:none">
					<TD class="blue">用户备注</TD>
					<TD >
						<input class="InputGrey" name="tonote" readonly>
					</TD>
				</TR>
				<TR>
					<TD id="footer" colspan="2">
						<input class="b_foot" name="sure"  type=button value="确认" onclick="refMain()" disabled>
						<input class="b_foot" name="reset1" onClick="" type=reset value="清除" disabled>
						<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭">
					</TD>
				</TR>
			</TABLE>
	<%@ include file="/npage/include/footer.jsp" %>   
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>
<script language="JavaScript">
	document.frm.iccid.focus();
	query_prodAttr();
</script>
</BODY>
</HTML>
