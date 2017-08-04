<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 账户转账1364
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update: 
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1310.wrapper.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
	//xl add for order
	String phone2 = request.getParameter("phone2");
	if(phone2==null ||phone2.equals(null))
	{
		phone2="";
	}
	//end
	String opCode="g377";
	String opName="空中充值拆机账户余额转账";
	String phoneno = (String)request.getParameter("phoneno");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String busy_type = request.getParameter("busy_type");
	String contractno=request.getParameter("contractno");
	String accountpassword=request.getParameter("accountpassword");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa accountpassword is "+accountpassword);
	accountpassword = Encrypt.encrypt(accountpassword);
	System.out.println("BBBBBBBBBBBBBBBBBB accountpassword is "+accountpassword);
	//System.out.println("R1364.accountpassword="+accountpassword);
	if (accountpassword == null) {
		//  accountpassword = "0";
		accountpassword = "L";
		//System.out.println("R1364.accountpassword="+accountpassword);
	}

//    ArrayList arlist = new ArrayList();
//	wrapper wrapper = new wrapper();//实例化wrapper
//	arlist = wrapper.s1364Init(contractno,accountpassword,orgCode,busy_type);
%>
	<wtc:service name="bs_g377Init" routerKey="region" routerValue="<%=regionCode%>" outnum="8" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=phoneno%>"/>
		<wtc:param value="<%=contractno%>"/>
		<wtc:param value="<%=accountpassword%>"/>
	 
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 
<%
	System.out.println("WWWWWWWWWW here@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	//System.out.println("WWWWWWWWWWWWWWWWW result ==="+result.length+" and result[0][0] is "+result[0][0]);
	System.out.println("FFFFFFFFFFFFFFFFFFFFFFFF　result is "+result.length); 
 
//	String [][] result = new String[][]{};
//	String [][] result2 = new String[][]{};
//	result = (String[][])arlist.get(0);
	if(result.length==0)
	{
		%>
			<script language="JavaScript">
				rdShowMessageDialog("服务调用失败！",0);
				history.go(-1);
			</script>
		<%
	}
	else
	{
		String return_code =result[0][0];
	String return_message = result[0][1];
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));

	if (!return_code.equals("000000")) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_message%>'。",0);
		history.go(-1);
	</script>
	<%}
	/*
		GPARM32_2    		s_AgtName   	客户名称
		GPARM32_3				s_begin_time	开户时间
		GPARM32_4				l_contract_no	账户ID
		GPARM32_5				d_prepay_fee	账户可转预存
		CPARM32_6				s_Off_Time		账户销户时间
		CPARM32_7				        		欠费
	*/
	String return_money = result[0][5];
	String cust_name =result[0][2];
	String cur_owe =result[0][7];
	String xhsj=result[0][6];
	return_money=return_money.trim();
	cust_name=cust_name.trim();
	cur_owe=cur_owe.trim();
//	result2 = (String[][])arlist.get(1);
	 
 
//	ArrayList retArray = new ArrayList();
//	String[][] result3 = new String[][]{};
//	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String sqlStr = "";
	String id_iccid="";
	String id_address=""; 
	String sm_name="";
	String back_cust="";
	sqlStr = "select c.id_iccid,c.id_address ,d.sm_name ,a.bank_cust from dconmsg a,dcustmsg b,dcustdoc c ,ssmcode d where  a.contract_no ="+contractno +" and a.con_cust_id=b.cust_id  and b.cust_id=c.cust_id and c.region_code=d.region_code and b.sm_code=d.sm_code   ";
//	retArray = callView.sPubSelect("4",sqlStr);

%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode1" retmsg="retMsg1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result3" scope="end" />
<%
//	result3  = (String[][])retArray.get(0);
	if(result3.length>0){
		id_iccid= result3[0][0];
		id_address= result3[0][1];
		sm_name= result3[0][2];
		back_cust= result3[0][3];
	}
	/****得到打印流水****/
	String printAccept="";
	printAccept = getMaxAccept();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-空中充值拆机账户余额转账</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
	TempChar= InString.substring (Count, Count+1);
	if (RefString.indexOf (TempChar, 0)==-1)
	return (false);
}
return (true);
}
function isKeyNumberdot(ifdot)
{
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		}
		else
			  return false;
    }
}
function form_load()
{
form.phoneno2.focus();
}
function docheck()
{
	getAfterPrompt();
   var v_fee = document.form.return_money.value;
   var pay_message="转帐金额不能小于0!";
   var null_message="转帐金额不能为空!";
   var NaN_message="转帐金额应为数字型!";
   var larger_message="转帐金额不能大于帐户剩余金额!";
   var pos;

   if(v_fee == null || v_fee == "")
   {
	    rdShowMessageDialog(null_message);
	    document.form.return_money.select();
		return false;
   }
   if(v_fee><%=return_money%>)
   {
	    rdShowMessageDialog(larger_message);
	    document.form.return_money.select();
		return false;
   }
   if(parseFloat(v_fee) <= 0)
   {
	    rdShowMessageDialog(pay_message);
	    document.form.return_money.select();
		return false;
   }
   if(isNaN(parseFloat(v_fee)))
   {
		rdShowMessageDialog(NaN_message);
	    document.form.return_money.select();
	    return false;
   }
   if(v_fee>9999999999.99)
   {
		rdShowMessageDialog("转帐金额不能大于9999999999.99");
		document.form.return_money.select();
		return false;
   }
   pos=v_fee.indexOf(".");
   if(pos!=-1)
   {
		if(pos>10)
		{
			rdShowMessageDialog("转帐金额小数点前不能大于10位！");
			document.form.return_money.select();
			return false;
		}
		if(v_fee.length-pos>3)
		{
			rdShowMessageDialog("转帐金额小数点后不能大于2位！");
			document.form.return_money.select();
			return false;
		}
   }
   else
   {
		if(v_fee.length>10)
		{
			rdShowMessageDialog("转帐金额小数点前不能大于10位！");
			document.form.return_money.select();
			return false;
		}
   }

	if(form.contractno2.value.length<5&&( form.phoneno2.value.length<11 || isNumberString(form.phoneno2.value,"1234567890")!=1)) {
		rdShowMessageDialog("请输入服务号码,长度为11位数字,或直接输入帐号 !!")
		document.form.phoneno2.focus();
		return false;
	}
	/*20090422 liyan modify 号段改造
	else if (form.contractno2.value.length<5&&(parseInt(form.phoneno2.value.substring(0,3),10)<134 || 158>parseInt(form.phoneno.value.substring(0,3),10)>139||parseInt(form.phoneno.value.substring(0,3),10)>159)){
		rdShowMessageDialog("请输入134-139或是158,159开头的服务号码,或直接输入帐号 !!")
		document.form.phoneno2.focus();
		return false;
	}*/

	else if (!checkPhone(form.phoneno2.value) && form.contractno2.value.length<5)
	{
		rdShowMessageDialog("<%=PhoneHeadErrMsg%>,或直接输入帐号 !");
		return false;
	}

	else if (form.contractno2.value==""){
		rdShowMessageDialog("请输入或查询帐户号码 !!")
		document.form.contractno2.focus();
		return false;
	}
	else if (form.contractno.value==form.contractno2.value)
   {
		rdShowMessageDialog("转存帐户不能与原帐户号码一致！");
		document.form.contractno2.select();
		return false;
	}

	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");

	if((ret=="confirm"))
	{
		if(rdShowConfirmDialog('确认电子免填单吗？')==1)
		{
			  form.action="g377_2.jsp";
			  form.submit();
		}

		if(ret=="remark")
		{
		 	if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			 {
				   form.action="g377_2.jsp";
				   form.submit();
		 	}
		}

	}
	else
	{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		{
			 form.action="g377_2.jsp";
			 form.submit();
		}
	}

	document.form.sure.disabled=true;
	document.form.clear.disabled=true;
	document.form.reset.disabled=true;


}

function showPrtDlg(printType,DlgMessage,submitCfn)
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
	var opCode="g377" ;                   			 		//操作代码
	var phoneNo="<%=phoneno%>";                  	 		//客户电话

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
		"&phoneNo="+document.form.phoneno.value+
		"&submitCfm="+submitCfn+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;

	var ret=window.showModalDialog(path,printStr,prop);
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

    var a ="<%=return_money%>";
	var b = document.form.return_money.value;
	var c=a-b;

    cust_info+="手机号码："+document.form.phoneno.value+"|";
    cust_info+="客户姓名："+"<%=cust_name%>"+"|";
    cust_info+="证件号码："+"<%=id_iccid%>"+"|";
    cust_info+="客户地址："+"<%=id_address%>"+"|";

    opr_info+="用户品牌："+"<%=sm_name%>"+"  办理业务：空中充值拆机账户余额转账"+"  操作流水："+"<%=printAccept%>"+"|";
    opr_info+="帐户名称："+"<%=back_cust%>"+"    帐户号码："+document.form.contractno.value+"  转帐金额："+document.form.return_money.value+"|";
    opr_info+="转存号码："+document.form.phoneno2.value+"  转存帐号："+document.form.contractno2.value+"  转存余额："+c+"|";
    opr_info+='<%=workno%>   <%=workname%>'+"|";
    opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    retInfo+=""+"|";
    retInfo+=""+"|";
    retInfo+=""+"|";
	retInfo+=""+"|";
    retInfo+=""+"|";
	retInfo+=""+"|";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}

function getcount()
{
	if( form.phoneno2.value.length<11 || isNumberString(form.phoneno2.value,"1234567890")!=1 ) {
		rdShowMessageDialog("请输入服务号码,长度为11位数字 !!")
		document.form.phoneno2.focus();
		return false;
	}
	/*20090422 liyan modify 号段改造
	else if (parseInt(form.phoneno2.value.substring(0,3),10)<134 || 158>parseInt(form.phoneno.value.substring(0,3),10)>139||parseInt(form.phoneno.value.substring(0,3),10)>159){
		rdShowMessageDialog("请输入134-139或是158,159开头的服务号码 !!")
		document.form.phoneno2.focus();
		return false;
	}
	*/
	if (!checkPhone(form.phoneno2.value))
	{
		rdShowMessageDialog("<%=PhoneHeadErrMsg%>");
		return false;
	}
	else {
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var str=window.showModalDialog('../s1300/getCount.jsp?phoneNo='+document.form.phoneno2.value,"",prop);

		if( typeof(str) != "undefined" ){
			if (parseInt(str)==0){
		   		rdShowMessageDialog("没有找到对应的帐号！",0);
		   		document.form.phoneno2.focus();
		   		return false;
		   	}
	   		else {
		   		document.form.contractno2.value=str;
		   		document.form.return_money.focus();
		   		return true;
		   	}
			return true;
		}
	}
}

//-->
</script>
</HEAD>
<BODY>
<FORM action="g377_2.jsp" method=post name=form>
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="printAccept"  value="<%=printAccept%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">账户信息</div>
	</div>
<table cellspacing="0">
 
	<tr>
		<td class="blue">服务号码</td>
		<td class="blue">
			<input type="text" name="phoneno" maxlength="11" class="InputGrey" readonly value="<%=phoneno%>">
		</td>
		<td class="blue">帐户号码</td>
		<td width="39%">
			<input type="text" class="InputGrey" readonly name="contractno" value="<%=contractno%>">
		</td>
	</tr>
	<tr>
		<td class="blue">帐户密码</td>
		<td>
			<input type="password" readonly name="accountpassword" class="InputGrey" value="想看密码啊？:)">
		</td>
		<td class="blue">用户姓名</td>
		<td>
			<input type="text" readonly name="contractno3" class="InputGrey" value="<%=cust_name%>">
		</td>
	</tr>
	<tr>
		<td class="blue">未结欠费</td>
		<td>
			<input type="text" name="cur_owe" maxlength="11" class="InputGrey" readonly value="<%=cur_owe%>">
		</td>
		<td class="blue">销户时间</td>
		<td>
			<input type="text" readonly name="xhsj" class="InputGrey" value="<%=xhsj%>">
		</td>
	</tr>
	 
</table>
</div>

 

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">转账明细</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">转存号码</td>
		<td>
			<input type="text" name="phoneno2" maxlength="11" class="button" onkeydown="if(event.keyCode==13)getcount()" onKeyPress="return isKeyNumberdot(0)" value="<%=phone2%>">
			<input class="b_text" name=sure22 type=button value=查询帐号 onClick="getcount();">
		</td>
		<td class="blue">转存帐户</td>
		<td>
			<input type="text" name="contractno2" class="InputGrey" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)document.form.return_money.focus()" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">可转存金额</td>
		<td>
			<input class="InputGrey" readonly name=remark2 value="<%=return_money%>">
		</td>
		<td class="blue">转存金额</td>
		<td>
			<input class="button" name=return_money value="<%=return_money%>">
		</td>
	</tr>
	<tr>
		<td align=center id="footer" colspan="4">
		<input class="b_foot" name=sure type=button value=确认 onclick="docheck()">
		&nbsp;
		<input class="b_foot" name=clear type=reset value=清除>
		&nbsp;
		<input class="b_foot" name=reset type=reset value=返回 onClick="history.go(-1)">
		&nbsp; </td>
	</tr>
</table>

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
<%
	}
	%>
	
