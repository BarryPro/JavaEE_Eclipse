<%
/********************
 version v2.0
������: si-tech
update:sunaj@2009-05-13
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = "8661";
	String opName = "������������������";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******���ع��пؼ�ҳ KeeperClient ******** -->
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
	String card_money=request.getParameter("card_money");  /*������*/
	String pay_money=request.getParameter("pay_money");   /*��Ԥ��*/
	//sunzx add at 20070903
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
  	//sunzx add end
	//String prepay_fee=""+Float.parseFloat(pay_money);
	String phone_no = request.getParameter("phone_no");
    String op_code=request.getParameter("op_code");
    //liyan add at 20090313
    /* ningtn add for pos start @ 20100722 */
	String payType			= request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
	String MerchantNameChs 	= request.getParameter("MerchantNameChs");/**�Ӵ˿�ʼ����Ϊ���в���**/
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
	String new_opCode = request.getParameter("opcode");
	
	//liyan add end

    String paraAray[] = new String[36]; /*liyan modify at 20081222 19-->21 */
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = new_opCode ;
  	paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
	paraAray[4] = request.getParameter("sale_type");
	paraAray[5] = request.getParameter("sale_code");
	paraAray[6] = request.getParameter("used_point");
	paraAray[7] = request.getParameter("sum_money");      /*Ӧ�����*/
	/*paraAray[8] = prepay_fee;                              ��Ԥ��*/
	paraAray[8] = request.getParameter("pay_money");       /*��Ԥ��*/
	paraAray[9] = request.getParameter("card_dz");
	paraAray[10] = request.getParameter("card_money");     /*������*/
	paraAray[11] = request.getParameter("opNote");
	paraAray[12] = request.getParameter("ip_Addr");
	paraAray[13] = request.getParameter("phone_typename");
	paraAray[14] = request.getParameter("IMEINo");
	paraAray[15] = request.getParameter("payTime");
	paraAray[16] = request.getParameter("repairLimit");
	paraAray[17] = phone_type;
	paraAray[18] = award_flag;
	/* ningtn add for pos start @ 20100722 */
	paraAray[19]  = payType		   ;
	paraAray[20]  = MerchantNameChs ;
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
	/* ningtn add for pos start @ 20100722 */
	
%>
<wtc:service  name="s8661Cfm" routerKey="region" routerValue="<%=orgCode%>" outnum="2"  retcode="errCode" retmsg="errMsg">
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
	
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phone_no+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	System.out.println("==========================================="+url);
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(paraAray[7],2);
	  String outParaNums= "4";
%>
	<script language="JavaScript">
		/* ningtn add for pos start @ 20100722 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/* ningtn add for pos start @ 20100722 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
	</script>
  	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=orgCode%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=ipf%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
%>
<script language="JavaScript">
   rdShowMessageDialog("�ύ�ɹ�! ��ӡ��Ʊ��");
   var infoStr="";

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       ��G3�ʼǱ�"+"|";//����	
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+=" "+"|";//Э�����
   infoStr+="�ʼǱ�Ʒ���ͺ�: "+'<%=paraAray[13]%>'+"|";//֧Ʊ����	
   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
   infoStr+="<%=WtcUtil.formatNumber(paraAray[7],2)%>"+"|";//Сд

    
   var jkinfo="";
   	  
	if("<%=card_money%>"=="0"){
	   	jkinfo+="�ɷѺϼƣ�<%=paraAray[7]%>"+"Ԫ";�� 
	  //��Ԥ�滰�� <%=pay_money%>"+"Ԫ";
	}else{
	   	jkinfo+="�ɷѺϼƣ�<%=paraAray[7]%>"+"Ԫ";
	}
	
   //alert(jkinfo);
	 infoStr+=jkinfo+"|";
	// infoStr+="<%=work_name%>"+"|";//��Ʊ��
	infoStr+="<%=work_name%>"+"|";
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
	 //���������   END
   // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f8661_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=op_code%>";
   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=op_code%>&loginAccept=<%=paraAray[0]%>&dirtPage=/npage/s1141/f8661_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=op_code%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("����������������������ʧ��!(<%=errMsg%>",0);
	window.location="f8661_login.jsp?activePhone=<%=phone_no%>&opCode=<%=op_code%>";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>