<%
/********************
 version v2.0
������: si-tech
update zhaohaitao at 2008.11.26
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!-- **** ningtn add for pos @ 20100414 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100414 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String opCode = "1143";
	String opName = "���ֻ���";
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");

	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");
	String spec_name =request.getParameter("spec_name");
	String spec_fee =request.getParameter("spec_fee");

	String pay_money=request.getParameter("pay_money");
	String prepay_fee=""+(Float.parseFloat(pay_money)+Float.parseFloat(spec_fee));
	
	/* ningtn add for pos start @ 20100414 */
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
	/* ningtn add for pos start @ 20100414 */

	String paraAray[] = new String[36];

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
	paraAray[6] = request.getParameter("used_point");
	paraAray[7] = request.getParameter("sum_money");
	paraAray[8] = prepay_fee;
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
	
	/* ningtn add for pos start @ 20100414 */
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
	/* ningtn add for pos start @ 20100414 */

	String phone_no = paraAray[3];
  System.out.println("********2222222222222222222222222222222*");
	//String[] ret = impl.callService("s1141Cfm",paraAray,"2","region",org_code.substring(0,2));
  %>
	<wtc:service name="s1141Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
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
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
  <%
  String errCode = retCode1;
	String errMsg = retMsg1;
	if (errCode.equals("000000"))
	{
	%>
  <script language="JavaScript">
		/* ningtn add for pos start @ 20100414 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/* ningtn add for pos start @ 20100414 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
	</script>
<%}%>
  <%
    System.out.println("**************************************************");

	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
  %>
  <jsp:include page="<%=url%>" flush="true" />
  <%
	if (errCode.equals("000000"))
	{
   //String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(paraAray[7],2)).get(0)))[0][2];//��д���
  %>

	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="3" >
		<wtc:param value="<%=WtcUtil.formatNumber(paraAray[7],2)%>"/>
	</wtc:service>
	<wtc:array id="retArr" scope="end"/>
  <%
	String chinaFee = retArr[0][2];
    System.out.print("chinaFee="+chinaFee);
  %>
   <script language="JavaScript">
   rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��");
   var infoStr="";
   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       ���ֻ���"+"|";//����
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//Э�����
   infoStr+="�ֻ��ͺ�"+'<%=paraAray[13]%>'+"|";//֧Ʊ����
   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
   infoStr+="<%=WtcUtil.formatNumber(paraAray[7],2)%>"+"|";//Сд
   var jkinfo="";
   if("<%=card_money%>"=="0"){
   	jkinfo+="�ɿ�ϼƣ�  <%=paraAray[7]%>"+
		 "Ԫ����:Ԥ�滰�� <%=pay_money%>"+"Ԫ";
   }else{
   	jkinfo+="�ɿ�ϼƣ�  <%=paraAray[7]%>"+
		 "Ԫ����:Ԥ�滰�� <%=pay_money%>"+"Ԫ��"+"<%=card_info%>";
   }
   if("<%=spec_fee%>"!="0"){
   	jkinfo=jkinfo+"��"+"<%=spec_name.trim()%>"+" "+"<%=spec_fee.trim()%>"+"Ԫ";
   }
	 infoStr+=jkinfo+"|";
   //infoStr+="�ɿ�ϼƣ�  <%=WtcUtil.formatNumber(paraAray[7],2)%>"+
	//	 "����Ԥ�滰�ѣ� <%=WtcUtil.formatNumber(paraAray[8],2)%>"+"Ԫ��"+"<%=card_info%>"+"|";


	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 //���������   START
	 infoStr+="IMEI�룺<%=paraAray[14]%>"+"|";
	 if( "<%=award_flag%>" == "1" )
	 {

	 		infoStr+="�Ѳ���������Ʒ�"+"|";
	 }
	 else
	 {
	 	  infoStr+=" "+"|";
	 }
	 //���������   END
	 
	 /* ningtn add for pos start @ 20100414 */
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
	/* ningtn add for pos end @ 20100414 */
	 
   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f1143_login.jsp?activePhone=<%=phone_no%>%26opCode=1143%26opName=���ֻ���";
   var dirtPage="/npage/s1141/f1143_login.jsp?activePhone=<%=phone_no%>%26opCode=1143%26opName=���ֻ���";
	 location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage+"&op_code=1143&loginAccept=<%=paraAray[0]%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("���ֻ���ʧ��!(<%=errMsg%>",0);
	window.location="f1143_login.jsp?activePhone=<%=phone_no%>&opCode=1143&opName=���ֻ���";
</script>
<%}%>

