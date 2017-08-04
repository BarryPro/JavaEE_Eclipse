<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>手机阅读</title>
<%
    String opCode = request.getParameter("actionId");
    String opName = request.getParameter("opName");

    String work_no = (String) session.getAttribute("workNo");
    String loginName = (String) session.getAttribute("workName");
    String org_code = (String) session.getAttribute("orgCode");
    String regionCode = org_code.substring(0, 2);
    
    String printAccept="";
	printAccept = getMaxAccept();
	String feeType="";
	String servType="";
	String actionID="";
	String nowActionId="";
	String nowActionCode="";
	if(opCode.equals("7509"))
	{
		nowActionId = "去绑定";
		nowActionCode = "07";
	}
	else if(opCode.equals("7510"))
	{
		nowActionId = "挂失";
		nowActionCode = "04";
	}
	else if(opCode.equals("7511"))
	{
		nowActionId = "解挂";
		nowActionCode = "05";
	}

    int srvStrIndex = 0;
    activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
    String srv_no = WtcUtil.repNull(request.getParameter("srv_no"));
    System.out.println("#######################################srv_no->" + srv_no);

%>

<wtc:service name="s7509Init" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=srv_no%>" outnum="12">
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=srv_no%>"/>
</wtc:service>
<wtc:array id="initStr" scope="end"/>

<%
	
	if (!(initRetCode.equals("000000")))
	{
%>
		<script language=javascript>
        	rdShowMessageDialog("错误信息：<%=initRetMsg%>");
        	window.location="f7509_login.jsp?opCode=<%=opCode%>&activePhone=<%=srv_no%>&opName=<%=opName%>"
			
        </script>
<%
		return;
	}
    if ((initStr==null)||(initStr.length==0))
    {
%>
        <script language=javascript>
        	rdShowMessageDialog("错误信息：<%=initStr[0][1]%>");
        	
        </script>
<%
		return;
    }
	else 
	{
		if(initStr[0][4].equals("0"))
		{
			feeType = "免费";
		}
		else
		{
			feeType = "未知";
		}
		if(initStr[0][5].equals("60"))
		{
			servType = "手机阅读";
		}
		else
		{
			servType = "未知";
		}
		if(initStr[0][8].equals("06"))
		{
			actionID = "绑定";
		}
		else if(initStr[0][8].equals("04"))
		{
			actionID = "挂失";
		}
		else if(initStr[0][8].equals("05"))
		{
			actionID = "解挂";
		}
	}
%>

<script language=javascript>

function printCommit()
{
	if(document.all.nowActionId.value == document.all.actionID.value)
	{
		rdShowMessageDialog("当前状态不能办理该业务!");
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
	if("<%=opCode%>" == "7509")
	{
		frm.action="f7509Cfm.jsp";
	}
	else
	{
		frm.action="f7510Cfm.jsp";
	}
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
	
	opr_info+="操作流水： <%=printAccept%>"+"|";
	opr_info+="受理内容： 手机号码"+document.all.phoneNo.value+"<%=opName%>"+"|";
	note_info1+="备注：<%=opName%>"+"|";
  	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}


</script>
</head>
<body>
<form name="frm" method="POST" action="f7509Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>客户姓名</td>
	    <td nowrap colspan="2" width="35%"><%=initStr[0][9]%>
	    </td>
	    <td class="blue" width="15%" nowrap>用户状态</td>
	    <td nowrap colspan="2"><%=initStr[0][10]%>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>计费用户</td>
	    <td nowrap colspan="2" width="35%"><%=initStr[0][2]%>
	    </td>
	    <td class="blue" width="15%" nowrap>手持终端号码</td>
	    <td nowrap colspan="2"><%=initStr[0][3]%>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>计费类型</td>
	    <td nowrap colspan="2" width="35%"><%=feeType%>
	    </td>
	    <td class="blue" width="15%" nowrap>业务代码</td>
	    <td nowrap colspan="2"><%=servType%>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>生效时间</td>
	    <td nowrap colspan="2" width="35%"><%=initStr[0][6]%>
	    </td>
	    <td nowrap class="blue" width="15%">失效时间</td>
	    <td nowrap colspan="2"><%=initStr[0][7]%>
	    </td>
	</tr>
	<tr>
	    <td class="blue" width="15%" nowrap>当前状态</td>
	    <td nowrap colspan="2" width="35%"><%=actionID%>
	    </td>
	    <td class="blue" width="15%" nowrap>当前操作</td>
	    <td nowrap colspan="2"><%=nowActionId%><font color="red">&nbsp*</font>
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

<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="phoneNo" value="<%=initStr[0][2]%>" >
<input type="hidden" name="custName" value="<%=initStr[0][9]%>" >
<input type="hidden" name="actionID" value="<%=initStr[0][8]%>">
<input type="hidden" name="nowActionId" value="<%=nowActionCode%>" >

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
