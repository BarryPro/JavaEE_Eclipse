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
    String workno = (String)session.getAttribute("workNo");
	String tax_number = request.getParameter("tax_number");   
	String tax_code = request.getParameter("tax_code");  
	String cust_id = request.getParameter("cust_id");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String[] inParas2 = new String[5];
	inParas2[0]=tax_number;
	inParas2[1]=tax_code;
	inParas2[2]=cust_id;
	inParas2[3]="zg24";
	inParas2[4]=workno;
	 
	//调用chenhu接口 查询展示
	String s_good_name="";//货物名称
	String s_ggxh="";//规格型号
	String s_dw="";//单位
	String s_sl="";//数量
	String s_dj="";//单价
	String s_je="";//金额
	String s_tax_rate="";//税率
	String s_se="";//税额
	String s_flag="";
	/*
	s_good_name="联想手机";
	s_ggxh="I9100";
	s_dw="台";
	s_sl="1";
	s_dj="1200";
	s_je="1200";
	s_tax_rate="17%";
	s_se="34";
	*/
	
%>
<wtc:service name="bs_zg24init" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="12">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	<wtc:param value="<%=inParas2[2]%>"/>
	<wtc:param value="<%=inParas2[3]%>"/>
	<wtc:param value="<%=inParas2[4]%>"/>
</wtc:service>
<wtc:array id="ret_val" scope="end" start="0"  length="2" /> 
<wtc:array id="tax_msg" scope="end" start="2"  length="8" />	
<wtc:array id="all_msg" scope="end" start="10"  length="2" />
<%
	if(ret_val.length>0)
	{
		if(ret_val=="000000" || ret_val.equals("000000"))
		{
			s_flag="Y";

		}	
		else
		{
			s_flag="N";
		}
	}
	else
	{
		s_flag="N";
	}
%>
 
var response = new AJAXPacket();
 
var s_flag="Y"; 
var s_good_name = "<%=s_good_name%>";
var s_ggxh = "<%=s_ggxh%>";
var s_dw  = "<%=s_dw%>";
var s_sl  = "<%=s_sl%>";
var s_dj  = "<%=s_dj%>";
var s_je  = "<%=s_je%>";
var s_tax_rate  = "<%=s_tax_rate%>";
var s_se  = "<%=s_se%>";
response.data.add("s_flag",s_flag);
response.data.add("s_good_name",s_good_name);
response.data.add("s_ggxh",s_ggxh);
response.data.add("s_dw",s_dw); 
response.data.add("s_sl",s_sl); 
response.data.add("s_dj",s_dj); 
response.data.add("s_je",s_je); 
response.data.add("s_tax_rate",s_tax_rate); 
response.data.add("s_se",s_se); 
core.ajax.receivePacket(response);



 
