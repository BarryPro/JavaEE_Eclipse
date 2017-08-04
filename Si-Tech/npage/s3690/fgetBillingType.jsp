<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
String regCode = (String)session.getAttribute("regCode");

String product_code = request.getParameter("product_code");
String retType = request.getParameter("retType");
String ret_message = "";
String ret_code = "";
String billingtype = "";
String baseservcode="";
String bizattrtype="";
int i=0;
//i = product_code.indexOf("|"); //得到主产品代码
//product_code = product_code.substring(0, i);
System.out.println("luxc fgetBillingType.jsp product_code="+product_code);

try
{
	//String[][] result  = null;
	String sqlStr = "";
	String[] inParams = new String[2];
	
	
	/*
	sqlStr="select b.billingtype "
		+"from sproductsrv a,sbillspcode b ,ssrvcode c "
		+"where a.service_code=b.srv_code "
		+"and a.service_code=c.service_code "
		+"and c.service_type='9' "
		+"and a.product_code='"+product_code+"'";
	*/
	//sqlStr="select billingtype from sBillSpCode " 
		//+ "where  BIZCODEADD ='" + product_code+"'";
	//inParams[0] = "select billingtype from sBillSpCode " 
		//+ "where  BIZCODEADD =:product_code";
	//inParams[0] ="select a.BillingType,b.baseservcode,a.bizattrtype from dBaseEcSIBusiadd a,dBaseEcSIBusi b " 
	    //+ "where  a.BizCode =:product_code and a.BizCode=b.BizCode " ;
	  inParams[0] ="select billingtype,accessnumber,bizstatus "
            +" from sbillspcode where bizcodeadd = :product_code ";
	inParams[1] = "product_code="+product_code;
	//result = (String[][])callView.sPubSelect("1",sqlStr).get(0);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%
    ret_code = retCode1;
	ret_message = retMsg1;
	if (result != null && result.length != 0) 
	{
		billingtype = result[0][0];
		baseservcode= result[0][1];
		bizattrtype=result[0][2];
	}
	else
	{
		ret_code = "000002";
		ret_message = "产品配置错误,请检查产品配置!";
	}
	System.out.println("luxc fgetBillingType.jsp billingtype="+billingtype);
}
catch(Exception e)
{
	ret_code = "000001";
	ret_message = "查询产品sbillspcode billingtype 失败2,请检查产品配置!";
}
System.out.println("# ret_code = "+ret_code);
System.out.println("# ret_message = "+ret_message);
%>


var response = new AJAXPacket();

var retType = "";
var retCode = "";
var retMessage = "";
var billingtype = "";
var baseservcode="";
var bizattrtype="";

retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
billingtype = "<%=billingtype%>";
baseservcode = "<%=baseservcode%>";
bizattrtype = "<%=bizattrtype%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("billingtype",billingtype);
response.data.add("baseservcode",baseservcode);
response.data.add("bizattrtype",bizattrtype);

core.ajax.receivePacket(response);

