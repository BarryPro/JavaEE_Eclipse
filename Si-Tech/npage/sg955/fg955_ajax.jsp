<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*��ҳ�洫�ݵĲ���*/
String ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( ajaxType.equals("setLst") ) //����html
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
	</wtc:service>
	<wtc:array id = "rst" scope = "end" />
	<input type = 'hidden' id = 'retcode' name = 'retcode' value = '<%=retcode%>' >
	<input type = 'hidden' id = 'retmsg' name = 'retmsg' value = '<%=retmsg%>' >
	
	<TABLE ID = '' >
		<TH ALIGN = "CENTER">��ǰ״̬</TH>          

<%
	if ( !retcode.equals( "000000" ) )
	{
		if("G95604".equals(retcode)){
	%>
		<TR>
			<TD ALIGN = "CENTER" >��ǰ�ɽ���</TD>
		</TR>  	
	<%
		}
	else{
		%>
		<TR>
			<TD ALIGN = "CENTER" ><%=retcode%>:<%=retmsg%></TD>
		</TR>
		<%
		
		}
	}
	else
	{

	
		for ( int i=0;i<rst.length;i++ )
		{
		%>
			<TR>
				<TD ALIGN = 'CENTER'>          
					<%=("0".equals(rst[0][0])?"��ǰ���ɽ���":"��ǰ�ɽ���")%>      
					<INPUT TYPE = 'hidden' ID ='l_type' VALUE = '<%=rst[0][0]%>' CLASS = 'InputGrey' readOnly >
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
