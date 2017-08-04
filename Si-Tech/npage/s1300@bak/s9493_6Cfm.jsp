<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.s1310.viewBean.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>发票打印</TITLE>
</HEAD>

<% 
    
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
    String regionCode = org_code.substring(0,2);
	request.setCharacterEncoding("GBK");
	String s_Invoice_number=request.getParameter("s_Invoice_number1");
	String e_Invoice_number=request.getParameter("e_Invoice_number1");
	String Invoice_code=request.getParameter("Invoice_code1");
	String delete_number=request.getParameter("delete_number");
	String op_code="9493";	
    int i_end1 = Integer.parseInt(s_Invoice_number) - 1;
    int i_begin2 = Integer.parseInt(s_Invoice_number) + Integer.parseInt(delete_number);
    java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
    nf.setGroupingUsed(false);
    nf.setMaximumIntegerDigits(8);   
    nf.setMinimumIntegerDigits(8);
    String s_end1 = nf.format(i_end1);
    String s_begin2 = nf.format(i_begin2);

/*    String s_end1 = i_end1+"";
    String s_begin2 = i_begin2+"";
    
    int strLen = s_end1.length();
	while (strLen < e_Invoice_number.length()) {
		StringBuffer sb = new StringBuffer();
		sb.append("0").append(s_end1);//左补0
		s_end1 = sb.toString();
		strLen = s_end1.length();
	}
	
	strLen = s_begin2.length();
	while (strLen < e_Invoice_number.length()) {
		StringBuffer sb = new StringBuffer();
		sb.append("0").append(s_begin2);//左补0
		s_begin2 = sb.toString();
		strLen = s_begin2.length();
	}*/
    
System.out.println("------------------------------------s_end1:"+s_end1);
System.out.println("------------------------------------s_begin2:"+s_begin2);
    String result[][] = new String[][]{};
    
	
	%>
<wtc:service name="sInvoiceDtDB" routerKey="phone" routerValue="<%=regionCode%>" retmsg="retMsg" retcode="retCode1"  outnum="2" >
	<wtc:param value="<%=s_end1%>"/>
	<wtc:param value="<%=s_begin2%>"/>
	<wtc:param value="<%=e_Invoice_number%>"/>
	<wtc:param value="<%=Invoice_code%>"/>
	<wtc:param value="<%=work_no%>"/>
    <wtc:param value="<%=op_code%>"/>
</wtc:service>
<wtc:array id="sVerifyTypeArr" scope="end"/>
<%
	result = sVerifyTypeArr;
	if(result!=null&&result.length>0){
		//if(result[0][0].length()>0){
		 
		  if(result[0][0].length()>0)
	  {
		  if(result[0][0]=="000000" ||result[0][0].equals("000000"))
		  {
			  %>
			<script language="javascript">
			rdShowMessageDialog("发票信息删除成功");
			window.location.href="s9493_6.jsp";
			</script>
			<%	
		  }
		  else{
	%>
			<script language="javascript">
			rdShowMessageDialog("发票信息删除失败!错误原因："+"<%=retMsg%>"+";错误代码："+"<%=retCode1%>");
			window.location.href="s9493_6.jsp";
			</script>
			<%
	}	
	
			
		}
	}
	
%>
	 
<!--**************************************************************************************-->
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
    <BODY  ><!--onload="doPrint()"-->
          
    </BODY>
</FORM>


</HTML>    
