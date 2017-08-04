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
 	String print_flag = request.getParameter("print_flag");
	String login_aceept = request.getParameter("login_aceept");

	String groupId = (String)session.getAttribute("groupId");
	String opCode = "";
	String opName = "";
	String busy_type = WtcUtil.repNull(request.getParameter("busy_type"));	
	/*************add by zhanghonga@2008-09-22,根据busy_type来更改opCode和opName,避免统一接触的opcode,opname记录错误*****************/
	String ims_flag = request.getParameter("ims_flag");
  switch(Integer.parseInt(busy_type)){
  	case 1 : 
  					opCode = "1302";
  					opName = "号码缴费";
  					break;
  	case 2 :
  					opCode = "1300";
  					opName = "账号缴费";
  					break;
  	case 3 :
  					opCode = "1304";
  					opName = "缴费(托收)";
  					break;
  	case 5 :
  					opCode = "2327";
  					opName = "缴费(托收账号)";
  					break;
  	default:
  					opCode = "1302";
  					opName = "普通缴费";
  					break;
  }
  System.out.println("########################################s1300->PayCfm(最终提交)->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
  
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
 
	
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");

	String phoneNo = request.getParameter("phoneNo");
	String phoneNo1= request.getParameter("phoneNo");
	String contractno = request.getParameter("contractno");
	String payMoney = request.getParameter("payMoney");
	String delayRate = request.getParameter("delayRate");
	String remonthRate = request.getParameter("remonthRate");
	String payType = request.getParameter("moneyType");
	String pay_note = request.getParameter("pay_note");/*wangmei add*/
	System.out.println("#######pay_note="+pay_note);

	String  open_time = request.getParameter("showopentime");
	String  op_code = request.getParameter("op_code");
	String  batch = request.getParameter("batch");
	String  batchdate = request.getParameter("batchdate");
	String  payNote = request.getParameter("payNote");
	String  bankCode= request.getParameter("BankCode");
	String  checkNo= request.getParameter("checkNo");
	String  userName = request.getParameter("countName");
	String  sum_owefee = request.getParameter("sumowefee");
	String  currentFee = request.getParameter("currentFee");
	String  belongcode = request.getParameter("belongcode");
	String  print_note = request.getParameter("print_note");
	String  pos_code = request.getParameter("pos_code");
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
	String id_no="";
  String s_sm_code="";
  String s_sm_name="";
  
		//hq add 根据contract_no查询id_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +" a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contractno;
		System.out.println("-----contractno--------------"+contractno);
		System.out.println("-----inParam_idno[0]--------------"+inParam_idno[0]);		

		
		
	String[] phone = new String[]{};
	String paySign=request.getParameter("paySign");
	String flag="0";
	
	if(payType.equals("8"))
	{
		op_code="3459";
		payType ="0";
	}
	%>

			
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
	<wtc:param value="<%=inParam_idno[0]%>"/>
	<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
	
	
	<%
		if(id_no_arr!=null&&id_no_arr.length>0){
        	id_no = id_no_arr[0][0];
        	phoneNo1 = id_no_arr[0][1].trim();
        
    }

    System.out.println("----------id_no-------------"+id_no);
    System.out.println("----------phoneNo1-------------"+phoneNo1);  
    
        		//查询品牌名称
    String[] inParam = new String[2];
		inParam[0] ="select c.sm_code, c.sm_name  from dcustmsg d,ssmcode c where d.sm_code=c.sm_code and substr(d.belong_code,0,2) =c.region_code and d.phone_no=:smphoneNo";
		inParam[1] = "smphoneNo="+phoneNo1;
		%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
	<wtc:param value="<%=inParam[0]%>"/>
	<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
		
		
		<%    
		if(sm_name_arr!=null&&sm_name_arr.length>0){
      s_sm_code = sm_name_arr[0][0];
      s_sm_name = sm_name_arr[0][1];
 		}		
 

	System.out.println("#####################--->op_code"+op_code);

  String return_page="";
	if(busy_type.equals("1")) 	return_page="s1300.jsp?opCode="+opCode+"&opName="+opName;
	if(busy_type.equals("2"))   return_page="s1300_2.jsp?opCode="+opCode+"&opName="+opName;
	if(busy_type.equals("4"))   return_page="s1300_4.jsp?opCode="+opCode+"&opName="+opName;
	if(busy_type.equals("5"))   return_page="s1300_5.jsp?opCode="+opCode+"&opName="+opName;
   
	String [] inParas = new String[33];
	inParas[0]  = workno;
	inParas[1]  = nopass;
	inParas[2]  = orgCode;
	inParas[3]  = op_code;
	inParas[4]  = contractno;
	inParas[5]  =  phoneNo;
	inParas[6]  = payMoney;
	inParas[7]  = payType;
	inParas[8]  = delayRate;
	inParas[9]  = remonthRate;
	inParas[10] = bankCode;
	inParas[11] = checkNo; 
	inParas[12] =payNote; 
	inParas[13] = paySign;
	inParas[14] = pay_note;
	inParas[15] = pos_code;
	inParas[16] = pos_accept;
	/********tianyang add at 20090928 for POS缴费需求****start*****/
	String s_pay_note="";
	s_pay_note ="本次发票金额:(小写)￥"+payMoney;
	if(MerchantId!="" && (!MerchantId.equals("")))
	{
		s_pay_note+=",商户名称（中英文):"+MerchantNameChs+",商户编码:"+MerchantId+",终端编码:"+TerminalId+",发卡行号:"+IssCode+",收单行号:"+AcqCode+",卡号:"+CardNo+",批次号:"+BatchNo+",回应日期时间:"+Response_time+",参考号:"+Rrn+",授权号:"+AuthNo+",流水号:"+TraceNo+",提交日期时间:"+Request_time+",交易卡号（屏蔽)"+CardNoPingBi+",卡片有效期:"+ExpDate+",备注信息:"+Remak+",芯片卡:"+TC;
	}

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

//System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB test flag is "+flag);
if(flag.equals("0")){
System.out.println("######################## test busy_type is "+busy_type);
		if(busy_type.equals("1")){ 
	    //value  = viewBean.callService("2",phoneNo,"s1300Cfm","3", inParas);
%>

		
	<wtc:service name="s1300Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
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
	if(busy_type.equals("2")){ 
       //value  = viewBean.callService("1", orgCode.substring(0,2), "s1300Cfm","3", inParas); 
%>
	<wtc:service name="s1300Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
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
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=login_aceept%>"/>
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
		if(busy_type.equals("5")){ 
  	 //value  = viewBean.callService("2",phoneNo,"s2327Cfm","3", inParas);
%>
	<wtc:service name="s2327Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
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
	 }else{//号码缴费或者托收缴费.托收单缴费是另一个页面
	 	  cnttContactId = phoneNo;
	 	  cnttUserType = "user";
	 		url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsgForCntt+"&opBeginTime="+opBeginTime+"&contactType="+cnttUserType+"&contactId="+cnttContactId;	
	 }
	 System.out.println("cccccccccccccccccccccccccccccccccccfffffffffffffffffffffffffffffffurl="+url);
	 String url_crm="";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
		//嵌入一个jsp:include的url 调用crm的接口 50.00
		url_crm="/npage/s1300/s_contact_crm.jsp?opCode="+opCode+"&s_login_accept="+loginAccept+"&s_phone_no="+phoneNo;
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa testetestetse payMoney is "+payMoney);
		if(payMoney=="30.00" ||payMoney.equals("30.00"))
		{
			System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb go hehehhehehehehe url_crm is "+url_crm);
			%>
			<jsp:include page="<%=url_crm%>" flush="true" />
			<%
		}
		else
		{
			System.out.println("cccccccccccccccccccccccccccccccccccccccccc 不走这里llllllllllllllll");
		}
		
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 
%>


<%
 	if (return_code.equals("000000"))
	{
 
		 paySeq = result[0][1];
		 totalDate = result[0][2];
		 year = totalDate.substring(0,4);
		 month = totalDate.substring(4,6);
		 day = totalDate.substring(6,8);
		
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
 
 
 
</SCRIPT>

<%
	//add for hanfeng 限制专票记录 beign
	System.out.println("ffffffffffffffffffffffffff test phoneNo is "+phoneNo+" and contractno is "+contractno);
	String[] inParam2_zp = new String[2];
	/*
	if(phoneNo==null || phoneNo.equals(null))
	{
		System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbb ccccccccccccdddddddddddddddddddddddd");
		inParam2_zp[0]="select count(*) from dinvoicebyym a,dconusermsg b,dcustmsg c  where a.phone_no=c.phone_no and b.id_no=c.id_no and b.contract_no=:s_con_no and a.tax_invoice_number is not null and a.chg_flag='1'; ";
		inParam2_zp[1]="s_con_no="+contractno;
	}	
	else
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa hhhhhhhheeeeeerrrreeeeeeeeee");
		inParam2_zp[0]="select to_char(count(*)) from dinvoicebyym where phone_no=:s_no and tax_invoice_number is not null and chg_flag='1' ";
		inParam2_zp[1]="s_no="+phoneNo1;
	}
	*/
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa hhhhhhhheeeeeerrrreeeeeeeeee");
	inParam2_zp[0]="select to_char(count(*)) from dinvoicebyym where phone_no=:s_no and tax_invoice_number is not null and chg_flag='1' ";
	inParam2_zp[1]="s_no="+phoneNo1;
	
	int i_count=0;
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam2_zp[0]%>"/>
		<wtc:param value="<%=inParam2_zp[1]%>"/>
	</wtc:service>
	<wtc:array id="retList" scope="end" />
<%		
	if(retList.length>0)
	{
		i_count=Integer.parseInt(retList[0][0]);
	}
	//end of Hanfeng

	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String s_invoice_flag="";
	
	if(id_no==null||"".equals(id_no)){
     id_no="0";
  }
  if(phoneNo1==null||"".equals(phoneNo1)){
    phoneNo1="0";
  }


  //xl add 根据打印标识判断是否打印发票 
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa print_flag is "+print_flag);
    if(print_flag=="Y" ||print_flag.equals("Y"))
	{
			%>
				<script language="javascript">
					rdShowMessageDialog("预开发票回收成功!");
					window.location.href="<%=return_page%>";
				</script>
			<%
	}
	else
	{%>
		 
 


<body onload="ifprint()">
<form action="" name="frm_print" method="post">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo1%>">  
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="s_invoice_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>">
<input type="hidden" name="userName" value="<%=userName%>">
<input type="hidden" name="ifRed" value="1">
<script language="javascript">
	 function doqx(packet)
	 {
		var s_flag = packet.data.findValueByName("s_flag");	
		var s_code = packet.data.findValueByName("s_code");	//貌似没啥用
		var s_note = packet.data.findValueByName("s_note");	
		var s_invoice_code  = packet.data.findValueByName("s_invoice_code");//貌似也没啥用	
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		//s_flag="1";
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		if(s_flag=="1")
		{
			rdShowMessageDialog("预占取消接口调用异常!");
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("发票预占取消成功,打印完成!",2);
				window.location.href="<%=return_page%>";
			}
			else
			{
				rdShowMessageDialog("发票预占失败! 错误代码:"+s_code,0);

				window.location.href="<%=return_page%>";
			}
		}
	 }
	 function doyz(packet)
	 {
		var ocpy_begin_no = packet.data.findValueByName("ocpy_begin_no");	 
		var ocpy_end_no = packet.data.findValueByName("ocpy_end_no");	
		var ocpy_num  = packet.data.findValueByName("ocpy_num"); 
		var res_code= packet.data.findValueByName("res_code"); 
		var bill_code= packet.data.findValueByName("bill_code");
		var bill_accept= packet.data.findValueByName("bill_accept");
		var s_invoice_flag= packet.data.findValueByName("s_invoice_flag");
		//new
		var s_ret_code  =  packet.data.findValueByName("s_ret_code");
		var s_ret_msg  =  packet.data.findValueByName("s_ret_msg");
		if(s_invoice_flag=="1")
		{
			rdShowMessageDialog("预占接口调用异常!错误代码:"+s_ret_code+",错误原因:"+s_ret_msg);
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("号码缴费成功!当前发票号码是"+ocpy_begin_no+",发票代码是"+bill_code+",是否打印发票?");
				if (prtFlag==1)
				{
					document.frm_print.action="PrintInvoice_1302.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code+"&ims_flag="+"<%=ims_flag%>"+"&returnPage="+"<%=return_page%>";
					document.frm_print.submit();
				}
				else
				{
					var pactket2 = new AJAXPacket("sdis_ocpy.jsp","正在进行发票预占取消，请稍候......");
					//alert("1 服务里应该是按流水改状态 不是插入了");
					pactket2.data.add("ocpy_begin_no",ocpy_begin_no);
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("paySeq","<%=paySeq%>");
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("op_code","<%=op_code%>");
					pactket2.data.add("phoneNo","<%=phoneNo1%>");
					pactket2.data.add("contractno","<%=contractno%>");
					pactket2.data.add("payMoney","<%=payMoney%>");
					pactket2.data.add("userName","<%=userName%>");
					//alert("2 "+pactket1.data);
					 
					core.ajax.sendPacket(pactket2,doqx);
				 
					pactket2=null;
				}
			}
			else
			{
				rdShowMessageDialog("缴费发票预占失败!错误原因:"+s_ret_msg,0);

				window.location.href="<%=return_page%>";
			}
		}
	 }
</script> 
</form>
 <script language="javascript">
		function ifprint()
		{
			/*
				xl add for 打印收据or发票的对话框
			*/
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			var path="s1300_select_invoice_new.jsp?i_count="+"<%=i_count%>";
			var returnValue = window.showModalDialog(path,"",prop);
			//alert("test returnValue is "+returnValue);	
			if(returnValue=="2")
			{
				
				//打印收据时 需要调用xuxz新接口
				var paySeq="<%=paySeq%>";
				var phoneno="<%=phoneNo1%>";
				var kphjje="<%=payMoney%>";//开票合计金额
				var s_hjbhsje=0;//合计不含税金额
				var s_hjse=0;
				var contractno="<%=contractno%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var s_xmmc="<%=opName%>";//项目名称 crm可能为多条? 看下zg17多组怎么传的
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_sj.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&payMoney="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&s_sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=缴费"+"&sj_flag=Y&ims_flag="+"<%=ims_flag%>";
				//document.frm_print.action="PrintInvoice_sj.jsp?sj_flag=Y&ims_flag="+"<%=ims_flag%>&payMoney="+"<%=payMoney%>"+"&id_no="+"<%=id_no%>&s_sm_code="+"<%=s_sm_code%>";
				 
				//alert(document.frm_print.action);
				document.frm_print.submit();
			}
			else if(returnValue=="1")
			{
				var pactket1 = new AJAXPacket("sfp_ocpy.jsp","正在进行发票预占，请稍候......");
				pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
				pactket1.data.add("bill_code","<%=bill_code%>");
				pactket1.data.add("paySeq","<%=paySeq%>");
				pactket1.data.add("bill_code","<%=bill_code%>");
				pactket1.data.add("op_code","<%=op_code%>");
				pactket1.data.add("phoneNo","<%=phoneNo1%>");
				pactket1.data.add("contractno","<%=contractno%>");
				pactket1.data.add("payMoney","<%=payMoney%>");
				pactket1.data.add("userName","<%=userName%>");
				core.ajax.sendPacket(pactket1,doyz);
				pactket1=null;
			}
			else if(returnValue=="3")
			{
				
				//alert("电子的");
				var s_kpxm="<%=opCode%>"+"<%=opName%>";
				var s_ghmfc="<%=userName%>";
				var s_jsheje="<%=payMoney%>";//价税合计金额
				var s_hjbhsje=0;//合计不含税金额
				var s_hjse=0;
				var s_xmmc="号码缴费";//s_kpxm;//项目名称 crm可能为多条? 看下zg17多组怎么传的
				var s_ggxh="";
				var s_hsbz="1";//含税标志 1=含税
				var s_xmdj="<%=payMoney%>";
				var s_xmje="<%=payMoney%>";
				var s_sl="*";
				var s_se="0";
				//新增
				var op_code="<%=opCode%>";
				var payaccept="<%=paySeq%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var phone_no="<%=phoneNo1%>";
				var pay_note=s_kpxm;
				var returnPage="<%=return_page%>";
				var chbz="1";//0红字发票 1普通发票 2原始发票冲红 p原发票作废
				//14 18 27 28 这四个值
				var kphjje = "<%=payMoney%>";
				//alert("s_xmmc is "+s_xmmc);
				//加入参:contractno total_date payAccept
				document.frm_print.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=totalDate%>";
				document.frm_print.submit(); 
				
			}
			else
			{
				var paySeq="<%=paySeq%>";
				var phoneno="<%=phoneNo1%>";
				var kphjje="<%=payMoney%>";//开票合计金额
				var s_hjbhsje=0;//合计不含税金额
				var s_hjse=0;
				var contractno="<%=contractno%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var s_xmmc="<%=opName%>";//项目名称 crm可能为多条? 看下zg17多组怎么传的
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=缴费";
				
				document.frm_print.submit();
			}
			
		}
		

	 
 </script>
 	
</body>
	<%}%>		

</html>
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
		
