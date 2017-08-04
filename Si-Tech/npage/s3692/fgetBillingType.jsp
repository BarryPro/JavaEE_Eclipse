<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by leimd @ 2009-04-15
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>

<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String product_code = request.getParameter("product_code");
	String retType = request.getParameter("retType");
	String ret_message = "";
	String ret_code = "";
	String billingtype = "";
	
	System.out.println("luxc fgetBillingType.jsp product_code="+product_code);
	
	try
	{
		String[][] result  = null;
		String sqlStr = "";
		
		sqlStr="select b.billingtype "
			+"from sproductsrv a,sbillspcode b ,ssrvcode c "
			+"where a.service_code=b.srv_code "
			+"and a.service_code=c.service_code "
			+"and c.service_type='9' "
			+"and a.product_code=:product_code";
		
		String [] paraIn = new String[2];
		paraIn[0] = sqlStr;    
	    paraIn[1]="product_code="+product_code;
	%>
	    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
	    	<wtc:param value="<%=paraIn[0]%>"/>
	    	<wtc:param value="<%=paraIn[1]%>"/> 
	    </wtc:service>
	    <wtc:array id="retArr1" scope="end"/>
	<%
	    if(retCode1.equals("000000")){
	        result = retArr1;
	    }
		if (result != null && result.length != 0) 
		{
			billingtype = result[0][0];
		}
		else
		{
			/*
			ret_code = "000002";
			ret_message = "查询产品sbillspcode billingtype 失败,请检查产品配置!";
			*/
			billingtype = "9";
		}
		ret_code = "000000";
		System.out.println("luxc fgetBillingType.jsp billingtype="+billingtype);
	}
	catch(Exception e)
	{
		ret_code = "000001";
		ret_message = "查询产品sbillspcode billingtype 失败2,请检查产品配置!";
	}
%>


var response = new AJAXPacket();

var retType = "";
var retCode = "";
var retMessage = "";
var billingtype = "";

retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
billingtype = "<%=billingtype%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("billingtype",billingtype);

core.ajax.receivePacket(response);

