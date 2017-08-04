<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>


<!-- **********加载建行控件页******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
<!-- **********加载工行控件页******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>

<%
 	String opCode = "";
	String opName = "";
	String busy_type = WtcUtil.repNull(request.getParameter("busy_type"));	
	/*************add by zhanghonga@2008-09-22,根据busy_type来更改opCode和opName,避免统一接触的opcode,opname记录错误*****************/
  switch(Integer.parseInt(busy_type)){
  	case 2 :
  					opCode = "b924";
  					opName = "集团账号缴费";
  					break;

  	default:
  					opCode = "1302";
  					opName = "普通缴费";
  					break;
  }
  System.out.println("########################################s1311->PayCfm1(最终提交)->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
  
	
	String orgCode     = (String)session.getAttribute("orgCode");
	String regionCode  = orgCode.substring(0,2);
	String workno      = (String)session.getAttribute("workNo");
	String workname    = (String)session.getAttribute("workName");
	String nopass      = (String)session.getAttribute("password");

	String phoneNo     = request.getParameter("phoneNo");
	String contractno  = request.getParameter("contractno");
	String payMoney    = request.getParameter("payMoney");
	String delayRate   = request.getParameter("delayRate");
	String remonthRate = request.getParameter("remonthRate");
	String payType     = request.getParameter("moneyType");
	String pay_note    = request.getParameter("pay_note");/*wangmei add*/
	System.out.println("#######pay_note="+pay_note);

	String  open_time  = request.getParameter("showopentime");
	String  op_code    = request.getParameter("op_code");
	String  batch      = request.getParameter("batch");
	String  batchdate  = request.getParameter("batchdate");
	String  payNote    = request.getParameter("payNote");
	String  bankCode   = request.getParameter("BankCode");
	String  checkNo    = request.getParameter("checkNo");
	String  userName   = request.getParameter("countName");
	String  sum_owefee = request.getParameter("sumowefee");
	String  currentFee = request.getParameter("currentFee");
	String  belongcode = request.getParameter("belongcode");
	String  print_note = request.getParameter("print_note");
	String  pos_code   = request.getParameter("pos_code");
	String  pos_accept = request.getParameter("pos_accept");
	
	/********tianyang add at 20090928 for POS缴费需求****start*****/
	String MerchantNameChs = request.getParameter("MerchantNameChs");
	String MerchantId      = request.getParameter("MerchantId");
	String TerminalId      = request.getParameter("TerminalId");
	String IssCode         = request.getParameter("IssCode");
	String AcqCode         = request.getParameter("AcqCode");
	String CardNo          = request.getParameter("CardNo");
	String BatchNo         = request.getParameter("BatchNo");
	String Response_time   = request.getParameter("Response_time");
	String Rrn             = request.getParameter("Rrn");
	String AuthNo          = request.getParameter("AuthNo");
	String TraceNo         = request.getParameter("TraceNo");
	String Request_time    = request.getParameter("Request_time");
	String CardNoPingBi    = request.getParameter("CardNoPingBi");
	String ExpDate         = request.getParameter("ExpDate");
	String Remak           = request.getParameter("Remak");
	String TC              = request.getParameter("TC");
	/********tianyang add at 20090928 for POS缴费需求****end*******/
	
	System.out.println("#######orgCode="+orgCode);
	System.out.println("#######regionCode="+regionCode);
	System.out.println("#######workno="+workno);
	System.out.println("#######workname="+workname);
	System.out.println("#######nopass="+nopass);
	System.out.println("#######phoneNo="+phoneNo);
	System.out.println("#######contractno="+contractno);
	System.out.println("#######payMoney="+payMoney);
	System.out.println("#######delayRate="+delayRate);
	System.out.println("#######remonthRate="+remonthRate);
	System.out.println("#######payType="+payType);
	System.out.println("#######pay_note="+pay_note);
	
	
	System.out.println("#######open_time="+open_time);
	System.out.println("#######op_code="+op_code);
	System.out.println("#######batch="+batch);
	System.out.println("#######batchdate="+batchdate);
	System.out.println("#######payNote="+payNote);
	System.out.println("#######bankCode="+bankCode);
	System.out.println("#######checkNo="+checkNo);
	System.out.println("#######userName="+userName);
	System.out.println("#######sum_owefee="+sum_owefee);
	System.out.println("#######currentFee="+currentFee);
	System.out.println("#######belongcode="+belongcode);
	System.out.println("#######print_note="+print_note);
	System.out.println("#######pos_code="+pos_code);
	System.out.println("#######pos_accept="+pos_accept);

	String[] phone = new String[]{};
	String paySign=request.getParameter("paySign");
	String flag="0";
	
	if(payType.equals("8"))
	{
		op_code="3459";
		payType ="0";
	}
	
	System.out.println("#####################--->op_code"+op_code);

  String return_page="s1311.jsp";
	if(busy_type.equals("2"))   return_page="s1311.jsp?opCode="+opCode+"&opName="+opName;
   
	String [] inParas = new String[33];
	inParas[0]  = workno;
	inParas[1]  = nopass;
	inParas[2]  = orgCode;
	inParas[3]  = op_code;
	inParas[4]  = contractno;
	inParas[5]  = phoneNo;
	inParas[6]  = payMoney;
	inParas[7]  = payType;
	inParas[8]  = delayRate;
	inParas[9]  = remonthRate;
	inParas[10] = bankCode;
	inParas[11] = checkNo; 
	inParas[12] = payNote; 
	inParas[13] = paySign;
	inParas[14] = pay_note;
	inParas[15] = pos_code;
	inParas[16] = pos_accept;
	/********tianyang add at 20090928 for POS缴费需求****start*****/
	inParas[17] = MerchantNameChs; /*商户名称（中英文)*/
	inParas[18] = MerchantId;      /*商户编码*/
	inParas[19] = TerminalId;      /*终端编码*/
	inParas[20] = IssCode;         /*发卡行号*/
	inParas[21] = AcqCode;         /*收单行号*/
	inParas[22] = CardNo;          /*卡号*/
	inParas[23] = BatchNo;         /*批次号*/
	inParas[24] = Response_time;   /*回应日期时间*/
	inParas[25] = Rrn;             /*参考号*/
	inParas[26] = AuthNo;          /*授权号*/
	inParas[27] = TraceNo;         /*流水号*/
	inParas[28] = Request_time;    /*提交日期时间*/
	inParas[29] = CardNoPingBi;    /*交易卡号（屏蔽*/
	inParas[30] = ExpDate;         /*卡片有效期*/
	inParas[31] = Remak;           /*备注信息*/
	inParas[32] = TC;              /*需要打印，用于EMV交易（芯片卡）*/
	/********tianyang add at 20090928 for POS缴费需求****end*******/

   System.out.println("wwwwwwwww"+contractno);
   
   String result[][] = new String[][]{};
   String loginAccept ="";
   
if(flag.equals("0")){
	if(busy_type.equals("2")){  
%>
	<wtc:service name="s1311Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	<wtc:param value="<%=inParas[11]%>"/>
	<wtc:param value="<%=inParas[12]%>"/>
	<wtc:param value="<%=inParas[13]%>"/>
	<wtc:param value="<%=inParas[14]%>"/>
	<wtc:param value="<%=inParas[15]%>"/>
	<wtc:param value="<%=inParas[16]%>"/>
	<wtc:param value="<%=inParas[17]%>"/>
	<wtc:param value="<%=inParas[18]%>"/>
	<wtc:param value="<%=inParas[19]%>"/>
	<wtc:param value="<%=inParas[20]%>"/>
	<wtc:param value="<%=inParas[21]%>"/>
	<wtc:param value="<%=inParas[22]%>"/>
	<wtc:param value="<%=inParas[23]%>"/>
	<wtc:param value="<%=inParas[24]%>"/>
	<wtc:param value="<%=inParas[25]%>"/>
	<wtc:param value="<%=inParas[26]%>"/>
	<wtc:param value="<%=inParas[27]%>"/>
	<wtc:param value="<%=inParas[28]%>"/>
	<wtc:param value="<%=inParas[29]%>"/>
	<wtc:param value="<%=inParas[30]%>"/>
	<wtc:param value="<%=inParas[31]%>"/>
	<wtc:param value="<%=inParas[32]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
		result = sVerifyTypeArr;
		if(result!=null&&result.length>0){
			if(result[0][1].length()>0){
				loginAccept = result[0][1];		
			}
		}
 }
	
	String return_code="999999";
	String ret_msg="";
	if(result!=null&&result.length>0){
		return_code = result[0][0];
		ret_msg     = result[0][2];
	}

 	if(return_code.equals("139444")){%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("查询错误!<br>错误代码：'<%=return_code%>'，错误信息：'标准神州行用户不允许前台交费'。");
			window.location.href="<%=return_page%>";
		//-->
		</SCRIPT>
	<%}
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	String paySeq="";
	String totalDate="";
	String year="";
	String month="";
	String day="";
%>


<%
	 System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	 String retCodeForCntt = return_code;
	 String retMsgForCntt=ret_msg;
	 String cnttLoginAccept = loginAccept;
	 String url = "";
	 String cnttUserType="";
	 String cnttContactId = contractno;
	 if(busy_type.equals("2")){//1302 账号缴费
	 		cnttContactId = contractno;
	 		cnttUserType = "acc";
	 		url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType+"&retMsgForCntt="+retMsgForCntt+"&opBeginTime="+opBeginTime;
	 }
	 System.out.println("url="+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 
%>


<%
 	if (return_code.equals("000000"))
	{
 
		 paySeq    = result[0][1];
		 totalDate = result[0][2];
		 year      = totalDate.substring(0,4);
		 month     = totalDate.substring(4,6);
		 day       = totalDate.substring(6,8);
		
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT type="text/javascript">
/*tianyang add for pos**** boss交易成功 调用银行确认函数 *****/
if("<%=payType%>"=="BX")
{
	BankCtrl.TranOK();
}
if("<%=payType%>"=="BY")
{
	var IfSuccess = KeeperClient.UpdateICBCControlNum();
}


function ifprint()
{
   var prtFlag=0;

		prtFlag = rdShowConfirmDialogPrint("号码缴费成功！是否打印发票？");
		if (prtFlag==1){
			document.frm_print.action="PrintInvoice1.jsp";
			document.frm_print.submit();
		}else{ 
				rdShowMessageDialog("交易完成!",2);
  		  document.location.replace("<%=return_page%>");
	 }
} 
</SCRIPT>

<body onload="ifprint()">
<form action="" name="frm_print" method="post">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo%>">  
<input type="hidden" name="print_note" value="<%=print_note%>">
</form>
</body></html>
<%
}else{%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("查询错误!<br>错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。");
			window.location.href="<%=return_page%>";

		//-->
		</SCRIPT>
	<%}
}%>
