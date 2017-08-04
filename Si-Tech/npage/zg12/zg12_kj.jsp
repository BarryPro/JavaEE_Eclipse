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
	String op_code = "zg12";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "增值税专用发票开具";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	 
	//window.location="zg12_kj.jsp?List_tax_invoice_number="+List_tax_invoice_number+"&List_tax_invoice_code="+List_tax_invoice_code+"&List_tax_rate="+List_tax_rate+"&kpd="+ClientNo+"&ClientNo="+ClientNo+"&begin_tm="+begin_tm+"&end_tm="+end_tm+"&phone_no="+phone_no; 
	String tax_no1 = request.getParameter("tax_no1");
	//xl add
	String f_p = request.getParameter("f_p");
	String f_a = request.getParameter("f_a");
	String ClientNo =  request.getParameter("kpd");
	String phone_no = request.getParameter("phone_no");
	String begin_tm = request.getParameter("begin_tm");
	String end_tm = request.getParameter("end_tm");
	String s_sum_total = request.getParameter("s_sum_total");
	String[] inParas = new String[20];
	inParas[0] = ""; 
	inParas[1] = "02";//request.getParameter("List_tax_invoice_number"); 
	inParas[2] = op_code;//
	inParas[3] = work_no;
	inParas[4]=	 pass;
	inParas[5]=  phone_no;
    inParas[6]=	 "";
	inParas[7]=  "专票开具";
	inParas[8]="";
	inParas[9]= begin_tm;
	inParas[10]= end_tm;
	inParas[11]=s_sum_total;//"";//金额+税额的总和 s_sum_total
	inParas[12]=request.getParameter("List_tax_rate");;
	inParas[13]=request.getParameter("List_tax_invoice_number");
	inParas[14]=request.getParameter("List_tax_invoice_code");
	inParas[15]=ClientNo;
	inParas[16]=work_no;
	//1->购机款
	//成员号码 多值
	//原业务流水 多值逗号分隔
	inParas[17]="1";
	inParas[18]=f_p;
	inParas[19]=f_a;
 
 
%>
<wtc:service name="bs_yxPrintCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
    <wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	<wtc:param value="<%=inParas[10]%>"/>
	<wtc:param value="<%=inParas[11]%>"/>
	<wtc:param value="<%=inParas[12]%>"/>
	<wtc:param value="<%=inParas[13]%>"/>
	<wtc:param value="<%=inParas[14]%>"/>
	<wtc:param value="<%=inParas[15]%>"/>
	<wtc:param value="<%=inParas[16]%>"/>
	<wtc:param value="<%=inParas[17]%>"/>
	<wtc:param value="<%=inParas[18]%>"/>
	<wtc:param value="<%=inParas[19]%>"/>
	<wtc:param value="<%=tax_no1%>"/>
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
	rdShowMessageDialog("增值税专票开具办理成功！");
	window.location="zg12_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("增值税专票开具办理失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="zg12_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%}
%>

