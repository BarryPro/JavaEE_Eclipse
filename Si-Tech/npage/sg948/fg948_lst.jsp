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
	
	String phoNo = request.getParameter( "pho_no1" );
	String pho_no2 = request.getParameter( "pho_no2" );      
	String usrPwd = request.getParameter( "usrPwd" );
	String time_b = request.getParameter( "time_b" );
	String time_e = request.getParameter( "time_e" );
	String pho_no1 = request.getParameter( "pho_no1" );
	
%>
	<wtc:service name = "sPtpMonthQry" outnum = "30" routerKey = "region" routerValue = "<%=regCode%>" 
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
		<wtc:param value = "<%=time_b%>"/>
			
		<wtc:param value = "<%=time_e%>"/>			
	</wtc:service>
	<wtc:array id = "rst" scope = "end" />
		
	<TABLE ID = '' >
		<TH ALIGN = "CENTER">Ͷ�ߺ���</TH>    
		<TH ALIGN = "CENTER">�������к���</TH>    		
		<TH ALIGN = "CENTER">������ʶ</TH>    
		<TH ALIGN = "CENTER">����ʱ��</TH>    
		<TH ALIGN = "CENTER">��������</TH>
		<TH ALIGN = "CENTER">�ٱ�����</TH>     

<%
	if ( !retcode.equals( "000000" ) )
	{	
	%>
		<TR>
			<TD ALIGN = "CENTER" colspan = '7'>�������:<%=retcode%>:<%=retmsg%></TD>
		</TR>  	
	<%
	}
	else
	{
		if (rst.length == 0)
		{
		%>
			<TR>
				<TD ALIGN = "CENTER" colspan = '7'>������!</TD>
			</TR>  	
		<%
		}
		else
		{
			for ( int i=0;i<rst.length;i++ )
			{
				if ( rst[i][2].equals("A") )
				{
					rst[i][2] = "����";
				}
				else if ( rst[i][2].equals("D") )
				{
					rst[i][2] = "ɾ��";
				}
			%>
				<TR>
					<TD ALIGN = 'CENTER'>
						<INPUT TYPE ='TEXT' ID = 'l_pho1<%=i%>' VALUE = '<%=rst[i][0]%>' class = 'InputGrey' readOnly >
					</TD>
					<TD ALIGN = 'CENTER'>                
						<INPUT TYPE = 'TEXT' ID ='l_pho2<%=i%>' VALUE = '<%=rst[i][1]%>' class = 'InputGrey' readOnly >
					</TD>
					<TD ALIGN = 'CENTER'>
						<INPUT TYPE ='TEXT' ID = 'opr_flag<%=i%>' VALUE = '<%=rst[i][2]%>' class = 'InputGrey' readOnly >
					</TD>
					<TD ALIGN = 'CENTER'>                
						<INPUT TYPE = 'TEXT' ID ='op_time<%=i%>' VALUE = '<%=rst[i][3]%>' class = 'InputGrey' readOnly >
					</TD>		
					<TD ALIGN = 'CENTER'>                
						<INPUT TYPE = 'TEXT' ID ='op_workNo<%=i%>' VALUE = '<%=rst[i][4]%>' class = 'InputGrey' readOnly >
					</TD>
					<TD ALIGN = 'CENTER'>                
						<INPUT TYPE = 'TEXT' ID ='op_type<%=i%>' VALUE = '<%if("1".equals(rst[i][5])){out.print("��Ե���������");}%><%if("2".equals(rst[i][5])){out.print("��Ե���������");}%>' class = 'InputGrey' readOnly >
					</TD>						
				</TR>        
			<%
			}
		}
	}
	%>
	</TABLE>
<%
}
%>