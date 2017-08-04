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
	String op_code =request.getParameter("opCode");// "zg12";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "增值税专用发票开具";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	 
	//window.location="zg12_kj.jsp?List_tax_invoice_number="+List_tax_invoice_number+"&List_tax_invoice_code="+List_tax_invoice_code+"&List_tax_rate="+List_tax_rate+"&kpd="+ClientNo+"&ClientNo="+ClientNo+"&begin_tm="+begin_tm+"&end_tm="+end_tm+"&phone_no="+phone_no; 
	String ClientNo =  request.getParameter("kpd");
	String phone_no = request.getParameter("phone_no");
	String yj_date = request.getParameter("yj_date");
	String yj_end_date = request.getParameter("yj_end_date");
	//print_sum_money="+print_sum_money+"&print_accept="+print_accept+"&print_ym="+print_ym
	String print_sum_money = request.getParameter("print_sum_money");
	String print_accept = request.getParameter("print_accept");
	String print_ym = request.getParameter("print_ym");
	
	//xl add 改为20个入参
	String s_all_spmc = request.getParameter("s_all_spmc");
	String s_all_je = request.getParameter("s_all_je");
	String s_all_se = request.getParameter("s_all_se");
	//xl add for bianlili 增加纳税人识别号
	String tax_no1 = request.getParameter("tax_no1");
	String[] inParas = new String[21];
	inParas[0] = print_accept;
	inParas[1] = "02";//request.getParameter("List_tax_invoice_number"); 
	inParas[2] = op_code;//
	inParas[3] = work_no;
	inParas[4]=	 pass;
	inParas[5]=  phone_no;//一点支付账号
    inParas[6]=	 "";
	inParas[7]=  "月结专票开具";
	inParas[8]=	 "";
	inParas[9]= yj_date;
	inParas[10]=yj_end_date;
	inParas[11]=print_sum_money;
	inParas[12]=request.getParameter("List_tax_rate");;
	inParas[13]=request.getParameter("List_tax_invoice_number");
	inParas[14]=request.getParameter("List_tax_invoice_code");
	inParas[15]=ClientNo;
	inParas[16]=work_no;
	//add 入参
	inParas[17]="";
	inParas[18]=s_all_spmc;
	inParas[19]=s_all_je;
	inParas[20]=s_all_se;
 
 
%>
<wtc:service name="bs_TaxMmCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
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
	<wtc:param value="<%=inParas[20]%>"/>
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
	//window.location="zg12_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	removeCurrentTab();
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("增值税专票开具办理失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	//window.location="zg12_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	removeCurrentTab();
	</script>
<%}
%>

