<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 退预存款1362
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
	//判断纸质or电子zz_flag
	String s_money = WtcUtil.repNull(request.getParameter("s_money"));
	String s_old_number = WtcUtil.repNull(request.getParameter("dzhm"));
	String s_old_code = WtcUtil.repNull(request.getParameter("dzdm"));
	String zz_flag = WtcUtil.repNull(request.getParameter("zz_flag"));
	String saccept = WtcUtil.repNull(request.getParameter("saccept"));
	String kyny = WtcUtil.repNull(request.getParameter("kyny")); 
	
	String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
	System.out.println("--------------------------0009------==="+opCode+":::"+opName);
	String phoneno = (String)request.getParameter("phoneno");
	String workno = (String)session.getAttribute("workNo");
	String orgcode = (String)session.getAttribute("orgCode"); 			//机构代码
	String orgid = (String)session.getAttribute("orgId");				//机构ID
	String regionCode = (String)session.getAttribute("regCode");	
	
	// xl add for 发票号码 begin
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	String s_sm_code="";
	
//定义变量
//输入参数：workno,nopass,orgcode,opcode,contactno,nopay_money。
	String contractno  = request.getParameter("contractno");
	String unbill_total  = request.getParameter("unbill_total");
	String opcode    = "e033";											//操作码
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
	
	
			//hq add 根据contract_no查询id_no
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
				rdShowMessageDialog("品牌信息不存在!");
				history.go(-1);
			</script>
		<%
	}
	

	// xl add for 发票号码 end 


	if (remark.equals("")==true) {
	remark = phoneno+"退预存款:"+nopay_money;}
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
	
%>
		
<%
	if ( return_code.equals("000000")) 
	{
		
		total_date = result[0][2];
		newloginaccept = result[0][3];
		bigmoney = result[0][4];
		//s_sm_code="kf";
		if(s_sm_code=="kf" || s_sm_code=="kg"|| s_sm_code=="ki" ||s_sm_code.equals("kf")||s_sm_code.equals("kg")||s_sm_code.equals("ki"))
		{
			String s_print_jsp="PrintInvoice_kf.jsp";
		}
		else
		{
				inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from tt_WLOGININVOICE where LOGIN_NO = :workNo";
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
			}else{
				s_invoice_flag="1";
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
<INPUT TYPE="hidden" name="opCode" value="e033">
<INPUT TYPE="hidden" name="returnPage" value="e033_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>">
<INPUT TYPE="hidden" name="id_no" value="<%=id_no%>">
<INPUT TYPE="hidden" name="print_cust_name" value="<%=cust_name%>">
<INPUT TYPE="hidden" name="total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="ifRed" value="<%=ifRed%>">

	<%@ include file="/npage/include/footer.jsp" %>
</form>

</body>
<SCRIPT type=text/javascript>
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
			window.location.href="../e033/e033_1.jsp?opCode=e033&opName=宽带退费&crmActiveOpCode=e033";
		}
		else
		{
			if(s_flag=="0")
			{
				rdShowMessageDialog("发票预占取消成功,打印完成!",2);
				window.location.href="../e033/e033_1.jsp?opCode=e033&opName=宽带退费&crmActiveOpCode=e033";
			}
			else
			{
				rdShowMessageDialog("发票预占失败! 错误代码:"+s_code,0);

				window.location.href="../e033/e033_1.jsp?opCode=e033&opName=宽带退费&crmActiveOpCode=e033";
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
			window.location.href="../e033/e033_1.jsp?opCode=e033&opName=宽带退费&crmActiveOpCode=e033";
		}
		else
		{
			if(s_invoice_flag=="0")
			{
				var prtFlag=0;
				prtFlag=rdShowConfirmDialog("退预存款成功!当前发票号码是"+ocpy_begin_no+",发票代码是"+bill_code+",是否打印发票?");
				if (prtFlag==1)
				{
					/*document.frm_print_invoice.action="PrintInvoice.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code;
					document.frm_print_invoice.submit();
					*/
					document.frm_print_invoice.check_seq.value=ocpy_begin_no;
					document.frm_print_invoice.action="PrintInvoice_kf.jsp?check_seq="+ocpy_begin_no+"&s_flag="+"<%=s_flag%>"+"&bill_code="+bill_code+"&s_sm_code="+"<%=s_sm_code%>";
					document.frm_print_invoice.submit();
				}
				else
				{
					var pactket2 = new AJAXPacket("../s1300/sdis_ocpy.jsp","正在进行发票预占取消，请稍候......");
					//alert("1 服务里应该是按流水改状态 不是插入了");
					pactket2.data.add("ocpy_begin_no",ocpy_begin_no);
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("paySeq","<%=newloginaccept%>");
					pactket2.data.add("bill_code",bill_code);
					pactket2.data.add("op_code","e033");
					pactket2.data.add("phoneNo","<%=phoneno%>");
					pactket2.data.add("contractno","<%=contractno%>");
					pactket2.data.add("payMoney","<%=nopay_money%>");
					pactket2.data.add("userName","<%=cust_name%>");
					//alert("2 "+pactket1.data);
					 
					core.ajax.sendPacket(pactket2,doqx);
				 
					pactket2=null;
				}
			}
			else
			{
				rdShowMessageDialog("发票预占失败!错误原因:"+s_ret_msg,0);

				window.location.href="../e033/e033_1.jsp?opCode=e033&opName=宽带退费&crmActiveOpCode=e033";
			}
		}
	 }
	 
function ifprint()
{
	//alert("s_sm_code is "+"<%=s_sm_code%>");
	if("<%=s_sm_code%>"=="kf" || "<%=s_sm_code%>"=="kg"|| "<%=s_sm_code%>"=="ki")
	{
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var path="../s1300/select_invoice_1362.jsp?zz_flag="+"<%=zz_flag%>";
		var returnValue = window.showModalDialog(path,"",prop);
		//alert("test returnValue is "+returnValue);
		if(returnValue=="1")
		{
			var pactket1 = new AJAXPacket("../s1300/sfp_ocpy.jsp","正在进行发票预占，请稍候......");
			pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
			pactket1.data.add("bill_code","<%=bill_code%>");
			pactket1.data.add("paySeq","<%=newloginaccept%>");
			pactket1.data.add("bill_code","<%=bill_code%>");
			pactket1.data.add("op_code","<%=opCode%>");
			pactket1.data.add("phoneNo","<%=phoneno%>");
			pactket1.data.add("contractno","<%=contractno%>");
			pactket1.data.add("payMoney","<%=nopay_money%>");
			pactket1.data.add("userName","<%=cust_name%>");
			core.ajax.sendPacket(pactket1,doyz);
			pactket1=null;
		}
		else if(returnValue=="3")
		{
			
			//alert("电子的");
			var s_kpxm="<%=opCode%>"+"<%=opName%>";
			var s_ghmfc="<%=cust_name%>";
			var s_jsheje="<%=s_money%>";//价税合计金额
			var s_hjbhsje=0;//合计不含税金额
			var s_hjse=0;
			var s_xmmc="退预存款";//项目名称 crm可能为多条? 看下zg17多组怎么传的
			var s_ggxh="";
			var s_hsbz="1";//含税标志 1=含税
			var s_xmdj="<%=s_money%>";
			var s_xmje="<%=s_money%>";
			var s_sl="*";
			var s_se="0";
			//新增
			var op_code="e033";
			var payaccept="<%=newloginaccept%>";
			var id_no="<%=id_no%>";
			var sm_code="<%=s_sm_code%>";
			var phone_no="<%=phoneno%>";
			var pay_note=s_kpxm;
			var returnPage="../e033/e033_1.jsp?opCode=e033&opName=宽带退费&crmActiveOpCode=e033";
			var chbz="2";//红字的传2 原冲正=0
			//红字的 新增old_accept 
			var old_accept="<%=saccept%>";
			var old_ym = "<%=kyny%>";
			var kphjje="<%=s_money%>";//开票合计金额
			kphjje = (-1)*Number(kphjje);
			s_xmdj = (-1)*Number(s_xmdj);
			var s_old_number="<%=s_old_number%>";
			var s_old_code="<%=s_old_code%>";
			var s_old_accept="<%=saccept%>";
			//alert("old_accept is "+old_accept);
			document.frm_print_invoice.action="../s1300/PrintInvoice_czdz_1362.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&xmsl=1&old_accept="+old_accept+"&old_ym="+old_ym+"&kphjje="+kphjje+"&hjbhsje="+s_hjbhsje+"&s_old_number="+s_old_number+"&s_old_code="+s_old_code+"&s_old_accept="+s_old_accept+"&contractno="+"<%=contractno%>"+"&total_date="+"<%=total_date%>"+"&returnPage="+returnPage;
			document.frm_print_invoice.submit(); 
			
		}
		else
		{
			var paySeq="<%=newloginaccept%>";
			var phoneno="<%=phoneno%>";
			var kphjje="<%=nopay_money%>";//开票合计金额
			var s_hjbhsje=0;//合计不含税金额
			var s_hjse=0;
			var contractno="<%=contractno%>";
			var id_no="<%=id_no%>";
			var sm_code="<%=s_sm_code%>";
			var s_xmmc="<%=opName%>";//项目名称 crm可能为多条? 看下zg17多组怎么传的
			var opCode="<%=opCode%>";
			var return_page = "../e033/e033_1.jsp?opCode=e033&opName=宽带退费&crmActiveOpCode=e033";
			//alert("return_page is "+return_page);
			document.frm_print_invoice.action="../s1300/PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=2&s_xmmc="+s_xmmc+"&paynote=缴费"+"&returnPage="+return_page;
			
			document.frm_print_invoice.submit();
		}
	}
	else
	{
		if(rdShowConfirmDialog("退预存款成功，当前发票号码是"+"<%=check_seq%>"+",是否打印收据?")==1)
		{
			document.frm_print_invoice.check_seq.value="<%=check_seq%>";
			frm_print_invoice.action="PrintInvoice.jsp?check_seq="+"<%=check_seq%>"+"&s_flag="+"<%=s_flag%>";
			frm_print_invoice.submit();
		}
		else 
			document.location.replace("e033_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
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
		 
		  		rdShowMessageDialog("退预存款失败。<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=error_msg%>'。",0);
			    document.location.replace("e033_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
		
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