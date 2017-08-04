<%
  /*
   * 功能: 添加新帐号
　 * 版本: 1.0
　 * 日期: 2007-07-05 16:12
　 * 作者:zhanghb
　 * 版权: sitech
　*/
%> 
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

   
<% 
    int valid = 1;	//0:正确，1：系统错误，2：业务错误
    int rowNum=0;   //返回的行数
    String errorCode="444444";
    String errorMsg="系统错误，请与系统管理员联系，谢谢!!";        
	String retType=request.getParameter("retType");
	String account=request.getParameter("account");
	String prefix1=request.getParameter("prefix");
	String suffix=request.getParameter("suffix");
	String city_id=request.getParameter("city_id");
	String flag=request.getParameter("flag");
	String purpose=request.getParameter("purpose");
	String site_id=request.getParameter("site_id");
	String order_id=request.getParameter("order_id");
	String staff_id=request.getParameter("staff_id");
	String conn_flag =request.getParameter("conn_flag");
	String branch_no =request.getParameter("branch_no");
	String svc_inst_id =request.getParameter("svc_inst_id");
	String[][] result = null;
	System.out.println("prefix= "+prefix1);
	System.out.println("suffix= "+suffix);
	System.out.println("city_id= "+city_id);
	System.out.println("flag= "+flag);
	System.out.println("site_id= "+site_id);
	System.out.println("purpose= "+purpose);
%>
<wtc:service name="RBM_kd_xh02" outnum="0">
	<wtc:param value="<%=account%>"/>
	<wtc:param value="<%=prefix1%>"/>
	<wtc:param value="<%=suffix%>"/>
	<wtc:param value="<%=city_id%>"/>
	<wtc:param value="2"/>
	<wtc:param value="<%=site_id%>"/>
	<wtc:param value="<%=purpose%>"/>
	<wtc:param value="<%=staff_id%>"/>
	<wtc:param value="<%=order_id%>"/>
	<wtc:param value="<%=conn_flag%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=branch_no%>"/>
	<wtc:param value="2"/>
	<wtc:param value="<%=svc_inst_id%>"/>
</wtc:service>

<%
	System.out.println("\n call service RBM_kd_xh01 ,retCode =  " + retCode +", retMsg = "+ retMsg +"\n");	
    errorCode=retCode;
	errorMsg =retMsg;
%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("rowNum","<%=rowNum%>");
response.data.add("retCode","<%=errorCode%>");
response.data.add("retMessage","<%= errorMsg %>");
core.ajax.receivePacket(response);