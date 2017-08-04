<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 账户转账1364
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
	String opCode="zgb6";
	String opName="账户转账(实名制)";
	String workno = (String)session.getAttribute("workNo");
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String phoneno  = request.getParameter("phoneno");
	String contractno  = request.getParameter("contractno");
	String opcode    = "zgb6";//操作码
	String cust_name = request.getParameter("cust_name");
	String nopay_money = request.getParameter("return_money");
	String prepay_fee = request.getParameter("prepay_fee");
	String remark = WtcUtil.repNull(request.getParameter("remark"));
	System.out.println("222222222222222"+remark);
	String busy_type = request.getParameter("busy_type");
	String phoneno2 = request.getParameter("phoneno2");
	String contractno2 = request.getParameter("contractno2");
	String printAccept = request.getParameter("printAccept");
	//xl add new
	String reason1 = request.getParameter("reason1");
	String reason2_txt = request.getParameter("reason2_txt");
	String selectValue = request.getParameter("selectValue");
	String s_content = request.getParameter("s_content"); 
	%>
		<script language="javascript">//alert("tes reason2_txt is "+"<%=reason2_txt%>");</script>
	<%
	if (remark.equals("")) 
	{
		remark = phoneno+"帐户转帐:"+nopay_money;
	}
	System.out.println("!@#$%^&*()"+remark);
	String nopass= (String)session.getAttribute("password");
	System.out.println("!@#$%^&*()");
	//System.out.println("phoneno :"+phoneno);
	//System.out.println("contractno :"+contractno);
	//System.out.println("opcode :"+opcode);
	//System.out.println("workno :"+workno);
	ArrayList arlist = new ArrayList();
	
	String    iErrorNo ="";
	String    sErrorMessage = " ";
	int   	  flag = 0;
	String newloginaccept = "";
	String total_date = "";
	String bigmoney="";

%>
	<wtc:service name="s1364Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=orgcode%>"/>
		<wtc:param value="<%=opcode%>"/>
		<wtc:param value="<%=phoneno%>"/>
		<wtc:param value="<%=contractno%>"/>
		<wtc:param value="<%=nopay_money%>"/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=busy_type%>"/>
		<wtc:param value="<%=phoneno2%>"/>
		<wtc:param value="<%=contractno2%>"/>
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="<%=reason1%>"/>
		<wtc:param value="<%=reason2_txt%>"/>
		<wtc:param value="<%=selectValue%>"/>
		<wtc:param value="<%=s_content%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	System.out.println("1111111111111111111111111111"+result.length);
	iErrorNo = result[0][0];
	sErrorMessage = result[0][1];
	String error_msg = iErrorNo;

			if (iErrorNo.equals("000000")==false)
		{
            flag = -1;
		}

	// 判断处理是否成功
	if (flag == 0)
	{
		total_date = result[0][2];
		newloginaccept = result[0][3];
		bigmoney = result[0][4];
	}
	else
	{
		//System.out.println("failed, 请检查 !");
	}
	String url = "";
	if(busy_type.equals("1")){
	    url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+newloginaccept+"&pageActivePhone="+phoneno
		+"&opBeginTime="+opBeginTime+"&contactId="+phoneno+"&contactType=user";	
	}else{
	    url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+workno+"&loginAccept="+newloginaccept+"&pageActivePhone="+phoneno
		+"&opBeginTime="+opBeginTime+"&contactId="+contractno+"&contactType=acc";
	}
	System.out.println(url);
%>
<SCRIPT type=text/javascript>
function ifprint(){
     <% if (flag == 0){%>
	    rdShowMessageDialog("帐户转帐成功！",2);
			document.location.replace("zgb6_1.jsp?activePhone=<%=phoneno%>");
    <%}else{%>
	    rdShowMessageDialog("帐户转帐失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
	    history.go(-1);
    <%}%>
} 						
</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/header.jsp" %>
<body onload="ifprint()">
<form action="" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="print_work_no" value="<%=workno%>">
<INPUT TYPE="hidden" name="print_phoneno" value="<%=phoneno%>">
<INPUT TYPE="hidden" name="print_contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="print_nopay_money" value="<%=nopay_money%>">
<INPUT TYPE="hidden" name="print_prepay_fee" value="<%=prepay_fee%>">
<INPUT TYPE="hidden" name="print_cust_name" value="<%=cust_name%>">
<INPUT TYPE="hidden" name="print_total_date" value="<%=total_date%>">
<INPUT TYPE="hidden" name="print_login_accept" value="<%=newloginaccept%>">
<INPUT TYPE="hidden" name="print_big_money" value="<%=bigmoney%>">
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<jsp:include page="<%=url%>" flush="true"/>

