<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="8379";
	String opName="赠送预存款";
	
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String loginNoPass = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");  	//数据格式为String[0][0]---String[n][0]
    String iPhoneNo = request.getParameter("srv_no");
    System.out.println("------------===============------------------------------   "+orgCode + "   "+regionCode +"    "+iPhoneNo);
	String iOpCode = request.getParameter("opcode");
	String groupId = (String)session.getAttribute("groupId");
	int recordNum=0;
	int i=0;

	/*begin huangrong add 查询用户所属地市和入网时间 2011-4-26 16:53*/
	String Infosql="SELECT subStr(belong_code,1,2),ceil(months_between(SYSDATE,open_time)) FROM dCustMsg  WHERE phone_no='"+iPhoneNo+"'";
	String cust_belongCode="";
	String cust_openTime="";	
	int opTimeTotal=0;
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="InfoRetCode" retmsg="InfoRetMsg" outnum="2">
	<wtc:sql><%=Infosql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="InfosqlStr" scope="end" />

<%
	if(InfoRetCode.equals("000000"))
	{
		if(InfosqlStr!=null && InfosqlStr.length>0)
	  	{
				cust_belongCode=InfosqlStr[0][0];
				cust_openTime=InfosqlStr[0][1];
				opTimeTotal=Integer.parseInt(cust_openTime);
			}	
	}else
	{
%>	
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=InfoRetCode%>，错误信息：<%=InfoRetMsg%>",0);
				history.go(-1);
			</script>
<%
	}
		/*end huangrong add 查询用户所属地市和入网时间 2011-4-26 16:53*/


	String 	retFlag="",retMsg="",sqlStr="";
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	String  point_note="",open_time="";
	Date    date = new Date();
	SimpleDateFormat df  = new SimpleDateFormat("yyyyMM");
	GregorianCalendar gc = new GregorianCalendar();
	gc.setTime(date); 
	String  time=df.format(gc.getTime());
	System.out.println("time =========================================== "+ time);

	String PrintAccept="";
    PrintAccept = getMaxAccept();

	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);

//	  retList = co2.callFXService("s2289Qry", inputParsm, "30","phone",iPhoneNo);
%>
	<wtc:service name="s2289Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="31" retcode="retCode" retmsg="retMsg1">

		<wtc:param value=" "/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=" "/>
		<wtc:param value="<%=orgCode%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
  String errCode = retCode;
  String errMsg = retMsg1;

  System.out.println("errCode="+errCode);
  System.out.println("errMsg ="+errMsg);

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s2289Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else 
  {
	  if (errCode.equals( "000000") && tempArr.length>0){
	  	if(!(tempArr==null)){
		    bp_name = tempArr[0][3];           //机主姓名
		    bp_add = tempArr[0][4];            //客户地址
		    passwordFromSer = tempArr[0][2];   //密码
		    sm_code = tempArr[0][11];          //业务类别
		    sm_name = tempArr[0][12];          //业务类别名称
		    hand_fee = tempArr[0][13];     	   //手续费
		    favorcode = tempArr[0][14];     	//优惠代码
		    rate_code = tempArr[0][5];    		 //资费代码
		    rate_name = tempArr[0][6];    		//资费名称
		    next_rate_code = tempArr[0][7];		//下月资费代码
		    next_rate_name = tempArr[0][8];		//下月资费名称
		    bigCust_flag = tempArr[0][9];		//大客户标志
		    bigCust_name = tempArr[0][10];		//大客户名称
		    lack_fee = tempArr[0][15];			//总欠费
		    prepay_fee = tempArr[0][16];		//总预交
		    cardId_type = tempArr[0][17];		//证件类型
		    cardId_no = tempArr[0][18];			//证件号码
		    cust_id = tempArr[0][19];			//客户id
		    cust_belong_code = tempArr[0][20];	//客户归属id
		    group_type_code = tempArr[0][21];	//集团客户类型
		    group_type_name = tempArr[0][22];	//集团客户类型名称
		    imain_stream = tempArr[0][23];		//当前资费开通流水
		    next_main_stream = tempArr[0][24];	//预约资费开通流水
		    print_note = tempArr[0][25];		//工单广告
		    contract_flag = tempArr[0][27];		//是否托收账户
		    high_flag = tempArr[0][28];			//是否中高端用户
		    point_note = tempArr[0][29];		//积分清零提示
		    open_time = tempArr[0][30];			//开户时间
		    System.out.println("====wanghfa==== 资费代码 = " + rate_code);
		    System.out.println("====wanghfa==== 资费名称 = " + rate_name);
		    System.out.println("====wanghfa==== 下月资费代码 = " + next_rate_code);
		    System.out.println("====wanghfa==== 下月资费名称 = " + next_rate_name);
	 	}
	}else{%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
				history.go(-1);
			</script>
      <%}
 }
%>

	
<%
	/* 赠送预存款营销案业务方案查询服务(s8379QryType) ningtn */
	String  s8379QryTypeParsm [] = new String[7];
	/* 0	"流水			（iLoginAccept）" */
	s8379QryTypeParsm[0] = PrintAccept;
	/* 1	"渠道标示	（iChnSource）" */
	s8379QryTypeParsm[1] = "01";
	/* 2	"操作代码	（opCode）" */
	s8379QryTypeParsm[2] = opCode;
	/* 3	"工号			（iLoginNo）" */
	s8379QryTypeParsm[3] = loginNo;
	/* 4	"工号密码	（iLoginPwd）" */
	s8379QryTypeParsm[4] = loginNoPass;
	/* 5	"用户号码	（iPhoneNo）" */
	s8379QryTypeParsm[5] = iPhoneNo;
	/* 6	"用户密码	（iUserPwd）" */
	s8379QryTypeParsm[6] = "";
%>
	<wtc:service name="s8379QryType" routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="2" retcode="retCodex1" retmsg="retMsgx1">
		<wtc:param value="<%=s8379QryTypeParsm[0]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[1]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[2]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[3]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[4]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[5]%>"/>
		<wtc:param value="<%=s8379QryTypeParsm[6]%>"/>
	</wtc:service>
	<wtc:array id="resultx1" scope="end"/>
<%
		System.out.println("===== s8379QryType ===" + retCodex1 + "," + retMsgx1);
		if(!"000000".equals(retCodex1)){
%>
			<script language="javascript">
				rdShowMessageDialog("错误代码：" + retCodex1 + "，错误信息：" + retMsgx1,0);
				document.location = "f8379_login.jsp";
			</script>
<%
		}
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>赠送预存款</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
  var arrbrandcode = new Array();//手机型号代码
  var arrbrandname = new Array();//手机型号名称
  var arrbrandmoney = new Array();//代理商代码

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  var arrtypemoney=new Array();
  var arrsalemoney=new Array();

  var arrdetbase=new Array();
  var arrdetfree=new Array();
  var arrdetfavour=new Array();
  var arrdetconsume=new Array();
  var arrdetmonbase=new Array();
  var arrdetmode=new Array();
  var arrdetsummoney=new Array();
  var arrdetsalecode=new Array();


  //--------2---------验证按钮专用函数-------------

function frmCfm()
{
	///////<!-- ningtn add for pos start @ 20100930 -->
	document.all.payType.value = document.all.payTypeSelect.value;
	if(document.all.payType.value=="BX")
	{
		/*set 输入参数*/
		var transerial    = "000000000000";  	                    //交易唯一号 ，将会取消
		var trantype      = "00";         //交易类型
		var bMoney        = document.all.sumMoney.value; 				//缴费金额
		if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
		var tranoper      = "<%=loginNo%>";                       //交易操作员
		var orgid         = "<%=groupId%>";                       //营业员归属机构
		var trannum       = "<%=iPhoneNo%>";                      //电话号码
		getSysDate();       /*取boss系统时间*/
		var respstamp     = document.all.Request_time.value;      //提交时间
		var transerialold = "";																		//原交易唯一号,在缴费时传入空
		var org_code      = "<%=orgCode%>";                       //营业员归属						
		CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
		if(ccbTran=="succ") posSubmitForm();
	}
	else if(document.all.payType.value=="BY")
	{
		var transType     = "05";					/*交易类型 */         
		var bMoney        = document.all.sumMoney.value;         /*交易金额 */
		if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
		var response_time = "";                								 		/*原交易日期 */				
		var rrn           = "";                           				/*原交易系统检索号 */ 
		var instNum       = "";                                   /*分期付款期数 */     
		var terminalId    = "";                    								/*原交易终端号 */			
		getSysDate();       																			//取boss系统时间                                            
		var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
		var workno        = "<%=loginNo%>";                        /*交易操作员 */       
		var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
		var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
		var phoneNo       = "<%=iPhoneNo%>";                       /*交易缴费号 */       
		var toBeUpdate    = "";						                        /*预留字段 */         
		var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
		if(icbcTran=="succ") posSubmitForm();
	}else{
		posSubmitForm();
	}
	
	//////<!-- ningtn add for pos end @ 20100930 -->
}
/* ningtn add for pos start @ 20100930 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	/* ningtn add for pos start @ 20100930 */
 function chkType()
 {
 	document.all.giftCode.value ="";
 	document.all.giftName.value ="";
 	document.all.baseFee.value ="";
 	document.all.freeFee.value ="";
 	document.all.markSubtract.value ="";
 	document.all.baseTerm.value ="";
 	document.all.freeTerm.value ="";
 	document.all.sumMoney.value ="";
 	document.all.payFee.value ="";
 	document.all.Month_Basefee.value ="";
 	

 }
function getInfo_code(){
	var projectTypeVal =  document.frm.projectType.value;
	
	var path = "<%=request.getContextPath()%>/npage/s1141/f8379_getInfo.jsp";
  path = path + "?iProjectType=" + projectTypeVal + "&opCode=" + "<%=opCode%>";
  path = path + "&phoneNo=" + <%=iPhoneNo%> + "&opName=" + "<%=opName%>";
  retInfo = window.showModalDialog(path,"","dialogWidth:"+80);
  
	if(retInfo ==undefined){
		return false;
	}
  var retToField = "giftCode|giftName|payFee|baseFee|freeFee|markSubtract|baseTerm|freeTerm|returnFee|returnTerm|sumMoney|Month_Basefee|";//返回赋值的域	
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
	document.all.systemNote.value = "赠送预存款，方案代码："+document.all.giftCode.value;
	getNode();
}

function getNode()
{
	var packet = new AJAXPacket("getDoNote.jsp","正获取备注信息，请稍候......");
	packet.data.add("projectType", document.frm.projectType.value);
	packet.data.add("code", document.frm.giftCode.value);
  core.ajax.sendPacket(packet,doGetOper);
  packet = null;	
}

function doGetOper(packet){
		var active_note = packet.data.findValueByName("active_note");
	  document.all.systemNote1.value=active_note;
	
}


function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var num = packet.data.findValueByName("num");
	if(retType=="1")
	{
		document.all.Flag.value=num;
	}
}

function businessCheck(){
		
		var projectTypeVal = document.all.projectType.value;
		var giftCodeVal = document.all.giftCode.value;
		var returnFeeVal = document.all.returnFee.value
		var accountMarkVal = document.all.accountMark.value;
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/f8379_check.jsp","正在校验业务限制，请稍候......");
		myPacket.data.add("opCode","<%=opCode%>");
		myPacket.data.add("opName","<%=opName%>");
		myPacket.data.add("phoneNo","<%=iPhoneNo%>");
		myPacket.data.add("iOldMode","<%=rate_code%>");
		myPacket.data.add("iProjectType",projectTypeVal);
		myPacket.data.add("vProjectCode",giftCodeVal);
		myPacket.data.add("iReturnFee",returnFeeVal);
		myPacket.data.add("iAccountMark",accountMarkVal);
		core.ajax.sendPacket(myPacket,doCheck);
}
function doCheck(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	$("#checkHidden").val(retCode);
	if("000000" != retCode){
		rdShowMessageDialog(retCode + ":" + retMsg);
		return false;
	}
}

function printCommit()
{
	
	getAfterPrompt();
 	if(!checkElement(document.all.phoneNo)) return;
	if(document.all.giftCode.value=="")
	{
		rdShowMessageDialog("请输入营销代码!");
		document.all.giftCode.focus();
		return false;
	} 
	if(parseFloat(document.all.markSubtract.value)>0)
	{  
		if(parseFloat(document.all.accountMark.value) < parseFloat(document.all.markSubtract.value))
		{
			rdShowMessageDialog("用户当前积分小于扣减积分,请重新选择!");
			return false;
		}
	}
	businessCheck();
	if("000000" != $("#checkHidden").val()){
		return false;
	}
	document.all.commit.disabled = true;//为防止二次确认

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
	var sysAccept =<%=PrintAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="8379" ;                   			 		//操作代码
	var phoneNo="<%=iPhoneNo%>";                  	 		//客户电话
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
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	var base_fee = document.all.baseFee.value;
	var free_fee = document.all.freeFee.value;
	var pay_fee  = document.all.payFee.value;
	var prepay_fee=document.all.sumMoney.value;
	var return_fee= document.all.returnFee.value;
	var return_term=document.all.returnTerm.value;
	var free_term=document.all.freeTerm.value;
	var month_basefee=document.all.Month_Basefee.value;

	var note=document.all.systemNote1.value;
	
	cust_info+="手机号码："+document.all.phoneNo.value+"|";
	cust_info+="客户姓名："+document.all.custName.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
	cust_info+="证件号码："+document.all.i7.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
		
    if("<%=regionCode%>"=="01" && document.all.giftCode.value=="0019" && document.all.projectType.value=="0002")
    {
    	opr_info+="用户品牌："+document.all.smName.value+"    业务类型：赠送预存款"+"|";
  		opr_info+="业务流水："+document.all.login_accept.value+"|";
  		opr_info+="业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
    	opr_info+="此活动预存款" +free_fee+"元，" + free_fee +"元活动预存款须在"+free_term +
    	           "个月内消费完毕，到期后未消费完毕，系统收回。消费"+month_basefee+
    	           "元(含"+month_basefee+"元)，次月赠送" +return_fee+"元话费，连续赠送"+return_term+
    	           "个月。" + "|";
    	if(note.length>0)
    	{
    		note_info1+="备注："+note+"|";
    	}
    }
    else if("<%=regionCode%>"=="08" && document.all.projectType.value=="0080")
    {
    	
    	var bussName = ''; //业务名称
    	var preTime = '';
    	var noteMsg = '';
    	if(document.all.giftCode.value == '0004'){
    		bussName = '60元入网享120元话费';
    		preTime = '预存款开始时间：2011年01月01日  预存款结束时间：2011年07月01日';
    		notemsg = '用户所交60元预存款从 2011年01月01日起按月返还每月返还20元，3个月返完，最长消费时限6个月（到期消费不完系统自动回收）。';
    	}
    	
  		opr_info+="业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>     用户品牌：<%=sm_name%>"+"|";
   		
   		opr_info+="办理业务："+bussName+"   操作流水："+document.all.login_accept.value+"|";
  		
  		opr_info+=preTime+"|";
   		retInfo+=" "+"|";
   		if(note.length>0)
    	{
    		note_info1+="备注："+note+"|";
    	}
  	  note_info1+="温馨提示：|";
   		note_info1+="1、用户所交预存款不退、不转，到期未使用完，系统自动回收。|";
   		note_info1+="2、"+notemsg+"|";
   		note_info1+="3、所赠话费的使用优先级高于现金预存款。（即：优先使用所赠的话费）|";
   		note_info1+=" "+"|";	
   	
    }
    else
    {
    	opr_info+="用户品牌："+document.all.smName.value+"    业务类型：赠送预存款"+"|";
  		opr_info+="业务流水："+document.all.login_accept.value+"|";
  		opr_info+="业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
    	opr_info+="方案名称："+document.all.giftName.value+"|";
		if(prepay_fee>0)
		{
			opr_info+="预存金额："+prepay_fee+"元 ";
			if(base_fee)
			{
				opr_info+="底线预存："+base_fee+"元 ";
			}
			if(free_fee>0)
			{
				opr_info+="活动预存："+free_fee+"元 ";
			}
			if(pay_fee>0)
			{
				opr_info+="现金："+pay_fee+"元 "+"|";
			}
			if(return_fee>0)
			{
				opr_info+="每月赠送预存款："+return_fee+"元 "+" 赠送预存款月数："+document.all.returnTerm.value+"个月|";
			}
		}else
		{
			if(return_fee>0)
			{
				opr_info+="每月赠送预存款："+return_fee+"元 "+" 赠送预存款月数："+document.all.returnTerm.value+"个月|";
			}
		}
		retInfo+=" "+"|";
	  if(note.length>0)
  	{
  		note_info1+="备注："+note+"|";
  	}
  	else
  	{
			note_info1+="备注：参与活动预存专款过期无效，不退不转"+"|";
		}
		
		retInfo+=" "+"|";
		retInfo+=" "+"|";
		retInfo+=" "+"|";
		retInfo+=" "+"|";
		retInfo+=" "+"|";
    }

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;
}
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f8379_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">业务明细</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">方案类型</td>
		<td colspan="3">
			<select id=projectType name=projectType onChange="chkType()">
<%
				recordNum = resultx1.length;
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + resultx1[i][0] + "'>" + resultx1[i][0]+"-->"+resultx1[i][1] + "</option>");
				}
		   %>
		   </select>
		</td>
	</tr>
	<tr>
		<td class="blue">手机号码</td>
		<td width="39%">
			<input class="InputGrey" type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
		</td>
		<td class="blue">客户名称</td>
		<td>
			<input name="custName" type="text" class="InputGrey" id="custName" value="<%=bp_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">品牌名称</td>
		<td>
			<input name="smName" type="text" class="InputGrey" id="smName" value="<%=sm_name%>" readonly>
		</td>
		<td class="blue">资费名称</td>
		<td>
			<input name="offerName" type="text" class="InputGrey" id="offerName" value="<%=rate_name%>" size ="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">可用预存</td>
		<td>
			<input name="prepayFee" type="text" class="InputGrey" id="prepayFee" value="<%=prepay_fee%>" readonly>
		</td>
		<td class="blue">当前积分</td>
		<td>
			<input name="accountMark" type="text" class="InputGrey" id="accountMark" value="<%=print_note%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">方案代码</td>
		<td>
			<input class="InputGrey" type="text" name="giftCode" id="giftCode" readonly>
			<input class="b_text" type="button" name="query" value="查询" onClick="getInfo_code()" >
				<font color="orange">*</font>
		</td>
		<td class="blue">方案名称</td>
		<td>
			<input name="giftName" type="text" class="InputGrey" id="giftName" v_type="string" v_must=1 value="" size ="40" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">底线预存</td>
		<td>
			<input name="baseFee" type="text" class="InputGrey" id="baseFee" readonly>
		</td>
		<td class="blue">底线消费期限</td>
		<td>
			<input name="baseTerm" type="text" class="InputGrey" id="baseTerm" readonly>
		</td>
	</tr>
	<tr>	
		<td class="blue">活动预存</td>
		<td>
			<input name="freeFee" type="text" class="InputGrey" id="freeFee"   readonly>
		</td>
		<td class="blue">活动消费期限</td>
		<td>
			<input name="freeTerm" type="text" class="InputGrey" id="freeTerm"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">每月赠送预存款</td>
		<td>
			<input name="returnFee" type="text" class="InputGrey" id="returnFee"   readonly>
		</td>
		<td class="blue">赠送预存款月数</td>
		<td>
			<input name="returnTerm" type="text" class="InputGrey" id="returnTerm"   readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">现金</td>
		<td>
			<input name="payFee" type="text" class="InputGrey" id="payFee"   readonly>
		</td>
		<td class="blue">扣减积分</td>
		<td>
			<input name="markSubtract" type="text" class="InputGrey" id="markSubtract"   readonly>
		</td>
	</tr>
	<tr>
	<!-- ningtn add for pos start @ 20100930 -->
		<td class="blue">缴费方式</td>
		<td>
			<select name="payTypeSelect" >
				<option value="0">现金缴费</option>
				<option value="BX">建设银行POS机缴费</option>
				<option value="BY">工商银行POS机缴费</option>
			</select>
		</td>
	<!-- ningtn add for pos start @ 20100930 -->
		<td class="blue">应收金额</td>
		<td>
			<input name="sumMoney" type="text" class="InputGrey" id="sumMoney"   readonly>
		</td>
	</tr>  
	<tr>
		<td class="blue">系统备注</td>
		<td colspan="3">
			<input name="systemNote" type="text" class="InputGrey" id="systemNote"  size="40" readonly>
			<input NAME="systemNote1" id="systemNote1" type="hidden" readonly>
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
	<!-- ningtn add for pos start @ 20100930 -->		
		<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
		<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
		<input type="hidden" name="MerchantId"  value="">
		<input type="hidden" name="TerminalId"  value="">
		<input type="hidden" name="IssCode"  value="">
		<input type="hidden" name="AcqCode"  value="">
		<input type="hidden" name="CardNo"  value="">
		<input type="hidden" name="BatchNo"  value="">
		<input type="hidden" name="Response_time"  value="">
		<input type="hidden" name="Rrn"  value="">
		<input type="hidden" name="AuthNo"  value="">
		<input type="hidden" name="TraceNo"  value="">
		<input type="hidden" name="Request_time"  value="">
		<input type="hidden" name="CardNoPingBi"  value="">
		<input type="hidden" name="ExpDate"  value="">
		<input type="hidden" name="Remak"  value="">
		<input type="hidden" name="TC"  value="">
	<!-- ningtn add for pos end @ 20100930 -->

<div name="licl" id="licl">	
		<input type="hidden" name="Month_Basefee" id="Month_Basefee">
		<input type="hidden" name="iOpCode" value="8379">
		<input type="hidden" name="return_page" value="/npage/s1141/f8379_login.jsp">
		<input type="hidden" name="login_accept" value="<%=PrintAccept%>">
		<input type="hidden" name="i5" value="<%=bp_add%>">
		<input type="hidden" name="i7" value="<%=cardId_no%>">
		<input type="hidden" name="Flag">
		<input type="hidden" name="checkHidden" id="checkHidden" />

</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100930 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100930 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
</html>
