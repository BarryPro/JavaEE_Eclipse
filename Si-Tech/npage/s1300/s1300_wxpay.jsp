<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>


<!-- **********加载建行控件页******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
<!-- **********加载工行控件页******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>

<%
 	String wxddh = request.getParameter("wxddh");
 
	String login_aceept = request.getParameter("login_aceept");

	String groupId = (String)session.getAttribute("groupId");
	String opCode = "";
	String opName = "";
	String busy_type = WtcUtil.repNull(request.getParameter("busy_type"));	
	/*************add by zhanghonga@2008-09-22,根据busy_type来更改opCode和opName,避免统一接触的opcode,opname记录错误*****************/
	String ims_flag = request.getParameter("ims_flag");
  switch(Integer.parseInt(busy_type)){
  	case 1 : 
  					opCode = "1302";
  					opName = "号码缴费";
  					break;
  	case 2 :
  					opCode = "1300";
  					opName = "账号缴费";
  					break;
  	case 3 :
  					opCode = "1304";
  					opName = "缴费(托收)";
  					break;
  	case 5 :
  					opCode = "2327";
  					opName = "缴费(托收账号)";
  					break;
  	default:
  					opCode = "1302";
  					opName = "普通缴费";
  					break;
  }
  System.out.println("########################################s1300->PayCfm(最终提交)->opCode->"+opCode+"&opName->"+opName);
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
	s_pay_note ="本次发票金额:(小写)￥"+payMoney;
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
	
	/********tianyang add at 20090928 for POS缴费需求****start*****/
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
	/********tianyang add at 20090928 for POS缴费需求****end*******/
	String id_no="";
    String s_sm_code="";
    String s_sm_name="";
 	

	 
 

	String return_page="s1300.jsp";
 
    
	String result[][] = new String[][]{};
	String return_code=""; 
	String error_msg = "";
	String paySeq="";//服务传出
	String totalDate="";//服务传出
	String year="";
	String month="";
	String day=""; 
	//sOrderPay
	String wxzf =request.getParameter("wxzf");
	String ipAddr = request.getRemoteAddr();
	String ip_Addr = (String)session.getAttribute("ipAddr");
	System.out.println("ffffffffffffffffffffffsssssssssssssssssssssss ipAddr is "+ipAddr+" and ip_Addr is "+ip_Addr);
	String s_ddms="微信支付";
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
	//如果这个接口返回成功 需要再调用一次新的接口 提供流水啥的~~
	retCode1="000000";
	 
	if(retCode1=="000000" ||retCode1.equals("000000"))
	{
		//新的wtc
		%>
		<wtc:service name="sOrderQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
			<wtc:param value="<%=ddhid%>"/>
		</wtc:service>
		<wtc:array id="s_result" scope="end"/>
		<%
		//end of 查询的接口调用
		return_code=retCode2;
		retCode2="000000";
		if(retCode2=="000000" ||retCode2.equals("000000"))
		{
			paySeq=s_result[0][2];//服务传出 下午写固定一个值
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
  //xl add 根据打印标识判断是否打印发票 
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
		var s_code = packet.data.findValueByName("s_code");	//貌似没啥用
		var s_note = packet.data.findValueByName("s_note");	
		var s_invoice_code  = packet.data.findValueByName("s_invoice_code");//貌似也没啥用	
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		//s_flag="1";
		//alert("s_flag is "+s_flag+" and s_code is "+s_code+" and s_note is "+s_note);
		if(s_flag=="1")
		{
			rdShowMessageDialog("预占取消接口调用异常!");
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("发票预占取消成功,打印完成!",2);
				window.location.href="<%=return_page%>";
			}
			else
			{
				rdShowMessageDialog("发票预占失败! 错误代码:"+s_code,0);

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
			rdShowMessageDialog("预占接口调用异常!错误代码:"+s_ret_code+",错误原因:"+s_ret_msg);
			window.location.href="<%=return_page%>";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("号码缴费成功!当前发票号码是"+ocpy_begin_no+",发票代码是"+bill_code+",是否打印发票?");
				if (prtFlag==1)
				{
					document.frm_print.action="PrintInvoice_1302.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code+"&ims_flag="+"<%=ims_flag%>"+"&returnPage="+"<%=return_page%>";
					document.frm_print.submit();
				}
				else
				{
					var pactket2 = new AJAXPacket("sdis_ocpy.jsp","正在进行发票预占取消，请稍候......");
					//alert("1 服务里应该是按流水改状态 不是插入了");
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
				rdShowMessageDialog("缴费发票预占失败!错误原因:"+s_ret_msg,0);

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
				xl add for 打印收据or发票的对话框
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
				
				//打印收据时 需要调用xuxz新接口
				var paySeq="<%=paySeq%>";
				var phoneno="<%=phoneNo1%>";
				var kphjje="<%=payMoney%>";//开票合计金额
				var s_hjbhsje=0;//合计不含税金额
				var s_hjse=0;
				var contractno="<%=contractno%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var s_xmmc="<%=opName%>";//项目名称 crm可能为多条? 看下zg17多组怎么传的
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_sj.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&payMoney="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&s_sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=缴费"+"&sj_flag=Y&ims_flag="+"<%=ims_flag%>";
				//document.frm_print.action="PrintInvoice_sj.jsp?sj_flag=Y&ims_flag="+"<%=ims_flag%>&payMoney="+"<%=payMoney%>"+"&id_no="+"<%=id_no%>&s_sm_code="+"<%=s_sm_code%>";
				 
				//alert(document.frm_print.action);
				document.frm_print.submit();
			}
			else if(returnValue=="1")
			{
				var pactket1 = new AJAXPacket("sfp_ocpy.jsp","正在进行发票预占，请稍候......");
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
				
				//alert("电子的");
				var s_kpxm="<%=opCode%>"+"<%=opName%>";
				var s_ghmfc="<%=userName%>";
				var s_jsheje="<%=payMoney%>";//价税合计金额
				var s_hjbhsje=0;//合计不含税金额
				var s_hjse=0;
				var s_xmmc="号码缴费";//s_kpxm;//项目名称 crm可能为多条? 看下zg17多组怎么传的
				var s_ggxh="";
				var s_hsbz="1";//含税标志 1=含税
				var s_xmdj="<%=payMoney%>";
				var s_xmje="<%=payMoney%>";
				var s_sl="*";
				var s_se="0";
				//新增
				var op_code="<%=opCode%>";
				var payaccept="<%=paySeq%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var phone_no="<%=phoneNo1%>";
				var pay_note=s_kpxm;
				var returnPage="<%=return_page%>";
				var chbz="1";//0红字发票 1普通发票 2原始发票冲红 p原发票作废
				//14 18 27 28 这四个值
				var kphjje = "<%=payMoney%>";
				//alert("s_xmmc is "+s_xmmc);
				//加入参:contractno total_date payAccept
				document.frm_print.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=totalDate%>";
				document.frm_print.submit(); 
				
			}
			else
			{
				var paySeq="<%=paySeq%>";
				var phoneno="<%=phoneNo1%>";
				var kphjje="<%=payMoney%>";//开票合计金额
				var s_hjbhsje=0;//合计不含税金额
				var s_hjse=0;
				var contractno="<%=contractno%>";
				var id_no="<%=id_no%>";
				var sm_code="<%=s_sm_code%>";
				var s_xmmc="<%=opName%>";//项目名称 crm可能为多条? 看下zg17多组怎么传的
				var opCode="<%=op_code%>";
				var return_page = "<%=return_page%>";
				document.frm_print.action="PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=缴费";
				
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
					rdShowMessageDialog("微信支付结果查询失败!错误原因:"+"<%=retMsg2%>");
					/*
					win=parent.addTab(true,'1352','发票打印','../s1300/s1352.jsp?activePhone=');
					parent.removeTab("1352");
					win=parent.addTab(true,'1352','发票打印','../s1300/s1352.jsp?activePhone='+"<%=phoneNo%>");
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
				rdShowMessageDialog("微信支付失败!错误代码:"+"<%=retCode1%>"+",错误原因:"+"<%=retMsg1%>");
				window.location.href="s1300.jsp";
			</script>
		<%
	}
	
 	 
	 
 %>
		
