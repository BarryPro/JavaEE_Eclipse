<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<!-- **** ningtn add for pos @ 20100430 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>


<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%	
	String[][] result = new String[][]{};
	
	ArrayList retArray = new ArrayList();
	
	
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
String regionCode= (String)session.getAttribute("regCode");
	String work_no =  (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");

	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr"); 
	String cust_name=request.getParameter("cust_name"); 
	String sum_money=request.getParameter("sum_money");
	String prepay_fee=request.getParameter("limit_pay"); 
	String sale_name=request.getParameter("sale_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");   
	String machine_type=request.getParameter("machine_type");
	String paraAray[] = new String[23];
	String phone_money=request.getParameter("price");
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
	String TVprice         = request.getParameter("TVprice");//wangdana add for �ֻ����ӷ�
	String isNextDay       = request.getParameter("isNextDay");
	String phoneNetPrice         = request.getParameter("phoneNetPrice");//huangrong add for �ֻ��������ܷ� 2011-7-4 
	String wlanPrice         = request.getParameter("wlanPrice");//huangrong add for WLAN���ܷ� 2011-7-4 
	
	String prepayfee =""+(Float.parseFloat(prepay_fee)+Float.parseFloat(TVprice)+Float.parseFloat(phoneNetPrice)+Float.parseFloat(wlanPrice)); //huangrong add for ���ֻ��������ܷ�WLAN���ܷѵļ��� 2011-7-4
System.out.print("prepayfee======================================================================"+prepayfee);
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/
	
	
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
    paraAray[3] = work_no;
    paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
   	System.out.println(paraAray[0]+"-----------------------------------------------------------------------------------------------ime��");
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
	
              

	//String[] ret = impl.callService("s1142Cfm",paraAray,"2","region",org_code.substring(0,2));
	//int errCode = impl.getErrCode();
	//String errMsg = impl.getErrMsg();

//S1100View callView = new S1100View();
//String chinaFee = ((String[][])(callView.view_sToChinaFee(Pub_lxd.formatNumber(sum_money,2)).get(0)))[0][2];//��д���
//String phoneFee_china = ((String[][])(callView.view_sToChinaFee(Pub_lxd.formatNumber(phone_money,2)).get(0)))[0][2];//��д���
//String payFee_china = ((String[][])(callView.view_sToChinaFee(Pub_lxd.formatNumber(prepayfee,2)).get(0)))[0][2];//��д���
//System.out.print(chinaFee);
	%>

	<wtc:service name="s1142Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
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
	<wtc:array id="ret" scope="end" />
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
<%
if (errCode.equals("000000"))
	{

/*** �ڶ��ŷ�Ʊ�Ĵ�ӡ��ˮ ***/

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
		String payFee_china = result112[0][2]; 
		System.out.println(phoneFee_china);
		System.out.println(payFee_china);
			%>
<script language="JavaScript">
	
		/*** tianyang add for pos start *** boss���׳ɹ� ��������ȷ�Ϻ��� *****/
		if("<%=payType%>"=="BX" && "<%=isNextDay%>" == "0"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY" && "<%=isNextDay%>" == "0"){
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
		var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=paraAray[2]%>&sysAccept="+sysAccept+"&phoneNo="+"<%=paraAray[1]%>"+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr + "&payType=" + payType;		
		var ret=window.showModalDialog(path,printStr,prop);		
	}
	/*function printInfo(printType)
	{
		var retInfo = "";		  
		if (printType == "Detail") {		//���
				alert("ƴ������ַ���");
		} else if (printType == "Bill") {	//��Ʊ
				retInfo+="�ͻ������ޱ��⣺"+"<%=cust_name%>"+"|";
		    retInfo+="�ֻ������ޱ��⣺"+"<%=paraAray[1]%>"+"|";
		    retInfo+="�ֻ��ͺţ�"+"<%=machine_type%>"+"|";
		    retInfo+="IMEI�룺"+"��"+"|";		    
		    retInfo+="����д��"+"<%=phoneFee_china%>"+"|";
		    retInfo+="���Сд��"+"��<%=WtcUtil.formatNumber(phone_money,2)%>Ԫ"+"|";		    
		    retInfo+="ҵ����ϸ��"+"�˹�����: <%=phone_money%>Ԫ"+"|";		    
		    retInfo+="ҵ�����ƣ�"+"���������ѣ����·���������-1"+"|";		    
				retInfo+="�տ�Ա��"+"<%=work_name%>"+"|";
				retInfo+="�Ƿ����������Ʒ���"+"��"+"|";
				
				retInfo = printInfoPos(retInfo);
		}
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
	}*/
	function printInfo(printType)
	{
		var infoStr = "";		  
		if (printType == "Detail") {		//���
				alert("ƴ������ַ���");
		} else if (printType == "Bill") {	//��Ʊ
			
			 infoStr+="<%=work_no%>  <%=work_name%>"+"       ���������ѣ����·���������-1"+"|";//����
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+="�ֻ��ͺţ�"+"<%=machine_type%>"+"|";
		   infoStr+='<%=paraAray[1]%>'+"|";
		   infoStr+=" "+"|";//Э�����
		   infoStr+=" "+"|";
		   infoStr+="<%=phoneFee_china%>"+"|";//�ϼƽ��(��д)
		   infoStr+="<%=WtcUtil.formatNumber(phone_money,2)%>"+"|";//Сд
		   infoStr+="ҵ����ϸ��"+"�˹�����: <%=phone_money%>Ԫ"+"|";		
		   infoStr+="<%=work_name%>"+"|";//��Ʊ��
	     infoStr+=" "+"|";//�տ���
	     infoStr+=" "+"|";//�տ���
	     infoStr+=" "+"|";
				
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
				 rdShowMessageDialog("��ӡ�ڶ��ŷ�Ʊ��",2)
				 var infoStr2 = "";
				
			 infoStr2+="<%=work_no%>  <%=work_name%>"+"       ���������ѣ����·���������-2"+"|";//����
       infoStr2+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr2+='<%=cust_name%>'+"|";
		   infoStr2+="�ֻ��ͺţ�"+"<%=machine_type%>"+"|";
		   infoStr2+='<%=paraAray[1]%>'+"|";
		   infoStr2+="1"+"|";//Э�����
		   infoStr2+=" "+"|";
		   infoStr2+="<%=payFee_china%>"+"|";//�ϼƽ��(��д)
		   infoStr2+="<%=WtcUtil.formatNumber(prepayfee,2)%>"+"|";//Сд
		   infoStr2+="ҵ����ϸ��"+"�˹�����: <%=WtcUtil.formatNumber(prepay_fee,2)%>Ԫ";	
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
			 		infoStr2+="|";
		   infoStr2+="<%=work_name%>"+"|";//��Ʊ��
	     infoStr2+=" "+"|";//�տ���
	     infoStr2+=" "+"|";//�տ���
	     infoStr2+=" "+"|";
				
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
						 		  dirtPate = "<%=request.getContextPath()%>/npage/s1141/f7955_login.jsp?activePhone=<%=paraAray[1]%>";
		  /* ningtn add for pos end @ 20100430 */
      window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&infoStr2="+infoStr2+"&op_code=7956&prNum=2&loginAccept=<%=paraAray[0]%>&dirtPage="+dirtPate;	

		}

	}
		function printInfo1(printType)
	{
		var infoStr = "";		  
		if (printType == "Detail") {		//���
				alert("ƴ������ַ���");
		} else if (printType == "Bill") {	//��Ʊ
			
				
			 infoStr+="<%=work_no%>  <%=work_name%>"+"       ���������ѣ����·���������-2"+"|";//����
       infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+="�ֻ��ͺţ�"+"<%=machine_type%>"+"|";
		   infoStr+='<%=paraAray[1]%>'+"|";
		   infoStr+="1"+"|";//Э�����
		   infoStr+=" "+"|";
		   infoStr+="<%=payFee_china%>"+"|";//�ϼƽ��(��д)
		   infoStr+="<%=WtcUtil.formatNumber(prepayfee,2)%>"+"|";//Сд
		   infoStr+="ҵ����ϸ��"+"�˹�����: <%=WtcUtil.formatNumber(prepay_fee,2)%>Ԫ";	
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
		 	
			  infoStr+="|";	
			 	
		   infoStr+="<%=work_name%>"+"|";//��Ʊ��
	     infoStr+=" "+"|";//�տ���
	     infoStr+=" "+"|";//�տ���
	     infoStr+=" "+"|";
				
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
						 		  dirtPate = "<%=request.getContextPath()%>/npage/s1141/f7955_login.jsp?activePhone=<%=paraAray[1]%>";
		  /* ningtn add for pos end @ 20100430 */
      window.location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=7956&loginAccept=<%=paraAray[0]%>&dirtPage="+dirtPate;	

		}

	}
	
	/*function printInfo2(printType)
	{
		var retInfo = "";		  
		if (printType == "Detail") {		//���
				alert("ƴ������ַ���");
		} else if (printType == "Bill") {	//��Ʊ
				retInfo+="�ͻ������ޱ��⣺"+"<%=cust_name%>"+"|";
		    retInfo+="�ֻ������ޱ��⣺"+"<%=paraAray[1]%>"+"|";
		    retInfo+="�ֻ��ͺţ�"+"<%=machine_type%>"+"|";
		    retInfo+="IMEI�룺"+"��"+"|";
		    retInfo+="����д��"+"<%=payFee_china%>"+"|";
		    retInfo+="���Сд��"+"��<%=WtcUtil.formatNumber(prepayfee,2)%>Ԫ"+"|";		    
		    retInfo+="ҵ����ϸ��"+"��Ԥ��: <%=WtcUtil.formatNumber(prepay_fee,2)%>Ԫ";

			 	if("<%=TVprice%>"!="0")
			 	{
			 		retInfo+="���ֻ����ӹ��ܷ�<%=WtcUtil.formatNumber(TVprice,2)%>Ԫ"+"|";
			 	}
			    		    
		    retInfo+="ҵ�����ƣ�"+"���������ѣ����·���������-2"+"|";
				retInfo+="�տ�Ա��"+"<%=work_name%>"+"|";
				retInfo+="�Ƿ����������Ʒ���"+"��"+"|";
				
				retInfo = printInfoPos(retInfo);
		}
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
	}*/
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
	 //var printStr = printInfo("Bill");		
		//showPrtDlg("�ύ�ɹ�! ���潫��ӡ��Ʊ��",printStr,"<%=payType%>","<%=paraAray[0]%>");
			rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
		  printInfo("Bill");	

		/*** �ڶ��ŷ�Ʊ ***/
		//var printStr2 = printInfo2("Bill");		
	//	showPrtDlg("��ӡ�ڶ��ŷ�Ʊ��",printStr2,"<%=payType%>","<%=printAccept%>");
	
		//window.location="f7955_login.jsp?activePhone=<%=paraAray[1]%>";
<%}else{%>
		//var printStr2 = printInfo2("Bill");
	//	showPrtDlg("�ύ�ɹ�! ���潫��ӡ��Ʊ��",printStr2,"<%=payType%>","<%=paraAray[0]%>");
		
		//window.location="f7955_login.jsp?activePhone=<%=paraAray[1]%>";
				rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
		printInfo1("Bill");	
<%}%>

</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("���������ѣ����·���������ʧ��!(<%=errMsg%>");
	window.location="f7955_login.jsp?activePhone=<%=paraAray[1]%>";
</script>
<%}%>



