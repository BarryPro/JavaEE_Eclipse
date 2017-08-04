<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.16
 模块:神州行余额转帐
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
  String opCode = "1588";
  String opName = "神州行余额转帐";
  
  String workno = (String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
  String orgcode = (String)session.getAttribute("orgCode");//机构代码

	//定义变量
	//输入参数：workno,nopass,orgcode,opcode,contactno,nopay_money。
	String phoneno  = request.getParameter("phoneno");
	String contractno  = request.getParameter("contractno");
	String opcode    = "1588";//操作码
	String cust_name = request.getParameter("cust_name");
	String nopay_money = request.getParameter("return_money");
	String prepay_fee = request.getParameter("prepay_fee");
	
	String phoneno2 = request.getParameter("phoneno2");
	String contractno2 = request.getParameter("contractno2");
	String remark = request.getParameter("remark");
	String hand_fee=request.getParameter("hand_fee");
	String hand_fee2=request.getParameter("hand_fee2");
	String favorcode=request.getParameter("favorcode");
	String sysAccept=request.getParameter("sysAccept");
	String nopass=(String)session.getAttribute("password");
	int pay_num=0;
	double pay_sum=0.00;
	
	ArrayList arlist = new ArrayList();
	
	String [][] result = new String[][]{};
	String    iErrorNo ="";
	String    sErrorMessage = " ";
	String    sReturnCode = "";
	int   	  flag = 0;
	String newloginaccept = "";
	String total_date = "";
	String bigmoney="";
	
		
	int inputNumber = 14;
	String  outputNumber = "3";
	String  inputParsm [] = new String[inputNumber];
	inputParsm[0] = workno;
	inputParsm[1] = nopass;
	inputParsm[2] = orgcode;
	inputParsm[3] = opcode;
	inputParsm[4] = phoneno;
	inputParsm[5] = contractno;
	inputParsm[6] = nopay_money;		
	inputParsm[7] = remark;
	inputParsm[8] = "3";
	inputParsm[9] = phoneno2;                          //转存手机号
	inputParsm[10] = contractno2;                      //转存帐号
	inputParsm[11] = hand_fee;                        //实际手续费
	inputParsm[12]= hand_fee2;                          //默认手续费
	inputParsm[13]=favorcode;                          //手续费修改权限代码
	
	
  	//String [] initBack = impl.callService("s1588Cfm",inputParsm,outputNumber,"phone",phoneno);
%>
	<wtc:service name="s1588Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="retCode1" retmsg="retMsg1" outnum="5">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
	<wtc:param value="<%=inputParsm[6]%>"/>	
	<wtc:param value="<%=inputParsm[7]%>"/>
	<wtc:param value="<%=inputParsm[8]%>"/>
	<wtc:param value="<%=inputParsm[9]%>"/>	
	<wtc:param value="<%=inputParsm[10]%>"/>
	<wtc:param value="<%=inputParsm[11]%>"/>
	<wtc:param value="<%=inputParsm[12]%>"/>
	<wtc:param value="<%=inputParsm[13]%>"/>
	<wtc:param value="<%=sysAccept%>"/>
	</wtc:service>	
	<wtc:array id="result1" scope="end"/>
<%
	
	String retCode = result1[0][0];
	String retMsg = retMsg1;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);

	String errMsg = retMsg1;
	
	//out.println("retCode:"+retCode);
	System.out.println("-----------------------------"+retCode);
	                    
	if ("000000".equals(retCode))
	{
		total_date = result1[0][2];
		newloginaccept = result1[0][3];
		System.out.println("total_date === "+ total_date);
		System.out.println("newloginaccept === "+ newloginaccept);
	}else{
		flag=-1;	
	}
	String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+workno+"&loginAccept="+newloginaccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;	
%>
	<jsp:include page="<%=url%>" flush="true" />
<SCRIPT type=text/javascript>
function ifprint(){
	
     <% 
     if (flag==0){%>
     //if (retCode.equals("000000")){%>
     rdShowMessageDialog("帐户转帐成功！",2);
     // frm_print_invoice.submit(); 
     // else
	    	//window.location.href="s1588.jsp";
	    removeCurrentTab();
    <%}
    else{%>
    rdShowMessageDialog("帐户转帐失败。<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
    history.go(-1);
    <%}
     %>
} 						
</SCRIPT>
<html  xmlns="http://www.w3.org/1999/xhtml">
<body onload="ifprint()">
<form action="PrintInvoice.jsp" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="workno" value="<%=workno%>">
<INPUT TYPE="hidden" name="print_phoneno" value="<%=phoneno%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno2%>">
<INPUT TYPE="hidden" name="print_nopay_money" value="<%=nopay_money%>">
<INPUT TYPE="hidden" name="print_prepay_fee" value="<%=prepay_fee%>">
<INPUT TYPE="hidden" name="opCode" value="<%=opcode%>">
<INPUT TYPE="hidden" name="total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="checkNo" value="">
<input type="hidden" name="pay_sum"  value="<%=pay_sum%>">
<input type="hidden" name="pay_num"  value="<%=pay_num%>">

</form>
</body></html>


