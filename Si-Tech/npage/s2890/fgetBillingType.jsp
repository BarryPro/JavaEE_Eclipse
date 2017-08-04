
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%


String product_code = request.getParameter("product_code");
String retType = request.getParameter("retType");
String regionCode = (String)session.getAttribute("regCode");
String ret_message = "";
String ret_code = "";
String billingtype = "";
int i=0;
// i = product_code.indexOf("|"); //得到主产品代码
// product_code = product_code.substring(0, i);
System.out.println("luxc fgetBillingType.jsp product_code="+product_code);

try
{

	String sqlStr = "";
	
	
	/*
	sqlStr="select b.billingtype "
		+"from sproductsrv a,sbillspcode b ,ssrvcode c "
		+"where a.service_code=b.srv_code "
		+"and a.service_code=c.service_code "
		+"and c.service_type='9' "
		+"and a.product_code='"+product_code+"'";
	*/
	sqlStr="select billingtype from sBillSpCode " 
		+ "where  BIZCODEADD ='" + product_code+"'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="errorCode" retmsg="errorMsg" outnum="4">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />

 <%	
	if (result != null && result.length != 0) 
	{
		billingtype = result[0][0];
	}
	else
	{
		ret_code = "000002";
		ret_message = "产品配置错误,请检查产品配置!";
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

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("billingtype",billingtype);

core.ajax.receivePacket(response);

