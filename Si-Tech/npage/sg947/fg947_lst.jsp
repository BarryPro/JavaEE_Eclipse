<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String ajaxType = request.getParameter("ajaxType");
String regCode = (String)session.getAttribute("regCode");

if ( ajaxType.equals("test") ) //返回字符串
{
	System.out.println("test~~~~`");
}
else if ( ajaxType.equals("setLst") ) //返回html
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
		<TH ALIGN = "CENTER">投诉号码</TH>    
		<TH ALIGN = "CENTER">受限主叫号码</TH>
		<TH ALIGN = "CENTER">举报类型</TH>     
		<TH ALIGN = "CENTER">操作</TH>   

<%
	if ( !retcode.equals( "000000" ) )
	{
	%>
		<TR>
			<TD ALIGN = "CENTER" colspan = '4'>服务出错:<%=retcode%>:<%=retmsg%></TD>
		</TR>  	
	<%
	}
	else
	{
		if(rst.length == 0 ){
		%>
		<TR>
			<TD ALIGN = "CENTER" colspan = '4'>无数据!</TD>
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
					<INPUT TYPE = 'TEXT' ID ='l_pho3<%=i%>' VALUE = '<%if("1".equals(rst[i][2])){out.print("点对点垃圾短信");}%><%if("2".equals(rst[i][2])){out.print("点对点垃圾彩信");}%>' CLASS = 'InputGrey' readOnly >
				</TD>
				<TD ALIGN = 'CENTER'>                
					<INPUT TYPE = 'BUTTON' ID ='' VALUE = '删除' CLASS = 'b_text' onClick = 'del( <%=i%> )' >
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