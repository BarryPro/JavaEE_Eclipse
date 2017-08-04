<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
    String tax_number = request.getParameter("tax_number");   
	String tax_code = request.getParameter("tax_code");  
	  
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String[] inParas2 = new String[2];
	//xl 改为月分表查询
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String s_year_month = dateStr.substring(0,6);
	String s_dinvoicecnt = "dinvoiceprint"+s_year_month;
	 
	inParas2[0]="select to_char(count(*)) from "+s_dinvoicecnt+" where tax_invoice_num=:s_no and tax_invoice_code=:s_code and invoice_flag='5' and invoice_type='1' ";//已传递
	inParas2[1]="s_no="+tax_number+",s_code="+tax_code;	
%>
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=org_code.substring(0,2)%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
</wtc:service>
<wtc:array id="ret_val" scope="end" /> 
<%
	String s_flag="";
	String s_count="";
	if(ret_val.length>0)
	{
		s_flag="Y";
		s_count=ret_val[0][0];
	}
	else
	{
		s_flag="Y";
	}
%>
 
var response = new AJAXPacket();
 
var s_flag= "<%=s_flag%>";
var s_count = "<%=s_count%>";
 
response.data.add("s_flag",s_flag);
response.data.add("s_count",s_count);

core.ajax.receivePacket(response);



 
