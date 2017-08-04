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
	String op_code = "zg23";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "增值税专用发票开具申请";//request.getParameter("op_note");              //备注
	String xfxx = request.getParameter("xfxx");
	
	String work_no = (String)session.getAttribute("workNo");       
 
	//s_tax_id="+s_tax_id+"&="+s_phone_no+"&="+begindate+"& 
 
	String s_tax_id =  request.getParameter("s_tax_id");
	String s_phone_no = request.getParameter("s_phone_no");
	String begindate = request.getParameter("begindate");
	String enddate = request.getParameter("enddate");
	
	String spr = request.getParameter("spr");
	String lxr_phone = request.getParameter("lxr_phone");
	 
	String tax_name = request.getParameter("tax_name");
	String tax_no1 = request.getParameter("tax_no1");
	String tax_address = request.getParameter("tax_address");
	String tax_phone = request.getParameter("tax_phone");
	String tax_khh = request.getParameter("tax_khh");
	String tax_contract_no = request.getParameter("tax_contract_no");
	//xl add q_flag
	String q_flag = request.getParameter("q_flag");
	String bzxx =  request.getParameter("bzxx");
	String[] inParas = new String[16];
	//s_tax_id="2303031962091046161"; 
	inParas[0] = op_code; 
	inParas[1] = work_no;//request.getParameter("List_tax_invoice_number"); 
	inParas[2] = s_tax_id;//
	inParas[3] = s_phone_no;
	inParas[4]=	 "0";
	inParas[5]=  begindate;
    inParas[6]=	 enddate;
	inParas[7]=	 spr;
	inParas[8]=	 lxr_phone;
	inParas[9]=  tax_name;	
	inParas[10]=  tax_no1;
	inParas[11]= tax_address;
	inParas[12]= tax_phone;
	inParas[13]= tax_khh;
	inParas[14]= tax_contract_no;
	inParas[15]= q_flag;
%>
<wtc:service name="szg23Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
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
	<wtc:param value="<%=bzxx%>"/>
	<wtc:param value="<%=xfxx%>"/>
	
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
	rdShowMessageDialog("增值税专票开具申请成功！");
	//window.location="zg23_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	removeCurrentTab();
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("增值税专票开具申请失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	//window.location="zg23_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	removeCurrentTab();
	</script>
<%}
%>

