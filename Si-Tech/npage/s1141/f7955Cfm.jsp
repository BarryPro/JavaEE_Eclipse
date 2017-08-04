
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>


<!-- **** ningtn add for pos @ 20100408 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%	
	String[][] result = new String[][]{};
	ArrayList retArray = new ArrayList();
	String regionCode= (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr"); 
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");
	String paraAray[] = new String[36];
	
			//增加参数区分网站预约和前台办理 wanghyd
	String banlitype =request.getParameter("banlitype");

	
	//sunzx add at 20070903 
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
	String sum_money=request.getParameter("sum_money");
	String pay_money=request.getParameter("pay_money");
	String TVprice=request.getParameter("TVprice");     //wangdana add for 手机电视费
	
	//begin huangrong add for 手机上网费，Wlan功能费 2011-7-1 
	String phoneNetPrice=request.getParameter("phoneNetPrice");     
	String wlanPrice=request.getParameter("wlanPrice");    
	System.out.println("----------------------------------------------------------------wlanPrice="+wlanPrice);
	//end huangrong add for 手机上网费，Wlan功能费 2011-7-1 
	String prepay_fee =""+(Float.parseFloat(pay_money)+Float.parseFloat(TVprice)+Float.parseFloat(phoneNetPrice)+Float.parseFloat(wlanPrice));   //wangdana add for 手机电视费+话费 ，huangrong update 手机电视费+话费+手机上网费+Wlan功能费
	System.out.println("----------------------------------------------------------------prepay_fee="+prepay_fee);
	String phone_money=""+(Float.parseFloat(sum_money)-Float.parseFloat(pay_money)-Float.parseFloat(TVprice)-Float.parseFloat(phoneNetPrice)-Float.parseFloat(wlanPrice));//huangrong update 购机款增加对手机上网费和Wlan功能费费用的扣减

	/********tianyang add at 20090928 for POS缴费需求****start*****/
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
	/********tianyang add at 20090928 for POS缴费需求****end*******/
	
    //sunzx add end
	System.out.println("phone_money============================================================================="+phone_money);
	
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("sale_type");
	paraAray[5] = request.getParameter("sale_code");
	paraAray[6] = request.getParameter("used_point");
	paraAray[7] = request.getParameter("sum_money");
	paraAray[8] = request.getParameter("pay_money");
	paraAray[9] = request.getParameter("card_dz");
	paraAray[10] = request.getParameter("point_money");
	paraAray[11] = request.getParameter("opNote");
	paraAray[12] = request.getParameter("ip_Addr");
	paraAray[13] = request.getParameter("phone_typename");
	paraAray[14] = request.getParameter("IMEINo");
	paraAray[15] = request.getParameter("payTime");
	paraAray[16] = request.getParameter("repairLimit");
	
	paraAray[17] = phone_type;
	paraAray[18] = award_flag;
	
	paraAray[19] = payType				 ;
  paraAray[20] = MerchantNameChs ;
  paraAray[21] = MerchantId      ;
  paraAray[22] = TerminalId      ;
  paraAray[23] = IssCode         ;
  paraAray[24] = AcqCode         ;
  paraAray[25] = CardNo          ;
  paraAray[26] = BatchNo         ;
  paraAray[27] = Response_time   ;
  paraAray[28] = Rrn             ;
  paraAray[29] = AuthNo          ;
  paraAray[30] = TraceNo         ;
  paraAray[31] = Request_time    ;
  paraAray[32] = CardNoPingBi    ;
  paraAray[33] = ExpDate         ;
  paraAray[34] = Remak           ;
  paraAray[35] = TC              ;
  
    	
	
              

	
	%>
	<wtc:service name="s1141Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=pass%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
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
	<%	
	if(banlitype.equals("1")) {//如果是网站预约办理的话加一个参数。wanghyd
	%>
	<wtc:param value="<%=banlitype%>"/>
	<%
	}
	%>
	
	</wtc:service>
	<wtc:array id="ret" scope="end" />
	
	<%

	if (errCode.equals("000000"))
	{		 	             
 	    String statisLoginAccept =  request.getParameter("login_accept"); /*流水*/
		String statisOpCode=request.getParameter("opcode");
		String statisPhoneNo= request.getParameter("phone_no");	
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
    	
   		if (statisOpCode.equals("7955"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}		
 	          
	 if(banlitype.equals("1")) {//如果是网站预约办理的话调用385cfm服务。wanghyd
	    System.out.println("7955调用sE385Cfm服务开始");
	    
			String iOpCode = 		request.getParameter("opcode");
			String iLoginNo = 		work_no;
			String iLoginPwd = 		pass;
			String iPhoneNo = 		request.getParameter("phone_no");	
			String iUserPwd = 		"";
			String inOpNote = 		request.getParameter("opNote");
			String iBookingId = 	"";
			String iLoginAccept=  request.getParameter("login_accept"); 
			String booking_url = "/npage/public/pubCfmBookingInfo.jsp?iOpCode="+iOpCode
				+"&iLoginNo="+iLoginNo
				+"&iLoginPwd="+iLoginPwd
				+"&iPhoneNo="+iPhoneNo
				+"&iUserPwd="+iUserPwd
				+"&inOpNote"+inOpNote
				+"&iLoginAccept="+iLoginAccept
				+"&iBookingId="+iBookingId;		
			System.out.println("booking_url="+booking_url);
			%>
			<jsp:include page="<%=booking_url%>" flush="true" />
			<%
		System.out.println("%%%%%%%调用预约服务结束%%%%%%%%"); 
		System.out.println("7955调用sE385Cfm服务结束");
		}
		%>
		
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=WtcUtil.formatNumber(phone_money,2)%>"/>
		</wtc:service>
		<wtc:array id="result111" scope="end"/>
			
			<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode2" retmsg="retMsg2">
			<wtc:param value="<%=WtcUtil.formatNumber(prepay_fee,2)%>"/>
		</wtc:service>
		<wtc:array id="result112" scope="end"/>
		<%
		String phoneFee_china = result111[0][2]; 
		String parepayfee_china = result112[0][2]; 
		System.out.println(phoneFee_china);
		System.out.println(parepayfee_china);

		/*** 第二张发票的打印流水 ***/
		
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
<script language="JavaScript">
	
		/*** tianyang add for pos start *** boss交易成功 调用银行确认函数 *****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/*** tianyang add for pos end *** boss交易成功 调用银行确认函数 *****/
		

	function showPrtDlg(DlgMessage,printStr,payType,prtAcc)
	{
	//alert(DlgMessage+"+++"+printStr+"+++"+payType+"+++"+prtAcc)
		//显示打印对话框
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var pType="subprint";		
		var billType = "2";
		
		var mode_code=null;
		var fav_code=null;
		var area_code=null;
		var submitCfm = "Yes";
		var sysAccept = prtAcc;
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no;	scrollbars:yes; resizable:no;location:no;status:no;help:no"		
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jd.jsp?DlgMsg=" + DlgMessage;
		var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=paraAray[1]%>&sysAccept="+sysAccept+"&phoneNo="+"<%=paraAray[3]%>"+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr + "&payType=" + payType;		
		var ret=window.showModalDialog(path,printStr,prop);	
		
		
	}

	
		function printInfo(printType)
	{
		var infoStr = "";		  
		if (printType == "Detail") {		//免填单
				alert("拼接免填单字符串");
		} else if (printType == "Bill") {	//发票
		   infoStr+="<%=work_no%>  <%=work_name%>"+"       购机赠话费（按月返还）2-1"+"|";//工号
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+=" 手机型号：<%=paraAray[13]%>  IMEI码：<%=paraAray[14]%>"+"|";
		   infoStr+='<%=paraAray[3]%>'+"|";
		   infoStr+=" "+"|";//协议号码
		   infoStr+=" "+"|";
		   infoStr+="<%=phoneFee_china%>"+"|";//合计金额(大写)
		   infoStr+="<%=WtcUtil.formatNumber(phone_money,2)%>"+"|";//小写
		   infoStr+=" "+"|";
		   infoStr+="<%=work_name%>"+"|";//开票人
	     infoStr+=" "+"|";//收款人
	     infoStr+=" "+"|";//收款人
	     	if( "<%=award_flag%>" == "1" ) {
					infoStr+="已参与赠送礼品活动"+"|";
				}
				else {
					infoStr+=" "+"|";
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

       rdShowMessageDialog("打印第二张发票！",2);
       var infoStr2 = "";	
       infoStr2+="<%=work_no%>  <%=work_name%>"+"       购机赠话费（按月返还）2-2"+"|";//工号
       infoStr2+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=cust_name%>'+"|";
		   infoStr2+="手机型号：<%=paraAray[13]%>  IMEI码：<%=paraAray[14]%>"+"|";
		   infoStr2+='<%=paraAray[3]%>'+"|";
		   infoStr2+="1"+"|";//协议号码
		   infoStr2+=" "+"|";
		   infoStr2+="<%=parepayfee_china%>"+"|";//合计金额(大写)
		   infoStr2+="<%=WtcUtil.formatNumber(prepay_fee,2)%>"+"|";//小写
			    infoStr2+="  业务明细"+"  预存话费: <%=WtcUtil.formatNumber(pay_money,2)%>元";               
			 	
			 	
			 		    //begin huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示
			 	if("<%=TVprice%>"!="0")
			 	{
			 		infoStr2+="，手机电视功能费<%=WtcUtil.formatNumber(TVprice,2)%>元";
			 	}
			 	if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"!="0")
			 	{
			 		infoStr2+="，手机上网功能费<%=WtcUtil.formatNumber(phoneNetPrice,2)%>元，WLAN功能费<%=WtcUtil.formatNumber(wlanPrice,2)%>元";
			 	}
			  if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"=="0" )
			  {
			  	infoStr2+="，手机上网功能费<%=WtcUtil.formatNumber(phoneNetPrice,2)%>元";
			  }
			 	if("<%=phoneNetPrice%>"=="0" && "<%=wlanPrice%>"!="0" )
			 	{
			 		infoStr2+="，WLAN功能费<%=WtcUtil.formatNumber(wlanPrice,2)%>元";
			 	}	
			 	//end huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示	 
			 	
       infoStr2+="|";
		   infoStr2+="<%=work_name%>"+"|";//开票人
	     infoStr2+=" "+"|";//收款人
	     infoStr2+=""+"|";			 	
		 	 if( "<%=award_flag%>" == "1" ) {
					infoStr2+="已参与赠送礼品活动"+"|";
				}
				else {
					infoStr2+=" "+"|";
				}
				     		/* ningtn add for pos start @ 20100430 */
		 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
		 		infoStr2+="<%=payType%>"+"|";
			 	infoStr2+="<%=MerchantNameChs%>"+"|";
				infoStr2+="<%=CardNoPingBi   %>"+"|";
				infoStr2+="<%=MerchantId     %>"+"|";
				infoStr2+="<%=BatchNo        %>"+"|";
				infoStr2+="<%=IssCode        %>"+"|";
				infoStr2+="<%=TerminalId     %>"+"|";
				infoStr2+="<%=AuthNo         %>"+"|";
				infoStr2+="<%=Response_time  %>"+"|";
				infoStr2+="<%=Rrn            %>"+"|";
				infoStr2+="<%=TraceNo        %>"+"|";
				infoStr2+="<%=AcqCode        %>"+"|";
		 }
		 		  dirtPate = "<%=request.getContextPath()%>/npage/s1141/f7955_login.jsp?activePhone=<%=paraAray[3]%>";
		  /* ningtn add for pos end @ 20100430 */
      window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&infoStr2="+infoStr2+"&op_code=7955&prNum=2&loginAccept=<%=paraAray[0]%>&dirtPage="+dirtPate;	
}
	}
			function printInfo1(printType)
	{
		var infoStr = "";		  
		if (printType == "Detail") {		//免填单
				alert("拼接免填单字符串");
		} else if (printType == "Bill") {	//发票

       infoStr+="<%=work_no%>  <%=work_name%>"+"       购机赠话费（按月返还）2-2"+"|";//工号
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+="手机型号：<%=paraAray[13]%>  IMEI码：<%=paraAray[14]%>"+"|";
		   infoStr+='<%=paraAray[3]%>'+"|";
		   infoStr+="1"+"|";//协议号码
		   infoStr+=" "+"|";
		   infoStr+="<%=parepayfee_china%>"+"|";//合计金额(大写)
		   infoStr+="<%=WtcUtil.formatNumber(prepay_fee,2)%>"+"|";//小写
			    infoStr+="  业务明细"+"  预存话费: <%=WtcUtil.formatNumber(pay_money,2)%>元";               
			 		 	if("<%=TVprice%>"!="0")
			 	{
			 		infoStr+="，手机电视功能费<%=WtcUtil.formatNumber(TVprice,2)%>元";
			 	}
			 	if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"!="0")
			 	{
			 		infoStr+="，手机上网功能费<%=WtcUtil.formatNumber(phoneNetPrice,2)%>元，WLAN功能费<%=WtcUtil.formatNumber(wlanPrice,2)%>元";
			 	}
			  if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"=="0" )
			  {
			  	infoStr+="，手机上网功能费<%=WtcUtil.formatNumber(phoneNetPrice,2)%>元";
			  }
			 	if("<%=phoneNetPrice%>"=="0" && "<%=wlanPrice%>"!="0" )
			 	{
			 		infoStr+="，WLAN功能费<%=WtcUtil.formatNumber(wlanPrice,2)%>元";
			 	}	
			 	//end huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示	 
			 	
       infoStr+="|";

		   infoStr+="<%=work_name%>"+"|";//开票人
	     infoStr+=" "+"|";//收款人
	     infoStr+=""+"|";			 	
		 	 if( "<%=award_flag%>" == "1" ) {
					infoStr+="已参与赠送礼品活动"+"|";
				}
				else {
					infoStr+=" "+"|";
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
		 		  dirtPate = "<%=request.getContextPath()%>/npage/s1141/f7955_login.jsp?activePhone=<%=paraAray[3]%>";
		  /* ningtn add for pos end @ 20100430 */
      window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7955&loginAccept=<%=paraAray[0]%>&dirtPage="+dirtPate;	
}
	}

	/********** pos机信息 start *******/
	function printInfoPos(printStr){
		printStr+="商户名称（中英文）：<%=MerchantNameChs%>"+"|";
		printStr+="交易卡号（屏蔽）：<%=CardNoPingBi%>"+"|";
		printStr+="商户编码：<%=MerchantId%>"+"|";
		printStr+="批次号：<%=BatchNo%>"+"|";
		printStr+="发卡行号：<%=IssCode%>"+"|";
		printStr+="终端编码：<%=TerminalId%>"+"|";
		printStr+="授权号：<%=AuthNo%>"+"|";
		printStr+="回应日期时间：<%=Response_time  %>"+"|";
		printStr+="参考号：<%=Rrn%>"+"|";
		printStr+="流水号：<%=TraceNo%>"+"|";
		printStr+="收单行号：<%=AcqCode%>"+"|";
		printStr+="签字："+"|";
		return printStr;
	}
	/********** pos机信息 end *******/

<%if(Float.parseFloat(phone_money)>0){%>
		/*** 第一张发票 ***/
		rdShowMessageDialog("提交成功! 下面将打印发票！",2);
		printInfo("Bill");		
		
<%}else{%>

		rdShowMessageDialog("提交成功! 下面将打印发票！",2);
		printInfo1("Bill");	
<%}%>
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("购机赠话费（按月返还）失败!(<%=errMsg%>",0);
	window.location="f7955_login.jsp?activePhone=<%=paraAray[3]%>";
</script>
<%}%>
