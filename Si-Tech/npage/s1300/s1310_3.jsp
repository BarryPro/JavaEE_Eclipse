<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-15 ҳ�����,�޸���ʽ
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 
<%@ page import="java.util.*"%>


<!-- **********���ؽ��пؼ�ҳ******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
<!-- **********���ع��пؼ�ҳ******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
   
<%
    String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String opCode = "1310";
    String opName = "�ɷѳ���";
	String orgcode = (String)session.getAttribute("orgCode");
    String regionCode = orgcode.substring(0,2);
    String groupId = (String)session.getAttribute("groupId");
    String loginaccept = request.getParameter("water_number");//��ˮ��
    String accept_detail = request.getParameter("nopaywater");//������ˮ
    String pay_code = request.getParameter("pay_code");//���ѷ�ʽ
    String remark = request.getParameter("remark");//��ע
    String pay_type = request.getParameter("pay_type");
//	pay_type="BY";
    String paytime = request.getParameter("paytime");
    String contractno=request.getParameter("contractno");
    String phoneno=request.getParameter("phoneNo");
    String totaldate=paytime.substring(0,4)+paytime.substring(5,7)+paytime.substring(8,10);
	  String userName=request.getParameter("user");
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

    //�������
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String workno = baseInfo[0][2];
    //String workname = baseInfo[0][3];
    //String orgcode = baseInfo[0][16];//��������
    
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    
		String id_no="";
  	String s_sm_code="";
 	 	String s_sm_name="";
  
		//hq add ����contract_no��ѯid_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +" a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contractno;
		
	String s_retun_page="s1310.jsp?ph_no="+phoneno+"&opCode="+opCode+"&opName="+opName;
		
 
    String paySeq = "";
    String totalDate = "";
    // xl add for ��Ʊ���� begin
	 
	// xl add for ��Ʊ���� end
	String payMoney = request.getParameter("textfield8");
	//int i_money = Integer.parseInt(payMoney);
	//i_money=(-1)*i_money;
	//Float f_pay_money=0.0; 
	//f_pay_money = Float.parseFloat(payMoney);
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
	String s_flag="";
	String check_seq="";
 
	String s_old_number="";	//ԭ��Ʊ����
	String s_old_code="";	//ԭ��Ʊ����
	String s_old_status="";	//ԭ��Ʊ״̬ 0-δ���� 1-ֽ�� 2-�����ն� 6-Ԥռ e-���ӷ�Ʊ r-�վ� z-רƱ
	String s_old_accept="";	//ԭ���ӷ�Ʊ��ˮ
	//String s_invoice_flag="";//Ԥ����
	String s_old_ret_code="";//���ش���
	String s_old_ret_msg=""; //����ֵ
	
	
	String inParas[] = new String[25];
    inParas[0] = contractno;
    inParas[1] = phoneno ;
    inParas[2] = totaldate;
    inParas[3] = loginaccept ;
    inParas[4] = workno;
    inParas[5] = pay_code ;
    inParas[6] = accept_detail ;
    inParas[7] = remark;
    inParas[8] = orgcode ;

    
    /********tianyang add at 20090928 for POS�ɷ�����****start*****/
		inParas[9]  = MerchantNameChs; /*�̻����ƣ���Ӣ��)*/
		inParas[10] = MerchantId;      /*�̻�����*/
		inParas[11] = TerminalId;      /*�ն˱���*/
		inParas[12] = IssCode;         /*�����к�*/
		inParas[13] = AcqCode;         /*�յ��к�*/
		inParas[14] = CardNo;          /*����*/
		inParas[15] = BatchNo;         /*���κ�*/
		inParas[16] = Response_time;   /*��Ӧ����ʱ��*/
		inParas[17] = Rrn;             /*�ο���*/
		inParas[18] = AuthNo;          /*��Ȩ��*/
		inParas[19] = TraceNo;         /*��ˮ��*/
		inParas[20] = Request_time;    /*�ύ����ʱ��*/
		inParas[21] = CardNoPingBi;    /*���׿��ţ�����*/
		inParas[22] = ExpDate;         /*��Ƭ��Ч��*/
		inParas[23] = Remak;           /*��ע��Ϣ*/
		inParas[24] = TC;              /*��Ҫ��ӡ������EMV���ף�оƬ����*/
		/********tianyang add at 20090928 for POS�ɷ�����****end*******/

    
    
    
    
    //String outNum="4";
      
    //ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
    
     
%>

			
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
	<wtc:param value="<%=inParam_idno[0]%>"/>
	<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
		
    <wtc:service name="s1310Cfm" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" retmsg="msg1" retcode="code1" outnum="4">
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
    </wtc:service>
    <wtc:array id="result" scope="end" />
<%
		if(id_no_arr!=null&&id_no_arr.length>0){
        	id_no = id_no_arr[0][0];
        	phoneno = id_no_arr[0][1].trim();
    }
        //��ѯƷ������
    String[] inParam = new String[2];
		inParam[0] ="select c.sm_code, c.sm_name  from dcustmsg d,ssmcode c where d.sm_code=c.sm_code and substr(d.belong_code,0,2) =c.region_code and d.phone_no=:smphoneNo";
		inParam[1] = "smphoneNo="+phoneno;
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />		
<!--xl add for ��ѯ���ӷ�Ʊ�Ľӿ� begin-->
	<wtc:service name="sInvAcceptQry"  outnum="5" retmsg="msg3" retcode="code3" >
		<wtc:param value="<%=loginaccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
	</wtc:service>
	<wtc:array id="s_cz_qry" scope="end" />	
<%
	
	if(s_cz_qry.length>0)
	{
		s_old_ret_code=s_cz_qry[0][0];
		if(s_old_ret_code=="000000" ||s_old_ret_code.equals("000000"))
		{
			s_old_number=s_cz_qry[0][2];
			s_old_code=s_cz_qry[0][1];
			s_old_status=s_cz_qry[0][3];
			s_old_accept=s_cz_qry[0][4];
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("��Ʊ״̬��ѯ�ӿڷ����ѯ����,�������"+"<%=s_old_ret_code%>");
					history.go(-1);
				</script>
			<%
		}
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��Ʊ״̬��ѯ�ӿڷ������ʧ��!");
				history.go(-1);
			</script>
		<%
	}
%>

<!--end of ���ӷ�Ʊ��ѯ-->


<%
      
		if(sm_name_arr!=null&&sm_name_arr.length>0){
      s_sm_code = sm_name_arr[0][0];
      s_sm_name = sm_name_arr[0][1];
 		}	
 		    System.out.println("----------id_no-------------"+id_no);
    System.out.println("----------phoneNo-------------"+phoneno);
        System.out.println("----------s_sm_code-------------"+s_sm_code);
    //String[][] result = value.getData();
    String return_code =code1;
    String return_message =msg1;
    //String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
   
    System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    
    String url ="/npage/contact/upCnttInfo_boss.jsp?opCode="+opCode+"&retCodeForCntt="+return_code
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginaccept
		+"&pageActivePhone="+phoneno+"&retMsgForCntt="+return_message+"&opBeginTime="+opBeginTime;
    System.out.println(url);
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
    
    if (return_code.equals("000000"))
    {
        paySeq = result[0][2];
        totalDate = result[0][3];
    
        //xl add begin
		%>
		 
 
<html xmlns="http://www.w3.org/1999/xhtml">
<SCRIPT LANGUAGE="JavaScript">
	
<!--
/*tianyang add for pos**** boss���׳ɹ� ��������ȷ�Ϻ��� *****/
if("<%=pay_type%>"=="BX")
{
	BankCtrl.TranOK();/*����*/
}
if("<%=pay_type%>"=="BY")
{
	var IfSuccess = KeeperClient.UpdateICBCControlNum();/*����*/
} 
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
			window.location.href="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("��ƱԤռȡ���ɹ�,��ӡ���!",2);
				window.location.href="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��! �������:"+s_code,0);
				window.location.href="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
			}
		}
	 }	 
function ifprint()
{
		 var s_cz_type="";//�ж��Ƿ������в�ĳ�������
		 <% if (pay_code.equals("1300") || pay_code.equals("1302")|| pay_code.equals("1306")||pay_code.equals("2327")
				||pay_code.equals("3459") || pay_code.equals("5255")|| pay_code.equals("d340") 
		|| pay_code.equals("g659")  
		 ) 
	    {%>
				//alert("pay_type is "+"<%=pay_type%>");
				if("<%=pay_type%>"=="BX")
				{
					 document.getElementById("czfx").value="����POS";
				}
				else if("<%=pay_type%>"=="BY")
				{
					 document.getElementById("czfx").value="����POS";
				}
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
				var path="select_invoice_cz.jsp?s_old_status="+"<%=s_old_status%>";
				var returnValue = window.showModalDialog(path,"",prop);
				//alert("test returnValue is "+returnValue);
				if(returnValue=="1")
				{
					var pactket1 = new AJAXPacket("sfp_ocpy_cz.jsp","���ڽ��з�ƱԤռ�����Ժ�......");
					pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
					pactket1.data.add("bill_code","<%=bill_code%>");
					pactket1.data.add("paySeq","<%=paySeq%>");
					pactket1.data.add("bill_code","<%=bill_code%>");
					pactket1.data.add("op_code","<%=opCode%>");
					pactket1.data.add("phoneNo","<%=phoneno%>");
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
			    var path1="getNsrsbh.jsp?param_no="+"<%=phoneno%>"+"&param_type=1";
			    var returnValue1 = window.showModalDialog(path1,"",prop);  //��ȡ��˰��ʶ���
			    //alert("test returnValue1 is "+returnValue1);
				  //add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
					
					//alert("���ӵ�");
					var s_kpxm="<%=opCode%>"+"<%=opName%>";
					var s_ghmfc="<%=userName%>";
					var s_jsheje="<%=payMoney%>";//��˰�ϼƽ��
					var s_hjbhsje=0;//�ϼƲ���˰���
					var s_hjse=0;
					var s_xmmc="�ɷѳ���";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
					var s_ggxh="";
					var s_hsbz="1";//��˰��־ 1=��˰
					var s_xmdj="<%=payMoney%>";
					var s_xmje="<%=payMoney%>";
					var s_sl="*";
					var s_se="0";
					//����
					var op_code="1310";
					var payaccept="<%=paySeq%>";
					var id_no="<%=id_no%>";
					var sm_code="<%=s_sm_code%>";
					var phone_no="<%=phoneno%>";
					var pay_note=s_kpxm;
					var returnPage="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
					var chbz="0";//���ֵ� ����־=0
					//���ֵ� ����old_accept 
					var old_accept="<%=s_old_accept%>";
					var old_ym = "<%=dateStr%>";
					var kphjje="<%=payMoney%>";//��Ʊ�ϼƽ��
					kphjje = (-1)*Number(kphjje);
					s_xmdj = (-1)*Number(s_xmdj);
					var s_old_number="<%=s_old_number%>";
					var s_old_code="<%=s_old_code%>";
					var s_old_accept="<%=s_old_accept%>";
					//alert("old_accept is "+old_accept);
					//document.frm_print_invoice.action="PrintInvoice_czdz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&xmsl=1&old_accept="+old_accept+"&old_ym="+old_ym+"&kphjje="+kphjje+"&hjbhsje="+s_hjbhsje+"&s_old_number="+s_old_number+"&s_old_code="+s_old_code+"&s_old_accept="+s_old_accept+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=totalDate%>";
					//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ begin
					document.frm_print_invoice.action="PrintInvoice_czdz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&xmsl=1&old_accept="+old_accept+"&old_ym="+old_ym+"&kphjje="+kphjje+"&hjbhsje="+s_hjbhsje+"&s_old_number="+s_old_number+"&s_old_code="+s_old_code+"&s_old_accept="+s_old_accept+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=totalDate%>"+"&s_gmfsbh="+returnValue1;
					//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
					document.frm_print_invoice.submit(); 
					
				}
				else
				{
					var paySeq="<%=paySeq%>";
					var phoneno="<%=phoneno%>";
					var kphjje="<%=payMoney%>";//��Ʊ�ϼƽ��
					var s_hjbhsje=0;//�ϼƲ���˰���
					var s_hjse=0;
					var contractno="<%=contractno%>";
					var id_no="<%=id_no%>";
					var sm_code="<%=s_sm_code%>";
					var s_xmmc="<%=opName%>";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
					var opCode="<%=opCode%>";
					var return_page = "";
					//alert("return_page is "+return_page);
					document.frm_print_invoice.action="PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=0&s_xmmc="+s_xmmc+"&paynote=�ɷ�";
					
					document.frm_print_invoice.submit();
				}
				<%
			}
			else if (pay_code.equals("1304") ) {
						if(pay_type.equals("BX")){%>         
							rdShowMessageDialog('����POS�����ɹ�!',2);
						window.location.href="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";";
					<%}else if(pay_type.equals("BY")){%>
							rdShowMessageDialog('����POS�����ɹ�!',2);
						window.location.href="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";";
					<%}else{%>
							rdShowMessageDialog('�����ɹ�!',2);
						window.location.href="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";";
						<%}
				}%>
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
	    var return_page="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
		var czfx=document.getElementById("czfx").value ;
		//new
		var s_ret_code  =  packet.data.findValueByName("s_ret_code");
		var s_ret_msg  =  packet.data.findValueByName("s_ret_msg");
		if(s_invoice_flag=="1")
		{
			rdShowMessageDialog("Ԥռ�ӿڵ����쳣!");
			window.location.href= return_page ;
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog(czfx+"�����ɹ�!��ǰ��Ʊ������"+ocpy_begin_no+",��Ʊ������"+bill_code+",�Ƿ��ӡ��Ʊ?");
				if (prtFlag==1)
				{
					document.frm_print_invoice.action="PrintInvoice.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code+"&opCode=1310";
					document.frm_print_invoice.submit();
				}
				else
				{
					var pactket2 = new AJAXPacket("sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
					//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
					pactket2.data.add("ocpy_begin_no",ocpy_begin_no);
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("paySeq","<%=paySeq%>");
					pactket2.data.add("op_code","<%=opCode%>");
					pactket2.data.add("phoneNo","<%=phoneno%>");
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
				rdShowMessageDialog("������ƱԤռʧ��!����ԭ��:"+s_ret_msg,0);
				window.location.href= return_page ;
			 
			}
		}
	 }
	 function doqx(packet)
	 {
		var s_flag = packet.data.findValueByName("s_flag");	
		var s_code = packet.data.findValueByName("s_code");	//ò��ûɶ��
		var s_note = packet.data.findValueByName("s_note");	
		var s_invoice_code  = packet.data.findValueByName("s_invoice_code");//ò��Ҳûɶ��	
		var return_page="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
		if(s_flag=="1")
		{
			rdShowMessageDialog("Ԥռȡ���ӿڵ����쳣!");
			window.location.href=return_page;
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("��ƱԤռȡ���ɹ�,��ӡ���!",2);
				window.location.href=return_page;
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��! �������:"+s_flag,0);
				window.location.href= return_page ;
				 
			}
		}
	 }
//-->
</SCRIPT>
    
<body onload="ifprint()">
<form action="PrintInvoice.jsp" name="frm_print_invoice" method="post">
<!--xl add for ����������ˮ-->
<input type="hidden" id="czfx">
 
<INPUT TYPE="text" name="returnPage" value="<%=s_retun_page%>">
<INPUT TYPE="hidden" name="loginaccept" value="<%=loginaccept%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="text" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneno%>">
<INPUT TYPE="text" name="opCode" value="<%=opCode%>">
<INPUT TYPE="hidden" name="check_seq" value="<%=check_seq%>">
<INPUT TYPE="hidden" name="s_flag" value="<%=s_flag%>">
<input type="hidden" name="bill_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>"> 
<INPUT TYPE="hidden" name="ifRed" value="2"> 
<INPUT TYPE="hidden" name="returnPage" value="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>">
</form>
</body>
</html>
    <%}else{%>
        <script language='JavaScript'>
            rdShowMessageDialog("����ʧ��!<br>������룺'<%=return_code%>'��<br>������Ϣ��'<%=return_message%>'��",0);
            window.location.href="s1310.jsp?ph_no=<%=phoneno%>&opCode=<%=opCode%>&opName=<%=opName%>";
        </script>
    <%}%>

