<%
/********************
 version v2.0
开发商: si-tech
update zhaohaitao at 2008.11.26
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!-- **** ningtn add for pos @ 20100722 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%	
	String opCode = "8678";
	String opName = "积分换G3上网本";
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	
	String cust_name=request.getParameter("cust_name");
	String net_money=request.getParameter("net_money");         /*上网费*/
	String consume_term =request.getParameter("Consume_Term");  /*话费消费期限*/
	/* ningtn add for pos start @ 20100722 */
	String payType			= request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行**/
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
	

	String pay_money=request.getParameter("pay_money");         /*话费*/
	String prepay_fee=""+(Float.parseFloat(pay_money)+Float.parseFloat(net_money));/*话费+上网费*/

	String paraAray[] = new String[37];
	
	//sunzx add at 20070903 
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
    //sunzx add end
	
	
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("sale_type");
	paraAray[5] = request.getParameter("sale_code");
	paraAray[6] = request.getParameter("used_point");     /*消费积分*/
	paraAray[7] = request.getParameter("sum_money");      /*应付金额*/
	paraAray[8] = prepay_fee;
	paraAray[9] = net_money;
	paraAray[10] = request.getParameter("point_money");   /*积分抵消的金额*/
	paraAray[11] = request.getParameter("opNote");
	paraAray[12] = request.getParameter("ip_Addr");
	paraAray[13] = request.getParameter("phone_typename");/*上网本品牌和型号*/
	paraAray[14] = request.getParameter("IMEINo");
	paraAray[15] = request.getParameter("payTime");
	paraAray[16] = request.getParameter("repairLimit");
	paraAray[17] = phone_type;                            /*上网本型号*/
	paraAray[18] = award_flag;
	paraAray[19] = consume_term;
    	
    /* ningtn add for pos start @ 20100722 */
	paraAray[20]  = payType		   ;
	paraAray[21]  = MerchantNameChs ;
	paraAray[22] = MerchantId      ;
	paraAray[23] = TerminalId      ;
	paraAray[24] = IssCode         ;
	paraAray[25] = AcqCode         ;
	paraAray[26] = CardNo          ;
	paraAray[27] = BatchNo         ;
	paraAray[28] = Response_time   ;
	paraAray[29] = Rrn             ;
	paraAray[30] = AuthNo          ;
	paraAray[31] = TraceNo         ;
	paraAray[32] = Request_time    ;
	paraAray[33] = CardNoPingBi    ;
	paraAray[34] = ExpDate         ;
	paraAray[35] = Remak           ;
	paraAray[36] = TC              ;
	/* ningtn add for pos start @ 20100722 */
	String phone_no = paraAray[3];
 
	//String[] ret = impl.callService("s1141Cfm",paraAray,"2","region",org_code.substring(0,2));
  %>
	<wtc:service name="s8678Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>
		<wtc:param value="<%=paraAray[15]%>"/>
		<wtc:param value="<%=paraAray[16]%>"/>
		<wtc:param value="<%=paraAray[17]%>"/>
		<wtc:param value="<%=paraAray[18]%>"/>
		<wtc:param value="<%=paraAray[19]%>"/>
		<wtc:param  value="<%=paraAray[20]%>"/>
		<wtc:param  value="<%=paraAray[21]%>"/>
		<wtc:param  value="<%=paraAray[22]%>"/>
		<wtc:param  value="<%=paraAray[23]%>"/>
		<wtc:param  value="<%=paraAray[24]%>"/>
		<wtc:param  value="<%=paraAray[25]%>"/>
		<wtc:param  value="<%=paraAray[26]%>"/>
		<wtc:param  value="<%=paraAray[27]%>"/>
		<wtc:param  value="<%=paraAray[28]%>"/>
		<wtc:param  value="<%=paraAray[29]%>"/>
		<wtc:param  value="<%=paraAray[30]%>"/>
		<wtc:param  value="<%=paraAray[31]%>"/>
		<wtc:param  value="<%=paraAray[32]%>"/>
		<wtc:param  value="<%=paraAray[33]%>"/>
		<wtc:param  value="<%=paraAray[34]%>"/>
		<wtc:param  value="<%=paraAray[35]%>"/>
		<wtc:param  value="<%=paraAray[36]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
		
  <%
	String errCode = retCode1;
	String errMsg = retMsg1;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
  %>
  <jsp:include page="<%=url%>" flush="true" />
  <%	
	if (errCode.equals("000000"))
	{
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
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="3" >
		<wtc:param value="<%=WtcUtil.formatNumber(paraAray[7],2)%>"/>
	</wtc:service>
	<wtc:array id="retArr" scope="end"/>
  <%
	String chinaFee = retArr[0][2];
    System.out.print("chinaFee="+chinaFee);
  %>
   <script language="JavaScript">
   rdShowMessageDialog("提交成功! 下面将打印发票！");
   var infoStr="";
   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       积分兑换G3上网本"+"|";//工号  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//协议号码                                                          
   infoStr+="上网本品牌型号"+'<%=paraAray[13]%>'+"|";//支票号码 
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(paraAray[7],2)%>"+"|";//小写 
   var jkinfo="";
	jkinfo+="IMEI码<%=paraAray[14]%>"+"，缴款合计：<%=paraAray[7]%>"+"元，其中话费<%=pay_money%>"+"元，上网费<%=net_money%>"+"元，";
	jkinfo+="兑换积分<%=paraAray[6]%>"+"分";
	infoStr+=jkinfo+"|";
		
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 //孙振兴添加   START
	 if( "<%=award_flag%>" == "1" )
	 {
	 	  
	 		infoStr+="已参与赠送礼品活动"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 /* ningtn add for pos start @ 20100722 */
	 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
	 		infoStr+=" "+"|";/*占位第16个参数*/ 
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
	 }
	/* ningtn add for pos end @ 20100722 */
	 //孙振兴添加   END
   location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f8678_login.jsp?activePhone=<%=phone_no%>%26opCode=8678%26opName=积分换G3上网本";
   
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("积分换G3上网本失败!(<%=errMsg%>",0);
	window.location="f8678_login.jsp?activePhone=<%=phone_no%>&opCode=8678&opName=积分换G3上网本";
</script>
<%}%>
 
