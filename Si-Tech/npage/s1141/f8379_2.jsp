<%
  /*
   * ����: ����Ԥ���8379
   * �汾: 1.0
   * ����: 2010/3/18
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @  ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @  ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String opCode="8379";
	String opName="����Ԥ���";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password"); 
	String cust_name=request.getParameter("custName");
	String Prepay_Fee=request.getParameter("sumMoney");
	String Base_Fee=request.getParameter("baseFee");
	String Free_Fee=request.getParameter("freeFee");
	String Pay_Fee=request.getParameter("payFee");
	String Return_Fee=request.getParameter("returnFee");
	String Return_Term=request.getParameter("returnTerm");
	/* ningtn add for pos start @  */
	String payType		   = request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
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
	/* ningtn add for pos start @  */
	
	String paraAray[] = new String[28];
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = "01";
	paraAray[2] = opCode;
    paraAray[3] = work_no;  
    paraAray[4] = password;
	paraAray[5] = request.getParameter("phoneNo");
    paraAray[6] = "";
    paraAray[7] = request.getParameter("giftCode");
	paraAray[8] = request.getParameter("systemNote");
    paraAray[9] = request.getParameter("ip_Addr");
    paraAray[10] = request.getParameter("projectType");
	
	/* ningtn add for pos start @ 20100430 */
	paraAray[11] = payType				 ;
	paraAray[12] = MerchantNameChs ;
	paraAray[13] = MerchantId      ;
	paraAray[14] = TerminalId      ;
	paraAray[15] = IssCode         ;
	paraAray[16] = AcqCode         ;
	paraAray[17] = CardNo          ;
	paraAray[18] = BatchNo         ;
	paraAray[19] = Response_time   ;
	paraAray[20] = Rrn             ;
	paraAray[21] = AuthNo          ;
	paraAray[22] = TraceNo         ;
	paraAray[23] = Request_time    ;
	paraAray[24] = CardNoPingBi    ;
	paraAray[25] = ExpDate         ;
	paraAray[26] = Remak           ;
	paraAray[27] = TC              ;
	/* ningtn add for pos start @ 20100430 */
%>
	<wtc:service name="s8379Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
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
		<wtc:param value="<%=paraAray[20]%>"/>
		<wtc:param value="<%=paraAray[21]%>"/>
		<wtc:param value="<%=paraAray[22]%>"/>
		<wtc:param value="<%=paraAray[23]%>"/>
		<wtc:param value="<%=paraAray[24]%>"/>
		<wtc:param value="<%=paraAray[25]%>"/>
		<wtc:param value="<%=paraAray[26]%>"/>
		<wtc:param value="<%=paraAray[27]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") || errCode.equals("0") )
	{
	
	    String statisLoginAccept =  request.getParameter("login_accept"); /*��ˮ*/
		String statisOpCode=opCode;
		String statisPhoneNo= request.getParameter("phoneNo");	
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
    	
   		if (statisOpCode.equals("8379"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}			
		
	
%>
	<script language="JavaScript">
		/* ningtn add for pos start @ 20100430 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/* ningtn add for pos start @ 20100430 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
	</script>
	
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//��д���
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
	if("<%=Prepay_Fee%>" > 0)
	{
		rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
		var infoStr="";
		var gift_code= Number(<%=request.getParameter("giftCode")%>);
	
		infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       ����Ԥ���"+"|";//����
		infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr+='<%=cust_name%>'+"|";
		infoStr+=" "+"|";
		infoStr+='<%=paraAray[5]%>'+"|";
		infoStr+=" "+"|";//Э�����
		infoStr+=" "+"|";

		infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
		infoStr+="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"+"|";//Сд
		infoStr+="Ԥ���<%=WtcUtil.formatNumber(Prepay_Fee,2)%>Ԫ ";
		if("<%=Base_Fee%>">0)
		{
			infoStr+="����Ԥ�棺"+"<%=Base_Fee%>Ԫ ";
		}
		if("<%=Free_Fee%>">0)
		{
			infoStr+="�Ԥ�棺"+"<%=Free_Fee%>Ԫ ";
		}
		if("<%=Pay_Fee%>">0)
		{
			infoStr+="�ֽ�"+"<%=Pay_Fee%>Ԫ ";
		}
	   
	   infoStr+=" "+"|";
	   infoStr+="<%=work_name%>"+"|";//��Ʊ��
	   infoStr+="������Ԥ����"+"|";
	   infoStr+=" "+"|";//�տ���
	   	/* ningtn add for pos start @  */
		 if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
		 		infoStr+=" "+"|";
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
		/* ningtn add for pos end @  */
		/*
	   dirtPate = "/npage/s1141/f8379_login.jsp?activePhone=<%=paraAray[5]%>&opCode=8379&opName=����Ԥ���";
	   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
	   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate)+"&op_code=8379&loginAccept=<%=paraAray[0]%>";
		 */
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=work_no%>");
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=cust_name%>");
			$(billArgsObj).attr("10006","<%=opName%>");
			$(billArgsObj).attr("10008","<%=paraAray[5]%>");
			$(billArgsObj).attr("10015","<%=WtcUtil.formatNumber(Prepay_Fee,2)%>");//Сд
			$(billArgsObj).attr("10016","<%=WtcUtil.formatNumber(Prepay_Fee,2)%>");//�ϼƽ��(��д) ��Сд������ҳת��
			if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
				$(billArgsObj).attr("10019","*");//���νɷѣ�ˢ��
			}else{
				$(billArgsObj).attr("10017","*");//�ֽ�
			}
			$(billArgsObj).attr("10020","");//������
			$(billArgsObj).attr("10021","");//������
			$(billArgsObj).attr("10022","");//ѡ�ŷ�
			$(billArgsObj).attr("10023","");//Ѻ��
			$(billArgsObj).attr("10024","");//SIM����
			$(billArgsObj).attr("10025","<%=WtcUtil.formatNumber(Prepay_Fee,2)%>");//Ԥ����
			$(billArgsObj).attr("10026","");//������
			$(billArgsObj).attr("10027","");//������
			$(billArgsObj).attr("10028","");//�����Ӫ�������
			$(billArgsObj).attr("10047","");//�����
			$(billArgsObj).attr("10030","<%=paraAray[0]%>");//ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opCode%>");
			$(billArgsObj).attr("10031","<%=work_name%>");//��Ʊ��
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
        //var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
        //��Ʊ��Ŀ�޸�Ϊ��·��
	    var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��";
			
			var path = path + "&infoStr="+printInfo+"&loginAccept=<%=paraAray[0]%>&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop); 
			location = "/npage/s1141/f8379_login.jsp?activePhone=<%=paraAray[5]%>&opCode=8379&opName=����Ԥ���";
	
	}else
	{	

		var infoStr="";
		if("<%=Return_Fee%>">0)
		{
			infoStr+="ÿ������Ԥ��"+"<%=Return_Fee%>Ԫ������Ԥ�������"+"<%=Return_Term%>��"+"|";
		}
		rdShowMessageDialog("ȷ�ϳɹ�! ",2);
		window.location="/npage/s1141/f8379_login.jsp?activePhone=<%=paraAray[5]%>&opCode=8379&opName=����Ԥ���";	
	}
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("����Ԥ���ʧ��!(<%=errMsg%>",0);
	window.location="/npage/s1141/f8379_login.jsp?activePhone=<%=paraAray[5]%>&opCode=8379&opName=����Ԥ���";
</script>
<%}%>
