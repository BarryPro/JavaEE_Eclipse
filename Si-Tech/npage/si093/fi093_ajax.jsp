<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( ajaxType.equals("setBizCode") ) //返回字符串
{
	String biz_type=request.getParameter("biz_type");
	
	String sql_biz = "SELECT pack_code,pack_name FROM swlanmode  "
		+ "where pack_type = :packType "
		+ " GROUP BY pack_code,pack_name ";
	String sql_param = "packType="+biz_type;
	%>
	<wtc:service name="TlsPubSelCrm" outnum="2"
		routerKey="region" routerValue="<%=regCode%>"  
		retcode="retCode" retmsg="retMsg" >
		<wtc:param value="<%=sql_biz%>"/>
		<wtc:param value="<%=sql_param%>"/>
	</wtc:service>
	<wtc:array id="rst" scope="end" />
	<%
	if (retCode.equals("000000"))
	{
	%>
		var arr_code = new Array();
		var arr_name = new Array();
		<%
		for ( int i = 0 ; i < rst.length ; i ++ )
		{
		%>
			arr_code["<%=i%>"] = "<%=rst[i][0]%>";
			arr_name["<%=i%>"] = "<%=rst[i][1]%>";
		<%
		}
		%>   
		var response = new AJAXPacket();
		response.data.add("retCode" , "<%=retCode%>");
		response.data.add("retMsg"  , "<%=retMsg%>");
		response.data.add("arr_code"  , arr_code );
		response.data.add("arr_name"  , arr_name );
		core.ajax.receivePacket(response);    
	<%
	}
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("retCode" ,"<%=retCode%>");
		response.data.add("retMsg"  ,"<%=retMsg%>");
		core.ajax.receivePacket(response);  
	<%    
	}
}
else if ( ajaxType.equals("setLst") ) //返回html
{
	System.out.println( "ajaxType = " + ajaxType);
}
%>
