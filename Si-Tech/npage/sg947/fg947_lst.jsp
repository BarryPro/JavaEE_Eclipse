<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*��ҳ�洫�ݵĲ���*/
String ajaxType = request.getParameter("ajaxType");
String regCode = (String)session.getAttribute("regCode");

if ( ajaxType.equals("test") ) //�����ַ���
{
	System.out.println("test~~~~`");
}
else if ( ajaxType.equals("setLst") ) //����html
{
	String accept = request.getParameter( "logacc" );
	String chnSrc = request.getParameter( "chnSrc" );
	String opCode = request.getParameter( "opCode" );
	String workNo = request.getParameter( "workNo" );
	String passwd = request.getParameter( "passwd" );
	
	String phoNo = request.getParameter( "phoNo" );   
	String usrPwd = request.getParameter( "usrPwd" );
	String pho_no1 = request.getParameter( "pho_no1" );
	String pho_no2 = request.getParameter( "pho_no2" );
%>
	<wtc:service name = "sPtpPhoneQry" outnum = "30" routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "retcode" retmsg = "retmsg" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			               
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
		<wtc:param value = "<%=pho_no1%>"/>
		<wtc:param value = "<%=pho_no2%>"/>
	</wtc:service>
	<wtc:array id = "rst" scope = "end" />
		
	<TABLE ID = '' >
		<TH ALIGN = "CENTER">Ͷ�ߺ���</TH>    
		<TH ALIGN = "CENTER">�������к���</TH>
		<TH ALIGN = "CENTER">�ٱ�����</TH>     
		<TH ALIGN = "CENTER">����</TH>   

<%
	if ( !retcode.equals( "000000" ) )
	{
	%>
		<TR>
			<TD ALIGN = "CENTER" colspan = '4'>�������:<%=retcode%>:<%=retmsg%></TD>
		</TR>  	
	<%
	}
	else
	{
		if(rst.length == 0 ){
		%>
		<TR>
			<TD ALIGN = "CENTER" colspan = '4'>������!</TD>
		</TR>
		<%
		}
		for ( int i=0;i<rst.length;i++ )
		{
		%>
			<TR>
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = 'l_pho1<%=i%>' VALUE = '<%=rst[i][0]%>' CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='l_pho2<%=i%>' VALUE = '<%=rst[i][1]%>' CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='l_pho3<%=i%>' VALUE = '<%if("1".equals(rst[i][2])){out.print("��Ե���������");}%><%if("2".equals(rst[i][2])){out.print("��Ե���������");}%>' CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'BUTTON' ID ='' VALUE = 'ɾ��' CLASS = 'b_text' onClick = 'del( <%=i%> )' >
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