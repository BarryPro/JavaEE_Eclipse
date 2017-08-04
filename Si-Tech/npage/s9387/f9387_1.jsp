<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
    /*
   * 功能: WLAN普通资费套餐申请
   * 版本: 1.0
   * 日期: 2010/6/24
   * 作者: dujl
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");

	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
	String password = (String) session.getAttribute("password");
	/* liujian 安全加固修改 2012-4-6 16:18:13 end */
	int recordNum=0;
	int i=0;

	String iPhoneNo = request.getParameter("srv_no");
	String opFlag = request.getParameter("opFlag");
	String flagName="";
	if(opFlag.equals("10"))
	{
		flagName="套餐申请";
	}
	else if(opFlag.equals("11"))
	{
		flagName="套餐变更";
	}
	else if(opFlag.equals("12"))
	{
		flagName="套餐取消";
	}
	
	System.out.println("===========gejing==========="+iPhoneNo);
	String  inputParsm [] = new String[8];
	inputParsm[0] = "";
	inputParsm[1] = "9";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	/* liujian 安全加固修改 2012-4-6 16:18:13 oneline */
	inputParsm[4] = password;
	inputParsm[5] = iPhoneNo;
	inputParsm[6] = "";
	inputParsm[7] = opFlag;

%>
	<wtc:service name="s9387Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg1">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg1;
	
	System.out.println("errCode="+errCode);
	System.out.println("errMsg ="+errMsg);
	System.out.println("====gejing====="+errMsg);
	
	if(!(errCode.equals("000000")))
	{
	   %>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%
	}
	if(tempArr.length == 0)
	{%>
		<script language="JavaScript">
			rdShowMessageDialog("未查询到该用户基本信息！",0);
			history.go(-1);
		</script>
  <%}

	String Timesql = " SELECT pack_type,type_name FROM swlanmode where  pack_type='07' GROUP BY pack_type,type_name ";
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="TimeRetCode" retmsg="TimeRetMsg" outnum="2">
	<wtc:sql><%=Timesql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<%

String printAccept="";
printAccept = getMaxAccept();

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WLAN普通资费套餐申请</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">

function frmCfm()
{
	frm.submit();
}

function printCommit()
{
	getAfterPrompt();//huangrong add 注意事项的时候提示
	if(document.all.packType.value == "")
	{
		rdShowMessageDialog("请选择套餐类型！");
		return false;
	}
	if(document.all.packCode.value == "")
	{
		rdShowMessageDialog("请选择资费类型！");
		return false;
	}
	
	document.all.commit.disabled = true;//为防止二次确认

	//打印工单并提交表单
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
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
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=document.all.offer_id.value+"~";           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="2289" ;                   			 		//操作代码
	var phoneNo="<%=iPhoneNo%>";                  			//客户电话

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
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
	cust_info+="客户地址：	 "+document.all.custAddr.value+"|";
	cust_info+="证件号码：	 "+document.all.icIccid.value+"|";
	
	opr_info+="操作流水： <%=printAccept%>"+"|";
	opr_info+="受理内容： 手机号码"+document.all.phoneNo.value+"WLAN普通资费套餐申请"+"|";
	note_info1+="备注：WLAN普通资费套餐申请"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function type_chg()
{
	if(document.all.packType.value == "")
	{
		rdShowMessageDialog("请选择套餐类型！");
		return false;
	}
	
	var sql = "90000252";
	var sqlParam = document.all.packType.value+"|";
	
	var rpc_flag = "typeChg";
	
	var myPacket = new AJAXPacket("rpc_select.jsp","正在获取信息，请稍候......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlParam);
	myPacket.data.add("rpc_flag",rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

//begin huangrong add 查询资费代码 2011-2-28
function getMid(bing){
	var pack_code=bing.value;	
	var sql = "90000253";
	var sqlParam = document.all.packType.value + "|" +pack_code+"|";
	
	var rpc_flag = "getMid";
	
	var myPacket = new AJAXPacket("rpc_select2.jsp","正在获取信息，请稍候......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlParam);
	myPacket.data.add("rpc_flag",rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;	
}
//end huangrong add 查询资费代码

function doProcess(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	var rpc_flag = packet.data.findValueByName("rpc_flag");
	self.status="";
	
	if(retCode != "000000")
	{
		rdShowMessageDialog(retMsg);
		return;
	}
	if(rpc_flag == "typeChg")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.packCode,code,text);
	}
	//begin huangrong add 查询offer_id
	if(rpc_flag == "getMid")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		var offer_id=  packet.data.findValueByName("offer_id");		
		document.all.offer_id.value=offer_id;
		getMidPrompt("10442",offer_id,"prompt");
	}
		//end huangrong add 查询offer_id
}

function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--请选择--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(code[i]+"->"+text[i],code[i]);
        obj.add(option1);
	}
}
function FixWidth(selectObj)
{

	if (navigator.userAgent.toLowerCase().indexOf("firefox") > 0) {
		return;
	}

	var newSelectObj = document.createElement("select");
	newSelectObj = selectObj.cloneNode(true);
	newSelectObj.selectedIndex = selectObj.selectedIndex;
	newSelectObj.id="newSelectObj";
  
	var e = selectObj;
	var absTop = e.offsetTop;
	var absLeft = e.offsetLeft;
	while(e = e.offsetParent)
	{
	    absTop += e.offsetTop;
	    absLeft += e.offsetLeft;
	}
	with (newSelectObj.style)
	{
	    position = "absolute";
	    top = absTop + "px";
	    left = absLeft + "px";
	    width = "auto";
	}
   
	var rollback = function(){ RollbackWidth(selectObj, newSelectObj); };
	if(window.addEventListener)
	{
	    newSelectObj.addEventListener("blur", rollback, false);
	    newSelectObj.addEventListener("change", rollback, false);
	}
	else
	{
	    newSelectObj.attachEvent("onblur", rollback);
	    newSelectObj.attachEvent("onchange", rollback);
	}
	
	selectObj.style.visibility = "hidden";
	document.body.appendChild(newSelectObj);
	
	var newDiv = document.createElement("div");
	with (newDiv.style)
	{
	    position = "absolute";
	    top = (absTop-10) + "px";
	    left = (absLeft-10) + "px";
	    width = newSelectObj.offsetWidth+20;
	    height= newSelectObj.offsetHeight+20;;
	    background = "transparent";
	    //background = "green";
	}
	document.body.appendChild(newDiv);
	newSelectObj.focus();
	var enterSel="false";
	var enter = function(){enterSel=enterSelect();};
	newSelectObj.onmouseover = enter;
	
	var leavDiv="false";
	var leave = function(){leavDiv=leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel);};
	newDiv.onmouseleave = leave;
}

function RollbackWidth(selectObj, newSelectObj)
{
    selectObj.selectedIndex = newSelectObj.selectedIndex;
    selectObj.style.visibility = "visible";
    if(document.getElementById("newSelectObj") != null){
       document.body.removeChild(newSelectObj);
    }
}

function removeNewDiv(newDiv)
{
	document.body.removeChild(newDiv);
}

function enterSelect(){
	return "true";
}

function leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel){
	if(enterSel == "true" ){
		RollbackWidth(selectObj, newSelectObj);
		removeNewDiv(newDiv);
	}
}
//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f9387Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="printAccept" value="<%=printAccept%>">
	<input type="hidden" name="offer_id">
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>操作类型</td>
	    <td width="35%" colspan="3">
	    	<input class="InputGrey" type="text" name="oprType" id="oprType" value="<%=flagName%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>客户姓名</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="custName" id="custName" value="<%=tempArr[0][2]%>" size="20" readonly>
	    </td>
		<td class="blue" width="15%" nowrap>手机号码</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="phoneNo" id="phoneNo" value="<%=iPhoneNo%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>客户地址</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="custAddr" id="custAddr" value="<%=tempArr[0][3]%>" size="50" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>业务品牌</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="smCode" id="smCode" value="<%=tempArr[0][6]%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>证件类型</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="icType" id="icType" value="<%=tempArr[0][4]%>" size="20" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>证件号码</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="icIccid" id="icIccid" value="<%=tempArr[0][5]%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>归属地市</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="belongCode" id="belongCode" value="<%=tempArr[0][7]%>" size="20" readonly>
	    </td>
	    <td class="blue" width="15%" nowrap>运行状态</td>
	    <td width="35%">
	    	<input class="InputGrey" type="text" name="runCode" id="runCode" value="<%=tempArr[0][8]%>" size="20" readonly>
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>套餐类型</td>
	    <td width="35%">
	    	<select name="packType" class="button" id="packType" onChange="type_chg()">
    		<option value="">--请选择--</option>
			<%for (int j = 0; j < result1.length; j++) {%>
	      	<option value="<%=result1[j][0]%>"><%=result1[j][0]%>-><%=result1[j][1]%>
	      	</option>
	    	<%}%>
    	</select>
	    </td>
	    <td class="blue" width="15%" id="prompt" nowrap>资费类型</td>
	    <td width="35%">
	    	<select name="packCode" id="packCode" onmouseover="FixWidth(this)" onChange="getMid(this)">
			    <option value="">--请选择--</option>
      		</select>
	    </td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="确认&打印" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp;
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			&nbsp;
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
