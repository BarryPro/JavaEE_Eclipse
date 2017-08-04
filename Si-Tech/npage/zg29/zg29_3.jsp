<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = "zg29";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "增值税专票作废";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	 
	String year_month = request.getParameter("year_month"); 
 
 
 
	String tax_invoice_number = request.getParameter("tax_invoice_number");
	String tax_invoice_code = request.getParameter("tax_invoice_code"); 
	String hz_hm="";
	String hz_dm="";
	String s_notice_no="";
	String s_query_type="1";
 
	 

 
 
%>
<wtc:service name="bs_zg26Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
	<wtc:param value="<%=tax_invoice_number%>"/>
	<wtc:param value="<%=tax_invoice_code%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=op_code%>"/>
    <wtc:param value="<%=work_no%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=s_query_type%>"/>
	<wtc:param value="<%=year_month%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = s4141CfmMsg;
	if ( s4141CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("专票作废开具办理成功！");
	window.location="zg29_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("专票作废开具办理失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="zg29_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%}
%>

