<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.04
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

<%
	//String[][] result = new String[][]{};
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();

	//ArrayList retArray = new ArrayList();

	/**
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String[][] agentInfo = (String[][])arr.get(2);
	String work_no = baseInfo[0][2];
	String work_name = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String[][] password1 = (String[][])arr.get(4);//��ȡ��������
	String pass = password1[0][0];
	String ip_Addr = agentInfo[0][2];
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");
	String paraAray[] = new String[19];
	**/

			String work_no =(String)session.getAttribute("workNo");
			String work_name =(String)session.getAttribute("workName");
			String orgCode =(String)session.getAttribute("orgCode");
			String regionCode = orgCode.substring(0,2);
			String ip_Addr =(String)session.getAttribute("ip_Addr");
			String pass = (String)session.getAttribute("password");
			String cust_name=request.getParameter("cust_name");
			String card_info=request.getParameter("");
			String card_money=request.getParameter("");
			String op_code=request.getParameter("op_code");
			String paraAray[] = new String[36];
			String TVprice=request.getParameter("TVprice");
			String opName="Ԥ�滰���Żݹ���";

			/* ningtn add for pos start @ 20100408 */
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
			/* ningtn add for pos start @ 20100408 */


	//sunzx add at 20070903
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
    //sunzx add end


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

		/* ningtn add for pos start @ 20100408 */
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
		/* ningtn add for pos start @ 20100408 */

		System.out.println("R1141.log..award_flag="+award_flag);

	for ( int i=0;i<paraAray.length;i++  )
	{
		System.out.println("1141~~~~paraAray["+i+"]= "+paraAray[i] );
	}
   /**String[] ret = impl.callService("s1141Cfm",paraAray,"2","region",org_code.substring(0,2));
	int errCode = impl.getErrCode();
	String errMsg = impl.getErrMsg();
	**/
%>
      <wtc:service name="s1141Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
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
			<wtc:array id="result1" scope="end" />

<%
/*����ʹ��
errCode="000000";*/
if(errCode.equals("0")||errCode.equals("000000")){

		String statisLoginAccept = request.getParameter("login_accept"); /*��ˮ*/
		String statisOpCode=op_code;
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
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />

	<script language="JavaScript">
		/* ningtn add for pos start @ 20100408 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/* ningtn add for pos start @ 20100408 **** boss���׳ɹ� ��������ȷ�Ϻ��� ****/
	</script>
<%
}

    System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
		String retCodeForCntt = errCode ;
		String loginAccept = paraAray[0];

		if(errCode.equals("0")||errCode.equals("000000")){
				if(result1.length>0){
				  //loginAccept=result1[0][0];
				}
		}

		String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[1] +"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);


		%>
		<jsp:include page="<%=url%>" flush="true" />
		<%
System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");


	      if(errCode.equals("0")||errCode.equals("000000")){
          System.out.println("���÷���s1141Cfm in f1141Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");

          ///____________________________________________________

          //S1100View callView = new S1100View();
			//String chinaFee = ((String[][])(callView.view_sToChinaFee(Pub_lxd.formatNumber(paraAray[7],2)).get(0)))[0][2];//��д���
			String chinaFee="";
						   %>
						   <wtc:service name="sToChinaFee" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="errMsg1"  outnum="3" >
				          <wtc:param value="<%=WtcUtil.formatNumber(paraAray[7],2)%>"/>
							</wtc:service>
							<wtc:array id="result" scope="end" />


						<%
						 if(ret_code1.equals("0")||ret_code1.equals("000000")){
				          System.out.println("���÷���sToChinaFee in f1141Cfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");

				 	       	if(result.length!=0){
				 	       	  chinaFee=result[0][2];


													%>
													<script language="JavaScript">
													   rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��");
													   var infoStr="";
													   infoStr+="<%=work_no%>  <%=work_name%>"+"       Ԥ�滰���Żݹ���"+"|";//����
													   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
													   infoStr+='<%=cust_name%>'+"|";
													   infoStr+=" "+"|";
													   infoStr+='<%=paraAray[3]%>'+"|";
													   infoStr+=" "+"|";//Э�����
													   infoStr+="�ֻ��ͺţ�"+"<%=paraAray[13]%>"+"|";//�ֻ��ͺ�
													   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
													   infoStr+="<%=WtcUtil.formatNumber(paraAray[7],2)%>"+"|";//Сд
													   infoStr+="�ɿ�ϼƣ� <%=WtcUtil.formatNumber(paraAray[7],2)%>"+
															 "Ԫ����Ԥ�滰�ѣ� <%=WtcUtil.formatNumber(paraAray[8],2)%>"+
															 "Ԫ���ֻ����ӹ��ܷѣ�<%=WtcUtil.formatNumber(TVprice,2)%>"+"Ԫ|";


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

														/* ningtn add for pos start @ 20100408 */
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
														/* ningtn add for pos end @ 20100408 */

													  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
													   var dirtPage="/npage/s1141/f1141_login.jsp?activePhone=<%=paraAray[3]%>%26opCode=<%=op_code%>";
													   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage+"&op_code=1141&loginAccept=<%=loginAccept%>";
													</script>

													<%

				 	       	}

				 	     	}else{
				 			System.out.println("���÷���sToChinaFee in f1141Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
				 			}



          ///____________________________________________________



 	     	}else{
			 			System.out.println("���÷���s1141Cfm in f1141Cfm.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>
						<script language="JavaScript">
							rdShowMessageDialog("Ԥ�滰���Żݹ���ʧ��!<%=errMsg%>");
							window.location="f1141_login.jsp?activePhone=<%=paraAray[3]%>&opCode=<%=op_code%>";
						</script>
						<%


 			}

	%>
