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
	//retCode1="000000";
	 
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
		
		if(retCode2=="000000" ||retCode2.equals("000000"))
		{
			paySeq=s_result[0][2];//���񴫳�
			totalDate=s_result[0][3];
			//new begin
			%>
			<script language="javascript">
				alert("paySeq is "+"<%=paySeq%>");
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
		<!--xl add ��ƱԤռ-->
<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="8" >
		 
		<wtc:param value="<%=paySeq%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value=""/><!--op_time-->
		<wtc:param value="<%=phoneNo1%>"/>
		<wtc:param value="<%=id_no%>"/><!--id_no-->
		<wtc:param value="<%=contractno%>"/>
		<wtc:param value="<%=checkNo%>"/><!--s_check_num-->
		<wtc:param value=""/><!--��Ʊ���� ��һ�ε���ʱ ���� ���ڷ�����tpcallBASD�Ľӿ�ȡ��-->
		<wtc:param value=""/><!--��Ʊ���� ��-->
		<wtc:param value="<%=s_sm_code%>"/><!--sm_code -->
		<wtc:param value="<%=payMoney%>"/><!--Сд���-->
		<wtc:param value=""/><!--��д���-->
		<wtc:param value="<%=s_pay_note%>"/><!--��ע-->
	 
		<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
		<wtc:param value=""/><!--�ݿ�-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/><!--˰��-->
		<wtc:param value=""/>

		<!--��basd�� 0��Ԥռ 1��ȡ��Ԥռ ���������Ҫ�� -->
		<wtc:param value="<%=userName%>"/>
		<!--xl add ������� ��Ʊ���� �������� ����ͺ� ��λ ���� ���� regionCode groupId �Ƿ���-->
		<wtc:param value="0"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=groupId%>"/> 
		<wtc:param value="1"/>
</wtc:service>
<wtc:array id="bill_opy" scope="end"/>
<%
	if(bill_opy!=null&&bill_opy.length>0)
	{
		return_flag=bill_opy[0][0];
		if(return_flag.equals("000000"))
		{
			 ocpy_begin_no=bill_opy[0][2];
			 ocpy_end_no=bill_opy[0][3];
			 ocpy_num=bill_opy[0][4];
	         res_code=bill_opy[0][5];
			 bill_code=bill_opy[0][6];
			 bill_accept=bill_opy[0][7];
			 s_invoice_flag="0";
		}
		else
		{
			return_note=bill_opy[0][1];
			s_invoice_flag="1";
			%>
				<script language="javascript">
					//alert("��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
					//history.go(-1);
				</script>
			<%
		}
	}
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
	 function doProcess(packet)
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
				rdShowMessageDialog("��ƱԤռʧ��! �������:"+return_flag,0);

				//window.location.href="<%=return_page%>";
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
			var path="s1300_select_invoice.jsp";
			var returnValue = window.showModalDialog(path,"",prop);
		//	alert("test "+returnValue);	
			if(returnValue=="2")
			{
				
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("����ɷѳɹ�,�Ƿ��ӡ�վ�?");
				if (prtFlag==1){
					//��ӡ�վ�ʱ ��Ҫ����qidxȡ��Ԥռ�Ľӿ�
					document.frm_print.action="PrintInvoice_sj.jsp?sj_flag=Y&ims_flag="+"<%=ims_flag%>&payMoney="+"<%=payMoney%>";
					//alert(document.frm_print.action);
					document.frm_print.submit();
				}else{ 
					//window.location.href="<%=return_page%>";
					document.frm_print.action="PrintInvoice_sj.jsp?sj_flag=N&ims_flag="+"<%=ims_flag%>";
					//alert(document.frm_print.action);
					document.frm_print.submit(); 
			 }
			}
			else
			{
				if("<%=s_invoice_flag%>"=="0")
				{
					var prtFlag=0;
		 
					prtFlag=rdShowConfirmDialog("����ɷѳɹ�!��ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",��Ʊ������"+"<%=bill_code%>"+",�Ƿ��ӡ��Ʊ?");
					if (prtFlag==1)
					{
						//alert("��ӡ ������szg12InDB_pt");
						document.frm_print.action="PrintInvoice.jsp?check_seq="+"<%=ocpy_begin_no%>"+"&bill_code="+"<%=bill_code%>"+"&ims_flag="+"<%=ims_flag%>";
						//alert(document.frm_print.action);
						document.frm_print.submit();
					}
					else
					{ 
						//����ȡ���ӿ�
						//alert("ȡ�� ������scancelInDB_pt ���������ҳ��һ��ʼ�ͻ����һ�� ��Ԥռ������һ����ȡ��Ԥռ");
						var pactket1 = new AJAXPacket("sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
						//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
						pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
						pactket1.data.add("bill_code","<%=bill_code%>");
						pactket1.data.add("paySeq","<%=paySeq%>");
						pactket1.data.add("bill_code","<%=bill_code%>");
						pactket1.data.add("op_code","<%=op_code%>");
						pactket1.data.add("phoneNo","<%=phoneNo1%>");
						pactket1.data.add("contractno","<%=contractno%>");
						pactket1.data.add("payMoney","<%=payMoney%>");
						pactket1.data.add("userName","<%=userName%>");
						//alert("2 "+pactket1.data);
						 
						core.ajax.sendPacket(pactket1);
					 
						pactket1=null;
					}
				}
				else
				{
					rdShowMessageDialog("�ɷ����,��ƱԤռʧ��!����ԭ��:"+"<%=return_note%>");
					window.location.href="<%=return_page%>";
				}
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
		
