<%
/********************
 version v2.0
开发商: si-tech
update: sunaj@2009-06-22
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<!-- **** ningtn add for pos @ 20100722 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String opCode = "8673";
	String opName = "预存赠G3上网卡冲正";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>

<%

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");

	String phone_no = request.getParameter("phone_no");
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");
	String net_fee=request.getParameter("net_fee");
	String paraAray[] = new String[23];
	String sum_money=request.getParameter("sum_money");
	String pay_money=request.getParameter("pay_money");
	String type_name=request.getParameter("type_name");
	String spec_fee =request.getParameter("spec_fee");
	String login_accept = request.getParameter("login_accept");
	String op_code=request.getParameter("op_code");
	String second_phone=request.getParameter("second_phone").trim();
	String IMEINo=request.getParameter("IMEINo");
	///////<!-- ningtn add for pos start @ 20100722 -->
	String payType		   = request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行**/
	String MerchantNameChs = request.getParameter("MerchantNameChs");/**从此开始以下为银行参数**/
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
	
	///////<!-- ningtn add for pos end @ 20100722 -->
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = op_code;
	paraAray[3] = work_no;
	paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
	///////<!-- ningtn add for pos start @ 20100722 -->
	paraAray[6]  = payType		   ;
	paraAray[7]  = MerchantNameChs ;
	paraAray[8]  = MerchantId      ;
	paraAray[9]  = TerminalId      ;
	paraAray[10] = IssCode         ;
	paraAray[11] = AcqCode         ;
	paraAray[12] = CardNo          ;
	paraAray[13] = BatchNo         ;
	paraAray[14] = Response_time   ;
	paraAray[15] = Rrn             ;
	paraAray[16] = AuthNo          ;
	paraAray[17] = TraceNo         ;
	paraAray[18] = Request_time    ;
	paraAray[19] = CardNoPingBi    ;
	paraAray[20] = ExpDate         ;
	paraAray[21] = Remak           ;
	paraAray[22] = TC              ;
	///////<!-- ningtn add for pos end @ 20100722 -->

%>
<wtc:service  name="s8673Cfm" routerKey="region" routerValue="<%=org_code%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
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
	<wtc:param value="<%=paraAray[20]%>"/>
	<wtc:param value="<%=paraAray[21]%>"/>
	<wtc:param value="<%=paraAray[22]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
	<%
		if("000000".equals(errCode)){
	%>
	<script language="javascript">
		/*** ningtn add for pos start @ 20100722 *****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/*** ningtn add for pos end  @ 20100722 *****/
	</script>
	<%
		}
	%>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+phone_no+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(sum_money,2);
	  String outParaNums= "4";
%>
  	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=org_code%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=ipf%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
	System.out.print(chinaFee);

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
   infoStr+='<%=paraAray[1]%>'+"|";
   infoStr+=" "+"|";//协议号码
   infoStr+="上网卡品牌型号："+'<%=type_name%>'+"|";//支票号码
   //infoStr+="IMEI码："+"<%=IMEINo%>"+"|";
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写
   var jkinfo="";
   jkinfo+="IMEI码<%=IMEINo%>"+",捆绑语音卡号码<%=second_phone%>"+",退款合计<%=sum_money%>"+"元,含数据卡上网费<%=net_fee%>"+"元,语音卡话费<%=pay_money%>"+"元|";
  
   
   //alert(jkinfo);
     infoStr+=jkinfo+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	/**** ningtn add for pos start @ 20100722 ****/      
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
	/**** ningtn add for pos end  @ 20100722****/  
   //location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1141/f1145_login.jsp";
   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f8672_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=opCode%>%26opName=预存赠G3上网卡冲正";
   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCode%>&loginAccept=<%=login_accept%>&dirtPage=/npage/s1141/f8672_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=opCode%>%26opName=预存赠G3上网卡冲正";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("预存赠G3上网卡冲正失败!(<%=errMsg%>");
	window.location="f8672_login.jsp?activePhone=<%=phone_no%>&opCode=<%=opCode%>&opName=预存赠G3上网卡冲正";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>