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
 
  String opCode = "";
	String opName = "";
	String return_code="";
	String ret_msg="";

	String s_Invoice_number = request.getParameter("s_Invoice_number");
	String e_Invoice_number = request.getParameter("e_Invoice_number");
	String Invoice_code = request.getParameter("Invoice_code");
	String s_in_ModeTypeCode = request.getParameter("s_in_ModeTypeCode");
	String s_in_CaseTypeCode = request.getParameter("s_in_CaseTypeCode");
	if(s_in_CaseTypeCode == null) s_in_CaseTypeCode = "";
	String workno = (String)session.getAttribute("workNo");
//	String PrintAccept="";
//    PrintAccept = getMaxAccept();
	String return_page = "g485_1.jsp";
    System.out.println("FFFFFFFFFFFFFFFFFFFFFFf s_in_CaseTypeCode is "+s_in_CaseTypeCode);

	String [] inParas = new String[6];
	inParas[0]  = s_Invoice_number;
	inParas[1]  = e_Invoice_number;
	inParas[2]  = Invoice_code;
	inParas[3]  = s_in_ModeTypeCode;
	inParas[4]  = s_in_CaseTypeCode;
	if(s_in_CaseTypeCode.length()==4)
	  {
	     inParas[4]  = s_in_CaseTypeCode.substring(2);
	  }
	inParas[5]  = workno;

System.out.println("s_in_ModeTypeCode:"+s_in_ModeTypeCode);
%>
	<wtc:service name="sInvoiceInsert" routerKey="region" routerValue="<%=s_in_ModeTypeCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value=""/>
		<wtc:param value="N"/>
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
	  rdShowMessageDialog("发票信息录入成功！");
	  window.location.href="<%=return_page%>";
 </script>


<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("发票信息录入失败!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%}
%>
</body></html>