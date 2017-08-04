<%
/********************
 version v2.0
 开发商: si-tech
 模块：陈帐.死帐回收
 update zhaohaitao at 2008.12.29
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
%>

<%
	String opCode = request.getParameter("opCodeAll");
  	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
	String contractno = request.getParameter("contractno");
	String payMoney = request.getParameter("payMoney");
	String delayRate = request.getParameter("delayRate");
	String remonthRate = request.getParameter("remonthRate");
	String payType = request.getParameter("moneyType");
	String op_code = request.getParameter("opCode");
	String id_no = request.getParameter("id_no");
	String payNote = request.getParameter("payNote");
	String bankCode= request.getParameter("BankCode");
	String checkNo= request.getParameter("checkNo");
	String userName = request.getParameter("custName");
	String paySign=request.getParameter("paySign");
    String payMoneyShort=request.getParameter("payMoneyShort"); 
	
    String workno = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
	
	String groupId = (String)session.getAttribute("groupId");
	String  print_note = request.getParameter("print_note");
	String regionCode = orgCode.substring(0,2);
  String s_sm_code="";
  String s_sm_name="";
	String return_page = "d618.jsp?opCode="+opCode+"&opName="+opName+"&activePhone="+phoneNo;
	//new yearmonth
	String yearmonth = request.getParameter("year_month1");
		 //查询品牌名称 
  String[] inParam = new String[2];
	inParam[0] ="select c.sm_code, c.sm_name  from dcustmsg d,ssmcode c where d.sm_code=c.sm_code and substr(d.belong_code,0,2) =c.region_code and d.phone_no=:smphoneNo";
	inParam[1] = "smphoneNo="+phoneNo;	
	
	
%>
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
		
<!-- chenhu add -->
<wtc:service name="bs_ChnPayLimit" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=workno%>"/>
  <wtc:param value="<%=payMoney%>"/>
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
						rdShowMessageDialog("查代理商错误！<br>错误代码：'<%=t_return_code%>'。<br>错误信息：'<%=t_return_msg%>'。",0);
						history.go(-1);
	</script>	    
<%		
				}
if (t_return_code.equals("000000")){
%>	
	
    <!-- chenhu add end-->
<%
	
	
	// xl add for 发票号码 begin
	String s_flag="";
	String check_seq="";

	
	
	
	String[] inParas = new String[16];
	inParas[0] = workno;
    inParas[1] = nopass;
    inParas[2] = orgCode;
    inParas[3] = op_code;
    inParas[4] = id_no;
    inParas[5] = phoneNo;
    inParas[6] = payMoney;
    inParas[7] = payType;
    inParas[8] = delayRate;
    inParas[9] = remonthRate;
    inParas[10] = bankCode;
    inParas[11] = checkNo;
    inParas[12] = payNote;
    inParas[13] = paySign;
    inParas[14] = payMoneyShort;
	inParas[15] = yearmonth;
    
    //CallRemoteResultValue  value  = viewBean.callService("2", phoneNo,  "s1354Cfm", "3"  ,  inParas  ) ;
%>
	<wtc:service name="sd618Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String sysAccept = "";
	if((retCode1.equals("000000") || retCode1.equals("0"))  && result.length>0)
		sysAccept = result[0][1];
	System.out.println("retCode1d618================="+retCode1);
	String url="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+sysAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%	
	String totalDate=null;
	String year=null;
	String month=null;
	String day=null;
	String paySeq=null;


	String return_code = result[0][0];
   
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
 	
	if (result[0][0].equals("000000"))
	{
		if(result.length>0){
			paySeq = result[0][1];
			totalDate = result[0][2];
			year = totalDate.substring(0,4);
			month = totalDate.substring(4,6);
			day = totalDate.substring(6,8);
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
	
		
	if (id_no==null || "".equals(id_no)) {
		id_no="0";
  }
  if (contractno==null || "".equals(contractno)) {
		contractno="0";
  }
%> 


<META http-equiv=Content-Type content="text/html; charset=gbk">
<SCRIPT LANGUAGE="JavaScript">
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
			rdShowMessageDialog("预占接口调用异常!");
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
					document.frm_print.action="PrintInvoice.jsp?ocpy_begin_no="+ocpy_begin_no+"&bill_code="+bill_code;
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
				rdShowMessageDialog("发票预占失败!错误原因:"+s_ret_msg,0);

				window.location.href="<%=return_page%>";
			}
		}
	 } 
	  

function ifprint()
{
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var path="select_invoice.jsp";
	var returnValue = window.showModalDialog(path,"",prop);
	if(returnValue=="1")
	{
		var pactket1 = new AJAXPacket("sfp_ocpy.jsp","正在进行发票预占，请稍候......");
		pactket1.data.add("ocpy_begin_no","<%=ocpy_begin_no%>");
		pactket1.data.add("bill_code","<%=bill_code%>");
		pactket1.data.add("paySeq","<%=paySeq%>");
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
		
		//alert("电子的");
		var s_kpxm="<%=opCode%>"+"<%=opName%>";
		var s_ghmfc="<%=userName%>";
		var s_jsheje="<%=payMoney%>";//价税合计金额
		var s_hjbhsje=0;//合计不含税金额
		var s_hjse=0;
		var s_xmmc="月陈账死账回收";//项目名称 crm可能为多条? 看下zg17多组怎么传的
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
		var phone_no="<%=phoneNo%>";
		var pay_note=s_kpxm;
		var returnPage ="<%=return_page%>";
		var chbz="1";
		var kphjje="<%=payMoney%>";
		document.frm_print.action="PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje;
		document.frm_print.submit(); 
		
	}
	else
	{
		var paySeq="<%=paySeq%>";
		var phoneno="<%=phoneNo%>";
		var kphjje="<%=payMoney%>";//开票合计金额
		var s_hjbhsje=0;//合计不含税金额
		var s_hjse=0;
		var contractno="<%=contractno%>";
		var id_no="<%=id_no%>";
		var sm_code="<%=s_sm_code%>";
		var s_xmmc="<%=opName%>";//项目名称 crm可能为多条? 看下zg17多组怎么传的
		var opCode="<%=opCode%>";
		var return_page = "<%=return_page%>";
		document.frm_print.action="PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=缴费";
		
		document.frm_print.submit();
	}

} 

//-->
</SCRIPT>
 <body onLoad="ifprint()">
<form action="" name="frm_print" method="post">
<INPUT TYPE="hidden" name="opCode" value="<%=op_code%>">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="total_date" value="<%=totalDate%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=paySeq%>">
<INPUT TYPE="hidden" name="phoneNo" value="<%=phoneNo%>">
<INPUT TYPE="hidden" name="checkNo" value="<%=checkNo%>">
<INPUT TYPE="hidden" name="id_no" value="<%=id_no%>"> 
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="bill_code" value="<%=bill_code%>">
<input type="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>">
<input type="hidden" name="userName" value="<%=userName%>">
<input type="hidden" name="s_sm_code" value="<%=s_sm_code%>">
<input type="hidden" name="s_sm_name" value="<%=s_sm_name%>">
<input type="hidden" name="ifRed" value="1">
<INPUT TYPE="hidden" name="returnPage" value="d618.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>">

</form>
</body>
</html>
<%}
else
{
 %>
   <script language="JavaScript">
		rdShowMessageDialog("陈账回收错误!错误代码：'<%=return_code%>'，错误信息：'<%=error_msg%>'。",0);
        document.location.replace("d618.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>");
   </script>
<%
}
%>
<%
}else
{
%>
<script language="JavaScript">
		rdShowMessageDialog("查代理商类型错误！<br>错误代码：'<%=t_return_code%>'。<br>错误信息：'<%=t_return_msg%>'。",0);
     history.go(-1);
   </script>
<%
}
%>
