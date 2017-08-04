<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：过期卡激活
********************/
%>


<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%
	String regCode = (String)session.getAttribute("regCode");
	
    String card_no  = request.getParameter("cardno");
    String op_code   = request.getParameter("op_code");
    String login_no  = request.getParameter("login_no");
    String login_accept = request.getParameter("loginAccept");
    String t_op_remark = request.getParameter("t_op_remark");    
    String loginNoPass = request.getParameter("loginNoPass"); 
    String org_code = request.getParameter("org_code");
	String ctotal= request.getParameter("ctotal");
	String stop_date = request.getParameter("stop_date");
	String newloginaccept = "";
	String total_date = "";
    String return_code = "";
	String error_msg = "";
	  
	int inputNumber = 11;
	String  outputNumber = "4";
	String  inputParsm [] = new String[inputNumber];
	
	inputParsm[0] = login_accept;
	inputParsm[1] = "01";
	inputParsm[2] = op_code;
	inputParsm[3] = login_no;
	inputParsm[4] = loginNoPass;
	
	inputParsm[5] = "";
	inputParsm[6] = "";
	
	inputParsm[7] = card_no;
	inputParsm[8] = org_code;
	inputParsm[9] = ctotal;
	inputParsm[10] = stop_date;
	
	//String [] initBack = impl.callService("s3073Cfm",inputParsm,outputNumber);
	System.out.println(" zhouby 0 " + inputParsm[0]);
	System.out.println(" zhouby 1 " + inputParsm[1]);
	System.out.println(" zhouby 2 " + inputParsm[2]);
	System.out.println(" zhouby 3 " + inputParsm[3]);
	System.out.println(" zhouby 4 " + inputParsm[4]);
	System.out.println(" zhouby 5 " + inputParsm[5]);
	System.out.println(" zhouby 6 " + inputParsm[6]);
	System.out.println(" zhouby 7 " + inputParsm[7]);
	System.out.println(" zhouby 8 " + inputParsm[8]);
	System.out.println(" zhouby 9 " + inputParsm[9]);
	System.out.println(" zhouby 10 " + inputParsm[10]);
	
	
%>
	<wtc:service name="s3073Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">			
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
	</wtc:service>	
	<wtc:array id="initBack"  scope="end"/>
<%
	String retCode = retCode1;
	String retMsg = retMsg1;
	
	 return_code=initBack[0][0];
	 error_msg=retMsg;

	if (retCode.equals("000000")){
	    total_date = initBack[0][2];
		newloginaccept = initBack[0][3];
	}
	System.out.println("retCode === ["+ retCode + "]");
	System.out.println("retMsg === ["+ error_msg+ "]");
%>
<SCRIPT type=text/javascript>
function ifprint(){
     <% 
     if ( retCode.equals("000000")){%>
	    rdShowMessageDialog("过期卡激活成功！",2)
		//window.location.href="s3073.jsp";
		removeCurrentTab();
    <%}
    else{%>
	    rdShowMessageDialog("过期卡激活失败。<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=error_msg%>'。",0);
	    history.go(-2);
    <%}%>
}
</SCRIPT>
<html>
<body onload="ifprint()">
<form action="s3071Print.jsp" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="workno" value="<%=login_no%>">
<INPUT TYPE="hidden" name="print_nopay_money" value="<%=ctotal%>">
<INPUT TYPE="hidden" name="print_prepay_fee" value="5">
<INPUT TYPE="hidden" name="op_code" value="<%=op_code%>">
<INPUT TYPE="hidden" name="total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="payAccept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="checkNo" value="">


</form>
</body></html>