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
	String opCode="zgb5";
	String opName="退预存款(非实名)";
	System.out.println("--------------------------0009------==="+opCode+":::"+opName);
	String phoneno = (String)request.getParameter("phoneno");
	String workno = (String)session.getAttribute("workNo");
	String orgcode = (String)session.getAttribute("orgCode"); 			//机构代码
	String orgid = (String)session.getAttribute("orgId");				//机构ID
	String regionCode = (String)session.getAttribute("regCode");	
//定义变量
//输入参数：workno,nopass,orgcode,opcode,contactno,nopay_money。
	String contractno  = request.getParameter("contractno");
	String unbill_total  = request.getParameter("unbill_total");
	String opcode  = request.getParameter("opCode");										//操作码
	String cust_name = request.getParameter("cust_name");
	String nopay_money = request.getParameter("nopay_money");
	String prepay_fee = request.getParameter("prepay_fee");
	String remark = WtcUtil.repNull(request.getParameter("remark"));
	String busy_type = request.getParameter("busy_type");
	String userName=request.getParameter("textfield7");
	String selectValue = request.getParameter("selectValue");
	String s_content = request.getParameter("s_content"); 
	String ifRed="1";
	if("2".equals(busy_type)){
		ifRed="0";
	}else{
		ifRed="2";
	}
	String interest = request.getParameter("interest");
	if (remark.equals("")==true) {
	remark = phoneno+"退预存款:"+nopay_money;}
	String    nopass="111111";
	String    newloginaccept = "";
	String    total_date = "";
	String    bigmoney="";
	//xl add new
	String reason1 = request.getParameter("reason1");
	String reason2_txt = request.getParameter("reason2_txt");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA reason1 is "+reason1+" and reason2_txt is "+reason2_txt);
	
	// xl add for 发票号码 begin
	// xl add for 发票号码 end
	  String groupId = (String)session.getAttribute("groupId");
		String payMoney = request.getParameter("nopay_money");
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
		String s_id_no="";
   	String s_sm_code="";
  	String s_sm_name="";
    String paySeq = "";
    String totalDate = "";
    
    
    //hq add 根据contract_no查询id_no
		String[] inParam_idno = new String[2];
		inParam_idno[0]="select to_char(a.id_no) from dconusermsg a,dcustmsg b where a.id_no=b.id_no and "
		 +" a.serial_no='0' and a.bill_order ='99999999' and a.contract_no=:s_contract_no";
		inParam_idno[1]="s_contract_no="+contractno;
		
	 //查询品牌名称 
    String[] inParam = new String[2];
		inParam[0] ="select c.sm_code, c.sm_name  from dcustmsg d,ssmcode c where d.sm_code=c.sm_code and substr(d.belong_code,0,2) =c.region_code and d.phone_no=:smphoneNo";
		inParam[1] = "smphoneNo="+phoneno;	
		
		String[] inParas = new String[12];
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
		inParas[10] = reason1;
		inParas[11] = reason2_txt;
 
//ScallSvrViewBean viewBean = new ScallSvrViewBean();
//CallRemoteResultValue  value  = viewBean.callService("1", orgcode.substring(0,2),  "s1362Cfm", "5"  ,  inParas) ;
%> 
	<wtc:service name="TlsPubSelBoss"  outnum="2" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="sm_name_arr" scope="end" />
		
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
	<wtc:param value="<%=inParam_idno[0]%>"/>
	<wtc:param value="<%=inParam_idno[1]%>"/>
	</wtc:service>
	<wtc:array id="id_no_arr" scope="end" />
		 
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
		<wtc:param value="<%=inParas[10]%>"/>
		<wtc:param value="<%=inParas[11]%>"/>
		<wtc:param value="<%=selectValue%>"/>
		<wtc:param value="<%=s_content%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<% 
//	String [][] result  = value.getData();
	String return_code =retCode;
	//String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retMsg));			
	String error_msg = retMsg;
	
	
		if(id_no_arr!=null&&id_no_arr.length>0){
        	s_id_no = id_no_arr[0][0];
    }
    if(s_id_no==null||"".equals(s_id_no)){
    		s_id_no="0";
    }
    
    if(sm_name_arr!=null&&sm_name_arr.length>0){
      s_sm_code = sm_name_arr[0][0];
      s_sm_name = sm_name_arr[0][1];
 		}	

	
%>
		
<%
	if ( return_code.equals("000000")) 
	{
		%>
		<SCRIPT LANGUAGE="JavaScript">
		 
		  		rdShowMessageDialog("退预存款成功",2);
			    document.location.replace("zgb5_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
		
		 </SCRIPT>
		<%
	}
	else
	{
		%>
		<SCRIPT LANGUAGE="JavaScript">
		 
		  		rdShowMessageDialog("退预存款失败。<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=error_msg%>'。",0);
			    document.location.replace("zgb5_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>");
		
		 </SCRIPT>
		<%
	}
%>

		
		 
 

<html xmlns="http://www.w3.org/1999/xhtml">
<body onload="ifprint()">
<form action="PrintInvoice.jsp" name="frm_print_invoice" method="post">
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
<INPUT TYPE="hidden" name="check_seq" value="<%=check_seq%>">
<INPUT TYPE="hidden" name="s_flag" value="<%=s_flag%>">
<INPUT TYPE="hidden" name="returnPage" value="zgb5_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>">
<INPUT TYPE="hidden" name="opCode" value="<%=opCode%>">
<INPUT TYPE="hidden" name="check_seq" value="<%=check_seq%>">
<INPUT TYPE="hidden" name="s_flag" value="<%=s_flag%>">
<INPUT TYPE="hidden" name="ocpy_begin_no" value="<%=ocpy_begin_no%>"> 
<INPUT TYPE="hidden" name="bill_code" value="<%=bill_code%>"> 
<input type="hidden" name="s_id_no" value="<%=s_id_no%>">
<input type="hidden" name="s_sm_code" value="<%=s_sm_code%>">
<input type="hidden" name="s_sm_name" value="<%=s_sm_name%>">
<input type="hidden" name="ifRed" value="<%=ifRed%>">
	<%@ include file="/npage/include/footer.jsp" %>
	

</form>
 
</body>
</html>

 