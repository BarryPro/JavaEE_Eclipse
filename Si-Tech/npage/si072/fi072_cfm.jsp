<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*��ҳ�洫�ݵĲ���*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("fn_doQryMIfo") ) //�����ַ���
{
	System.out.println("if~~"+s_ajaxType);
}
else if ( s_ajaxType.equals("setLst") ) //����html
{
	String accept = request.getParameter( "logacc" );
	String chnSrc = request.getParameter( "chnSrc" );
	String opCode = request.getParameter( "opCode" );
	String workNo = request.getParameter( "workNo" );
	String passwd = request.getParameter( "passwd" );
	
	String phoNo = request.getParameter( "phoNo" );   
	String usrPwd = request.getParameter( "usrPwd" );
	String op_acc = request.getParameter( "op_acc" );
	%>
	
	<wtc:service name = "sWlwBatchQry" outnum = "30" 
		routerKey = "region" routerValue = "<%=regCode%>" 
		retcode = "retcode" retmsg = "retmsg" >
		<wtc:param value = "<%=op_acc%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			               
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
	</wtc:service>
	<wtc:array id = "rst" scope = "end" />
		
	<TABLE ID = '' >
		<TH ALIGN = "CENTER">�ֻ�����</TH>    
		<TH ALIGN = "CENTER">��������</TH>     
		<TH ALIGN = "CENTER">��������</TH>     
		<TH ALIGN = "CENTER">�ļ�����</TH>     
		<TH ALIGN = "CENTER">����ʱ��</TH>
		     
		<TH ALIGN = "CENTER">���ŷ���</TH>     
		<TH ALIGN = "CENTER">��������</TH>   
		<TH ALIGN = "CENTER">������ˮ</TH>   
  

<%
	if ( !retcode.equals( "000000" ) )
	{
	%>
		<TR >
			<TD ALIGN = "CENTER" colspan = '8' >������!</TD>
		</TR>  	
	<%
	}
	else
	{
		for ( int i=0;i<rst.length;i++ )
		{
		%>
			<TR>
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = '' name = '' VALUE = '<%=rst[i][0]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][1]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>		
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = '' name = '' VALUE = '<%=rst[i][2]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][3]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>		
				<TD ALIGN = 'CENTER'>
					<INPUT TYPE ='TEXT' ID = '' name = '' VALUE = '<%=rst[i][4]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
				
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][5]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>
						
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' tips="<%=rst[i][6]%>" onmousemove="seashowtip(this.tips,1,150)" onmouseout=seashowtip(this.tips,0,150) VALUE = '<%=rst[i][6]%>' 
						CLASS = 'InputGrey' readOnly >
				</TD>		
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'TEXT' ID ='' name = '' VALUE = '<%=rst[i][7]%>' 
						CLASS = 'InputGrey' readOnly >
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
