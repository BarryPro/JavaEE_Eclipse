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
 	String wxddh = request.getParameter("wxddh");
 
	String login_aceept = request.getParameter("login_aceept");

	String groupId = (String)session.getAttribute("groupId");
	String opCode = "";
	String opName = "";
	String busy_type = WtcUtil.repNull(request.getParameter("busy_type"));	
	/*************add by zhanghonga@2008-09-22,����busy_type������opCode��opName,����ͳһ�Ӵ���opcode,opname��¼����*****************/
	String ims_flag = request.getParameter("ims_flag");
  switch(Integer.parseInt(busy_type)){
  	case 1 : 
  					opCode = "1302";
  					opName = "����ɷ�";
  					break;
  	case 2 :
  					opCode = "1300";
  					opName = "�˺Žɷ�";
  					break;
  	case 3 :
  					opCode = "1304";
  					opName = "�ɷ�(����)";
  					break;
  	case 5 :
  					opCode = "2327";
  					opName = "�ɷ�(�����˺�)";
  					break;
  	default:
  					opCode = "1302";
  					opName = "��ͨ�ɷ�";
  					break;
  }
  System.out.println("########################################s1300->PayCfm(�����ύ)->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/
	
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
 
	
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");

	String phoneNo = request.getParameter("phoneNo");
	String phoneNo1= request.getParameter("phoneNo");
	String contractno = request.getParameter("contractno");
	String payMoney = request.getParameter("payMoney");
	String delayRate = request.getParameter("delayRate");
	String remonthRate = request.getParameter("remonthRate");
	String payType = request.getParameter("moneyType");
	String pay_note = request.getParameter("pay_note");/*wangmei add*/
	System.out.println("#######pay_note="+pay_note);
	String s_pay_note="";
	s_pay_note ="���η�Ʊ���:(Сд)��"+payMoney;
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
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/
	String id_no="";
    String s_sm_code="";
    String s_sm_name="";
 	

	 
 

	String return_page="s1300.jsp";
 
    
	String result[][] = new String[][]{};
	String return_code=""; 
	String error_msg = "";
	String paySeq="";//���񴫳�
	String totalDate="";//���񴫳�
	String year="";
	String month="";
	String day=""; 
	//sOrderPay
	String wxzf =request.getParameter("wxzf");
	String ipAddr = request.getRemoteAddr();
	String ip_Addr = (String)session.getAttribute("ipAddr");
	System.out.println("ffffffffffffffffffffffsssssssssssssssssssssss ipAddr is "+ipAddr+" and ip_Addr is "+ip_Addr);
	String s_ddms="΢��֧��";
	//
	String ddhid = request.getParameter("ddhid");
%>

		
	<wtc:service name="sOrderPay" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=payMoney%>"/>
		<wtc:param value="<%=wxzf%>"/>
		<wtc:param value="<%=ip_Addr%>"/>
		<wtc:param value="<%=wxddh%>"/>
		<wtc:param value="<%=s_ddms%>"/>
		<wtc:param value="<%=ddhid%>"/>
	</wtc:service>
	<wtc:array id="sVerifyTypeArr" scope="end"/>
<% 		
	result = sVerifyTypeArr;
	//�������ӿڷ��سɹ� ��Ҫ�ٵ���һ���µĽӿ� �ṩ��ˮɶ��~~
	retCode1="000000";
	 
	if(retCode1=="000000" ||retCode1.equals("000000"))
	{
		//�µ�wtc
		%>
		<wtc:service name="sOrderQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
			<wtc:param value="<%=ddhid%>"/>
		</wtc:service>
		<wtc:array id="s_result" scope="end"/>
		<%
		//end of ��ѯ�Ľӿڵ���
		return_code=retCode2;
		retCode2="000000";
		if(retCode2=="000000" ||retCode2.equals("000000"))
		{
			paySeq=s_result[0][2];//���񴫳� ����д�̶�һ��ֵ
			totalDate=s_result[0][3];
			paySeq="12345689015";
			totalDate="20170517";
			//new begin
			%>
			<script language="javascript">
				//alert("paySeq is "+"<%=paySeq%>");
			</script>
			<% 
 
		
		
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
 

<%
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
	
	if(id_no==null||"".equals(id_no)){
     id_no="0";
  }
  if(phoneNo1==null||"".equals(phoneNo1)){
    phoneNo1="0";
  }
  //xl add ���ݴ�ӡ��ʶ�ж��Ƿ��ӡ��Ʊ 
	%>
 


<body onload="ifprint()">
<form action="" name="frm_print" method="post">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo1%>">  
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="s_invoice_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>">
<input type="hidden" name="userName" value="<%=userName%>">
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
				prtFlag=rdShowConfirmDialog("����ɷѳɹ�!��ǰ��Ʊ������"+ocpy_begin_no+",��Ʊ������"+bill_code+",�Ƿ��ӡ��Ʊ?");
				if (prtFlag==1)
				{
					document.frm_print.action="PrintInvoice_1302.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code+"&ims_flag="+"<%=ims_flag%>"+"&returnPage="+"<%=return_page%>";
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
					pactket2.data.add("phoneNo","<%=phoneNo1%>");
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
			//alert("1???");
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			var path="s1300_select_invoice_new.jsp?i_count=0";
			var returnValue = window.showModalDialog(path,"",prop);
			//alert("222 test returnValue is "+returnValue);	
			if(returnValue=="2")
			{
				
				//��ӡ�վ�ʱ ��Ҫ����xuxz�½ӿ�
				var paySeq="<%=paySeq%>";
				var phoneno="<%=phoneNo1%>";
				var kphjje="<%=payMoney%>";//��Ʊ�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var contractno="<%=contractno%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var s_xmmc="<%=opName%>";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_sj.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&payMoney="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&s_sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=�ɷ�"+"&sj_flag=Y&ims_flag="+"<%=ims_flag%>";
				//document.frm_print.action="PrintInvoice_sj.jsp?sj_flag=Y&ims_flag="+"<%=ims_flag%>&payMoney="+"<%=payMoney%>"+"&id_no="+"<%=id_no%>&s_sm_code="+"<%=s_sm_code%>";
				 
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
				pactket1.data.add("phoneNo","<%=phoneNo1%>");
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
				var s_xmmc="����ɷ�";//s_kpxm;//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				var s_ggxh="";
				var s_hsbz="1";//��˰��־ 1=��˰
				var s_xmdj="<%=payMoney%>";
				var s_xmje="<%=payMoney%>";
				var s_sl="*";
				var s_se="0";
				//����
				var op_code="<%=opCode%>";
				var payaccept="<%=paySeq%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var phone_no="<%=phoneNo1%>";
				var pay_note=s_kpxm;
				var returnPage="<%=return_page%>";
				var chbz="1";//0���ַ�Ʊ 1��ͨ��Ʊ 2ԭʼ��Ʊ��� pԭ��Ʊ����
				//14 18 27 28 ���ĸ�ֵ
				var kphjje = "<%=payMoney%>";
				//alert("s_xmmc is "+s_xmmc);
				//�����:contractno total_date payAccept
				document.frm_print.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=totalDate%>";
				document.frm_print.submit(); 
				
			}
			else
			{
				var paySeq="<%=paySeq%>";
				var phoneno="<%=phoneNo1%>";
				var kphjje="<%=payMoney%>";//��Ʊ�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var contractno="<%=contractno%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var s_xmmc="<%=opName%>";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=�ɷ�";
				
				document.frm_print.submit();
			}
			
		}
		

	 
 </script>
 	
</body>
	 

</html>
<%
 
			//end new
			
		}	
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("΢��֧�������ѯʧ��!����ԭ��:"+"<%=retMsg2%>");
					/*
					win=parent.addTab(true,'1352','��Ʊ��ӡ','../s1300/s1352.jsp?activePhone=');
					parent.removeTab("1352");
					win=parent.addTab(true,'1352','��Ʊ��ӡ','../s1300/s1352.jsp?activePhone='+"<%=phoneNo%>");
					*/
					window.location.href="s1300.jsp";
				</script>
			<%
		}
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("΢��֧��ʧ��!�������:"+"<%=retCode1%>"+",����ԭ��:"+"<%=retMsg1%>");
				window.location.href="s1300.jsp";
			</script>
		<%
	}
	
 	 
	 
 %>
		
