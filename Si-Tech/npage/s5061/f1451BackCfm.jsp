   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
<%
  String opCode = "1451";
  String opName = "电子帐单受理";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html;charset=GBK"%>

<%	

	String op_code = request.getParameter("op_code");
	String loginAccept = request.getParameter("loginAccept");
	String phoneno = request.getParameter("phoneno");
	String r_cus = request.getParameter("r_cus");
	String mail_address1 = request.getParameter("mail_address1");
	String mail_address2 = request.getParameter("mail_address2");
	String mail_address3 = request.getParameter("mail_address3");
	String t_sys_remark = request.getParameter("t_sys_remark");
	String tran_content = request.getParameter("tran_content");
	
	
	String[][] result = new String[][]{};
	String work_no = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String paraAray[] = new String[19];   
	
	paraAray[0] = loginAccept; //流水
	paraAray[1] = "01"; //渠道标识
	paraAray[2] = "1451";	//功能代码
	paraAray[3] = work_no;  //操作工号
	paraAray[4] = ""; //工号密码
	paraAray[5] = phoneno;	//用户号码 
	paraAray[6] = ""; //号码密码
	paraAray[7] = r_cus; //类型
	paraAray[8] = "1";
	paraAray[9] = "2";	//电子邮件
	paraAray[10] = "";	//邮寄姓名
	paraAray[11] = "";//邮寄地址
	paraAray[12] = ""; //邮编
	paraAray[13] = "";	//传真
	paraAray[14] = mail_address1;	//E_Mail
	paraAray[15] = mail_address2;//E_Mail
	paraAray[16] = mail_address3;//E_Mail
	paraAray[17] = t_sys_remark; //用户备注
	paraAray[18] = tran_content; 
	
	
	
	//String[] ret = impl.callService("sPostPrtBill",paraAray,"1","phone",phoneno);
	%>
	
    <wtc:service name="sPostPrtBill" outnum="1" retmsg="msg1" retcode="code1" routerKey="phone" routerValue="<%=phoneno%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />			
			<wtc:param value="<%=paraAray[4]%>" />	
			<wtc:param value="<%=paraAray[5]%>" />	
			<wtc:param value="<%=paraAray[6]%>" />
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:param value="<%=paraAray[8]%>" />
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:param value="<%=paraAray[10]%>" />
			<wtc:param value="<%=paraAray[11]%>" />						
			<wtc:param value="<%=paraAray[12]%>" />	
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:param value="<%=paraAray[14]%>" />		
			<wtc:param value="<%=paraAray[15]%>" />	
			<wtc:param value="<%=paraAray[16]%>" />	
			<wtc:param value="<%=paraAray[17]%>" />	
			<wtc:param value="<%=paraAray[18]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />	
	
	<%
	String retCode= code1;
	String retMsg = msg1;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	//int errCode = impl.getErrCode();
	
	String errMsg = msg1;
	//String loginAccept = "";
	if (result_t != null &&retCode.equals("000000"))
	{
	loginAccept =result_t[0][0];

%>

<script language="JavaScript">
	rdShowMessageDialog("Email业务受理成功！",2);
    //removeCurrentTab();
    window.location="f1451.jsp?op_code=1451&opCode=1451&opName=电子帐单受理&activePhone=<%=phoneno%>"
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("Email业务受理失败: <%=errMsg%>",0);
	window.location="f1451.jsp?op_code=1451&opCode=1451&opName=电子帐单受理&activePhone=<%=phoneno%>"
</script>
<%}
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneno+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
