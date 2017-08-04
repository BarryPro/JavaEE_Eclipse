<% 
  /*
   * 功能: 异地主账户现金充值
　 * 版本: v1.00
　 * 日期: 2010/02/24
　 * 作者: dujl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>异地主账户现金充值</title>

<%
String opCode = "9452";
String opName = "异地主账户现金充值";

String work_no = (String) session.getAttribute("workNo");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String phoneNo = WtcUtil.repNull(request.getParameter("srv_no"));
String cCPassWd = WtcUtil.repNull(request.getParameter("cCPassWd"));
String idCardType = WtcUtil.repNull(request.getParameter("idCardType"));
String idCardNum = WtcUtil.repNull(request.getParameter("idCardNum"));

String userStatus="";
String statusChgTime="";
String mPay="";
String homeProv="";

String printAccept="";
printAccept = getMaxAccept();

System.out.println("###########gaopengSeeLog############################phoneNo->" + phoneNo);
System.out.println("###########gaopengSeeLog############################cCPassWd->" + cCPassWd);
System.out.println("###########gaopengSeeLog############################idCardType->" + idCardType);
System.out.println("###########gaopengSeeLog############################idCardNum->" + idCardNum);
%>

<wtc:service name="s9452Init" routerKey="phone" routerValue="<%=phoneNo%>" retCode="initRetCode" retMsg="initRetMsg" outnum="6">
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=phoneNo%>"/>
<wtc:param value="<%=opCode%>"/>
<wtc:param value="<%=cCPassWd%>"/>
<wtc:param value="<%=idCardType%>"/>
<wtc:param value="<%=idCardNum%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>

<%
System.out.println("gaopengSeeLog===========initRetCode=================="+initRetCode);
System.out.println("gaopengSeeLog===========initRetMsg==================="+initRetMsg);

System.out.println("gaopengSeeLog===========result[0][2]=================="+result[0][2]);
if(!(initRetCode.equals("000000")))
{
%>
	<script language=javascript>
		rdShowMessageDialog("错误信息：<%=initRetMsg%>");
		window.location="f9452_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
if((result==null) || (!(result[0][0].equals("000000"))))
{
%>
	<script language=javascript>
		rdShowMessageDialog("错误信息：<%=result[0][1]%>");
		window.location="f9452_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}
if(result[0][2].equals("00"))
{
	userStatus="正常";
}
else if(result[0][2].equals("01"))
{
	userStatus="单向停机";
}
else if(result[0][2].equals("02"))
{
	userStatus="停机";
}
else if(result[0][2].equals("03"))
{
	userStatus="预销号";
}
else if(result[0][2].equals("04"))
{
	userStatus="销号";
}
else if(result[0][2].equals("05"))
{
	userStatus="过户";
}
else if(result[0][2].equals("06"))
{
	userStatus="改号";
}
else if(result[0][2].equals("90"))
{
	userStatus="神州行用户";
}
else if(result[0][2].equals("99"))
{
	userStatus="此号码不存在";
}

if((result[0][2].equals("01")) || (result[0][2].equals("02")) || (result[0][2].equals("03")) || (result[0][2].equals("04")) || (result[0][2].equals("99")))
{
System.out.println("gaopengSeeLog=======11====result[0][2]=================="+result[0][2]);
%>
	<script language="JavaScript">
		rdShowMessageDialog("用户当前状态为<%=userStatus%>不允许充值！");
		window.location.href="f9452_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
	return;
}

statusChgTime=result[0][3];

if(result[0][4].equals("0"))
{
	mPay="开通";
}
else if(result[0][4].equals("1"))
{
	mPay="未开通";
	
%>
	<script language=javascript>
		rdShowMessageDialog("该用户未开通手机支付主账户，无法充值！");
	</script>
<%
}

if(result[0][5].equals("471"))
{
	homeProv="内蒙古";
}
else if(result[0][5].equals("100"))
{
	homeProv="北京";
}
else if(result[0][5].equals("220"))
{
	homeProv="天津";
}
else if(result[0][5].equals("531"))
{
	homeProv="山东";
}
else if(result[0][5].equals("311"))
{
	homeProv="河北";
}
else if(result[0][5].equals("351"))
{
	homeProv="山西";
}
else if(result[0][5].equals("551"))
{
	homeProv="安徽";
}
else if(result[0][5].equals("210"))
{
	homeProv="上海";
}
else if(result[0][5].equals("250"))
{
	homeProv="江苏";
}
else if(result[0][5].equals("571"))
{
	homeProv="浙江";
}
else if(result[0][5].equals("591"))
{
	homeProv="福建";
}
else if(result[0][5].equals("898"))
{
	homeProv="海南";
}
else if(result[0][5].equals("200"))
{
	homeProv="广东";
}
else if(result[0][5].equals("771"))
{
	homeProv="广西";
}
else if(result[0][5].equals("971"))
{
	homeProv="青海";
}
else if(result[0][5].equals("270"))
{
	homeProv="湖北";
}
else if(result[0][5].equals("731"))
{
	homeProv="湖南";
}
else if(result[0][5].equals("791"))
{
	homeProv="江西";
}
else if(result[0][5].equals("371"))
{
	homeProv="河南";
}
else if(result[0][5].equals("891"))
{
	homeProv="西藏";
}
else if(result[0][5].equals("280"))
{
	homeProv="四川";
}
else if(result[0][5].equals("230"))
{
	homeProv="重庆";
}
else if(result[0][5].equals("290"))
{
	homeProv="陕西";
}
else if(result[0][5].equals("851"))
{
	homeProv="贵州";
}
else if(result[0][5].equals("871"))
{
	homeProv="云南";
}
else if(result[0][5].equals("931"))
{
	homeProv="甘肃";
}
else if(result[0][5].equals("951"))
{
	homeProv="宁夏";
}
else if(result[0][5].equals("991"))
{
	homeProv="新疆";
}
else if(result[0][5].equals("431"))
{
	homeProv="吉林";
}
else if(result[0][5].equals("240"))
{
	homeProv="辽宁";
}
else if(result[0][5].equals("451"))
{
	homeProv="黑龙江";
}
else if(result[0][5].equals("999"))
{
	homeProv="交换中心";
}
%>

<script language=javascript>
function printCommit()
{
	if(document.all.payMoney.value.trim()=="")
	{
		rdShowMessageDialog("请输入充值金额！");
		return false;
	}
	if(document.all.homeProvCode.value.trim()=="")
	{
		rdShowMessageDialog("号码归属省不可为空！");
		return false;
	}
	
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
	cust_info+="客户姓名：   ";
	
	opr_info+="操作流水： <%=printAccept%>"+"|";
	opr_info+="受理内容： 手机号码"+document.all.phoneNo.value+"异地主账户现金充值"+document.all.payMoney.value+"元"+"|";
	note_info1+="备注：异地主账户现金充值"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

</script>

</head>
<body>
<form name="frm" method="POST" action="f9452Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>手机号码</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" size="20" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>用户归属省</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="homeProv" id="homeProv" value="<%=homeProv%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>用户状态</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="userStatus" id="userStatus" value="<%=userStatus%>" size="20" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>用户状态变更时间</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="statusChgTime" id="statusChgTime" value="<%=statusChgTime%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>是否开通手机支付业务</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="mPay" id="mPay" value="<%=mPay%>" size="20" readonly>
	    </td>
	    <td nowrap class="blue" width="15%">充值金额</td>
	    <td width="35%">
	    	<input class="button" type="text" name="payMoney" id="payMoney" size="20" maxlength="17">
	    </td>
	</tr>
    <tr>
        <td colspan="7" id="footer">
            <input class="b_foot" type="button" name="b_print" value="确认&打印" onClick="printCommit();">
            &nbsp;
            <input class="b_foot" type="button" name="b_clear" value="返回" onClick="history.go(-1);">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="loginAccept" value="<%=printAccept%>">
<input type="hidden" name="homeProvCode" value="<%=result[0][5]%>">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>