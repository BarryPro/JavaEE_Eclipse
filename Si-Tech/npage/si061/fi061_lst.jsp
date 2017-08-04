<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
String rstStr = "";
if ( s_ajaxType.equals("fn_doQryMIfo") ) //返回字符串
{
	System.out.println("s_ajaxType="+s_ajaxType);
}
else if ( s_ajaxType.equals("setLst") ) //返回html
{
	String accept = request.getParameter( "logacc" );
	String chnSrc = request.getParameter( "chnSrc" );
	String opCode = request.getParameter( "opCode" );
	String workNo = request.getParameter( "workNo" );
	String passwd = request.getParameter( "passwd" );
	
	String phoNo = request.getParameter( "phoNo" );   
	String usrPwd = request.getParameter( "usrPwd" );
	String start_pos = request.getParameter( "start_pos" );
	String end_pos = request.getParameter( "end_pos" );
	String svc_name = "sSpBatchFileQry"; //sSpBatchFileQry sJQKTest
%>
	<wtc:service name = "<%=svc_name%>" outnum = "30" routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "retcode" retmsg = "retmsg" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			               
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
		<wtc:param value = "<%=start_pos%>"/>
		<wtc:param value = "<%=end_pos%>"/>
	</wtc:service>
	<wtc:array id="rst0" start = "0" length = "2" scope="end" />
	<wtc:array id="rst" start = "2" length = "3" scope="end" />	
	<TABLE ID = 'lst' >
		<tr>
			<TH ALIGN = "CENTER">用户号码</TH>    
			<TH ALIGN = "CENTER">错误代码</TH>     
			<TH ALIGN = "CENTER">错误原因</TH>         
		</tr>
<%
	if ( !retcode.equals( "000000" ) )
	{
	%>
		<TR>
			<TD ALIGN = "CENTER" colspan = '4' ><%=retcode%>:<%=retmsg%></TD>
		</TR>  	
	<%
	}
	else
	{
		if ( 0 == rst.length )
		{
			%>
				<TR>
					<TD ALIGN = "CENTER" colspan = '4' >无数据!</TD>
				</TR>  	
			<%
		}
		else
		{
			for ( int i=0;i<rst.length;i++ )
			{
			%>
				<TR>
					<TD ALIGN = 'CENTER'><%=rst[i][0]%></TD>
					<TD ALIGN = 'CENTER'><%=rst[i][1]%></TD>
					<TD ALIGN = 'CENTER'><%=rst[i][2]%></TD>
				</TR>        				
			<%
			}		
			%>
			<tr >
				<td  align = 'center' colspan = '3'>
					<font color = 'red'>
						成功条数：<%=rst0[0][0]%>，失败条数<%=rst0[0][1]%>，批量开通错误数据超过1000条，请通过后台导出!
					</font>
				</td>
			</tr>
		<%
		}
		%>
			<input id = 'succ_num' name = 'succ_num' value ='<%=rst0[0][0]%>' type = 'hidden'>
			<input id = 'fail_num' name = 'fail_num' value = '<%=rst0[0][1]%>' type = 'hidden'>
	<%
	}
	%>
	</TABLE>
<%
}
%>
