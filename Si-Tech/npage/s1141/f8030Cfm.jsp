<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-6
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>   

<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
  <%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @ 20100722 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%	
	
	String pktFlag=request.getParameter("pCardSel");
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");

  	String opName = "集团用户预存话费赠机";

	
	String cust_name=request.getParameter("cust_name");
	String imei_no=request.getParameter("IMEINo");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");
	String paraAray[] = new String[44];
	String consum_time = request.getParameter("consum_note");
	String chinaFee ="";
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
	String sum_money = request.getParameter("sum_money");
	/* ningtn add for pos start @ 20100722 */
	String payType			= request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行  EI 是分期付款工商银行**/
	String MerchantNameChs 	= request.getParameter("MerchantNameChs");/**从此开始以下为银行参数**/
	String MerchantId      	= request.getParameter("MerchantId");
	String TerminalId      	= request.getParameter("TerminalId");
	String IssCode         	= request.getParameter("IssCode");
	String AcqCode         	= request.getParameter("AcqCode");
	String CardNo          	= request.getParameter("CardNo");
	String BatchNo         	= request.getParameter("BatchNo");
	String Response_time   	= request.getParameter("Response_time");
	String Rrn             	= request.getParameter("Rrn");
	String AuthNo          	= request.getParameter("AuthNo");
	String TraceNo         	= request.getParameter("TraceNo");
	String Request_time    	= request.getParameter("Request_time");
	String CardNoPingBi    	= request.getParameter("CardNoPingBi");
	String ExpDate         	= request.getParameter("ExpDate");
	String Remak           	= request.getParameter("Remak");
	String TC              	= request.getParameter("TC");
	/* ningtn add for pos start @ 20100722 */
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("sale_type");
	paraAray[5] = request.getParameter("sale_code"); 
	paraAray[6] = request.getParameter("sum_money");
	paraAray[7] = request.getParameter("pay_money");
	paraAray[8] = request.getParameter("opNote");
	paraAray[9] = request.getParameter("ip_Addr");
	paraAray[10] = request.getParameter("vUnitId");
	paraAray[11] = request.getParameter("vUnitName");
	paraAray[12] = request.getParameter("vProductId");
	paraAray[13] = request.getParameter("vProductCode");
	paraAray[14] = request.getParameter("vTargetCode");
	paraAray[15] = request.getParameter("phone_typename");
	paraAray[16] = request.getParameter("IMEINo");
	paraAray[17] = request.getParameter("payTime");
	paraAray[18] = request.getParameter("repairLimit");
	paraAray[19] = request.getParameter("sale_month");
	paraAray[20] = phone_type;
	paraAray[21] = award_flag;
	/* ningtn add for pos start @ 20100722 */
	paraAray[22]  = payType		   ;
	paraAray[23]  = MerchantNameChs ;
	paraAray[24] = MerchantId      ;
	paraAray[25] = TerminalId      ;
	paraAray[26] = IssCode         ;
	paraAray[27] = AcqCode         ;
	paraAray[28] = CardNo          ;
	paraAray[29] = BatchNo         ;
	paraAray[30] = Response_time   ;
	paraAray[31] = Rrn             ;
	paraAray[32] = AuthNo          ;
	paraAray[33] = TraceNo         ;
	paraAray[34] = Request_time    ;
	paraAray[35] = CardNoPingBi    ;
	paraAray[36] = ExpDate         ;
	paraAray[37] = Remak           ;
	paraAray[38] = TC              ;
	/* ningtn add for pos start @ 20100722 */
	/************ tianyang add for 支票缴费 start ****************/
	paraAray[39] = request.getParameter("BankCode");
	paraAray[40] = request.getParameter("checkNo");
	paraAray[41] = request.getParameter("pCardSel");
	/************ tianyang add for 支票缴费 end ****************/
	
	/*** add 工商分期付款 分期付款期数、贴息比例、交易总账 @2013/3/26**/
	String installmentNumStr = WtcUtil.repNull(request.getParameter("installmentNumStr"));
	String installmentIncomeStr = WtcUtil.repNull(request.getParameter("installmentIncomeStr"));
	String transTotal			 = WtcUtil.repNull(request.getParameter("transTotal"));
	paraAray[42] = installmentNumStr;
	paraAray[43] = installmentIncomeStr;
	
	//String[] ret = impl.callService("s8030Cfm",paraAray,"2","region",regionCode);
%>

    <wtc:service name="s8030Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:param value="<%=paraAray[8]%>" />
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:param value="<%=paraAray[10]%>" />
			<wtc:param value="<%=paraAray[11]%>" />
			<wtc:param value="<%=paraAray[12]%>" />
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:param value="<%=paraAray[14]%>" />
			<wtc:param value="<%=paraAray[15]%>" />
			<wtc:param value="<%=paraAray[16]%>" />
			<wtc:param value="<%=paraAray[17]%>" />
			<wtc:param value="<%=paraAray[18]%>" />
			<wtc:param value="<%=paraAray[19]%>" />
			<wtc:param value="<%=paraAray[20]%>" />
			<wtc:param value="<%=paraAray[21]%>" />
			<wtc:param value="<%=paraAray[22]%>"/>
			<wtc:param value="<%=paraAray[23]%>"/>
			<wtc:param value="<%=paraAray[24]%>"/>
			<wtc:param value="<%=paraAray[25]%>"/>
			<wtc:param value="<%=paraAray[26]%>"/>
			<wtc:param value="<%=paraAray[27]%>"/>
			<wtc:param value="<%=paraAray[28]%>"/>
			<wtc:param value="<%=paraAray[29]%>"/>
			<wtc:param value="<%=paraAray[30]%>"/>
			<wtc:param value="<%=paraAray[31]%>"/>
			<wtc:param value="<%=paraAray[32]%>"/>
			<wtc:param value="<%=paraAray[33]%>"/>
			<wtc:param value="<%=paraAray[34]%>"/>
			<wtc:param value="<%=paraAray[35]%>"/>
			<wtc:param value="<%=paraAray[36]%>"/>
			<wtc:param value="<%=paraAray[37]%>"/>
			<wtc:param value="<%=paraAray[38]%>"/>
			<wtc:param value="<%=paraAray[39]%>"/>
			<wtc:param value="<%=paraAray[40]%>"/>
			<wtc:param value="<%=paraAray[41]%>"/>
			<wtc:param value="<%=paraAray[42]%>"/>
			<wtc:param value="<%=paraAray[43]%>"/>
		</wtc:service>

<%	
	String errCode = code1;
	String errMsg = msg1;
	if (errCode.equals("000000"))
	{
	//S1100View callView = new S1100View();
	//String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(paraAray[7],2)).get(0)))[0][2];//大写金额
%>
	<script language="JavaScript">
		/* ningtn add for pos start @ 20100722 **** boss交易成功 调用银行确认函数 ****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/* ningtn add for pos start @ 20100722 **** boss交易成功 调用银行确认函数 ****/
	</script>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    if(result.length>0 && sToChinaFeeCode.equals("0")){
        chinaFee = result[0][2];
    }
	
	System.out.print(chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! 下面将打印发票！",2);
   var infoStr="";
   infoStr+="<%=work_no%>  <%=work_name%>"+"       集团用户预存话费优惠购机"+"|";//工号  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//协议号码                                                          
   infoStr+="手机型号："+"<%=paraAray[15]%>"+"|";//手机型号 
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(paraAray[6],2)%>"+"|";//小写 
   
   /********* tianyang add for 支票缴费 start **************************************/
	var money_pos = "<%=WtcUtil.formatNumber(0,2)%>" ;
	var money_9 = "<%=WtcUtil.formatNumber(0,2)%>" ;
	var money_0 = "<%=WtcUtil.formatNumber(0,2)%>" ;		
	if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
		money_pos = "<%=WtcUtil.formatNumber(paraAray[6],2)%>" ;
	}else if("<%=payType%>"=="9"){
		money_9 = "<%=WtcUtil.formatNumber(paraAray[6],2)%>" ;
	}else{
		money_0 = "<%=WtcUtil.formatNumber(paraAray[6],2)%>" ;
	}
	infoStr+="缴款合计：现金:"+money_0+"　支票:"+money_9+"　POS机:"+money_pos+
		 "　　含预存话费： <%=WtcUtil.formatNumber(paraAray[7],2)%>元"+"		<%=consum_time%>"+"|";	 
	/********* tianyang add for 支票缴费 end **************************************/
	
   /*infoStr+="缴款合计：  <%=WtcUtil.formatNumber(paraAray[6],2)%>    "+
		 "含预存话费： <%=WtcUtil.formatNumber(paraAray[7],2)%>"+"		<%=consum_time%>"+"|";*/
		

	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+="IMEI号码 ："+"<%=imei_no%>"+"|";
	 if( "<%=award_flag%>" == "1" )
	 {
	 	  
	 		infoStr+="已参与赠送礼品活动"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 /* ningtn add for pos start @ 20100722 */
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"||"<%=payType%>"=="EI"){
	 		infoStr+="<%=payType%>"+"|";
		 	infoStr+="<%=MerchantNameChs%>"+"|";
			infoStr+="<%=CardNoPingBi   %>"+"|";
			infoStr+="<%=MerchantId     %>"+"|";
			infoStr+="<%=BatchNo        %>"+"|";
			infoStr+="<%=IssCode        %>"+"|";
			infoStr+="<%=TerminalId     %>"+"|";
			infoStr+="<%=AuthNo         %>"+"|";
			infoStr+="<%=Response_time  %>"+"|";
			infoStr+="<%=Rrn            %>"+"|";
			infoStr+="<%=TraceNo        %>"+"|";
			infoStr+="<%=AcqCode        %>"+"|";
			infoStr+="<%=transTotal     %>"+"|";
	 }
	/* ningtn add for pos end @ 20100722 */
   var dirtPage="/npage/s1141/f8030.jsp?opCode=<%=paraAray[1]%>&opName=<%=opName%>&activePhone=<%=paraAray[3]%>"
   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPage);
    location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=paraAray[1]%>&loginAccept=<%=paraAray[0]%>&dirtPage="+codeChg(dirtPage);

</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("集团用户预存话费优惠购机失败!(<%=errMsg%>",0);
	history.go(-2);
	//window.location.href = "/npage/s1141/f8030_1.jsp?opCode=<%=paraAray[1]%>&opName=<%=opName%>&activePhone=<%=paraAray[3]%>";
</script>
<%}%>
	<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+paraAray[1]+
								 "&retCodeForCntt="+errCode+
								 "&retMsgForCntt="+errMsg+
	               "&opName="+opName+
     	    			 "&workNo="+work_no+
     	    			 "&loginAccept="+paraAray[0]+
     	    			 "&pageActivePhone="+paraAray[3]+
     	    			 "&opBeginTime="+opBeginTime+
     	    			 "&contactId="+paraAray[3]+
     	    			 "&contactType=user";
     	System.out.println(url);
     	    			 %>
<jsp:include page="<%=url%>" flush="true" />