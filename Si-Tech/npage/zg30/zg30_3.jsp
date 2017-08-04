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
	String op_code = "zg30";//需要新申请             //操作代码
	String op_note = "发票传递";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	//分为 集团联系人和 重要成员两种   

	String zp_numberArrays[]=request.getParameterValues("zp_numberArrays");   
	String zp_codeArrays[]=request.getParameterValues("zp_codeArrays");
	String zp_zdArrays[]=request.getParameterValues("zp_zdArrays");
	String zp_kprArrays[]=request.getParameterValues("zp_kprArrays");
	String zp_ztArrays[]=request.getParameterValues("zp_ztArrays");
	
	String sprid = request.getParameter("sprid");
	String lxr_phone = request.getParameter("lxr_phone");
	String zp_number="";
	String zp_code="";
	String zp_zd="";
	String zp_kpr="";	
	String zp_zt="";
	
	String s_year_month= request.getParameter("s_year_month");
    
	for(int i =0;i<zp_numberArrays.length;i++)
	{
		zp_number+=zp_numberArrays[i];
		zp_code+=zp_codeArrays[i];
		zp_zd+=zp_zdArrays[i];
		zp_kpr+=zp_kprArrays[i];
		zp_zt+=zp_ztArrays[i];
	}
	
 
 
	 
	//String sysAccept = request.getParameter("sysAccept");
	 
	String paraAray[] = new String[9]; 
	paraAray[0] = zp_number;
	paraAray[1] = zp_code;
	paraAray[2] = zp_zd;
	paraAray[3] = zp_zt;
	paraAray[4] = zp_kpr;//应该是"开具人数组";
	paraAray[5] = work_no;//申请人
	paraAray[6] = sprid;
	paraAray[7] = lxr_phone;  
	paraAray[8] = "zg30";
	 
%>
<wtc:service name="bs_DealCntt" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/> 
    <wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=s_year_month%>"/>
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
	rdShowMessageDialog("办理成功！");
	window.location="zg30_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="zg30_1.jsp?opCode=asdf&opName=集团客户缴费通知";
	</script>
<%}
%>

