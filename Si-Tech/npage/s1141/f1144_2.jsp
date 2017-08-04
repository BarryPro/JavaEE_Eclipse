<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<!-- **** ningtn add for pos @ 20100414 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100414 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

<%
	String opCode = "1144";
	String opName = "积分换机冲正";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");

	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");
	String paraAray[] = new String[23];
	String sum_money=request.getParameter("sum_money");
	String pay_money=request.getParameter("pay_money");
	String type_name=request.getParameter("type_name");
	String spec_name =request.getParameter("spec_name");
	String spec_fee =request.getParameter("spec_fee");
	
		///////<!-- ningtn add for pos start @ 20100414 -->
		String payType				 = request.getParameter("payType");/**缴费类型 payType=BX 是建行 payType=BY 是工行**/
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
		
		System.out.println("payType : " + payType);
		System.out.println("MerchantNameChs : " + MerchantNameChs);
		System.out.println("MerchantId : " + MerchantId);
		System.out.println("Response_time : " + Response_time);
		System.out.println("TerminalId : " + TerminalId);
		System.out.println("Request_time : " + Request_time);
		System.out.println("Rrn : " + Rrn);
		///////<!-- ningtn add for pos end @ 20100414 -->

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
	System.out.println("------------------------------"+paraAray[2]);
    paraAray[3] = work_no;
	paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
///////<!-- ningtn add for pos start @ 20100414 -->
		paraAray[6]  = payType				 ;
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
///////<!-- ningtn add for pos end @ 20100414 -->
	//String[] ret = impl.callService("s1142Cfm",paraAray,"2","region",org_code.substring(0,2));
%>	
	<wtc:service name="s1142Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode" retmsg="retMsg" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=pass%>"/> 
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value=""/>
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
		<wtc:param value="<%=paraAray[20]%>"/>
		<wtc:param value="<%=paraAray[21]%>"/>
		<wtc:param value="<%=paraAray[22]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	System.out.println("errCode====" + errCode);
	System.out.println("errMsg====" + errMsg);
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />

<%
	if (errCode.equals("000000"))
	{
      //String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(sum_money,2)).get(0)))[0][2];//大写金额
%>
	<script language="javascript">
		/*** ningtn add for pos start @ 20100414 *****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/*** ningtn add for pos end  @ 20100414 *****/
	</script>
    <wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode2" retmsg="retMsg2"outnum="3" >
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
	</wtc:service>
	<wtc:array id="retArr" scope="end"/>
<%
	System.out.println("errCode2===" + retCode2);
	System.out.println("retMsg2===" + retMsg2);
	String chinaFee = retArr[0][2];
    System.out.print(chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! 下面将打印发票！");
   var infoStr="";
   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       积分换机冲正"+"|";//工号
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[1]%>'+"|";
   infoStr+=" "+"|";//协议号码
   infoStr+="手机型号:"+'<%=type_name%>'+"|";//支票号码
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写
   var jkinfo="";
   if("<%=card_money%>"=="0"){
   	jkinfo+="退款合计：  <%=sum_money%>"+
		 "元 含:预存话费　<%=pay_money%>"+"元";
   }else{
   	jkinfo+="退款合计：  <%=sum_money%>"+
		 "元 含:预存话费　<%=pay_money%>"+"元，"+"<%=card_info%>";
	}
   if("<%=spec_fee%>"!="0"){
   	jkinfo=jkinfo+"，"+"<%=spec_name.trim()%>"+" "+"<%=spec_fee.trim()%>"+"元";
   }
   //alert(jkinfo);
	 infoStr+=jkinfo+"|";
   //infoStr+="退款合计：  <%=WtcUtil.formatNumber(sum_money,2)%>"+
		// "含预存话费： <%=WtcUtil.formatNumber(pay_money,2)%>"+"元、"+"<%=card_info%>"+"|";


	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 
		/**** ningtn add for pos start @ 20100414 ****/  
		if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){  
			infoStr+=" "+"|";/*占位第15个参数*/           
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
		/**** ningtn add for pos end  @ 20100414****/    

	 
  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
  //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f1143_login.jsp?activePhone=<%=request.getParameter("phone_no")%>%26opCode=1144%26opName=积分换机冲正";
  var dirtPage="/npage/s1141/f1143_login.jsp?activePhone=<%=request.getParameter("phone_no")%>%26opCode=1144%26opName=积分换机冲正";
  location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage+"&op_code=1144&loginAccept=<%=paraAray[0]%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("积分换机冲正失败!(<%=errMsg%>",0);
	window.location="f1143_login.jsp?activePhone=<%=request.getParameter("phone_no")%>&opCode=1144&opName=积分换机冲正";
</script>
<%}%>
