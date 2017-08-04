<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( ajaxType.equals("setLst") ) //返回html
{
	String accept = request.getParameter( "logacc" );
	String chnSrc = request.getParameter( "chnSrc" );
	String opCode = request.getParameter( "opCode" );
	String workNo = request.getParameter( "workNo" );
	String passwd = request.getParameter( "passwd" );
	
	String phoNo = request.getParameter( "phoNo" );   
	String usrPwd = request.getParameter( "usrPwd" );
	String opNote = request.getParameter( "opNote" );
	String fromWay = request.getParameter( "fromWay" );
	String tm_b = request.getParameter( "tm_b" );
	
	String tm_e = request.getParameter( "tm_e" );
	String op_type = request.getParameter( "op_type" );
	String op_login = request.getParameter( "op_login" );

%>
	<wtc:service name = "sG956Qry" outnum = "30" routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "retcode" retmsg = "retmsg" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			               
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
		<wtc:param value = "<%=opNote%>"/>
		<wtc:param value = "<%=fromWay%>"/>
		<wtc:param value = "<%=tm_b%>"/>
			
		<wtc:param value = "<%=tm_e%>"/>
		<wtc:param value = "<%=op_type%>"/>
		<wtc:param value = "<%=op_login%>"/>
	</wtc:service>
	<wtc:array id = "rst" scope = "end" />
	<input type = 'hidden' id = 'retcode' name = 'retcode' value = '<%=retcode%>' >
	<input type = 'hidden' id = 'retmsg' name = 'retmsg' value = '<%=retmsg%>' >
	
	<TABLE ID = '' >
		<TH ALIGN = "CENTER">操作时间</TH>    
		<TH ALIGN = "CENTER">受理号码</TH>          
		<TH ALIGN = "CENTER">归属地市</TH>          
		<TH ALIGN = "CENTER">操作工号</TH>          
		<TH ALIGN = "CENTER">操作方式</TH>          

<%
	if ( !retcode.equals( "000000" ) )
	{
	%>
		<TR>
			<TD ALIGN = "CENTER"><%=retcode%>:<%=retmsg%></TD>
		</TR>  	
	<%
	}
	else
	{
		for ( int i=0;i<rst.length;i++ )
		{
		/* update for 关于优化客服CRM系统功能七月份第六次需求的函@2014/9/4 */
		/*
		%>
			<TR>
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = 'op_tm' VALUE = '<%=rst[i][0]%>' CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = 'op_phone' VALUE = '<%=rst[i][1]%>' CLASS = 'InputGrey' readOnly >
				</TD>				
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = 'reg_name' VALUE = '<%=rst[i][2]%>' CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = 'op_login' VALUE = '<%=rst[i][3]%>' CLASS = 'InputGrey' readOnly >
				</TD>				
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = 'op_type' VALUE = '<%=(rst[i][4].equals("0")?"添加":"删除")%>      
						' CLASS = 'InputGrey' readOnly >
				</TD>				
			</TR>        
		<%
		*/
		%><TR>
				<TD ALIGN = 'CENTER'>
					<%=rst[i][0]%>
				</TD>
				<TD ALIGN = 'CENTER'>
					<%=rst[i][1]%>
				</TD>
				<TD ALIGN = 'CENTER'>
					<%=rst[i][2]%>
				</TD>
				<TD ALIGN = 'CENTER'>
					<%=rst[i][3]%>
				</TD>
				<TD ALIGN = 'CENTER'>
					<%=(rst[i][4].equals("0")?"添加":"删除")%>
				</TD>				
			</TR>
		<%
		}
	}
	%>
	</TABLE>
<%
}
%>
