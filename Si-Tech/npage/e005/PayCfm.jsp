<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>


<!-- **********���ؽ��пؼ�ҳ******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
<!-- **********���ع��пؼ�ҳ******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>

<%
 	String groupId = (String)session.getAttribute("groupId");
	String opCode = "";
	String opName = "";
	String busy_type = WtcUtil.repNull(request.getParameter("busy_type"));	
	/*************add by zhanghonga@2008-09-22,����busy_type������opCode��opName,����ͳһ�Ӵ���opcode,opname��¼����*****************/
  switch(Integer.parseInt(busy_type)){
  	case 1 : 
  					opCode = "e005";
  					opName = "��ͨ�̻��ɷ�";
  					break;
  	case 2 :
  					opCode = "e006";
  					opName = "��ͨ����ɷ�";
  					break;
  	case 3 :
  					opCode = "e034";
  					opName = "���(����)";
  					break;
  	 			
  	default:
  					opCode = "e005";
  					opName = "��ͨ�̻��ɷ�";
  					break;
  }
  System.out.println("########################################s1300->PayCfm(�����ύ)->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
  
	
	String orgCode = (String)session.getAttribute("orgCode");
	
	String regionCode = orgCode.substring(0,2);
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");

	String phone_input = request.getParameter("phone_input");
//�������
	String phoneNo = request.getParameter("phoneNo");//�ֻ�����
	String contractno = request.getParameter("contractno");
	String payMoney = request.getParameter("payMoney");
	String delayRate = request.getParameter("delayRate");
	String remonthRate = request.getParameter("remonthRate");
	String payType = request.getParameter("moneyType");
	String pay_note = request.getParameter("pay_note");/*wangmei add*/
	System.out.println("#######pay_note="+pay_note);

	String  open_time = request.getParameter("showopentime");
	String  op_code = request.getParameter("op_code");
	String  batch = request.getParameter("batch");
	String  batchdate = request.getParameter("batchdate");
	String  payNote = request.getParameter("payNote");
	String  bankCode= request.getParameter("BankCode");
	String  checkNo= request.getParameter("checkNo");
	String  userName = request.getParameter("countName");
	String  sum_owefee = request.getParameter("sumowefee");
	String  currentFee = request.getParameter("currentFee");
	String  belongcode = request.getParameter("belongcode");
	String  print_note = request.getParameter("print_note");
	String  pos_code = request.getParameter("pos_code");
	String  pos_accept = request.getParameter("pos_accept");
	
	/********tianyang add at 20090928 for POS�ɷ�����****start*****/
	String MerchantNameChs = request.getParameter("MerchantNameChs");
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
	
	
	
	// xl add for ��Ʊ���� begin
	
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String result_sm[][]=new String[][]{};
	String[] inParam2 = new String[2];
	
	

	String[] inParam1 = new String[2];
	inParam1[0]="select sm_code,to_char(a.id_no) from dcustmsg a,dbroadbandmsg b where a.id_no =b.id_no and b.cfm_login=:s_no  ";
	inParam1[1]="s_no="+phone_input;
	String s_sm_code="";
	String s_id_no="";
	String s_print_jsp="";
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam1[0]%>"/>
		<wtc:param value="<%=inParam1[1]%>"/>
	</wtc:service>
	<wtc:array id="retSm" scope="end" />
<%
	result_sm=retSm;
	if(result_sm.length != 0)
	{
		s_sm_code = result_sm[0][0].trim();
		s_id_no= result_sm[0][1];
	}
	
	
	String prepayFee_fp = request.getParameter("prepayFee"); //Ԥ������
	
	String payMoney_fp = payMoney;
	
	String ubill_fp = request.getParameter("area");
	
	String curbalanace=request.getParameter("curbalanace");
	
	float kdzhsy = Float.parseFloat(payMoney_fp)+Float.parseFloat(curbalanace)-Float.parseFloat(ubill_fp);
	
	float kdzhsy_new =  (float)(Math.round(kdzhsy*100))/100;
	String result[][] = new String[][]{};
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/



	String[] phone = new String[]{};
	String paySign=request.getParameter("paySign");
	String flag="0";
 
	
	System.out.println("#####################--->op_code"+op_code);

  String return_page="";
	if(busy_type.equals("1")) 	return_page="../e005/s1300_2.jsp?opCode=e006&opName=����ɷ�&crmActiveOpCode=e006";
	if(busy_type.equals("2"))   return_page="../e005/s1300_2.jsp?opCode=e006&opName=����ɷ�&crmActiveOpCode=e006";
	if(busy_type.equals("3"))   return_page="e034.jsp?opCode="+opCode+"&opName="+opName;
 


	String [] inParas = new String[33];
	inParas[0]  = workno;
	inParas[1]  = nopass;
	inParas[2]  = orgCode;
	inParas[3]  = op_code;
	inParas[4]  = contractno;
	inParas[5]  =  phoneNo;
	inParas[6]  = payMoney;
	inParas[7]  = payType;
	inParas[8]  = delayRate;
	inParas[9]  = remonthRate;
	inParas[10] = bankCode;
	inParas[11] = checkNo; 
	inParas[12] =payNote; 
	inParas[13] = paySign;
	inParas[14] = pay_note;
	inParas[15] = pos_code;
	inParas[16] = pos_accept;
	/********tianyang add at 20090928 for POS�ɷ�����****start*****/
	inParas[17] = MerchantNameChs; /*�̻����ƣ���Ӣ��)*/
	inParas[18] = MerchantId;      /*�̻�����*/
	inParas[19] = TerminalId;      /*�ն˱���*/
	inParas[20] = IssCode;         /*�����к�*/
	inParas[21] = AcqCode;         /*�յ��к�*/
	inParas[22] = CardNo;          /*����*/
	inParas[23] = BatchNo;         /*���κ�*/
	inParas[24] = Response_time;   /*��Ӧ����ʱ��*/
	inParas[25] = Rrn;             /*�ο���*/
	inParas[26] = AuthNo;          /*��Ȩ��*/
	inParas[27] = TraceNo;         /*��ˮ��*/
	inParas[28] = Request_time;    /*�ύ����ʱ��*/
	inParas[29] = CardNoPingBi;    /*���׿��ţ�����*/
	inParas[30] = ExpDate;         /*��Ƭ��Ч��*/
	inParas[31] = Remak;           /*��ע��Ϣ*/
	inParas[32] = TC;              /*��Ҫ��ӡ������EMV���ף�оƬ����*/
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/

   System.out.println("wwwwwwwww"+contractno);
   
   
   String loginAccept ="";
%>
    <!-- chenhu add -->
<wtc:service name="bs_ChnPayLimit" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="5" >
	<wtc:param value="<%=workno%>"/>
  <wtc:param value="<%=payMoney%>"/>
    </wtc:service>
    <wtc:array id="result4"   scope="end" />
    <wtc:array id="result5"  scope="end" /> 	
    <wtc:array id="result6"  scope="end" />
    <wtc:array id="result7"  scope="end" />
    <wtc:array id="result8"  scope="end" />
<%      
								 String t_return_code = result4[0][0].trim();
				String t_return_msg = result5[0][0].trim();
				String flag_status  = result6[0][0].trim(); 
				String pledge_fee  = result7[0][0].trim(); 
				String total_money = result8[0][0].trim(); 
				System.out.println("chenhu test ############################ test t_return_code is "+t_return_code);
				System.out.println("chenhu test ############################ test t_return_msg is "+t_return_msg);
				System.out.println("chenhu test ############################ test flag_status is "+flag_status);
				if(!t_return_code.equals("000000")){
%>
 <script language='jscript'>			
						rdShowMessageDialog("��������˻�����<br>������룺'<%=t_return_code%>'��<br>������Ϣ��'<%=t_return_msg%>'��",0);
						history.go(-1);
	</script>	    
<%		
				}
%>	
    <!-- chenhu add end-->
<%   
   
   
if(flag.equals("0")&&t_return_code.equals("000000")){
		if(busy_type.equals("1")){ 
	    //value  = viewBean.callService("2",phoneNo,"s1300Cfm","3", inParas);
%>
	<wtc:service name="s1300Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	<wtc:param value="<%=inParas[11]%>"/>
	<wtc:param value="<%=inParas[12]%>"/>
	<wtc:param value="<%=inParas[13]%>"/>
	<wtc:param value="<%=inParas[14]%>"/>
	<wtc:param value="<%=inParas[15]%>"/>
	<wtc:param value="<%=inParas[16]%>"/>
	<wtc:param value="<%=inParas[17]%>"/>
	<wtc:param value="<%=inParas[18]%>"/>
	<wtc:param value="<%=inParas[19]%>"/>
	<wtc:param value="<%=inParas[20]%>"/>
	<wtc:param value="<%=inParas[21]%>"/>
	<wtc:param value="<%=inParas[22]%>"/>
	<wtc:param value="<%=inParas[23]%>"/>
	<wtc:param value="<%=inParas[24]%>"/>
	<wtc:param value="<%=inParas[25]%>"/>
	<wtc:param value="<%=inParas[26]%>"/>
	<wtc:param value="<%=inParas[27]%>"/>
	<wtc:param value="<%=inParas[28]%>"/>
	<wtc:param value="<%=inParas[29]%>"/>
	<wtc:param value="<%=inParas[30]%>"/>
	<wtc:param value="<%=inParas[31]%>"/>
	<wtc:param value="<%=inParas[32]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	result = sVerifyTypeArr;
	if(result!=null&&result.length>0){
		if(result[0][1].length()>0){
			loginAccept = result[0][1];		
		}
	}
} 
	if(busy_type.equals("2")){ 
       //value  = viewBean.callService("1", orgCode.substring(0,2), "s1300Cfm","3", inParas); 
%>
	<wtc:service name="s1300Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	<wtc:param value="<%=inParas[11]%>"/>
	<wtc:param value="<%=inParas[12]%>"/>
	<wtc:param value="<%=inParas[13]%>"/>
	<wtc:param value="<%=inParas[14]%>"/>
	<wtc:param value="<%=inParas[15]%>"/>
	<wtc:param value="<%=inParas[16]%>"/>
	<wtc:param value="<%=inParas[17]%>"/>
	<wtc:param value="<%=inParas[18]%>"/>
	<wtc:param value="<%=inParas[19]%>"/>
	<wtc:param value="<%=inParas[20]%>"/>
	<wtc:param value="<%=inParas[21]%>"/>
	<wtc:param value="<%=inParas[22]%>"/>
	<wtc:param value="<%=inParas[23]%>"/>
	<wtc:param value="<%=inParas[24]%>"/>
	<wtc:param value="<%=inParas[25]%>"/>
	<wtc:param value="<%=inParas[26]%>"/>
	<wtc:param value="<%=inParas[27]%>"/>
	<wtc:param value="<%=inParas[28]%>"/>
	<wtc:param value="<%=inParas[29]%>"/>
	<wtc:param value="<%=inParas[30]%>"/>
	<wtc:param value="<%=inParas[31]%>"/>
	<wtc:param value="<%=inParas[32]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
		result = sVerifyTypeArr;
		if(result!=null&&result.length>0){
			if(result[0][1].length()>0){
				loginAccept = result[0][1];		
			}
		}
 }

		if(busy_type.equals("3")){ 
  	 //value  = viewBean.callService("2",phoneNo,"s2327Cfm","3", inParas);
%>
	<wtc:service name="s2327Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	<wtc:param value="<%=inParas[11]%>"/>
	<wtc:param value="<%=inParas[12]%>"/>
	<wtc:param value="<%=inParas[13]%>"/>
	<wtc:param value="<%=inParas[14]%>"/>
	<wtc:param value="<%=inParas[15]%>"/>
	<wtc:param value="<%=inParas[16]%>"/>
	<wtc:param value="<%=inParas[17]%>"/>
	<wtc:param value="<%=inParas[18]%>"/>
	<wtc:param value="<%=inParas[19]%>"/>
	<wtc:param value="<%=inParas[20]%>"/>
	<wtc:param value="<%=inParas[21]%>"/>
	<wtc:param value="<%=inParas[22]%>"/>
	<wtc:param value="<%=inParas[23]%>"/>
	<wtc:param value="<%=inParas[24]%>"/>
	<wtc:param value="<%=inParas[25]%>"/>
	<wtc:param value="<%=inParas[26]%>"/>
	<wtc:param value="<%=inParas[27]%>"/>
	<wtc:param value="<%=inParas[28]%>"/>
	<wtc:param value="<%=inParas[29]%>"/>
	<wtc:param value="<%=inParas[30]%>"/>
	<wtc:param value="<%=inParas[31]%>"/>
	<wtc:param value="<%=inParas[32]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<% 
		result = sVerifyTypeArr;
		if(result!=null&&result.length>0){
			if(result[0][1].length()>0){
				loginAccept = result[0][1];		
			}
		}
 }
	
	String return_code="999999";
	String ret_msg="";
	if(result!=null&&result.length>0){
		return_code = result[0][0];
		ret_msg     = result[0][2];
	}

 	if(return_code.equals("139444")){%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("��ѯ����!<br>������룺'<%=return_code%>'��������Ϣ��'��׼�������û�������ǰ̨����'��");
			window.location.href="<%=return_page%>";
		//-->
		</SCRIPT>
	<%}
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
	String paySeq="";
	String totalDate="";
	String year="";
	String month="";
	String day="";
%>


<%
	 System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	 String retCodeForCntt = return_code;
	 String retMsgForCntt=ret_msg;
	 String cnttLoginAccept = loginAccept;
	 String url = "";
	 String cnttUserType="";
	 String cnttContactId = contractno;
	 if(busy_type.equals("4")){//xl ֮ǰ���˺ŽɷѲ�����;�����һ�������ڵĶ���
	 		cnttContactId = contractno;
	 		cnttUserType = "acc";
	 		url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType+"&retMsgForCntt="+retMsgForCntt+"&opBeginTime="+opBeginTime;
	 }else{//����ɷѻ������սɷ�.���յ��ɷ�����һ��ҳ��
	 	  cnttContactId = phoneNo;
	 	  cnttUserType = "user";
	 		url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsgForCntt+"&opBeginTime="+opBeginTime+"&contactType="+cnttUserType+"&contactId="+cnttContactId;	
	 }
	 System.out.println("url="+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
		System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%"); 
%>


<%
 	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String s_invoice_flag="";
	String s_pay_note="";
	s_pay_note ="���η�Ʊ���:(Сд)��"+payMoney;
	if(MerchantId!="" && (!MerchantId.equals("")))
	{
		s_pay_note+=",�̻����ƣ���Ӣ��):"+MerchantNameChs+",�̻�����:"+MerchantId+",�ն˱���:"+TerminalId+",�����к�:"+IssCode+",�յ��к�:"+AcqCode+",����:"+CardNo+",���κ�:"+BatchNo+",��Ӧ����ʱ��:"+Response_time+",�ο���:"+Rrn+",��Ȩ��:"+AuthNo+",��ˮ��:"+TraceNo+",�ύ����ʱ��:"+Request_time+",���׿��ţ�����)"+CardNoPingBi+",��Ƭ��Ч��:"+ExpDate+",��ע��Ϣ:"+Remak+",оƬ��:"+TC;
	}
	if (return_code.equals("000000"))
	{
 
		 paySeq = result[0][1];
		 totalDate = result[0][2];
		 year = totalDate.substring(0,4);
		 month = totalDate.substring(4,6);
		 day = totalDate.substring(6,8);
		// s_sm_code="kf"; xl add kg�ж�
	if((s_sm_code=="kf" ||s_sm_code.equals("kf")) ||(s_sm_code=="kg" ||s_sm_code.equals("kg")) ||(s_sm_code=="ki" ||s_sm_code.equals("ki")))
	{
		s_print_jsp="PrintInvoice_kf.jsp";
	}
	else
	{
		inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from tt_WLOGININVOICE where LOGIN_NO = :workNo";
		s_print_jsp="PrintInvoice.jsp";
		inParam2[1]="workNo="+workno;
	%>
		<wtc:service name="TlsPubSelCrm"  outnum="2" >
		
		<wtc:param value="<%=inParam2[0]%>"/>
		
		<wtc:param value="<%=inParam2[1]%>"/>
	
		</wtc:service>
	
		<wtc:array id="retList" scope="end" />
		
<%
			
			result_check = retList;
	
			if(retList.length != 0)
	
			{
				s_invoice_flag="0";
				check_seq=result_check[0][0];
				s_flag=result_check[0][1];
				//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa check_seq is "+check_seq);
	
			}
			else{
				s_invoice_flag="1";
			}
	
	// xl add for ��Ʊ���� end
		
	}
%>


<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT type="text/javascript">
/*tianyang add for pos**** boss���׳ɹ� ��������ȷ�Ϻ��� *****/
if("<%=payType%>"=="BX")
{
	BankCtrl.TranOK();
}
if("<%=payType%>"=="BY")
{
	var IfSuccess = KeeperClient.UpdateICBCControlNum();
}

	 function doqx(packet)
	 {
		var s_flag = packet.data.findValueByName("s_flag");	
		var s_code = packet.data.findValueByName("s_code");	//ò��ûɶ��
		var s_note = packet.data.findValueByName("s_note");	
		var s_invoice_code  = packet.data.findValueByName("s_invoice_code");//ò��Ҳûɶ��	
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		//s_flag="1";
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		if(s_flag=="1")
		{
			rdShowMessageDialog("Ԥռȡ���ӿڵ����쳣!");
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("��ƱԤռȡ���ɹ�,��ӡ���!",2);
				window.location.href="<%=return_page%>";
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��! �������:"+s_code,0);

				window.location.href="<%=return_page%>";
			}
		}
	 }
	 function doyz(packet)
	 {
		var ocpy_begin_no = packet.data.findValueByName("ocpy_begin_no");	 
		var ocpy_end_no = packet.data.findValueByName("ocpy_end_no");	
		var ocpy_num  = packet.data.findValueByName("ocpy_num"); 
		var res_code= packet.data.findValueByName("res_code"); 
		var bill_code= packet.data.findValueByName("bill_code");
		var bill_accept= packet.data.findValueByName("bill_accept");
		var s_invoice_flag= packet.data.findValueByName("s_invoice_flag");
		//new
		//s_ret_code="111111";
		var s_ret_code  =  packet.data.findValueByName("s_ret_code");
		var s_ret_msg  =  packet.data.findValueByName("s_ret_msg");
		if(s_invoice_flag=="1")
		{
			rdShowMessageDialog("Ԥռ�ӿڵ����쳣!");
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("e006�ɷѳɹ�!��ǰ��Ʊ������"+ocpy_begin_no+",��Ʊ������"+bill_code+",�Ƿ��ӡ��Ʊ?");
				if (prtFlag==1)
				{
					document.frm_print.action="PrintInvoice_kf.jsp?check_seq="+ocpy_begin_no+"&s_flag="+"<%=s_flag%>"+"&bill_code="+bill_code;
					//alert(document.frm_print.action);
					document.frm_print.submit();
				}
				else
				{
					var pactket2 = new AJAXPacket("sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
					//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
					pactket2.data.add("ocpy_begin_no",ocpy_begin_no);
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("paySeq","<%=paySeq%>");
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("op_code","<%=op_code%>");
					pactket2.data.add("phoneNo","<%=phoneNo%>");
					pactket2.data.add("contractno","<%=contractno%>");
					pactket2.data.add("payMoney","<%=payMoney%>");
					pactket2.data.add("userName","<%=userName%>");
					//alert("2 "+pactket1.data);
					 
					core.ajax.sendPacket(pactket2,doqx);
				 
					pactket2=null;
				}
			}
			else
			{
				rdShowMessageDialog("�ɷѷ�ƱԤռʧ��!����ԭ��:"+s_ret_msg,0);
				window.location.href="<%=return_page%>";
			}
		}
	 } 
function ifprint()//kf kg ki���ӷ�Ʊ
{
	if(("<%=s_sm_code%>"=="kf" || "<%=s_sm_code%>"=="kg"|| "<%=s_sm_code%>"=="ki"))
	{
		//ֱ�ӵ���ѡ���ӡҳ��
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var path="../s1300/select_invoice.jsp";
		var returnValue = window.showModalDialog(path,"",prop);
		if(returnValue=="1")
		{
			var pactket1 = new AJAXPacket("../s1300/sfp_ocpy.jsp","���ڽ��з�ƱԤռ�����Ժ�......");
			pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
			pactket1.data.add("bill_code","<%=bill_code%>");
			pactket1.data.add("paySeq","<%=paySeq%>");
			pactket1.data.add("bill_code","<%=bill_code%>");
			pactket1.data.add("op_code","<%=op_code%>");
			pactket1.data.add("phoneNo","<%=phoneNo%>");
			pactket1.data.add("contractno","<%=contractno%>");
			pactket1.data.add("payMoney","<%=payMoney%>");
			pactket1.data.add("userName","<%=userName%>");
			core.ajax.sendPacket(pactket1,doyz);
			pactket1=null;
		}
		else if(returnValue=="3")
		{
			
			//alert("���ӵ�");
			var s_kpxm="<%=opCode%>"+"<%=opName%>";
			var s_ghmfc="<%=userName%>";
			var s_jsheje="<%=payMoney%>";//��˰�ϼƽ��
			var s_hjbhsje=0;//�ϼƲ���˰���
			var s_hjse=0;
			var s_xmmc="����ɷ�";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
			var s_ggxh="";
			var s_hsbz="1";//��˰��־ 1=��˰
			var s_xmdj="<%=payMoney%>";
			var s_xmje="<%=payMoney%>";
			var s_sl="*";
			var s_se="0";
			//����
			var op_code="<%=opCode%>";
			var payaccept="<%=paySeq%>";
			var id_no="<%=s_id_no%>";
			var sm_code="<%=s_sm_code%>";
			var phone_no="<%=phoneNo%>";
			var pay_note=s_kpxm;
			var chbz="1";//0���ַ�Ʊ 1��ͨ��Ʊ 2ԭʼ��Ʊ��� pԭ��Ʊ����
			var returnPage="<%=return_page%>";
			var kphjje = "<%=payMoney%>";
			document.frm_print.action="../s1300/PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje;
			document.frm_print.submit(); 
				
		}
		else//ȡ����
		{
			var paySeq="<%=paySeq%>";
			var phoneno="<%=phoneNo%>";
			var kphjje="<%=payMoney%>";//��Ʊ�ϼƽ��
			var s_hjbhsje=0;//�ϼƲ���˰���
			var s_hjse=0;
			var contractno="<%=contractno%>";
			var id_no="<%=s_id_no%>";
			var sm_code="<%=s_sm_code%>";
			var s_xmmc="<%=opName%>";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
			var opCode="<%=opCode%>";
			var return_page = "<%=return_page%>";
			document.frm_print.action="../s1300/PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=e006�ɷ�";
			
			document.frm_print.submit();
		}
	}	
    else
	{
		document.frm_print.action="PrintInvoice.jsp?check_seq="+"<%=check_seq%>"+"&s_flag="+"<%=s_flag%>";
		document.frm_print.submit();
	}
} 
</SCRIPT>

<body onload="ifprint()">
<form action="" name="frm_print" method="post">

<INPUT TYPE="hidden" name="s_sm_code" value="<%=s_sm_code%>">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo%>">  
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="phone_input"  value="<%=phone_input%>">
<!--xl add for ��Ʊ-->

<input type="hidden" name="prepayFee_fp"  value="<%=prepayFee_fp%>">
<input type="hidden" name="payMoney_fp"  value="<%=payMoney_fp%>">
<input type="hidden" name="ubill_fp"  value="<%=ubill_fp%>">
<input type="hidden" name="curbalanace"  value="<%=curbalanace%>">
<input type="hidden" name="kdzhsy"  value="<%=kdzhsy_new%>">
<input type="hidden" name="ifRed"  value="1">
</form>
</body></html>
<%
}else{%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("��ѯ����!<br>������룺'<%=return_code%>'��������Ϣ��'<%=retMsg1%>'��");
			window.location.href="<%=return_page%>";

		//-->
		</SCRIPT>
	<%}
}else{%>
<!--chenhu add -->
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("��������˻�����<br>������룺'<%=t_return_code%>'��<br>������Ϣ��'<%=t_return_msg%>'��",0);
			window.location.href="<%=return_page%>";
		</SCRIPT>
	<%}%>