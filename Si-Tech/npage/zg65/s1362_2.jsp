<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��Ԥ���1362
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
	System.out.println("--------------------------0009------==="+opCode+":::"+opName);
	String phoneno = (String)request.getParameter("phoneno");
	String workno = (String)session.getAttribute("workNo");
	String orgcode = (String)session.getAttribute("orgCode"); 			//��������
	String orgid = (String)session.getAttribute("orgId");				//����ID
	String regionCode = (String)session.getAttribute("regCode");	
	
	// xl add for ��Ʊ���� begin
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	String s_sm_code="";
	
//�������
//���������workno,nopass,orgcode,opcode,contactno,nopay_money��
	String contractno  = request.getParameter("contractno");
	String unbill_total  = request.getParameter("unbill_total");
	String opcode    = "zg65";											//������
	String cust_name = request.getParameter("cust_name");
	String nopay_money = request.getParameter("nopay_money");
	String prepay_fee = request.getParameter("prepay_fee");
	String remark = WtcUtil.repNull(request.getParameter("remark"));
	String busy_type = request.getParameter("busy_type");
	String interest = request.getParameter("interest");
	//20120503
	String phoneno_out = request.getParameter("phoneno_out");
	System.out.println("ccccccccccccccccccccccccccc phoneno_out is "+phoneno_out);
 	String groupId = (String)session.getAttribute("groupId");
	//xl add sm_code
	//xl add sm_code phoneno_out
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
	String id_no="";
	String ifRed="";
	String[] inParas_sm = new String[2];
	inParas_sm[0]="select sm_code from dcustmsg a,dbroadbandmsg b where a.phone_no=b.phone_no and b.cfm_login= :s_phone";
	inParas_sm[1]="s_phone="+phoneno_out;
	
	
			//hq add ����contract_no��ѯid_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +" a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contractno;
		
		if(busy_type.equals("2")){
			ifRed="0";
		}else{
			ifRed="2";
		}
		
		
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
	<wtc:param value="<%=inParam_idno[0]%>"/>
	<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
		
		<wtc:service name="TlsPubSelBoss"  outnum="1" >
			<wtc:param value="<%=inParas_sm[0]%>"/>
			<wtc:param value="<%=inParas_sm[1]%>"/> 
		</wtc:service>
		<wtc:array id="result1_sm" scope="end"/>
	<%
	
			if(id_no_arr!=null&&id_no_arr.length>0){
        	id_no = id_no_arr[0][0];
       // 	phoneNo = id_no_arr[0][1].trim();
      }
      
      
	if(result1_sm.length>0)
	{
		s_sm_code=result1_sm[0][0];
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("Ʒ����Ϣ������!");
				history.go(-1);
			</script>
		<%
	}
	

	// xl add for ��Ʊ���� end 


	if (remark.equals("")==true) {
	remark = phoneno+"��Ԥ���:"+nopay_money;}
	String    nopass="111111";
	String    newloginaccept = "";
	String    total_date = "";
	String    bigmoney="";

	String[] inParas = new String[10];
	inParas[0] = workno;
    inParas[1] = nopass;
    inParas[2] = orgid;
    inParas[3] = opcode;
    inParas[4] = phoneno;
    inParas[5] = contractno;
    inParas[6] = nopay_money;
    inParas[7] = remark;
    inParas[8] = busy_type;
    inParas[9] = interest;
 
//ScallSvrViewBean viewBean = new ScallSvrViewBean();
//CallRemoteResultValue  value  = viewBean.callService("1", orgcode.substring(0,2),  "s1362Cfm", "5"  ,  inParas) ;
%>  
	<wtc:service name="s1362Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode" retmsg="retMsg">
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<% 
//	String [][] result  = value.getData();
	String return_code =retCode;
	//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retMsg));			
	String error_msg = retMsg;
	 
 
		  
		String s_id_no=""; 
  	String s_sm_name="";
    String paySeq = "";
    String totalDate = "";
%>
		
<%
	if ( return_code.equals("000000")) 
	{
		
		total_date = result[0][2];
		newloginaccept = result[0][3];
		bigmoney = result[0][4];
		//xl add for ���÷�ƱԤռ�ӿ� begin
		%>
		<wtc:service name="scancelInDB" routerKey="phone" routerValue="<%=phoneno%>"  outnum="8" >
				<wtc:param value="<%=newloginaccept%>"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workno%>"/>
				<wtc:param value=""/><!--op_time-->
				<wtc:param value="<%=phoneno%>"/>
				<wtc:param value="<%=id_no%>"/><!--id_no-->
				<wtc:param value="<%=contractno%>"/>
				<wtc:param value=""/><!--s_check_num-->
				<wtc:param value=""/><!--��Ʊ���� ��һ�ε���ʱ ���� ���ڷ�����tpcallBASD�Ľӿ�ȡ��-->
				<wtc:param value=""/><!--��Ʊ���� ��-->
				<wtc:param value=""/> 
				<wtc:param value="<%=nopay_money%>"/><!--Сд���-->
				<wtc:param value=""/><!--��д���-->
				<wtc:param value="zg65��ͨ����˷�(��Ʒ)"/><!--��ע-->
			 
				<wtc:param value="6"/><!--Ԥռ��6 ȡ����5��δ��ӡ-->
				<wtc:param value=""/><!--�ݿ�-->
				<wtc:param value=""/><!--˰��-->
				<wtc:param value=""/><!--˰��-->
				<wtc:param value=""/>

				<!--��basd�� 0��Ԥռ 1��ȡ��Ԥռ ���������Ҫ�� -->
				<wtc:param value="<%=cust_name%>"/>
				<!--xl add ������� ��Ʊ���� �������� ����ͺ� ��λ ���� ���� regionCode groupId �Ƿ���-->
				<wtc:param value="0"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=regionCode%>"/>
				<wtc:param value="<%=groupId%>"/> 
				<wtc:param value="2"/><!--�Ƿ��Ǻ��ַ�Ʊ 0�� 1�ǣ��ǹ淶��Ҫ��ĳ�쵫���˷���ҵ���Ϊ2-->
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
					alert("��ƱԤռʧ��!����ԭ��:"+"<%=bill_opy[0][0]%>");
					//history.go(-1);
				</script>
			<%
		}
	}
%>		

<html xmlns="http://www.w3.org/1999/xhtml">
<body onload="ifprint()">
<form action="" name="frm_print_invoice" method="post">
	<%@ include file="/npage/include/header.jsp" %>
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="print_phoneno" value="<%=phoneno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="print_unbill_total" value="<%=unbill_total%>">
<INPUT TYPE="hidden" name="print_nopay_money" value="<%=nopay_money%>">
<INPUT TYPE="hidden" name="print_prepay_fee" value="<%=prepay_fee%>">
<INPUT TYPE="hidden" name="print_cust_name" value="<%=cust_name%>">
<INPUT TYPE="hidden" name="total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="print_big_money" value="<%=bigmoney%>">
<input type="hidden" name="phoneno_out" value="<%=phoneno_out%>">
<INPUT TYPE="hidden" name="check_seq" value="<%=check_seq%>">
<INPUT TYPE="hidden" name="s_flag" value="<%=s_flag%>">
<INPUT TYPE="hidden" name="opCode" value="zg65">
<INPUT TYPE="hidden" name="returnPage" value="zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>">
<INPUT TYPE="hidden" name="id_no" value="<%=id_no%>">
<INPUT TYPE="hidden" name="print_cust_name" value="<%=cust_name%>">
<INPUT TYPE="hidden" name="total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="ifRed" value="<%=ifRed%>">

	<%@ include file="/npage/include/footer.jsp" %>
</form>

</body>
<SCRIPT type=text/javascript>
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
			window.location.href="zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("��ƱԤռȡ���ɹ�,��ӡ���!",2);
				window.location.href="zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
			else
			{
				rdShowMessageDialog("��ƱԤռʧ��! �������:"+return_flag,0);
 
			}
		}
	 }	   
	 
function ifprint()
{
	if("<%=s_invoice_flag%>"=="0")
	{
		 	if(rdShowConfirmDialog("��Ԥ���ɹ�����ǰ��Ʊ������"+"<%=ocpy_begin_no%>"+",�Ƿ��ӡ�վ�?")==1)
			{
				document.frm_print_invoice.check_seq.value="<%=check_seq%>";
				frm_print_invoice.action="PrintInvoice.jsp?check_seq="+"<%=ocpy_begin_no%>"+"&s_invoice_code="+"<%=bill_code%>";
				frm_print_invoice.submit();
			}
			else 
			{ 
				if(("<%=s_sm_code%>"=="kf")||("<%=s_sm_code%>"=="kh")){
						//����ȡ���ӿ�
							//alert("ȡ�� ������scancelInDB_pt ���������ҳ��һ��ʼ�ͻ����һ�� ��Ԥռ������һ����ȡ��Ԥռ");
							var pactket1 = new AJAXPacket("../e005/sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
							//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
							pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
							pactket1.data.add("bill_code","<%=bill_code%>");
							pactket1.data.add("paySeq","<%=newloginaccept%>");
							pactket1.data.add("bill_code","<%=bill_code%>");
							pactket1.data.add("op_code","<%=opCode%>");
							pactket1.data.add("phoneNo","<%=phoneno%>");
							pactket1.data.add("contractno","<%=contractno%>");
							pactket1.data.add("payMoney","<%=nopay_money%>");
							pactket1.data.add("userName","<%=cust_name%>");
							//alert("2 "+pactket1.data);					 
							core.ajax.sendPacket(pactket1);				 
							pactket1=null;
				}else{
					rdShowMessageDialog("�������!",2);
					document.location.replace("zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
				}
					
			}
					

	}
	else
	{
		rdShowMessageDialog("�˷ѳɹ�,��Ʊ��ӡʧ��!");
		document.location.replace("zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
	}

} 						
</SCRIPT>
 
</html>

<%
}
else
{
    %>
 		 <SCRIPT LANGUAGE="JavaScript">
		 
		  		rdShowMessageDialog("��Ԥ���ʧ�ܡ�<br>������룺'<%=return_code%>'��<br>������Ϣ��'<%=error_msg%>'��",0);
			    document.location.replace("zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
		
		 </SCRIPT>
	<%
}
%>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
	          	+"&opName="+opName+"&workNo="+workno+"&loginAccept="+newloginaccept+"&pageActivePhone="+phoneno
		          +"&opBeginTime="+opBeginTime;
		          
	if(busy_type.equals("2")){
		url=url+"&contactId="+contractno+"&contactType=acc";
	}else{
		url=url+"&contactId="+phoneno+"&contactType=user";
	}
	System.out.println(url);
%>
<jsp:include page="<%=url%>" flush="true" />