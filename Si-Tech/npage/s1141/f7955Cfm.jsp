
<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>


<!-- **** ningtn add for pos @ 20100408 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******���ع��пؼ�ҳ KeeperClient ******** -->
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
	
			//���Ӳ���������վԤԼ��ǰ̨���� wanghyd
	String banlitype =request.getParameter("banlitype");

	
	//sunzx add at 20070903 
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
	String sum_money=request.getParameter("sum_money");
	String pay_money=request.getParameter("pay_money");
	String TVprice=request.getParameter("TVprice");     //wangdana add for �ֻ����ӷ�
	
	//begin huangrong add for �ֻ������ѣ�Wlan���ܷ� 2011-7-1 
	String phoneNetPrice=request.getParameter("phoneNetPrice");     
	String wlanPrice=request.getParameter("wlanPrice");    
	System.out.println("----------------------------------------------------------------wlanPrice="+wlanPrice);
	//end huangrong add for �ֻ������ѣ�Wlan���ܷ� 2011-7-1 
	String prepay_fee =""+(Float.parseFloat(pay_money)+Float.parseFloat(TVprice)+Float.parseFloat(phoneNetPrice)+Float.parseFloat(wlanPrice));   //wangdana add for �ֻ����ӷ�+���� ��huangrong update �ֻ����ӷ�+����+�ֻ�������+Wlan���ܷ�
	System.out.println("----------------------------------------------------------------prepay_fee="+prepay_fee);
	String phone_money=""+(Float.parseFloat(sum_money)-Float.parseFloat(pay_money)-Float.parseFloat(TVprice)-Float.parseFloat(phoneNetPrice)-Float.parseFloat(wlanPrice));//huangrong update ���������Ӷ��ֻ������Ѻ�Wlan���ܷѷ��õĿۼ�

	/********tianyang add at 20090928 for POS�ɷ�����****start*****/
	String payType				 = request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
	String MerchantNameChs = request.getParameter("MerchantNameChs");/**�Ӵ˿�ʼ����Ϊ���в���**/
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
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/
	
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
	if(banlitype.equals("1")) {//�������վԤԼ����Ļ���һ��������wanghyd
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
 	    String statisLoginAccept =  request.getParameter("login_accept"); /*��ˮ*/
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
 	          
	 if(banlitype.equals("1")) {//�������վԤԼ����Ļ�����385cfm����wanghyd
	    System.out.println("7955����sE385Cfm����ʼ");
	    
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
		System.out.println("%%%%%%%����ԤԼ�������%%%%%%%%"); 
		System.out.println("7955����sE385Cfm�������");
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

		/*** �ڶ��ŷ�Ʊ�Ĵ�ӡ��ˮ ***/
		
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
<script language="JavaScript">
	
		/*** tianyang add for pos start *** boss���׳ɹ� ��������ȷ�Ϻ��� *****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/*** tianyang add for pos end *** boss���׳ɹ� ��������ȷ�Ϻ��� *****/
		

	function showPrtDlg(DlgMessage,printStr,payType,prtAcc)
	{
	//alert(DlgMessage+"+++"+printStr+"+++"+payType+"+++"+prtAcc)
		//��ʾ��ӡ�Ի���
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
		if (printType == "Detail") {		//���
				alert("ƴ������ַ���");
		} else if (printType == "Bill") {	//��Ʊ
		   infoStr+="<%=work_no%>  <%=work_name%>"+"       ���������ѣ����·�����2-1"+"|";//����
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+=" �ֻ��ͺţ�<%=paraAray[13]%>  IMEI�룺<%=paraAray[14]%>"+"|";
		   infoStr+='<%=paraAray[3]%>'+"|";
		   infoStr+=" "+"|";//Э�����
		   infoStr+=" "+"|";
		   infoStr+="<%=phoneFee_china%>"+"|";//�ϼƽ��(��д)
		   infoStr+="<%=WtcUtil.formatNumber(phone_money,2)%>"+"|";//Сд
		   infoStr+=" "+"|";
		   infoStr+="<%=work_name%>"+"|";//��Ʊ��
	     infoStr+=" "+"|";//�տ���
	     infoStr+=" "+"|";//�տ���
	     	if( "<%=award_flag%>" == "1" ) {
					infoStr+="�Ѳ���������Ʒ�"+"|";
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

       rdShowMessageDialog("��ӡ�ڶ��ŷ�Ʊ��",2);
       var infoStr2 = "";	
       infoStr2+="<%=work_no%>  <%=work_name%>"+"       ���������ѣ����·�����2-2"+"|";//����
       infoStr2+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=cust_name%>'+"|";
		   infoStr2+="�ֻ��ͺţ�<%=paraAray[13]%>  IMEI�룺<%=paraAray[14]%>"+"|";
		   infoStr2+='<%=paraAray[3]%>'+"|";
		   infoStr2+="1"+"|";//Э�����
		   infoStr2+=" "+"|";
		   infoStr2+="<%=parepayfee_china%>"+"|";//�ϼƽ��(��д)
		   infoStr2+="<%=WtcUtil.formatNumber(prepay_fee,2)%>"+"|";//Сд
			    infoStr2+="  ҵ����ϸ"+"  Ԥ�滰��: <%=WtcUtil.formatNumber(pay_money,2)%>Ԫ";               
			 	
			 	
			 		    //begin huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ
			 	if("<%=TVprice%>"!="0")
			 	{
			 		infoStr2+="���ֻ����ӹ��ܷ�<%=WtcUtil.formatNumber(TVprice,2)%>Ԫ";
			 	}
			 	if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"!="0")
			 	{
			 		infoStr2+="���ֻ��������ܷ�<%=WtcUtil.formatNumber(phoneNetPrice,2)%>Ԫ��WLAN���ܷ�<%=WtcUtil.formatNumber(wlanPrice,2)%>Ԫ";
			 	}
			  if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"=="0" )
			  {
			  	infoStr2+="���ֻ��������ܷ�<%=WtcUtil.formatNumber(phoneNetPrice,2)%>Ԫ";
			  }
			 	if("<%=phoneNetPrice%>"=="0" && "<%=wlanPrice%>"!="0" )
			 	{
			 		infoStr2+="��WLAN���ܷ�<%=WtcUtil.formatNumber(wlanPrice,2)%>Ԫ";
			 	}	
			 	//end huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ	 
			 	
       infoStr2+="|";
		   infoStr2+="<%=work_name%>"+"|";//��Ʊ��
	     infoStr2+=" "+"|";//�տ���
	     infoStr2+=""+"|";			 	
		 	 if( "<%=award_flag%>" == "1" ) {
					infoStr2+="�Ѳ���������Ʒ�"+"|";
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
		if (printType == "Detail") {		//���
				alert("ƴ������ַ���");
		} else if (printType == "Bill") {	//��Ʊ

       infoStr+="<%=work_no%>  <%=work_name%>"+"       ���������ѣ����·�����2-2"+"|";//����
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+="�ֻ��ͺţ�<%=paraAray[13]%>  IMEI�룺<%=paraAray[14]%>"+"|";
		   infoStr+='<%=paraAray[3]%>'+"|";
		   infoStr+="1"+"|";//Э�����
		   infoStr+=" "+"|";
		   infoStr+="<%=parepayfee_china%>"+"|";//�ϼƽ��(��д)
		   infoStr+="<%=WtcUtil.formatNumber(prepay_fee,2)%>"+"|";//Сд
			    infoStr+="  ҵ����ϸ"+"  Ԥ�滰��: <%=WtcUtil.formatNumber(pay_money,2)%>Ԫ";               
			 		 	if("<%=TVprice%>"!="0")
			 	{
			 		infoStr+="���ֻ����ӹ��ܷ�<%=WtcUtil.formatNumber(TVprice,2)%>Ԫ";
			 	}
			 	if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"!="0")
			 	{
			 		infoStr+="���ֻ��������ܷ�<%=WtcUtil.formatNumber(phoneNetPrice,2)%>Ԫ��WLAN���ܷ�<%=WtcUtil.formatNumber(wlanPrice,2)%>Ԫ";
			 	}
			  if("<%=phoneNetPrice%>"!="0" && "<%=wlanPrice%>"=="0" )
			  {
			  	infoStr+="���ֻ��������ܷ�<%=WtcUtil.formatNumber(phoneNetPrice,2)%>Ԫ";
			  }
			 	if("<%=phoneNetPrice%>"=="0" && "<%=wlanPrice%>"!="0" )
			 	{
			 		infoStr+="��WLAN���ܷ�<%=WtcUtil.formatNumber(wlanPrice,2)%>Ԫ";
			 	}	
			 	//end huangrong add ���ֻ����ӹ��ܷѣ��ֻ��������ܷѣ�WLAN���ܷ��в�Ϊ0��ʱ���չʾ	 
			 	
       infoStr+="|";

		   infoStr+="<%=work_name%>"+"|";//��Ʊ��
	     infoStr+=" "+"|";//�տ���
	     infoStr+=""+"|";			 	
		 	 if( "<%=award_flag%>" == "1" ) {
					infoStr+="�Ѳ���������Ʒ�"+"|";
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

	/********** pos����Ϣ start *******/
	function printInfoPos(printStr){
		printStr+="�̻����ƣ���Ӣ�ģ���<%=MerchantNameChs%>"+"|";
		printStr+="���׿��ţ����Σ���<%=CardNoPingBi%>"+"|";
		printStr+="�̻����룺<%=MerchantId%>"+"|";
		printStr+="���κţ�<%=BatchNo%>"+"|";
		printStr+="�����кţ�<%=IssCode%>"+"|";
		printStr+="�ն˱��룺<%=TerminalId%>"+"|";
		printStr+="��Ȩ�ţ�<%=AuthNo%>"+"|";
		printStr+="��Ӧ����ʱ�䣺<%=Response_time  %>"+"|";
		printStr+="�ο��ţ�<%=Rrn%>"+"|";
		printStr+="��ˮ�ţ�<%=TraceNo%>"+"|";
		printStr+="�յ��кţ�<%=AcqCode%>"+"|";
		printStr+="ǩ�֣�"+"|";
		return printStr;
	}
	/********** pos����Ϣ end *******/

<%if(Float.parseFloat(phone_money)>0){%>
		/*** ��һ�ŷ�Ʊ ***/
		rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
		printInfo("Bill");		
		
<%}else{%>

		rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
		printInfo1("Bill");	
<%}%>
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("���������ѣ����·�����ʧ��!(<%=errMsg%>",0);
	window.location="f7955_login.jsp?activePhone=<%=paraAray[3]%>";
</script>
<%}%>
