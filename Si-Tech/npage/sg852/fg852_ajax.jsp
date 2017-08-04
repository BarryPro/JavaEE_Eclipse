<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("fn_doQryMIfo") ) //返回字符串
{
	System.out.println("s_ajaxType~~"+s_ajaxType);
}
else if (s_ajaxType.equals("getIfo")) //返回html
{
	String accept = request.getParameter( "logacc" );
	String chnSrc = request.getParameter( "chnSrc" );
	String opCode = request.getParameter( "opCode" );
	String workNo = ( String ) session.getAttribute( "workNo" );
	String passwd = ( String ) session.getAttribute( "password" );
	
	String phoNo = request.getParameter( "phoNo" );   
	String usrPwd = "";
	String biz_type = "ZY";
	String sp_id = "045105";
	String biz_cfode = "ZY0501";
	
	String iOprCode = "02";
	String eff_date = request.getParameter( "opTime" );
	String exp_date = "20501231000000";
	String op_time = eff_date;	
	String opNote = opCode + request.getParameter("opName");
	
	String Account = request.getParameter( "Account" );
	String remark = "2";
	String BusiType = "1021";
	
%>
	<wtc:service name="sProWorkFlowCfm" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" retcode="rc" retmsg="rm" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
		<wtc:param value = "<%=biz_type%>"/>
		<wtc:param value = "<%=sp_id%>"/>
		<wtc:param value = "<%=biz_cfode%>"/>
			
		<wtc:param value = "<%=iOprCode%>"/>
		<wtc:param value = "<%=eff_date%>"/>
		<wtc:param value = "<%=exp_date%>"/>
		<wtc:param value = "<%=op_time%>"/>
		<wtc:param value = "<%=opNote%>"/>
			
		<wtc:param value = "<%=Account%>"/>
		<wtc:param value = "<%=remark%>"/>
		<wtc:param value = "<%=BusiType%>"/>
	</wtc:service>
	<wtc:array id="rst" scope="end" />

	<%
	if (rc.equals("000000"))
	{
	%>   
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc%>");
		response.data.add("oRetMsg"  ,"<%=rm%>");
		response.data.add("oJsn"  ,'<%=rst[0][0]%>');
		core.ajax.receivePacket(response);	
	<%
	}
	else
	{
	%>
		var response = new AJAXPacket();
		response.data.add("oRetCode" ,"<%=rc%>");
		response.data.add("oRetMsg"  ,"<%=rm%>");
		core.ajax.receivePacket(response);	
	<%	
	}
}
%>
		
