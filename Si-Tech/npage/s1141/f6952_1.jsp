<%
  /* *********************
   * 功能:新入网赠话费预案
   * 版本: 1.0
   * 日期: 2009/09/02
   * 作者: fengry
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>新入网赠话费预案</title>
<%
	String opCode = "6952";
	String opName = "新入网赠话费预案";
	String workNo = (String) session.getAttribute("workNo");
	String orgCode = (String) session.getAttribute("orgCode"); 
	String printAccept="";
	printAccept = getMaxAccept();
	//activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	//String phoneNo = activePhone;

	String phoneNo = WtcUtil.repNull(request.getParameter("activePhone"));
	String ProCode_Str = WtcUtil.repNull(request.getParameter("ProCodeStr"));
	String ProCode[] = ProCode_Str.split("-->");

	System.out.println("activePhone======================"+activePhone);
	System.out.println("workNo==========================="+workNo);
	System.out.println("opCode==========================="+opCode);
	System.out.println("phoneNo=========================="+phoneNo);
	System.out.println("orgCode=========================="+orgCode);
	System.out.println("ProCode_Str======================"+ProCode_Str);
%>

<wtc:service name="s6952Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="initRetCode" retmsg="initRetMsg" outnum="9">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=orgCode%>"/>
</wtc:service>
<wtc:array id="initStr" scope="end"/>
<%
	System.out.println("initRetCode==="+initRetCode);
	System.out.println("initRetMsg==="+initRetMsg);
	if(!(initRetCode.equals("000000")))
	{
%>
		<script language=javascript>
			rdShowMessageDialog("<%=initRetMsg%>");
			window.location="f6952_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
		return;
	}
%>

<script language="javascript">
function printCommit()
{
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			{
				doCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			{
				doCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		{
			doCfm();
		}
	}
}
function doCfm()
{	
	frm.submit();
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
	cust_info+="客户姓名：   "+document.all.custName.value+"|";

	opr_info+="业务类型: 新入网赠话费预案"+"|";
	opr_info+="客户品牌："+document.all.sm_name.value+"|";
	if(document.all.ProCode[0].value == "0001"){
		note_info1+="备注：欢迎您参加哈移动“高校迎新入网赠话费预案”活动，您开户入网交纳的预存款为50元，获赠的50元话费自开户次月起赠送，10元/月,连续赠送5个月。"+"|";
  }
	else if(document.all.ProCode[0].value == "0002"){
		note_info1+="备注：欢迎您参加哈移动“高校迎新入网赠话费预案”活动，您开户入网交纳的预存款为100元，获赠的120元话费自开户次月起赠送，10元/月,连续赠送12个月。"+"|";
  }
  else{
		note_info1+="备注："+"|";
  }
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
</script>
</head>

<body>
<form name="frm" method="POST" action="f6952Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
 	<input type="hidden" name="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" value="<%=opName%>">
	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
			<td>
				<input name="phoneNo" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phoneNo" maxlength="20" size="40">
			</td>
			<td class="blue">用户ID</td>
			<td>
				<input name="id_no" value="<%=initStr[0][2]%>" type="text" class="InputGrey" v_must=1 readonly id="id_no" maxlength="20" size="40">
			</td>
		</tr>
		<tr>
			<td class="blue">客户名称</td>
			<td>
				<input name="cust_name" value="<%=initStr[0][3]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" size="40">
			</td>
			<td class="blue">客户地址</td>
			<td>
				<input name="cust_address" value="<%=initStr[0][4]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_address" maxlength="20" size="40">
			</td>
		</tr>
		<tr>
			<td class="blue">业务品牌</td>
			<td>
				<input name="sm_name" value="<%=initStr[0][5]%>" type="text" class="InputGrey" v_must=1 readonly id="sm_name" maxlength="20" size="40">
			</td>
			<td class="blue">当前状态</td>
			<td>
				<input name="run_name" value="<%=initStr[0][6]%>" type="text" class="InputGrey" v_must=1 readonly id="run_name" maxlength="20" size="40">
			</td>
		</tr>
		<tr>
			<td class="blue">证件类型</td>
			<td>
				<input name="id_name" value="<%=initStr[0][7]%>" type="text" class="InputGrey" v_must=1 readonly id="id_name" maxlength="20" size="40">
			</td>
			<td class="blue">证件号码</td>
			<td>
				<input name="id_iccid" value="<%=initStr[0][8]%>" type="text" class="InputGrey" v_must=1 readonly id="id_iccid" maxlength="20" size="40">
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td class="blue">方案代码</td>
			<td>
				<input name="ProCode" value="<%=ProCode[0]%>" type="text" class="InputGrey" v_must=1 readonly id="ProCode" maxlength="20" size="40">
			</td>
			<td class="blue">方案名称</td>
			<td>
				<input name="ProName" value="<%=ProCode[1]%>" type="text" class="InputGrey" v_must=1 readonly id="ProName" maxlength="20" size="40">
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td colspan="6" id="footer">
				<input class="b_foot" type="button" name="b_print" value="确认&打印" onClick="printCommit();">&nbsp;
				<input class="b_foot" type="button" name="b_clear" value="返回" onClick="history.go(-1);">
			</td>
		</tr>
	</table>

<input type="hidden" name="printAccept" value="<%=printAccept%>" >
<input type="hidden" name="custName" value="<%=initStr[0][3]%>" >
<input type="hidden" name="custAdress" value="<%=initStr[0][4]%>" >
<input type="hidden" name="idIccid" value="<%=initStr[0][8]%>" >
<input type="hidden" name="ProCode" value="<%=ProCode%>" >
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
