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
 	String opCode = "";
	String opName = "";
	String groupId = (String)session.getAttribute("groupId");
	String busy_type = WtcUtil.repNull(request.getParameter("busy_type"));	
	/*************add by zhanghonga@2008-09-22,����busy_type������opCode��opName,����ͳһ�Ӵ���opcode,opname��¼����*****************/
  switch(Integer.parseInt(busy_type)){
  	case 1 : 
  					opCode = "d340";
  					opName = "���Žɷ�";
  					break;
  		
  	default:
  					opCode = "d340";
  					opName = "���Žɷ�";
  					break;
  }
  System.out.println("#################################���Ž�ͨ>PayCfmgroup(�����ύ)->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
	String print_flag = request.getParameter("print_flag");

    String login_aceept = request.getParameter("login_aceept");
	String s_id_no="";
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");

	String phoneNo = request.getParameter("phoneNo");
	String contractno = request.getParameter("contractno");
	String payMoney = request.getParameter("payMoney");
	String delayRate = request.getParameter("delayRate");
	String remonthRate = request.getParameter("remonthRate");
	String payType = request.getParameter("moneyType");
	String pay_note = request.getParameter("pay_note");/*wangmei add*/
	System.out.println("#######pay_note="+pay_note);

	String  open_time = request.getParameter("showopentime");
	String  op_code = request.getParameter("op_code");
  String s_sm_code="";
  String s_sm_name="";
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
	//xl add for ��ע��Ϣ
	String backnote = request.getParameter("backnote");
	System.out.println("fffffffffffffffffffffffffffffffffffffffffff backnote is "+backnote);
	// xl add for ��Ʊ���� begin
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from WLOGININVOICE where LOGIN_NO = :workNo";
	inParam2[1]="workNo="+workno;
	
	//hq add ����contract_no��ѯid_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +" a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contractno;
			
%>
	<wtc:service name="TlsPubSelCrm"  outnum="2" >
		<wtc:param value="<%=inParam2[0]%>"/>
		<wtc:param value="<%=inParam2[1]%>"/>
	</wtc:service>
	<wtc:array id="retList" scope="end" />
		
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
	<wtc:param value="<%=inParam_idno[0]%>"/>
	<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
<%
	result_check = retList;
	if(retList.length != 0)
	{
		check_seq=result_check[0][0];
		s_flag=result_check[0][1];
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa check_seq is "+check_seq);
	}
	
		if(id_no_arr!=null&&id_no_arr.length>0){
        	s_id_no = id_no_arr[0][0];
        	phoneNo = id_no_arr[0][1].trim();
    }
 		
 		
    //��ѯƷ������
    String[] inParam = new String[2];
		inParam[0] ="select c.sm_code, c.sm_name  from dcustmsg d,ssmcode c where d.sm_code=c.sm_code and substr(d.belong_code,0,2) =c.region_code and d.phone_no=:smphoneNo";
		inParam[1] = "smphoneNo="+phoneNo;	
	// xl add for ��Ʊ���� end
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
	String result[][] = new String[][]{};
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/


	//xl add for chenglili
	String jtcpmc = request.getParameter("jtcpmc");
	String[] phone = new String[]{};
	String paySign=request.getParameter("paySign");
	String flag="0";
	
	if(payType.equals("8"))
	{
		op_code="3459";
		payType ="0";
	}
	
	System.out.println("#####################--->op_code"+op_code);

  String return_page="s1300_group.jsp?opCode="+opCode+"&opName="+opName;
	


	String [] inParas = new String[34];
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
	
	String s_pay_note="";
	s_pay_note ="���η�Ʊ���:(Сд)��"+payMoney;
	if(MerchantId!="" && (!MerchantId.equals("")))
	{
		s_pay_note+=",�̻����ƣ���Ӣ��):"+MerchantNameChs+",�̻�����:"+MerchantId+",�ն˱���:"+TerminalId+",�����к�:"+IssCode+",�յ��к�:"+AcqCode+",����:"+CardNo+",���κ�:"+BatchNo+",��Ӧ����ʱ��:"+Response_time+",�ο���:"+Rrn+",��Ȩ��:"+AuthNo+",��ˮ��:"+TraceNo+",�ύ����ʱ��:"+Request_time+",���׿��ţ�����)"+CardNoPingBi+",��Ƭ��Ч��:"+ExpDate+",��ע��Ϣ:"+Remak+",оƬ��:"+TC;
	}


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
	inParas[33] = login_aceept;
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/

   System.out.println("wwwwwwwww"+contractno);
   
   
   String loginAccept ="";
%>  
<!-- chenhu add -->
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
		
		
<wtc:service name="bs_ChnPayLimit" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=inParas[0]%>"/>
  <wtc:param value="<%=inParas[6]%>"/>
    </wtc:service>
    <wtc:array id="result4"   scope="end" />
    <wtc:array id="result5"  scope="end" /> 	
    <wtc:array id="result6"  scope="end" />
    <wtc:array id="result7"  scope="end" />
    <wtc:array id="result8"  scope="end" />
<%      

    
		if(sm_name_arr!=null&&sm_name_arr.length>0){
      s_sm_code = sm_name_arr[0][0];
      s_sm_name = sm_name_arr[0][1];
 		}	
 		
 		
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
   
if(flag.equals("0") && t_return_code.equals("000000")){
 
	    //value  = viewBean.callService("2",phoneNo,"s1300Cfm","3", inParas);
%>
  <!-- chenhu add end-->
	<wtc:service name="sd340Cfm" routerKey="region" routerValue="<%=orgCode.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
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
	<wtc:param value="<%=inParas[33]%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	result = sVerifyTypeArr;
	if(result!=null&&result.length>0){
		if(result[0][1].length()>0){
			loginAccept = result[0][1];		
		}
	}
 
  
	
	String return_code="999999";
	String ret_msg="";
	if(result!=null&&result.length>0){
		return_code = result[0][0];
		ret_msg     = result[0][1];
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
	 if(busy_type.equals("2")){//1302 �˺Žɷ�
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
 	if (return_code.equals("000000"))
	{
 
		 paySeq = result[0][1];
		 totalDate = result[0][2];
		 year = totalDate.substring(0,4);
		 month = totalDate.substring(4,6);
		 day = totalDate.substring(6,8);
		
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
 
</SCRIPT>
<%
	//add for hanfeng ����רƱ��¼ beign
	String[] inParam2_zp = new String[2];
	inParam2_zp[0]="select to_char(count(*)) from dinvoicebyym a,dconusermsg b,dcustmsg c  where a.phone_no=c.phone_no and b.id_no=c.id_no and b.contract_no=:s_contract_no and a.tax_invoice_number is not null and a.chg_flag='1'";
	inParam2_zp[1]="s_contract_no="+contractno;
	int i_count=0;
%>
<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam2_zp[0]%>"/>
		<wtc:param value="<%=inParam2_zp[1]%>"/>
	</wtc:service>
	<wtc:array id="retList" scope="end" />
<%		
	if(retList.length>0)
	{
		i_count=Integer.parseInt(retList[0][0]);
	}
	//end of Hanfeng
//huangqi add ��ƱԤռ  start 
 
	//String s_invoice_tmp="";
	String return_flag="";
	String return_note="";
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String s_invoice_flag="";
%>
<%
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa print_flag is "+print_flag);
	if(print_flag=="Y" ||print_flag.equals("Y"))
	{
			%>
				<script language="javascript">
					rdShowMessageDialog("Ԥ����Ʊ���ճɹ�!");
					window.location.href="<%=return_page%>";
				</script>
			<%
	}
	else
	{
		%>
		 


<body onload="ifprint()">
<form action="" name="frm_print" method="post">

<INPUT TYPE="hidden" name="backnote" value="<%=backnote%>">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo%>">  
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="bill_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>">
<input type="hidden" name="s_invoice_code" value="<%=bill_code%>">
<input type="hidden" name="userName" value="<%=userName%>">
<input type="hidden" name="s_id_no" value="<%=s_id_no%>">
<input type="hidden" name="s_sm_code" value="<%=s_sm_code%>">
<input type="hidden" name="s_sm_name" value="<%=s_sm_name%>">
<input type="hidden" name="ifRed" value="1">
<script language="javascript">
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
		var s_ret_code  =  packet.data.findValueByName("s_ret_code");
		var s_ret_msg  =  packet.data.findValueByName("s_ret_msg");
		if(s_invoice_flag=="1")
		{
			rdShowMessageDialog("Ԥռ�ӿڵ����쳣!�������:"+s_ret_code+",����ԭ��:"+s_ret_msg);
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("���Žɷѳɹ�!��ǰ��Ʊ������"+ocpy_begin_no+",��Ʊ������"+bill_code+",�Ƿ��ӡ��Ʊ?");
				if (prtFlag==1)
				{
					document.frm_print.action="PrintInvoice.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code+"&returnPage="+"<%=return_page%>";
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
</script> 
</form>
 <script language="javascript">
		function ifprint()
		{
			/*
				xl add for ��ӡ�վ�or��Ʊ�ĶԻ���
			*/
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			var path="s1300_select_invoice_new.jsp?i_count="+"<%=i_count%>";
		//	alert("path "+path);
			var returnValue = window.showModalDialog(path,"",prop);
			//alert("test returnValue is "+returnValue);	
			if(returnValue=="2")
			{
				
				//��ӡ�վ�ʱ ��Ҫ����xuxz�½ӿ�
				var paySeq="<%=paySeq%>";
				var phoneno="<%=phoneNo%>";
				var kphjje="<%=payMoney%>";//��Ʊ�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var contractno="<%=contractno%>";
				var id_no="<%=s_id_no%>";
				var sm_code="<%=s_sm_code%>";
				var s_xmmc="<%=opName%>";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_sj.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&payMoney="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&s_sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=���Žɷ�"+"&sj_flag=Y";;
		 
				 
				//alert(document.frm_print.action);
				document.frm_print.submit();
			}
			else if(returnValue=="1")
			{
				var pactket1 = new AJAXPacket("sfp_ocpy.jsp","���ڽ��з�ƱԤռ�����Ժ�......");
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
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ begin
				var h=300;
			  var w=680;
			  var t=screen.availHeight/2-h/2;
			  var l=screen.availWidth/2-w/2;
			  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			  var path1="getNsrsbh.jsp?param_no="+"<%=phoneNo%>"+"&param_type=1";
			  var returnValue1 = window.showModalDialog(path1,"",prop);
			  //alert("test returnValue1 is "+returnValue1);
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
				
				//alert("���ӵ�");
				var s_kpxm="<%=opCode%>"+"<%=opName%>";
				var s_ghmfc="<%=userName%>";
				var s_jsheje="<%=payMoney%>";//��˰�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var s_xmmc="���Žɷ�";//s_kpxm;//��Ŀ���� crm����Ϊ����? ����zg17������ô����
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
				var returnPage="<%=return_page%>";
				var chbz="1";//0���ַ�Ʊ 1��ͨ��Ʊ 2ԭʼ��Ʊ��� pԭ��Ʊ����
				//14 18 27 28 ���ĸ�ֵ
				var kphjje = "<%=payMoney%>";
				//alert("s_xmmc is "+s_xmmc);
				//�����:contractno total_date payAccept
				//document.frm_print.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=totalDate%>";
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ begin
				document.frm_print.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=totalDate%>"+"&s_gmfsbh="+returnValue1;
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
				document.frm_print.submit(); 
				
			}
			else
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
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=���Žɷ�";
				
				document.frm_print.submit();
			}	
			  
			
		}
		

	 
 </script>
 	
</body>
		<%
	}	
%>


</html>
<%
}else{%>
	<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("��������˻�����<br>������룺'<%=t_return_code%>'��<br>������Ϣ��'<%=t_return_msg%>'��",0);
			window.location.href="<%=return_page%>";
		</SCRIPT>
	<%}
	}%>
