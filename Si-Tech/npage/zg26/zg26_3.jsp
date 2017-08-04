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
	String op_code = "zg26";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "增值税红字发票开具";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	 
	 
   //window.location="zg26_3.jsp?lz_hm="+lz_hm+"&lz_dm="+lz_dm+"&invoice_code="+invoice_code+"&invoice_number="+invoice_number+"&kp_loginaccept="+kp_loginaccept;
 
	String invoice_number = request.getParameter("invoice_number");
	String invoice_code = request.getParameter("invoice_code"); 
	String kp_loginaccept = request.getParameter("kp_loginaccept");
	String lz_hm = request.getParameter("lz_hm");
	String lz_dm = request.getParameter("lz_dm"); 
 
    String year_month = request.getParameter("year_month");
	 

 
 
%>
<wtc:service name="bs_zg26Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
	<wtc:param value="<%=lz_hm%>"/>
	<wtc:param value="<%=lz_dm%>"/>
	<wtc:param value="<%=invoice_number%>"/>
	<wtc:param value="<%=invoice_code%>"/>
	<wtc:param value="<%=op_code%>"/>
    <wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=kp_loginaccept%>"/>
	<wtc:param value="0"/>
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
	rdShowMessageDialog("红字专票开具办理成功！");
	window.location="zg26_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("红字专票开具办理失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="zg26_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%}
%>

