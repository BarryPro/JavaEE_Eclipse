<%
/********************
 version v2.0
 开发商: si-tech
 作者: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%

%>
<html>
<head>
<title>sp增值业务套餐冲正</title>
<%
	
	String opCode="9897";
	String opName="sp增值业务套餐冲正";
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");

	String phoneNo =(String)request.getParameter("srv_no");	//手机号码
	String backaccept = request.getParameter("backaccept");
	System.out.println("phoneNo="+phoneNo);
	System.out.println("backaccept="+backaccept);
    
    String retMsg3="";
    
    String  inputParsm [] = new String[4];
	inputParsm[0] = phoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = backaccept;
	inputParsm[3] = opCode;
    
    String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
    
%>
<wtc:service name="s9897Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg1" outnum="10">
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
</wtc:service>
<wtc:array id="tempArr" scope="end"/>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>

<%
String errCode = retCode;
String errMsg = retMsg1;

System.out.println("errCode="+errCode);
System.out.println("errMsg ="+errMsg);

if(tempArr.length==0)
{
   retMsg3 = "s9897Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
}
else if(!(errCode.equals("000000")))
{
%>
	<script language="javascript">
	 	rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
	 	removeCurrentTab();
	</script>
<%
}
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
function frmCfm()
{
	frm.submit();
	return true;
}

function printCommit()
{
	getAfterPrompt();
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
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="2293" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
		"&phoneNo="+phoneNo+
		"&submitCfm="+submitCfm+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,"",prop);
	return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容

	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";

	opr_info+="受理内容：sp增值业务套餐冲正"+"|";
  	opr_info+="业务流水："+document.all.login_accept.value+"|";
  	note_info1+="备注：sp增值业务套餐冲正"+"|";
	
    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}

</script>
</head>
<body>
<form name="frm" method="post" action="f9897Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
<table cellspacing="0">
	<tr>
		<td class="blue">操作类型</td>
		<td class="blue" colspan="3"><b>sp增值业务套餐冲正</b></td>
	</tr>
	<tr>
		<td class="blue">手机号码</td>
		<td>
			<input name="phone_no" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="phone_no" maxlength="20">
		</td>
		<td class="blue">客户姓名</td>
		<td>
			<input name="cust_name" value="<%=tempArr[0][2]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" >
		</td>
	</tr>
	<tr>
		<td class="blue">营销案类别名称</td>
		<td >
			<input name="type_name" type="text" class="InputGrey" id="type_name" value="<%=tempArr[0][4]%>" readonly>
		</td>
		<td class="blue">营销案名称</td>
		<td>
			<input name="sale_name" type="text"  class="InputGrey" id="sale_name" value="<%=tempArr[0][6]%>" readonly>
		</td>
	</tr>
	<tr class="blue">
		<td class="blue">预存话费金额（元）</td>
		<td>
			<input name="prepay_pay" type="text"  class="InputGrey" id="prepay_pay" value="<%=tempArr[0][7]%>" readonly>
		</td>
		<td class="blue">消费时长（月）</td>
		<td colspan="3">
			<input name="consume_term" type="text"  class="InputGrey" id="consume_term" value="<%=tempArr[0][8]%>" readonly>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer"> 
			<input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" onClick="history.go(-1);" value="返回" >
			&nbsp;
			<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
			&nbsp; 
		</td>
	</tr>
</table>
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opCode" value="<%=opCode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="backaccept" value="<%=backaccept%>">
	<input type="hidden" name="sale_type" value="<%=tempArr[0][3]%>">
	<input type="hidden" name="sale_code" value="<%=tempArr[0][5]%>">
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

