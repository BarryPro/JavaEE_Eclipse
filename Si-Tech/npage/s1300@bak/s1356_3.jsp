<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺����.���ʻ��ջ���
 update zhaohaitao at 2008.12.30
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo").trim();
	String busyName = request.getParameter("busyName");
	String contractno = request.getParameter("contractno");
	String totaldate  = request.getParameter("billdate");//��������
	String opcode    = request.getParameter("OpCode"); //������
	String loginaccept = request.getParameter("water_number");//��ˮ��
	String accept_detail = request.getParameter("nopaywater");//������ˮ
	String remark = request.getParameter("remark");//��ע
  String pay_account = request.getParameter("pay_account");
	String payMoney = request.getParameter("remark2");
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workno = (String)session.getAttribute("workNo");
	String orgcode = (String)session.getAttribute("orgCode");//��������
	String regionCode = orgcode.substring(0,2);
	String userName = request.getParameter("user");
	String regCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	String  print_note = request.getParameter("print_note");
	String checkNo= request.getParameter("checkNo");
	String id_no = request.getParameter("id_no");
	String s_sm_code="";
  String s_sm_name="";
  //��ѯƷ������ ��ѯcontractno�� id_no 
  String[] inParam = new String[2];
	inParam[0] ="select c.sm_code, c.sm_name,to_char(d.contract_no),to_char(d.id_no)  from dcustmsg d,ssmcode c where d.sm_code=c.sm_code and substr(d.belong_code,0,2) =c.region_code and d.phone_no=:smphoneNo";
	inParam[1] = "smphoneNo="+phoneNo;	
	String s_old_number="";	//ԭ��Ʊ����
	String s_old_code="";	//ԭ��Ʊ����
	String s_old_status="";	//ԭ��Ʊ״̬ 0-δ���� 1-ֽ�� 2-�����ն� 6-Ԥռ e-���ӷ�Ʊ r-�վ� z-רƱ
	String s_old_accept="";	//ԭ���ӷ�Ʊ��ˮ
	//String s_invoice_flag="";//Ԥ����
	String s_old_ret_code="";//���ش���
	String s_old_ret_msg=""; //����ֵ

	
	// xl add for ��Ʊ���� begin
	String check_seq="";
	String s_flag="";
	// xl add for ��Ʊ���� end
	String[] inParas = new String[6];
	inParas[0] = workno;
	inParas[1] = opcode;
	inParas[2] = orgcode;
	inParas[3] = loginaccept;
	inParas[4] = totaldate;
 	inParas[5] = remark;

	//CallRemoteResultValue  value  = viewBean.callService("1", orgcode.substring(0,2) ,  "s1356Cfm", "3"  , inParas) ;
 %>
 
	<wtc:service name="TlsPubSelBoss"  outnum="4" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
		
 	<wtc:service name="s1356Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 <% 

    if(sm_name_arr!=null&&sm_name_arr.length>0){
      s_sm_code = sm_name_arr[0][0];
      s_sm_name = sm_name_arr[0][1];
      contractno = sm_name_arr[0][2];
      id_no = sm_name_arr[0][3];
      System.out.println("----------------contractno"+contractno);
      System.out.println("----------------id_no"+id_no);
 		}	
 	if (id_no==null || "".equals(id_no)) {
		id_no="0";
  }
  if (contractno==null || "".equals(contractno)) {
		contractno="0";
  }
 		
	String sysAccept = "";
	if((retCode1.equals("000000") || retCode1.equals("0"))  && result.length>0)
		sysAccept = result[0][1];
 	
 	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opcode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1
		+"&opName="+busyName+"&workNo="+workno+"&loginAccept="+sysAccept+"&pageActivePhone="+phoneNo.trim()
		+"&opBeginTime="+opBeginTime+"&contactId="+pay_account+"&contactType=acc";
 	System.out.println(url);
 %>
 	<jsp:include page="<%=url%>" flush="true" />
 <%	
	String return_code = retCode1;
 	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
    
    String newloginaccept="";
    String newtotaldate="";
    
	if (return_code.equals("000000") || return_code.equals("0")) 
  {
	 if(result.length>0){
		newloginaccept = result[0][1];
	    newtotaldate = result[0][2];
	 }
	 
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
	String return_page="s1356.jsp?opCode=1356";
%> 
<!--xl add for ��ѯ���ӷ�Ʊ�Ľӿ� begin-->
	<wtc:service name="sInvAcceptQry"  outnum="5" retmsg="msg3" retcode="code3" >
		<wtc:param value="<%=loginaccept%>"/>
		<wtc:param value="1354"/>
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
<script language="JavaScript">
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

				//window.location.href="<%=return_page%>";
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
			rdShowMessageDialog("Ԥռ�ӿڵ����쳣!");
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("���ʻ��ջ��˳ɹ�!��ǰ��Ʊ������"+ocpy_begin_no+",��Ʊ������"+bill_code+",�Ƿ��ӡ��Ʊ?");
				if (prtFlag==1)
				{
					document.frm_print.action="PrintInvoice.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code;
					document.frm_print.submit();
				}
				else
				{
					var pactket2 = new AJAXPacket("sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
					//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
					pactket2.data.add("ocpy_begin_no",ocpy_begin_no);
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("paySeq","<%=newloginaccept%>");
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("op_code","<%=opCode%>");
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
				rdShowMessageDialog("��ƱԤռʧ��!����ԭ��:"+s_ret_msg,0);

				window.location.href="<%=return_page%>";
			}
		}
	 }
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
		var path="select_invoice_cz.jsp?s_old_status="+"<%=s_old_status%>";
		var returnValue = window.showModalDialog(path,"",prop);
		//alert("test returnValue is "+returnValue);	
		if(returnValue=="1")
		{
			var pactket1 = new AJAXPacket("sfp_ocpy_cz.jsp","���ڽ��з�ƱԤռ�����Ժ�......");
			pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
			pactket1.data.add("bill_code","<%=bill_code%>");
			pactket1.data.add("paySeq","<%=newloginaccept%>");
			pactket1.data.add("bill_code","<%=bill_code%>");
			pactket1.data.add("op_code","<%=opCode%>");
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
			var s_xmmc="�������˻��ջ���";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
			var s_ggxh="";
			var s_hsbz="1";//��˰��־ 1=��˰
			var s_xmdj="<%=payMoney%>";
			var s_xmje="<%=payMoney%>";
			var s_sl="*";
			var s_se="0";
			//����
			var op_code="<%=opCode%>";
			var payaccept="<%=newloginaccept%>";
			var id_no="<%=id_no%>";
			var sm_code="<%=s_sm_code%>";
			var phone_no="<%=phoneNo%>";
			var pay_note=s_kpxm;
			var returnPage ="<%=return_page%>";
			var chbz="0";
			var kphjje="<%=payMoney%>";
			var old_accept="<%=s_old_accept%>";
			var old_ym = "<%=dateStr%>";
			var old_accept="<%=s_old_accept%>";
	 
			kphjje = (-1)*Number(kphjje);
			s_xmdj = (-1)*Number(s_xmdj);
			var s_old_number="<%=s_old_number%>";
			var s_old_code="<%=s_old_code%>";
			var s_old_accept="<%=s_old_accept%>";
			//alert("old_accept is "+old_accept);
			document.frm_print.action="PrintInvoice_czdz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&xmsl=1&old_accept="+old_accept+"&old_ym="+old_ym+"&kphjje="+kphjje+"&hjbhsje="+s_hjbhsje+"&s_old_number="+s_old_number+"&s_old_code="+s_old_code+"&s_old_accept="+s_old_accept+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=newtotaldate%>";
			document.frm_print.submit(); 
			
		}
		else
		{
			var paySeq="<%=newloginaccept%>";
			var phoneno="<%=phoneNo%>";
			var kphjje="<%=payMoney%>";//��Ʊ�ϼƽ��
			var s_hjbhsje=0;//�ϼƲ���˰���
			var s_hjse=0;
			var contractno="<%=contractno%>";
			var id_no="<%=id_no%>";
			var sm_code="<%=s_sm_code%>";
			var s_xmmc="<%=opName%>";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
			var opCode="<%=opCode%>";
			var return_page = "<%=return_page%>";
			document.frm_print.action="PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=�ɷ�";
			
			document.frm_print.submit();
		}
		
	}
						
</script>

<body onload="ifprint()">
<form action="PrintInvoice.jsp" name="frm_print" method="post">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=newtotaldate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="contractno" value="<%=pay_account%>">
<INPUT TYPE="hidden" name="returnPage" value="s1356.jsp?opCode=<%=opCode%>&opName=<%=opName%>">
<INPUT TYPE="hidden" name="opCode" value="<%=opcode%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo%>">  
<input type="hidden" name="userName" value="<%=userName%>">
<input type="hidden" name="s_sm_code" value="<%=s_sm_code%>">
<input type="hidden" name="s_sm_name" value="<%=s_sm_name%>">
<input type="hidden" name="ifRed" value="2">
<INPUT TYPE="hidden" name="id_no" value="<%=id_no%>"> 
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="bill_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>">
</form>
</body>
</html>
<%
 }
 else{
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
	rdShowMessageDialog("��ѯ����<br>������룺'<%=return_code%>'��<br>������Ϣ��'<%=error_msg%>'��",0);
	history.go(-1);
//-->
</SCRIPT>
 <%}%>

