   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-11
********************/
%>
              

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("gb2312");%>
<%@ page import="org.apache.log4j.Logger"%>

<%
	Logger logger = Logger.getLogger("f3172cfm.jsp");
	//xl add ��Ʊ����  
	String loginaccept = request.getParameter("loginaccept");	
	String print_flag = request.getParameter("print_flag");	

	String opName = "һ��֧���ʻ��ɷ�";	 	                                                             	
  String workNo = request.getParameter("workNo");										//����          
  String noPass = request.getParameter("noPass");                   //����          
  String org_code = request.getParameter("org_code");               //��������      
  String opcode = request.getParameter("opcode");                   //��������      
  String contract_no = request.getParameter("contract_no");         //�ʻ�ID        
	String cashPay = request.getParameter("cashPay");                 //���ѽ��  
	String payType = request.getParameter("payType"); 								//���ѷ�ʽ                      
  String note = request.getParameter("note");                 			//����ע��      
  String rate = request.getParameter("rate");                       //�Ƿ���׻���
  String yearMonth = request.getParameter("yearMonth");    
  
    // huangqi add Ӫ����
  String paySeq="";
	String groupId = (String)session.getAttribute("groupId");
//	groupId="10031";
	String  userName = request.getParameter("countName");
	String  userName1 = request.getParameter("accountName");
	//userName1="test";
	String  print_note = request.getParameter("print_note");
	String s_yyt_name="";
	String totalDate="";
  String s_sm_code="";
  String s_sm_name="";
	String s_id_no="";
	String phoneNo = "";
   // xl add for ��Ʊ���� begin
  String return_page=request.getContextPath()+"/npage/s3172/f3172_1.jsp?opcode="+opcode+"&opName="+opName;
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from WLOGININVOICE where LOGIN_NO = :workNo";
	inParam2[1]="workNo="+workNo;
	
	//hq add ����contract_no��ѯid_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no),to_char(b.phone_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +" a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contract_no;
		
		
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

		if(id_no_arr!=null&&id_no_arr.length>0){
        	s_id_no = id_no_arr[0][0];
        	phoneNo = id_no_arr[0][1].trim();
			}
			else
			{
				phoneNo="999999999";
			}

    //��ѯƷ������
    String[] inParam = new String[2];
		inParam[0] ="select c.sm_code, c.sm_name  from dcustmsg d,ssmcode c where d.sm_code=c.sm_code and substr(d.belong_code,0,2) =c.region_code and d.phone_no=:smphoneNo";
		inParam[1] = "smphoneNo="+phoneNo;	
		

	result_check = retList;
	if(retList.length != 0)
	{
		check_seq=result_check[0][0];
		s_flag=result_check[0][1];
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa check_seq is "+check_seq);
	}
	// xl add for ��Ʊ���� end

  String bankCode = request.getParameter("bankCode").equals("")?"0":request.getParameter("bankCode");         //
  String checkNo = request.getParameter("checkNo").equals("")?"0":request.getParameter("checkNo");         //
  String regionCode = (String)session.getAttribute("regCode");                                             
  String error_code = "";                                               
  String error_msg = "";                                            
  String result [][]= new String[][]{};				                                                                  
	ArrayList acceptList = new ArrayList();
		                                                            
   String paramsIn[] = new String[13];                              
   paramsIn[0]=workNo;                                              
   paramsIn[1]=noPass;                                              
   paramsIn[2]=org_code;              
   paramsIn[3]=opcode;
   paramsIn[4]=contract_no;
   paramsIn[5]=cashPay;
   paramsIn[6]=payType;
   paramsIn[7]=note;
   paramsIn[8]=yearMonth;
   paramsIn[9]=rate;
   paramsIn[10]=bankCode;
   paramsIn[11]=checkNo;
   paramsIn[12]=loginaccept;	
   //������           
 	//acceptList	= callView.callFXService("s3172Cfm", paramsIn, "3");
%>
      <!-- chenhu add -->
      
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
		
		
<wtc:service name="bs_ChnPayLimit" outnum="5" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=cashPay%>"/>
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
if (t_return_code.equals("000000")){
%>	
    <!-- chenhu add end-->

    <wtc:service name="s3172Cfm" outnum="3" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:params value="<%=paramsIn%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" start="0"  length="3" />
			
		<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 	

<% 	
  error_code = code1;
  error_msg= msg1;

%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opcode="+opcode+
								 "&retCodeForCntt="+error_code+
								 "&retMsgForCntt="+error_msg+
	               "&opName="+opName+
     	    			 "&workNo="+workNo+
     	    			 "&loginAccept="+sysAcceptl+
     	    			 "&pageActivePhone="+""+
     	    			 "&opBeginTime="+opBeginTime+
     	    			 "&contactId="+contract_no+
     	    			 "&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />

<%
  if(error_code.equals("000000"))
  {
		paySeq = result_t[0][2];
		 // paySeq = "1";
%>
   <!--huangqi add ��ƱԤռ  start-->
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

	//xl add ����print_flag �ж��Ƿ�Ҫ����
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
	{%>
		 
 


<body onload="ifprint()">
<form action="" name="frm_print" method="post">
<INPUT TYPE="hidden" name="opcode" value="<%=opcode%>">
<INPUT TYPE="hidden" name="workNo" value="<%=workNo%>">
<INPUT TYPE="hidden" name="contract_no" value="<%=contract_no%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo%>">  
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="bill_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>">
<input type="text" name="userName" value="<%=userName1%>">
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
			rdShowMessageDialog("Ԥռ�ӿڵ����쳣!");
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("3172�ɷѳɹ�!��ǰ��Ʊ������"+ocpy_begin_no+",��Ʊ������"+bill_code+",�Ƿ��ӡ��Ʊ?");
				if (prtFlag==1)
				{
					document.frm_print.action="<%=request.getContextPath()%>/npage/s3172/f3172_print.jsp?check_seq="+ocpy_begin_no+"&parm="+"<%=result_t[0][2]%>"+"&bill_code="+bill_code;
					document.frm_print.submit();
				}
				else
				{
					var pactket1 = new AJAXPacket("sdis_ocpy.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
					//alert("1 ������Ӧ���ǰ���ˮ��״̬ ���ǲ�����");
					pactket1.data.add("ocpy_begin_no",ocpy_begin_no);
					pactket1.data.add("bill_code","<%=bill_code%>");
					pactket1.data.add("paySeq","<%=paySeq%>");
					pactket1.data.add("bill_code",bill_code);
					pactket1.data.add("op_code","<%=opcode%>");
					pactket1.data.add("phoneNo","<%=phoneNo%>");
					pactket1.data.add("contractno","<%=contract_no%>");
					pactket1.data.add("payMoney","<%=cashPay%>");
					pactket1.data.add("userName","<%=userName1%>");
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
			//���ӷ�Ʊ
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
				pactket1.data.add("op_code","<%=opcode%>");
				pactket1.data.add("phoneNo","<%=phoneNo%>");
				pactket1.data.add("contractno","<%=contract_no%>");
				pactket1.data.add("payMoney","<%=cashPay%>");
				pactket1.data.add("userName","<%=userName1%>");
				core.ajax.sendPacket(pactket1,doyz);
				pactket1=null;
			}
			else if(returnValue=="3")
			{
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ begin
				var h=300;
			  var w=500;
			  var t=screen.availHeight/2-h/2;
			  var l=screen.availWidth/2-w/2;
			  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
			  var path1="../s1300/getNsrsbh.jsp?param_no="+"<%=contract_no%>"+"&param_type=2";
			  var returnValue1 = window.showModalDialog(path1,"",prop);
			  //alert("test returnValue1 is "+returnValue1);
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
				
				//alert("���ӵ�");
				var s_kpxm="3172_һ��֧���ʻ��ɷ�";
				var s_ghmfc="<%=userName1%>";
				var s_jsheje="<%=cashPay%>";//��˰�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var s_xmmc="һ��֧���ʻ��ɷ�";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				var s_ggxh="";
				var s_hsbz="1";//��˰��־ 1=��˰
				var s_xmdj=s_jsheje;
				var s_xmje=s_jsheje;
				var s_sl="*";
				var s_se="0";
				//����
				var op_code="3172";
				var payaccept="<%=paySeq%>";
				var id_no="0";
				var sm_code="0";
				var phone_no="99999999999";
				var pay_note="һ��֧���ʻ��ɷ�";
				var returnPage ="../s3172/f3172_1.jsp";
				var chbz="1";
				var contractno="<%=contract_no%>";
				var kphjje=s_jsheje;
				//document.frm_print.action="../s1300/PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&contractno="+contractno+"&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje;
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ begin
				document.frm_print.action="../s1300/PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&contractno="+contractno+"&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&s_gmfsbh="+returnValue1;
				//add by zhangleij 20170628 for sunqy ����������ֵ˰��Ʊ�����йع�����֪ͨ end
				document.frm_print.submit(); 
				
			}
			else//qx
			{
				var paySeq="<%=paySeq%>";
				var phoneno="99999999999";
				var kphjje="<%=cashPay%>";;//��Ʊ�ϼƽ��
				var s_hjbhsje=0;//�ϼƲ���˰���
				var s_hjse=0;
				var contractno="<%=contract_no%>";
				var id_no="0";
				var sm_code="0";
				var s_xmmc="һ��֧���ʻ��ɷ�";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
				var opCode="3172";
				var return_page = "../s3172/f3172_1.jsp";
				document.frm_print.action="../s1300/PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=3172�ɷ�";
				document.frm_print.submit();
			}
		}
		

	 
 </script>
 	
</body>
<%
	}	
%>
</html>
<%}
  else
  {
%>        
	    <script language='jscript'>
	       rdShowMessageDialog("�ɷ�ʧ�ܣ�<BR>[" +"<%=error_code%>"+ "]"  +  "<BR><%=error_msg%>" ,0);
	       history.go(-1);
      </script>
         
<%            
  }
%>
<%
} else
  {
%> <script language='jscript'>
	       rdShowMessageDialog("�ɷ�ʧ�ܣ�<br>������룺'<%=t_return_code%>' <br>������Ϣ��'<%=t_return_msg%>'",0);
	       history.go(-1);
      </script>
<%            
  }
%>
