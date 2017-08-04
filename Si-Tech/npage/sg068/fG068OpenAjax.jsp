<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String regCode=(String)session.getAttribute("regCode");
String ajaxType=request.getParameter("ajaxType");

if ( ajaxType.equals("chkImei") )
{
	String strImei=request.getParameter("imeiNo");
	System.out.println("e889~~~~imeiNo="+strImei);
	String sqlChkPho=" select count(*)  "
	+" from wmachsndopr t   "  
	+" where 1=1 "
	+"  and  sysdate between t.bx_begin and t.bx_end "  
	+" and t.back_flag = '0' and trim( t.imei_no)=trim( '"+strImei+"'  )"  
	+" and t.op_code = 'g068'";
	System.out.println("g068~~~~~"+sqlChkPho);
%>
	
	<wtc:pubselect name="sPubSelect"  retcode="retCode" retmsg="retMsg" outnum="1">
		<wtc:sql><%=sqlChkPho%>
	</wtc:sql>
	</wtc:pubselect>
	<wtc:array id="rstChkImei" scope="end"/>	
	<%
	if (!rstChkImei[0][0].equals("0") )
	{%>
		var response = new AJAXPacket();
		response.data.add("retCode","000001");
		response.data.add("retMsg","该IMEI码已经办理过该营销案,不能重复办理!");		
	<%
	}	
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("retCode","000000");
		response.data.add("retMsg","success");		
	<%	
	}
}
else if ( ajaxType.equals("chkImei1") )
{
	String retType=request.getParameter("retType");
	String strImei=request.getParameter("imeiNo");
	String strSaleCode=request.getParameter("sale_code");

	String sqlChkPho1=" select count(1)  "
		+" from  dphonesalecode  a , dbchnterm.schnrescodetac  b "
		+" where a.type_code=b.res_code  and region_code='"+regCode+"' "
		+"and valid_flag='Y' and  a.sale_code='"+strSaleCode+"' and b.tac_code = substr( '"+strImei+"' ,0,8 )";
%>	
	<wtc:pubselect name="sPubSelect"  retcode="retResult" retmsg="retMsg" outnum="1">
		<wtc:sql><%=sqlChkPho1%>
	</wtc:sql>
	</wtc:pubselect>
	<wtc:array id="rstChkImei1" scope="end"/>	
	<%
	if (!rstChkImei1[0][0].equals("0") )
	{%>
		var response = new AJAXPacket();
		response.data.add("retResult","000000");
		response.data.add("retMsg","<%=retType%>");		
	<%
	}	
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("retResult","000003");
		response.data.add("retType","<%=retType%>");		
	<%	
	}	
}
%>
		