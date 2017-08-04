<%
/********************
 version v2.0
开发商: si-tech
update:sunaj@2009-06-22
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = "8672";
	String opName = "预存赠G3上网卡";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
  	String regionCode = orgCode.substring(0,2);
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");  /*上网流量费*/
	String pay_money=request.getParameter("pay_money");   /*赠预存*/
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
	//String prepay_fee=""+Float.parseFloat(pay_money);
	String phone_no = request.getParameter("phone_no");
    String op_code=request.getParameter("op_code");
   
	String new_opCode = request.getParameter("opcode");
	
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
	//liyan add end

    String paraAray[] = new String[39]; /*liyan modify at 20081222 19-->21 */
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = new_opCode ;
  	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("sale_type");
	paraAray[5] = request.getParameter("sale_code");
	paraAray[6] = request.getParameter("used_point");
	paraAray[7] = request.getParameter("sum_money");      /*应付金额*/
	/*paraAray[8] = prepay_fee;                              赠预存*/
	paraAray[8] = request.getParameter("pay_money");       /*赠预存*/
	paraAray[9] = request.getParameter("price");          /*卡费*/
	paraAray[10] = request.getParameter("net_money");     /*上网费*/
	paraAray[11] = request.getParameter("opNote");
	paraAray[12] = request.getParameter("ip_Addr");
	paraAray[13] = request.getParameter("phone_typename");
	paraAray[14] = request.getParameter("IMEINo");
	paraAray[15] = request.getParameter("payTime");
	paraAray[16] = request.getParameter("repairLimit");
	paraAray[17] = phone_type;
	paraAray[18] = award_flag;
	paraAray[19] = request.getParameter("secondphone2");
	paraAray[20] = request.getParameter("Consume_Term"); /*话费期限*/
	paraAray[21] = request.getParameter("Active_Term");  /*网费期限*/
	
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

%>
<wtc:service  name="s8672Cfm" routerKey="region" routerValue="<%=orgCode%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="<%=paraAray[7]%>"/>
	<wtc:param  value="<%=paraAray[8]%>"/>
	<wtc:param  value="<%=paraAray[9]%>"/>
	<wtc:param  value="<%=paraAray[10]%>"/>
	<wtc:param  value="<%=paraAray[11]%>"/>
	<wtc:param  value="<%=paraAray[12]%>"/>
	<wtc:param  value="<%=paraAray[13]%>"/>
	<wtc:param  value="<%=paraAray[14]%>"/>
	<wtc:param  value="<%=paraAray[15]%>"/>
	<wtc:param  value="<%=paraAray[16]%>"/>
	<wtc:param  value="<%=paraAray[17]%>"/>
	<wtc:param  value="<%=paraAray[18]%>"/>
	<wtc:param  value="<%=paraAray[19]%>"/>
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
	<wtc:param  value="<%=paraAray[37]%>"/>
	<wtc:param  value="<%=paraAray[38]%>"/>
	
</wtc:service>
<wtc:array id="ret" scope="end"/>
	<%
		if("000000".equals(errCode)){
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
	<%
		}
	%>
	
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phone_no+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	System.out.println("==========================================="+url);
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(paraAray[7],2);
	  String outParaNums= "4";
%>
  	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=orgCode%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
	<wtc:param  value="<%=ipf%>"/>
	</wtc:service>
	<wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! 打印发票！");
   var infoStr="";

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       预存赠G3上网卡"+"|";//工号	
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//协议号码
   infoStr+="上网卡品牌型号: "+'<%=paraAray[13]%>'+"|";//支票号码	
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(paraAray[7],2)%>"+"|";//小写

    
   var jkinfo="";
   	  
	if("<%=card_money%>"=="0"){
	   	jkinfo+="捆绑语音卡号码：<%=paraAray[19]%> 缴费合计：<%=paraAray[7]%>"+"元，含数据卡上网费<%=paraAray[10]%>"+"元 ，语音卡话费<%=paraAray[8]%>"+"元";　 
	  //含预存话费 <%=pay_money%>"+"元";
	}else{
	     jkinfo+="捆绑语音卡号码：<%=paraAray[19]%>"+"，缴费合计：<%=paraAray[7]%>"+"元，含数据卡上网费<%=paraAray[10]%>"+"元，语音卡话费<%=paraAray[8]%>"+"元";　 
	}
	
   //alert(jkinfo);
	 infoStr+=jkinfo+"|";
	// infoStr+="<%=work_name%>"+"|";//开票人
	infoStr+="<%=work_name%>"+"|";
	 infoStr+=" "+"|";//收款人
	 //孙振兴添加   START
	 infoStr+="IMEI码：<%=paraAray[14]%>"+"|";
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
   // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f8672_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=opCode%>%26opName=预存赠G3上网卡";
    location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCode%>&loginAccept=<%=paraAray[0]%>&dirtPage=/npage/s1141/f8672_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=opCode%>%26opName=预存赠G3上网卡";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("购上网本，赠通信费申请失败!(<%=errMsg%>",0);
	window.location="f8672_login.jsp?activePhone=<%=phone_no%>&opCode=<%=opCode%>&opName=预存赠G3上网卡";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>