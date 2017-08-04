<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: sp增值业务套餐申请9896
   * 版本: 1.0
   * 日期: 2009/09/22
   * 作者: dujl
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="9896";
	String opName="sp增值业务套餐申请";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String saleType = request.getParameter("saleType1");
	String saleCode = request.getParameter("sale_code");
 	String iPhoneNo = request.getParameter("srv_no");
	System.out.println("phoneNO === "+ iPhoneNo);
	
	String sqlStr="";
	String retMsg3="";
	int recordNum=0;
	int i=0;
	
	String  inputParsm [] = new String[6];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = saleType;
	inputParsm[3] = saleCode;
	inputParsm[4] = regionCode;
	inputParsm[5] = opCode;

	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>

<wtc:service name="s9896Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
</wtc:service>
<wtc:array id="tempArr" scope="end"/>
<%
String errCode = retCode;
String errMsg = retMsg1;

System.out.println("errCode="+errCode);
System.out.println("errMsg ="+errMsg);

if(tempArr.length==0)
{
   retMsg3 = "s9896Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
}
else if(!(errCode.equals("000000")))
{
%>
	<script language="javascript">
	 	rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location="f9896_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
	</script>
<%
}

String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>sp增值业务套餐申请</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--

//--------2---------验证按钮专用函数-------------
onload=function()
{
	var saleCode = document.all.sale_code.value;
	document.getElementById("qryOprInfoFrame").style.display="block"; 
	document.qryOprInfoFrame.location = "f9896Info.jsp?saleCode="+saleCode;
}

function frmCfm()
{
	frm.submit();
	return true;
}

function printCommit()
{
	getAfterPrompt();
	
	if(document.all.sale_code.value=="")
	{
		rdShowMessageDialog("请输入营销代码!");
		return false;
	}
	
	if(document.all.prepay_pay1.value=="")
	{
		rdShowMessageDialog("请输入应收金额!");
		return false;
	}

//打印工单并提交表单
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			{
				frmCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			{
				frmCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		{
			frmCfm();
		}
	}
	return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
  
	 var retInfo = "";
	 
	cust_info+="手机号码：   "+document.all.phoneNo.value+"|";
	cust_info+="客户姓名：   "+document.all.oCustName.value+"|";
	
	opr_info+="业务类型：增值业务套餐申请"+"|";
	opr_info+="套餐类型："+document.all.sale_name.value+"|";
	opr_info+="业务流水： <%=printAccept%>"+"|";
	
	opr_info+="交款额："+document.all.prepay_pay.value+"元"+"|";
	opr_info+="业务执行时间："+document.all.consume_term.value+"个月（含业务受理月）"+"|";
	
	note_info1+=" "+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function checkAward()
{
	if(document.all.need_award.checked == true)
	{
		document.all.award_flag.value="0"
	}
	else
	{
		document.all.award_flag.value="1"
	}
}

function goBack()
{
	location="f9896_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f9896Cfm.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
<input type="hidden" name="login_accept" value="<%=printAccept%>">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="smName" value="<%=tempArr[0][7]%>">
<input type="hidden" name="saleType" value="<%=saleType%>">
<input type="hidden" name="sale_code" value="<%=saleCode%>">
<input type="hidden" name="regionCode" value="<%=regionCode%>">
<div class="title">
	<div id="title_zi">业务明细</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">手机号码</td>
		<td width="39%">
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
		</td>
		<td class="blue">机主姓名</td>
		<td>
			<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=tempArr[0][2]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">类别名称</td>
		<td>
			<input name="typeName" type="text" class="InputGrey" id="typeName" value="<%=tempArr[0][3]%>" readonly>
		</td>
		<td class="blue">营销案名称</td>
		<td>
			<input name="sale_name" type="text" class="InputGrey" id="sale_name"  value="<%=tempArr[0][4]%>"  readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">预存话费金额（元）</td>
		<td>
			<input name="prepay_pay" type="text" class="InputGrey" id="prepay_pay"  value="<%=tempArr[0][5]%>" readonly>
		</td>
		<td class="blue">消费时长（月）</td>
		<td>
			<input name="consume_term" type="text" class="InputGrey" id="consume_term" value="<%=tempArr[0][6]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">应收金额（元）</td>
		<td>
			<input name="prepay_pay1" type="text" class="button" id="prepay_pay1" value="<%=tempArr[0][5]%>" readonly><font color="red">*</font>
		</td>
		<td class="blue">是否预存有礼</td>
		<td>
			<input name="need_award" type="checkbox" class="checkbox" id="need_award" onclick="checkAward()" checked>
			<input type="hidden" name="award_flag" value="0" />
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="确认&打印" onClick="printCommit();">
			&nbsp;
			<input name="back" onClick="goBack();" type="button" class="b_foot" value="返回">
			&nbsp;
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td style="height:0;">
			<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:99%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
