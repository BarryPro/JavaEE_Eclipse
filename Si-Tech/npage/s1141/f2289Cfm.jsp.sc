<%
  /*
   * 功能: 统一预存赠礼2289
   * 版本: 1.0
   * 日期: 2008/12/31
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @ 20100408 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String opCode="2289";
	String opName="统一预存赠礼";
	String work_no = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");	/**huangrong 添加  获取工号密码 2011-8-11**/
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String cust_name=request.getParameter("oCustName");
	String Prepay_Fee=request.getParameter("Prepay_Fee");
	String Base_Fee=request.getParameter("Base_Fee");
	String Free_Fee=request.getParameter("Free_Fee");
	String Consume_Term=request.getParameter("Consume_Term");
	String take_prize=request.getParameter("take_prize");/**huangrong 添加 标记是否参与抽奖 1：参与抽奖 0：不参与抽奖**/
	
	/* ningtn add for pos start @ 20100430 */
	System.out.println("======================= f2290Cfm.jsp ===============================");
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
	/* ningtn add for pos start @ 20100430 */
	
	String paraAray[] = new String[27];
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = request.getParameter("iOpCode");
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phoneNo");
	paraAray[4] = request.getParameter("projectType");
	paraAray[5] = request.getParameter("Gift_Code");
	paraAray[6] = request.getParameter("do_note");
	paraAray[7] = request.getParameter("ip_Addr");
	
	/* ningtn add for pos start @ 20100430 */
		paraAray[8] = payType				 ;
		paraAray[9] = MerchantNameChs ;
		paraAray[10] = MerchantId      ;
		paraAray[11] = TerminalId      ;
		paraAray[12] = IssCode         ;
		paraAray[13] = AcqCode         ;
		paraAray[14] = CardNo          ;
		paraAray[15] = BatchNo         ;
		paraAray[16] = Response_time   ;
		paraAray[17] = Rrn             ;
		paraAray[18] = AuthNo          ;
		paraAray[19] = TraceNo         ;
		paraAray[20] = Request_time    ;
		paraAray[21] = CardNoPingBi    ;
		paraAray[22] = ExpDate         ;
		paraAray[23] = Remak           ;
		paraAray[24] = TC              ;
	/* ningtn add for pos start @ 20100430 */
	  paraAray[25] = request.getParameter("flag");	//huangrong add 标记是否为预约营销案 0：普通，1：预约
		paraAray[26] = take_prize              ;
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
//	String[] ret = impl.callService("s2289Cfm",paraAray,"2","region",org_code.substring(0,2));
%>

	<wtc:service name="s2289Init" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode0" retmsg="retMsg0">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="01"/>			
		<wtc:param value="<%=paraAray[1]%>"/>		
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=paraAray[4]%>"/>
	</wtc:service>
	<wtc:array id="s2289Init_result" scope="end"/>
<%

	if (!retCode0.equals("000000") )
	{
%>		
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=retCode0%>，错误信息：<%=retMsg0%>");
			history.go(-1);
		</script>
<%
  }else{
%>				
		
		
	<wtc:service name="s2289Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="6" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>	
		<wtc:param value="<%=password%>"/>		
		<wtc:param value="<%=paraAray[3]%>"/>	
		<wtc:param value=" "/>	
						
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
		<wtc:param value="<%=paraAray[23]%>"/>
		<wtc:param value="<%=paraAray[24]%>"/>
	  <wtc:param value="<%=paraAray[25]%>"/>		
	  <wtc:param value="<%=paraAray[26]%>"/>	
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{             
 	    String statisLoginAccept =request.getParameter("login_accept"); /*流水*/
		String statisOpCode=request.getParameter("iOpCode");
		String statisPhoneNo=request.getParameter("phoneNo"); ;	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("2289"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		<%	
		}		
%>
	<script language="JavaScript">
		/* ningtn add for pos start @ 20100430 **** boss交易成功 调用银行确认函数 ****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/* ningtn add for pos start @ 20100430 **** boss交易成功 调用银行确认函数 ****/
	</script>

<%
//		S1100View callView = new S1100View();
//		String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(Prepay_Fee,2)).get(0)))[0][2];//大写金额
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//大写金额
		System.out.print(chinaFee);
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<script language="JavaScript">
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}	
   rdShowMessageDialog("提交成功! 下面将打印发票！",2);
   var infoStr="";
   var gift_code= Number(<%=request.getParameter("Gift_Code")%>);

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       统一预存赠礼"+"|";//工号
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//协议号码
   if( "<%=org_code.substring(0,2)%>"=="13" &&  "<%=request.getParameter("projectType")%>" == "0004" ){
   		infoStr+=" "+"|";
   }
   else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0005" && "<%=request.getParameter("Gift_Code")%>"=="0001" )
   {
	    infoStr+=" "+"|";
   }
   else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0006" && gift_code>=1 && gift_code <=8 )
   {
	 	 infoStr+=" "+"|";
   }
   else{
   		infoStr+="参与活动，预存款不退"+"|";
   }//9支票号

	 
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"+"|";//小写
   infoStr+="预存金额：<%=WtcUtil.formatNumber(Prepay_Fee,2)%>元    "+
		 "其中底线预存："+"<%=Base_Fee%>元，活动预存："+"<%=Free_Fee%>元,  <%=result[0][4]%>,  <%=result[0][5]%>"+"|";

	 
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
	 infoStr+=" "+"|";//收款人

	 if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0004"  )
	 {
	 	 infoStr+="此活动预存期限"+"<%=Consume_Term%>"+"个月，期间不能参加其他活动，预存款不退不转，不能转签资费。"+"|";
	 }
	 else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0005" && "<%=request.getParameter("Gift_Code")%>"=="0001" )
	 {
	 	 infoStr+="预存金额100元，其中80元分8个月返还，预存款不退不转。"+"|";
	 }
	 else if( "<%=org_code.substring(0,2)%>"=="13" && "<%=request.getParameter("projectType")%>" == "0006" && gift_code>=1 && gift_code <=8 )
	 {
	 	 infoStr+="预存金额<%=WtcUtil.formatNumber(Prepay_Fee,2)%>元，其中120元分12个月返还，预存款不退不转"+"|";
	 }
	 else if( "<%=org_code.substring(0,2)%>"=="08" && "<%=request.getParameter("projectType")%>" == "0012" )
   	 {
	 	 infoStr+="您缴费<%=WtcUtil.formatNumber(Prepay_Fee,2)%>元，获赠礼品一份，所缴话费不退不转"+"|";
   	 }
	 else
	 {
	 	infoStr+=" "+"|";//收款人
	 }
	/* ningtn add for pos start @ 20100430 */
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
	/* ningtn add for pos end @ 20100430 */
	/*
	dirtPate = "/npage/s1141/f2289_login.jsp?activePhone=<%=paraAray[3]%>&opCode=2289&opName=统一预存赠礼";
   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate)+"&op_code=2289&loginAccept=<%=paraAray[0]%>";
   */
	  var billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=work_no%>");
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005","<%=cust_name%>");
		$(billArgsObj).attr("10006","统一预存赠礼");
		$(billArgsObj).attr("10008","<%=paraAray[3]%>");
		$(billArgsObj).attr("10015","<%=WtcUtil.formatNumber(Prepay_Fee,2)%>");//小写
		$(billArgsObj).attr("10016","<%=WtcUtil.formatNumber(Prepay_Fee,2)%>");//合计金额(大写) 传小写，公共页转换
		if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
			$(billArgsObj).attr("10019","*");//本次缴费：刷卡
		}else{
			$(billArgsObj).attr("10017","*");//现金
		}
		$(billArgsObj).attr("10020","");//入网费
		$(billArgsObj).attr("10021","");//手续费
		$(billArgsObj).attr("10022","");//选号费
		$(billArgsObj).attr("10023","");//押金
		$(billArgsObj).attr("10024","");//SIM卡费
		$(billArgsObj).attr("10025","<%=WtcUtil.formatNumber(Prepay_Fee,2)%>");//预存金额
		$(billArgsObj).attr("10026","");//机器费
		$(billArgsObj).attr("10027","");//其他费
		$(billArgsObj).attr("10028","");//参与的营销活动名称
		$(billArgsObj).attr("10047","");//活动代码
		$(billArgsObj).attr("10030","<%=paraAray[0]%>");//业务流水
		$(billArgsObj).attr("10036","2289");
		$(billArgsObj).attr("10031","<%=work_name%>");//开票人
		if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
			$(billArgsObj).attr("10049","<%=payType%>");
			$(billArgsObj).attr("10050","<%=MerchantNameChs%>");
			$(billArgsObj).attr("10051","<%=CardNoPingBi%>");
			$(billArgsObj).attr("10052","<%=MerchantId%>");
			$(billArgsObj).attr("10053","<%=BatchNo%>");
			$(billArgsObj).attr("10054","<%=IssCode%>");
			$(billArgsObj).attr("10055","<%=TerminalId%>");
			$(billArgsObj).attr("10056","<%=AuthNo%>");
			$(billArgsObj).attr("10057","<%=Response_time%>");
			$(billArgsObj).attr("10058","<%=Rrn%>");
			$(billArgsObj).attr("10059","<%=TraceNo%>");
			$(billArgsObj).attr("10060","<%=AcqCode%>");
		}
			
		var printInfo = "";
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？";
		var path = path + "&infoStr="+printInfo+"&loginAccept=<%=paraAray[0]%>&opCode=2289&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
		location = "/npage/s1141/f2289_login.jsp?activePhone=<%=paraAray[3]%>&opCode=2289&opName=统一预存赠礼";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("统一预存赠礼失败!(<%=errMsg%>,<%=errCode%>",0);
	window.location="/npage/s1141/f2289_login.jsp?activePhone=<%=paraAray[3]%>&opCode=2289&opName=统一预存赠礼";
</script>
<%
	}
}
%>
