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
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%
 
    String opCode = "e673";
	String opName = "发票统计信息";
	String return_code="";
	String ret_msg="";

	String invoeice_code = request.getParameter("invoeice_code");
	String s_invoice_number = request.getParameter("s_invoice_number");
	String e_invoice_number = request.getParameter("e_invoice_number");
	String login_no = request.getParameter("login_no");
	String temp = request.getParameter("temp");
	String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
	
	String org_code = (String)session.getAttribute("orgCode");
 	String regionCode = org_code.substring(0,2);
	
	String workno = (String)session.getAttribute("workNo");
//	workno="mjjp01";
	String return_page = "e673_6.jsp";

	
	if(!login_no.equals(workno))
	{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("录入工号和删除工号不同，不允许操作");
			window.location.href="<%=return_page%>";			
		</SCRIPT>		
<%
		return;
	}
  
    String [] inParas = new String[5];
	inParas[0]  = invoeice_code;
	inParas[1]  = s_invoice_number;
	inParas[2]  = e_invoice_number;	
	inParas[3]  = login_no;
	inParas[4]  = temp;

%>
<wtc:service name="bs_6735Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
</wtc:service>
<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<body >
  <%	
	if (return_code.equals("000000"))
	{	
%>	
 <script language="javascript">
	  rdShowMessageDialog("发票信息删除成功！");
	  window.location.href="<%=return_page%>";
 </script>


<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("发票信息删除失败!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%}
%>
</body></html>