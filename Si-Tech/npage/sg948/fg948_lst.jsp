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
		<TH ALIGN = "CENTER">投诉号码</TH>    
		<TH ALIGN = "CENTER">受限主叫号码</TH>    		
		<TH ALIGN = "CENTER">操作标识</TH>    
		<TH ALIGN = "CENTER">操作时间</TH>    
		<TH ALIGN = "CENTER">操作工号</TH>
		<TH ALIGN = "CENTER">举报类型</TH>     

<%
	if ( !retcode.equals( "000000" ) )
	{	
	%>
		<TR>
			<TD ALIGN = "CENTER" colspan = '7'>服务出错:<%=retcode%>:<%=retmsg%></TD>
		</TR>  	
	<%
	}
	else
	{
		if (rst.length == 0)
		{
		%>
			<TR>
				<TD ALIGN = "CENTER" colspan = '7'>无数据!</TD>
			</TR>  	
		<%
		}
		else
		{
			for ( int i=0;i<rst.length;i++ )
			{
				if ( rst[i][2].equals("A") )
				{
					rst[i][2] = "增加";
				}
				else if ( rst[i][2].equals("D") )
				{
					rst[i][2] = "删除";
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
						<INPUT TYPE = 'TEXT' ID ='op_type<%=i%>' VALUE = '<%if("1".equals(rst[i][5])){out.print("点对点垃圾短信");}%><%if("2".equals(rst[i][5])){out.print("点对点垃圾彩信");}%>' class = 'InputGrey' readOnly >
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