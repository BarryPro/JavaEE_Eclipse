<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 温馨家庭取消1252
   * 版本: 1.0
   * 日期: 2008/12/24
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="1252";
	String opName="温馨家庭取消";
	String phoneNo = (String)request.getParameter("activePhone");
	String loginNo =(String)session.getAttribute("workNo");    		         //工号
	String loginName =(String)session.getAttribute("workName");               //工号名称
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");		//优惠权限信息
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode =(String)session.getAttribute("orgCode");				//归属代码（机构代码）
%>

<%
  	String retFlag="";				//存放是否校验失败的标志、信息
/****************由移动号码得到密码、机主姓名、温馨家庭申请等信息 s1251Init***********************/
	String[] paraAray1 = new String[4];
	String main_card = request.getParameter("srv_no");
	String passwordFromSer="";

	paraAray1[0] = main_card;		/* 手机号码   */
	paraAray1[1] = loginNo; 	/* 操作工号   */
	paraAray1[2] = orgCode;	/* 归属代码   */
	paraAray1[3] = "1252";	/* 操作代码   */
	for(int i=0; i<paraAray1.length; i++)
	{
		if( paraAray1[i] == null )
		{
	  		paraAray1[i] = "";
		}
	}

%>
	<wtc:service name="s1251Init" routerKey="region" routerValue="<%=regionCode%>" outnum="36" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
	<wtc:array id="familyCodeArr" start="29" length="1" scope="end"/>
	<wtc:array id="otherCodeArr" start="30" length="1" scope="end"/>
	<wtc:array id="cardTypeArr" start="31" length="1" scope="end"/>
	<wtc:array id="beginTimeArr" start="32" length="1" scope="end"/>
	<wtc:array id="endTimeArr" start="33" length="1" scope="end"/>
	<wtc:array id="opTimeArr" start="34" length="1" scope="end"/>
	<wtc:array id="newRateCodeArr" start="35" length="1" scope="end"/>

<%

	String  bp_name="",sm_code="",family_code="",rate_code="",op_type="2",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",print_note="",cardId_no="",bp_add="";
	String otherCardFlag = "" ;							//付卡
	String mainDisabledFlag="";
	/**
	String[][] familyCodeArr= new String[][]{};			//家庭号码
	String[][] otherCodeArr= new String[][]{};			//付卡号码
	String[][] cardTypeArr= new String[][]{};			//卡类型
	String[][] beginTimeArr= new String[][]{};			//开始时间
	String[][] endTimeArr= new String[][]{};			//结束时间
	String[][] opTimeArr= new String[][]{};				//操作时间
	String[][] newRateCodeArr= new String[][]{};		//温馨家庭资费代码
	**/
	String errCode = retCode ;
	String errMsg = retMsg ;

	if(tempArr == null)
	{
		if(!retFlag.equals("1"))
		{
			retFlag="1";
			retMsg="s1251Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
		}
	}else if(!(tempArr == null))
	{
		if (errCode.equals("000000")  ){
			bp_name = tempArr[0][3];						//机主姓名
			passwordFromSer = tempArr[0][2];				//密码
			sm_code = tempArr[0][11];						//业务类别
			cardId_no = tempArr[0][19];						//证件号码
			bp_add = tempArr[0][4];							//客户地址
			sm_name = tempArr[0][12];						//业务类别名称
			rate_code = tempArr[0][5];						//资费代码
			rate_name = tempArr[0][6];						//资费名称
			next_rate_code = tempArr[0][7];					//下月资费代码
			next_rate_name = tempArr[0][8];					//下月资费名称
			bigCust_flag = tempArr[0][9];					//大客户标志
			bigCust_name = tempArr[0][10];					//大客户名称
			lack_fee = tempArr[0][15];						//总欠费
			prepay_fee = tempArr[0][16];					//总预交
			print_note = tempArr[0][27];					//工单广告词
			family_code = tempArr[0][29];
			//判断是否存在申请纪录
			if(familyCodeArr==null || familyCodeArr.length==0 || familyCodeArr[0][0].equals("")){
				if(!retFlag.equals("1"))
				{
					retFlag="1";
					retMsg="该号码没有对应的申请信息!";
				}
			}else if(familyCodeArr.length>1){
				otherCardFlag = "1";//判断是否存在付卡
			}
		}else{
			if(!retFlag.equals("1"))
			{
				retFlag="1";
				retMsg="s1251Init查询号码基本信息失败!"+errMsg;
			}

		}
	}

//********************得到营业员权限，核对密码，并设置优惠权限*****************************//
	int infoLen = favInfo.length;
	String tempStr = "";								//优惠信息
	for(int i=0;i<infoLen;i++)
	{
		tempStr = (favInfo[i][0]).trim();
	}
	String printAccept="";								/****得到打印流水****/
	printAccept = getMaxAccept();

	//******************得到下拉框数据***************************//
	String sqlNewRateCode2  = "";  						//资费代码
	//sqlNewRateCode2  = "select a.mode_code, a.mode_code||'--'||b.mode_name from sRegionNormal a, sBillModeCode b where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code='" + orgCode.substring(0,2) + "'";
	sqlNewRateCode2  = "select a.mode_code, a.mode_code||'--'||b.offer_name from sRegionNormal a, product_offer b where  to_char(a.mode_code)=b.offer_id and a.region_code='" + orgCode.substring(0,2) + "'";

%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2" retCode="retCode2" retMsg="retMsg2">
   		<wtc:sql><%=sqlNewRateCode2%></wtc:sql>
    </wtc:pubselect>
   	<wtc:array id="newRateCodeStr2" scope="end" />
<%
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>温馨家庭取消 </title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
<script language="JavaScript">
    //如果校验失败，则返回上一界面
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>");
	 history.go(-1);
	<%}%>
<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   			//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  function frmCfm(){
	  frm.submit();
	  return true;
  }
  //***//校验one
  function checkOne(){
	var flag = 0;
	var card_type,phoneNo ;
	var radio1 = document.getElementsByName("phoneNo");
	for(var i=0;i<radio1.length;i++){
	  if(radio1[i].checked){
	    flag = 1;
		phoneNo = oneTokSelf(radio1[i].value,"~",1);			//卡号码
		card_type = oneTokSelf(radio1[i].value,"~",2);			//卡类型
		document.frm.phoneNoForPrt.value=phoneNo;
		document.frm.cardTypeForPrt.value=card_type;
	  }
	}
	if(flag==0){
	  rdShowMessageDialog("请选择要取消的号码!");
	  return false;
	}else
	{
	  if(card_type=="1")
	  {
	    if(document.frm.new_rate_code2.value=="")
		{
		  rdShowMessageDialog("请选择新套餐代码!");
		  document.frm.new_rate_code2.focus();
	      return false;
		}
	  }
	}
	return true;
  }

  function printCommitOne(subButton){
	controlButt(subButton);						//延时控制按钮的可用性
	if(!checkOne()) return false;				//校验
	setOpNote();								//为备注赋值
	document.frm.action="f1252Confirm.jsp";
    //打印工单并提交表单
    var ret = showPrtdlg("Detail","确实要进行电子免填单打印吗？","Yes");
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
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

  function showPrtdlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

     var pType="subprint";             				 //打印类型：print 打印 subprint 合并打印
	 var billType="1";              				 //票价类型：1电子免填单、2发票、3收据
	 var sysAccept ="<%=printAccept%>";              //流水号
	 var printStr = printInfo(printType);			 //调用printinfo()返回的打印内容
	 var mode_code=null;           //资费代码
	 var fav_code=null;                				 //特服代码
	 var area_code=null;             				 //小区代码
	 var opCode="1252" ;                   			 //操作代码
	 var phoneNo="<%=phoneNo%>";                  	 //客户电话

     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	 var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     var path = path+"&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.main_card.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
  }

  function printInfo(printType)
  {
		var cust_info="";  //客户信息
		var opr_info="";   //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容

	  var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
	  var card_type_name;//卡类型名称
      if(document.frm.cardTypeForPrt.value=="0")
	  {
		  card_type_name = "0--主卡";
	  }else if(document.frm.cardTypeForPrt.value=="1")
	  {
		  card_type_name = "1--第一付卡";
	  }if(document.frm.cardTypeForPrt.value=="2")
	  {
		  card_type_name = "2--其他付卡";
	  }

//    retInfo+='<%=loginNo%>   <%=loginName%>'+"|";
//	  retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  cust_info+="手机号码："+document.frm.main_card.value+"|";
	  cust_info+="客户姓名：" +document.frm.bp_name.value+"|";
	  cust_info+="证件号码："+"<%=cardId_no%>"+"|";
	  cust_info+="客户地址："+"<%=bp_add%>"+"|";

	  opr_info+="用户品牌:"+"<%=sm_name%>"+"  办理业务：温馨家庭－－取消"+"  操作流水:"+"<%=printAccept%>"+"|";
	  opr_info+="主卡号码:"+document.frm.main_card.value+"   主卡姓名："+document.frm.bp_name.value+"|";
	  if(document.frm.cardTypeForPrt.value=="0"){
	  		opr_info+=" "+"|";
	  }else if(document.frm.cardTypeForPrt.value=="1"){
	  		opr_info+="第一副卡号码:"+document.frm.phoneNoForPrt.value+"   第一副卡执行资费"+document.frm.new_rate_code2.options[document.frm.new_rate_code2.selectedIndex].text+"|";
	  }else {
	 		 opr_info+="其他副卡号码："+document.frm.phoneNoForPrt.value+"|";
	  }
	  opr_info+="生效时间："+exeDate+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
  }

  function oneTokSelf(str,tok,loc)
  {
	    var temStr=str;
		var temLoc;
		var temLen;
	    for(ii=0;ii<loc-1;ii++)
		{
			temLen=temStr.length;
			temLoc=temStr.indexOf(tok);
			temStr=temStr.substring(temLoc+1,temLen);
	 	}
		if(temStr.indexOf(tok)==-1)
		  	return temStr;
		else
	      	return temStr.substring(0,temStr.indexOf(tok));
  }

  /*根据卡类型动态改变行的可见性*/
  function controlByCardType(str)
  {
    var card_type = oneTokSelf(str,"~",2);//卡类型
	var phoneNo = oneTokSelf(str,"~",1);//卡号码
	document.frm.phoneNoForPrt.value=phoneNo;
    document.frm.cardTypeForPrt.value=card_type;
	if(card_type=="1")
	{
		document.all.newRateCode2tr.style.display="";
	}else
	{
	    document.all.newRateCode2tr.style.display="none";
	}
	return true;
  }
/******为备注赋值********/
function setOpNote(){
    if(document.frm.opNote.value=="")
	{  document.frm.opNote.value = "温馨取消;类型:"+document.frm.cardTypeForPrt.value+";主卡:"+document.frm.main_card.value+" ;取消:"+document.frm.phoneNoForPrt.value;
	}
	return true;
}
//-->
//事中提示
function controlFlagCodeTdView(){
	getMidPrompt("10442",codeChg($('#new_rate_code2').val()),"ipTd");
}
</script>

</head>
<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">操作类型</td>
		<td><font color="red"> &nbsp;&nbsp;取消</font></td>
		<td class="blue">主卡号码</td>
		<td>
			<input name="main_card" type="text" id="main_card" value="<%=main_card%>" class="InputGrey" readonly >
		</td>
	</tr>
	<tr >
		<td class="blue">家庭代码</td>
		<td>
			<input name="family_code" type="text" id="family_code" value="<%=family_code%>" class="InputGrey" readonly >
		</td>
		<td class="blue">业务类型</td>
		<td>
			<input name="sm_name" type="text" id="sm_name" value="<%=sm_code + "--" + sm_name%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">当前主套餐</td>
		<td>
			<input name="rate_name" type="text" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" class="InputGrey" readonly>
		</td>
		<td class="blue">下月主套餐</td>
		<td>
			<input name="next_rate_name" type="text" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">机主姓名</td>
		<td>
			<input name="bp_name" type="text" id="bp_name" value="<%=bp_name%>" class="InputGrey" readonly>
		</td>
		<td class="blue">大客户标志</td>
		<td>
			<input name="bigCust_flag" type="text" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
	<td class="blue">总欠费</td>
	<td>
		<input name="lack_fee" type="text" id="lack_fee" value="<%=lack_fee%>" class="InputGrey" readonly >
	</td>
	<td class="blue">总预存</td>
	<td>
		<input name="prepay_fee" type="text" id="prepay_fee" value="<%=prepay_fee%>" class="InputGrey" readonly>
	</td>
	</tr>
	<tr id="newRateCode2tr" style="display:none">
		<td class="blue">新套餐代码</td>
		<td id="ipTd">
			<select id="new_rate_code2"  name="new_rate_code2" class="button" onChange="controlFlagCodeTdView()">
				<option value="">--请选择--</option>
				<%for(int i = 0 ; i < newRateCodeStr2.length ; i ++){%>
				<option value="<%=newRateCodeStr2[i][0]%>"><%=newRateCodeStr2[i][1]%></option>
				<%}%>
			</select>
			<font color="orange">*</font>
		</td>
		<td> </td>
		<td> </td>
	</tr>
	<tr>
		<td height="32" class="blue">备注</td>
		<td colspan="3" height="32">
			<input name="opNote" type="text" id="opNote" size="60" maxlength="60" onFocus="setOpNote();" class="InputGrey" readOnly>
		</td>
	</tr>
</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">选择卡类型</div>
</div>

<table cellSpacing="0">
	<tr align="middle">
		<th align=center>选择</th>
		<th align=center>卡类型</th>
		<th align=center>卡号码</th>
		<th align=center>开始时间</th>
		<th align=center>结束时间</th>
		<th align=center>操作时间</th>
	</tr>
<%
	for(int j=0;j<otherCodeArr.length;j++){
		if(cardTypeArr[j][0].equals("0") && otherCardFlag.equals("1")){
			mainDisabledFlag = "disabled";
		}else{
			mainDisabledFlag = "";
		}
	%>
		<tr>
		<td align="center">
			<input type="radio" name="phoneNo" value="<%=otherCodeArr[j][0]+"~"+cardTypeArr[j][0]+"~"+newRateCodeArr[j][0]%>" <%=mainDisabledFlag%> onClick="controlByCardType(this.value)">
		</td>
		<%if(cardTypeArr[j][0].equals("0")){%>
		<td align="center">主卡</td>
		<%}else if(cardTypeArr[j][0].equals("1")){%>
	 	<td align="center">第一付卡</td>
		<%}else if(cardTypeArr[j][0].equals("2")){%>
		<td align="center">其他付卡</td>
		<%}else{%>
		<td align="center"><%=cardTypeArr[j][0]%></td>
		<%}%>
		<td align="center"><%=otherCodeArr[j][0]%></td>
		<td align="center"><%=beginTimeArr[j][0]%></td>
		<td align="center"><%=endTimeArr[j][0]%></td>
		<td align="center"><%=opTimeArr[j][0]%></td>
		</tr>
	<%
  }
%>
</table>

<table cellSpacing="0">
	<tr>
		<td colspan="4" align="center">
			<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认&打印" onClick="printCommitOne(this)">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp;
			<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
			&nbsp;
		</td>
	</tr>
</table>
	<input type="hidden" name="phoneNoForPrt" ><!--要取消的手机号码,用于打印-->
	<input type="hidden" name="cardTypeForPrt" ><!--要取消的卡类型,用于打印-->
	<input type="hidden" name="printAccept" value="<%=printAccept%>"><!--打印流水-->
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

