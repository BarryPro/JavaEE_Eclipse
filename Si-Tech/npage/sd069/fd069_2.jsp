<%
  /*
   * ����: ��Լ�Żݹ���d069
   * �汾: 1.0
   * ����: 2011-1-5
   * ����: 
   * ��Ȩ: si-tech
   * update:huangrong
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ include file="/npage/public/posCCB.jsp" %>
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password"); 
				//���Ӳ���������վԤԼ��ǰ̨���� wanghyd
	String banlitype =request.getParameter("banlitype");

	String cust_name=request.getParameter("oCustName");//��������
	String Prepay_Fee=request.getParameter("Prepay_Fee");//Ӧ�ս��
	String Base_Fee=request.getParameter("Base_Fee");//����Ԥ��
	String Free_Fee=request.getParameter("Free_Fee");//�Ԥ��
	String Consume_Term=request.getParameter("Consume_Term");//��������
	String iAddStr=request.getParameter("iAddStr");//ƴ��
	String do_note=request.getParameter("do_note");//��ע��Ϣ
	String payTypeSelect=request.getParameter("payTypeSelect");//�ɷ�����
	String sale_code=request.getParameter("sale_code");//Ӫ��������	
	String p3=request.getParameter("p3");//�ֻ��ͺ�		
  String IMEINo=request.getParameter("IMEINo");//IMEINo��
  String Save_Fee=request.getParameter("Save_Fee");//Ԥ�滰�� 
  String PhoneFree_Fee=request.getParameter("PhoneFree_Fee");//huangrong add �ֻ����ӷ� 2011-2-18 11:29
  String Active_Term=request.getParameter("Active_Term");//huangrong add �ֻ����ӷ��������� 2011-2-18 11:29   
  
  
	System.out.println("======================= sd069_2.jsp ===============================");
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
	/*gaopeng 2013/4/19 ������ 15:50:55 ����һ�������������ж��Ƿ��н� �� 0 �н� 1 û�н�*/
	String PreFlag="";
	/*zhangyan ���ѻ���*/
	String used_point = request.getParameter("markPoint");
	String point_money=request.getParameter("pointMoney");
	
	String paraAray[] = new String[32];
	paraAray[0] = request.getParameter("printAccept");
	paraAray[1] = opCode;
	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phoneNo");
	paraAray[4] = "01";
	paraAray[5] = password;
	paraAray[6] = "";
	paraAray[7] = iAddStr;
	paraAray[8] = do_note;
	paraAray[9] = ip_Addr;
	paraAray[10] = payTypeSelect;
	paraAray[11] = "41";	
	
	

	paraAray[12] = payType				 ;
	paraAray[13] = MerchantNameChs ;
	paraAray[14] = MerchantId      ;
	paraAray[15] = TerminalId      ;
	paraAray[16] = IssCode         ;
	paraAray[17] = AcqCode         ;
	paraAray[18] = CardNo          ;
	paraAray[19] = BatchNo         ;
	paraAray[20] = Response_time   ;
	paraAray[21] = Rrn             ;
	paraAray[22] = AuthNo          ;
	paraAray[23] = TraceNo         ;
	paraAray[24] = Request_time    ;
	paraAray[25] = CardNoPingBi    ;
	paraAray[26] = ExpDate         ;
	paraAray[27] = Remak           ;
	paraAray[28] = TC              ;
	paraAray[29] = used_point              ;
	paraAray[30] = point_money              ;
	
	for ( int i=0;i<paraAray.length;i++  )
	{
		System.out.println("d069~~~~paraAray["+i+"]= "+paraAray[i] );
	}
	
%>
	<wtc:service name="sd069Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
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
  <%	  	
	if(!banlitype.equals("0")) {//�������վԤԼ����Ļ���һ��������wanghyd
	%>
		<wtc:param value="<%=banlitype%>"/>
	<% 
	} 
	%> 	
	
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
			PreFlag=result[0][0];
			System.out.println("gaopengv587:-------------"+PreFlag);
			if(!banlitype.equals("0")) {//�������վԤԼ����Ļ�����385cfm����wanghyd
	    System.out.println("d069����sE385Cfm����ʼ");
	    
			String iOpCode = 		opCode;
			String iLoginNo = 		work_no;
			String iLoginPwd = 		password;
			String iPhoneNo = 		request.getParameter("phoneNo");	
			String iUserPwd = 		"";
			String inOpNote = 		do_note;
			String iBookingId = 	"";
			String iLoginAccept=  request.getParameter("printAccept"); 
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
		System.out.println("d069����sE385Cfm�������");
		}
		
%>
	<script language="JavaScript">
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
	</script>

<%
System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
%>
		<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%	
		String chinaFee = result1[0][2];   	//��д���
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
   rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��",2);
   var preFlag="<%=PreFlag%>";
   var resultwrite = "";
   if(preFlag!="1")
   {
   	resultwrite="�𾴵Ŀͻ����ã���ϲ���ڹ�����л���"+preFlag+",�����Ч֤����������Ʊ��ָ��Ӫҵ����ȡ";
   }
   else if (preFlag=="1")
   	{
   		resultwrite="��л������Ӫ�����ף���´��н�";
   	}
   var infoStr="";
  

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       <%=opName%>"+"|";//����
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
   infoStr+='<%=cust_name%>'+"|";//�û�����
   infoStr+='<%=paraAray[3]%>'+"|";//����
   infoStr+='<%=paraAray[3]%>'+"|";//�ƶ�̨��
   infoStr+=" "+"|";//Э�����
   infoStr+=" "+"|";//֧Ʊ���� 
   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
   infoStr+="<%=WtcUtil.formatNumber(Prepay_Fee,2)%>"+"|";//Сд
   //ҵ����Ŀ
	 infoStr+="�ֻ��ͺţ�<%=p3%>   "+
		 "IMEI�룺"+"<%=IMEINo%>"+"~"+"�ɷѺϼƣ�"+"<%=chinaFee%>Ԫ"+"    ��Ԥ�滰�ѣ�<%=Save_Fee%>Ԫ"+"    �ֻ����ӷѣ�"+"<%=PhoneFree_Fee%>Ԫ"+"~"+resultwrite+"|";

	 
	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 infoStr+=" "+"|";//�տ���
	 infoStr+=" "+"|";//�տ���
	
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
	dirtPate = "/npage/sd069/fd069_login.jsp?activePhone=<%=paraAray[3]%>&opCode=d069&opName=<%=opName%>";
  // location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=d069&loginAccept=<%=paraAray[0]%>&dirtPage="+codeChg(dirtPate);
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("ͳһԤ������ʧ��!(<%=errMsg%>,<%=errCode%>",0);
	window.location="/npage/sd069/fd069_login.jsp?activePhone=<%=paraAray[3]%>&opCode=d069&opName=<%=opName%>";
</script>
<%}%>

