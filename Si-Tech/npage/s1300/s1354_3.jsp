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

	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
	String busyName = request.getParameter("busyName"); //操作名字
	String totaldate  = request.getParameter("billdate");//帐务日期
	String opcode    = request.getParameter("OpCode"); //操作码
	String loginaccept = request.getParameter("water_number");//流水号
	String accept_detail = request.getParameter("nopaywater");//冲销流水
	String remark = request.getParameter("remark");//备注

	String workno = (String)session.getAttribute("workNo");
	String orgcode = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");

	String[] inParas = new String[6];
	inParas[0] = workno;
	inParas[1] = opcode;
	inParas[2] = orgcode;
	inParas[3] = loginaccept;
	inParas[4] = totaldate;
 	inParas[5] = remark;

   
	//CallRemoteResultValue  value  = viewBean.callService("1", orgcode.substring(0,2) ,  "s1356Cfm", "3"  , inParas) ;
 %>
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
 	String sysAccept = "";
	if((retCode1.equals("000000") || retCode1.equals("0"))  && result.length>0)
		sysAccept = result[0][1];
 	String url="/npage/contact/upCnttInfo_boss.jsp?opCode="+opcode+"&retCodeForCntt="+retCode1+"&opName="+busyName+"&workNo="+workno+"&loginAccept="+sysAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
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
 	
%>
<html>
<script language="JavaScript">
function ifprint()
{
 	rdShowMessageDialog("回收回退成功！",2);
    removeCurrentTab();
} 						
</script>

<body onload="ifprint()">
<form action="s1356_print.jsp" name="frm_print_invoice" method="post">
<INPUT TYPE="hidden" name="print_work_no" value="<%=workno%>">
<INPUT TYPE="hidden" name="print_nopass" value="<%=orgcode%>">
<INPUT TYPE="hidden" name="print_total_date" value="<%=newtotaldate%>">
<INPUT TYPE="hidden" name="print_login_accept" value="<%=newloginaccept%>">
</form>
</body>
</html>
<%
 }
 else{
%>

<SCRIPT LANGUAGE="JavaScript">
<!--
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=error_msg%>'。",0);
	history.go(-1);
//-->
</SCRIPT>
 <%}%>

